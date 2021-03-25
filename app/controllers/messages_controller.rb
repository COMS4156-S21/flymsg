class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params)
  end

  
  def message_params
    params.require(:message).permit(:img_id, :source_user_id, :target_user_id)
  end
end
