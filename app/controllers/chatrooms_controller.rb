class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :edit, :update]

  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
  end

  def new
    flash[:notice] = nil if request.referer.split('/').last == 'chatrooms'
    @chatroom = Chatroom.new
  end

  def edit
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = { error: ['a chatroom with this topic already exists'] }
        format.html { redirect_to new_chatroom_path }
        format.js { render template: 'chatrooms/chatroom_error.js.erb' }
      end
    end
  end

  def update
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @message = Message.new
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chatroom
    @chatroom = Chatroom.find_by(slug: params[:slug])
    redirect_to chatrooms_path, flash[:notice] = { error: ["The chatroom #{params[:slug]} no longer exists"] } unless @chatroom
  end

  def chatroom_params
    params.require(:chatroom).permit(:topic)
  end
end
