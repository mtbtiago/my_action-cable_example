#!/usr/bin/env ruby

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
  client.received do |message|
    puts message
    client.perform('speak', message: 'hello from amc', user: 'gato')
  end

  # adds to a queue that is purged upon receiving of
  # a ping from the server
end
