class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def speak(data)
    logger.info data
    # infinte loop!
    # ActionCable.server.broadcast 'messages', message: data, user: 'some'
  end
end
