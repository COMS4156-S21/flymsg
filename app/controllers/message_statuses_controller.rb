class MessageStatusesController < ApplicationController
  def create
    @messagestatus = MessageStatus.create!(messagestatus_params)
  end
  
  def messagestatus_params
    params.require(:messagestatus).permit(:img_id, :unread, :deleted, :created_on, :ttl)
  end
  
end
