#!/usr/bin/env ruby

# https://github.com/NullVoxPopuli/action_cable_client
require 'action_cable_client'

EventMachine.run do
  uri = 'ws://localhost:3000/cable/'
  # client = ActionCableClient.new(uri, 'RoomChannel')
  client = ActionCableClient.new(uri, 'MessagesChannel')
  # the connected callback is required, as it triggers
  # the actual subscribing to the channel but it can just be
  # client.connected {}
  client.connected { puts 'successfully connected.' }

  # called whenever a message is received from the server
  client.received do |data|
    message = data['message']
    puts "Received message: #{message['message']} from user #{message['user']}"
  end
end
