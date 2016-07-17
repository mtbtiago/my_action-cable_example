# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def speak(data)
    logger.info data
    # ActionCable.server.broadcast 'messages', message: data['message'], user: data['user']
    ActionCable.server.broadcast 'messages', data
  end
end
