class UserKeysController < ApplicationController
  def create
    @userkey = UserKey.create!(userkey_params)
  end
  
  def userkey_params
    params.require(:userkey).permit(:id, :pem)
  end
end
