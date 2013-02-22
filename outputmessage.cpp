//////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
//////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software Foundation,
// Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//////////////////////////////////////////////////////////////////////
#include "otpch.h"

#include "outputmessage.h"
#include "protocol.h"
#include "scheduler.h"

extern Dispatcher g_dispatcher;

#ifdef __ENABLE_SERVER_DIAGNOSTIC__
uint32_t OutputMessagePool::OutputMessagePoolCount = OUTPUT_POOL_SIZE;
#endif

OutputMessage::OutputMessage()
{
	freeMessage();
}

//*********** OutputMessagePool ****************//

OutputMessagePool::OutputMessagePool()
{
	for(uint32_t i = 0; i < OUTPUT_POOL_SIZE; ++i)
	{
		OutputMessage* msg = new OutputMessage();
		m_outputMessages.push_back(msg);
#ifdef __TRACK_NETWORK__
		m_allOutputMessages.push_back(msg);
#endif
	}
	m_frameTime = OTSYS_TIME();
}

void OutputMessagePool::startExecutionFrame()
{
	//boost::recursive_mutex::scoped_lock lockClass(m_outputPoolLock);
	m_frameTime = OTSYS_TIME();
	m_isOpen = true;
}

OutputMessagePool::~OutputMessagePool()
{
	InternalOutputMessageList::iterator it;
	for(it = m_outputMessages.begin(); it != m_outputMessages.end(); ++it)
		delete *it;

	m_outputMessages.clear();
}

void OutputMessagePool::send(OutputMessage_ptr msg)
{
	m_outputPoolLock.lock();
	OutputMessage::OutputMessageState state = msg->getState();
	m_outputPoolLock.unlock();

	if(state == OutputMessage::STATE_ALLOCATED_NO_AUTOSEND)
	{
		#ifdef __DEBUG_NET_DETAIL__
		std::cout << "Sending message - SINGLE" << std::endl;
		#endif

		if(msg->getConnection())
		{
			if(!msg->getConnection()->send(msg))
			{
				// Send only fails when connection is closing (or in error state)
				// This call will free the message
				msg->getProtocol()->onSendMessage(msg);
			}
		}
		else
		{
			#ifdef __DEBUG_NET__
			std::cout << "Error: [OutputMessagePool::send] NULL connection." << std::endl;
			#endif
		}
	}
	else
	{
		#ifdef __DEBUG_NET__
		std::cout << "Warning: [OutputMessagePool::send] State != STATE_ALLOCATED_NO_AUTOSEND" << std::endl;
		#endif
	}
}

void OutputMessagePool::sendAll()
{
	boost::recursive_mutex::scoped_lock lockClass(m_outputPoolLock);

	const int64_t dropTime = m_frameTime - 10000;
	const int64_t frameTime = m_frameTime - 10;

	for(OutputMessageMessageList::const_iterator it = m_toAddQueue.begin(), end = m_toAddQueue.end(); it != end; ++it)
	{
		OutputMessage_ptr omsg = *it;
		const int64_t msgFrame = omsg->getFrame();
		if(msgFrame >= dropTime)
		{
			omsg->setState(OutputMessage::STATE_ALLOCATED);
			omsg->setSent(false);
			if(frameTime > msgFrame)
				m_autoSendOutputMessages.push_front(omsg);
			else if(omsg->getMessageLength() > 1024)
				m_dirtyOutputMessages.push_back(omsg);
			else
				m_autoSendOutputMessages.push_back(omsg);
		}
		else
		{
			//drop messages that are older than 10 seconds
			omsg->getProtocol()->onSendMessage(omsg);
		}
	}
	m_toAddQueue.clear();

	for(OutputMessageMessageList::iterator it = m_autoSendOutputMessages.begin(), end = m_autoSendOutputMessages.end(); it != end; it = m_autoSendOutputMessages.erase(it))
	{
		OutputMessage_ptr omsg = *it;
		if(frameTime <= omsg->getFrame())
			break;

		if(omsg->getConnection() && !omsg->isSent())
		{
			#ifdef __DEBUG_NET_DETAIL__
			std::cout << "Sending message - ALL" << std::endl;
			#endif

			if(!omsg->getConnection()->send(omsg))
			{
				// Send only fails when connection is closing (or in error state)
				// This call will free the message
				omsg->getProtocol()->onSendMessage(omsg);
			}
			omsg->setSent(true);
		}
	}

	for(OutputMessageMessageList::const_iterator it = m_dirtyOutputMessages.begin(), end = m_dirtyOutputMessages.end(); it != end; ++it)
	{
		OutputMessage_ptr omsg = *it;
		if(omsg->getMessageLength() > 1024 && omsg->getConnection() && !omsg->isSent())
		{
			#ifdef __DEBUG_NET_DETAIL__
			std::cout << "Sending message - ALL" << std::endl;
			#endif

			if(!omsg->getConnection()->send(omsg))
			{
				// Send only fails when connection is closing (or in error state)
				// This call will free the message
				omsg->getProtocol()->onSendMessage(omsg);
			}
			omsg->setSent(true);
		}
	}
	m_dirtyOutputMessages.clear();
}

