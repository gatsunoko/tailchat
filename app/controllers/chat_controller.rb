class ChatController < ApplicationController
  def index
    @paintroom = [1, 2, 3, 4]
  end

  def show
    @webchannel = "websocket_chat_channel_" + params[:id].to_s
    @webpaintchannel = "websocket_paint_channel_" + params[:id].to_s
    @webuserchannel = "websocket_user_channel_" + params[:id].to_s
    @webmychannel = "web_my_channel_" + params[:id].to_s + "_" + current_user.id.to_s
    session[:room_id] = params[:id].to_s

    if Chatlog.where("room_num = ?", session[:room_id]).count > 17
      cnt = Chatlog.where("room_num = ?", session[:room_id]).count - 18
    else
      cnt = 0
    end
    @chatlogs = Chatlog.where("room_num = ?", session[:room_id]).all.order(id: :asc).limit(18).offset(cnt)
    p @webmychannel
  end

  def pain
  	if Chatlog.count > 17
  		cnt = Chatlog.count - 18
  	else
  		cnt = 0
  	end
  	@chatlogs = Chatlog.all.order(id: :asc).limit(18).offset(cnt)
  end
end