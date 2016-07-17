#!/usr/bin/env ruby

# https://github.com/NullVoxPopuli/action_cable_client
require 'action_cable_client'

module KeyboardHandler
  include EM::Protocols::LineText2
  def receive_line(data)
    exit if data.empty?
    @client.perform('speak', message: data, user: @user)
  end

  def client=(client)
    @client = client
  end

  def user=(user)
    @user = user
  end
end

EventMachine.run do
  puts 'Rails 5 Action Cable client'
  puts 'Enter your name'
  user = gets.chomp
  exit if user.empty?
  puts 'Enter text. Blank line ends'
  uri = 'ws://localhost:3000/cable/'
  client = ActionCableClient.new(uri, 'MessagesChannel')

  # the connected callback is required, as it triggers
  # the actual subscribing to the channel but it can just be
  client.connected { puts 'successfully connected.' }

  # called whenever a message is received from the server
  client.received do |data|
    message = data['message']
    puts "Received message: #{message['message']} from user #{message['user']}"
  end

  EM.open_keyboard(KeyboardHandler) do |kb|
    kb.client = client
    kb.user = user
  end
end