void OutputMessagePool::releaseMessage(OutputMessage* msg)
{
	g_dispatcher.addTask(
		createTask(boost::bind(&OutputMessagePool::internalReleaseMessage, this, msg)));
}

void OutputMessagePool::internalReleaseMessage(OutputMessage* msg)
{
	if(msg->getProtocol())
	{
		msg->getProtocol()->unRef();
#ifdef __DEBUG_NET_DETAIL__
		std::cout << "Removing reference to protocol " << msg->getProtocol() << std::endl;
#endif
	}
	else
		std::cout << "No protocol found." << std::endl;

	if(msg->getConnection())
	{
		msg->getConnection()->unRef();
#ifdef __DEBUG_NET_DETAIL__
		std::cout << "Removing reference to connection " << msg->getConnection() << std::endl;
#endif
	}
	else
		std::cout << "No connection found." << std::endl;

	msg->freeMessage();

#ifdef __TRACK_NETWORK__
	msg->clearTrack();
#endif

	m_outputPoolLock.lock();
	m_outputMessages.push_back(msg);
	m_outputPoolLock.unlock();
}

OutputMessage_ptr OutputMessagePool::getOutputMessage(Protocol* protocol, bool autosend /*= true*/)
{
	#ifdef __DEBUG_NET_DETAIL__
	std::cout << "request output message - auto = " << autosend << std::endl;
	#endif

	if(!m_isOpen)
		return OutputMessage_ptr();

	boost::recursive_mutex::scoped_lock lockClass(m_outputPoolLock);

	if(protocol->getConnection() == NULL)
		return OutputMessage_ptr();

	if(m_outputMessages.empty())
	{
		OutputMessage* msg = new OutputMessage();
		m_outputMessages.push_back(msg);

#ifdef __ENABLE_SERVER_DIAGNOSTIC__
		OutputMessagePoolCount++;
#endif

#ifdef __TRACK_NETWORK__
		m_allOutputMessages.push_back(msg);
#endif
	}

	OutputMessage_ptr outputmessage;
	outputmessage.reset(m_outputMessages.back(),
		boost::bind(&OutputMessagePool::releaseMessage, this, _1));

	m_outputMessages.pop_back();

	configureOutputMessage(outputmessage, protocol, autosend);
	return outputmessage;
}

void OutputMessagePool::configureOutputMessage(OutputMessage_ptr msg, Protocol* protocol, bool autosend)
{
	TRACK_MESSAGE(msg);
	msg->Reset();
	if(autosend)
	{
		msg->setState(OutputMessage::STATE_ALLOCATED);
		msg->setSent(false);
		m_autoSendOutputMessages.push_back(msg);
		m_dirtyOutputMessages.push_back(msg);
	}
	else
		msg->setState(OutputMessage::STATE_ALLOCATED_NO_AUTOSEND);

	Connection_ptr connection = protocol->getConnection();
	assert(connection != NULL);

	msg->setProtocol(protocol);
	protocol->addRef();
#ifdef __DEBUG_NET_DETAIL__
	std::cout << "Adding reference to protocol - " << protocol << std::endl;
#endif
	msg->setConnection(connection);
	connection->addRef();
#ifdef __DEBUG_NET_DETAIL__
	std::cout << "Adding reference to connection - " << connection << std::endl;
#endif
	msg->setFrame(m_frameTime);
}

void OutputMessagePool::addToAutoSend(OutputMessage_ptr msg)
{
	m_outputPoolLock.lock();
	m_toAddQueue.push_back(msg);
	m_outputPoolLock.unlock();
}

void OutputMessagePool::markAsDirty(OutputMessage_ptr msg)
{
	m_dirtyOutputMessages.push_back(msg);
}
