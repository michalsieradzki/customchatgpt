class ChatsController < ApplicationController
  def index
    @message = params[:message]
  end

  def create
    message = params[:message]
    chat_service = ChatService.new(message: message)
    @response = chat_service.call
    redirect_to root_path
  end
end