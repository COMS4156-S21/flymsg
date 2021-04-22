class ImgStoragesController < ApplicationController
  def create
    @imgstorage = MessageStatus.create!(imgstorage_params)
  end
  
  def imgstorage_params
    params.require(:imgstorage).permit(:img_id, :img_src)
  end
end
