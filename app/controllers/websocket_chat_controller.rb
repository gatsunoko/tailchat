class WebsocketChatController < WebsocketRails::BaseController
	def message_recieve
		# クライアントからのメッセージを取得
		recieve_message = session[:username] + " : " + message()

		@chatlog = Chatlog.new
		@chatlog.user_id = session[:id]
		@chatlog.text = message()
		@chatlog.room_num = session[:room_id]
		unless @chatlog.save
			render text: 'しっぱい'
		end

		#websocket_chatイベントで接続しているクライアントにブロードキャスト
		#broadcast_message(:websocket_chat, recieve_message)
		webchannel = "websocket_chat_channel_" + session[:room_id]
		WebsocketRails[webchannel].trigger "websocket_chat", recieve_message
	end

	def paint_session_event
		webpaintchannel = "websocket_paint_channel_" + session[:room_id]
		WebsocketRails[webpaintchannel].trigger "websocket_paint_mouse", message()
	end

	def gamestart_event
		p 'gamestart'
		p session[:room_id]
		p session[:id]
		@roommembers = Roomstate.where(['room_num = ?', session[:room_id]])

		@roommembers.each do |roommember|
			p 'aaaaaaa'
			web_my_channel = "web_my_channel_" + session[:room_id].to_s + '_' + roommember.user_id.to_s
			p web_my_channel
			WebsocketRails[web_my_channel].trigger "gamestart", message
		end
	end

	def user_connected
		user_name = session[:username].to_s
		user_state = [message(), user_name]
		p session[:connection_id]

		if message() == 0
			Roomstate.where(['room_num = ? and username = ?', session[:room_id], session[:username]]).limit(1).destroy_all
		else
			@roomstate = Roomstate.new
			@roomstate.room_num = session[:room_id]
			@roomstate.username = session[:username]
			@roomstate.user_id = session[:id]
			@roomstate.connection_id = session[:connection_id]
			@roomstate.save
		end

		@roomstates = Roomstate.where(['room_num = ?', session[:room_id]])
		user_all = '部屋にいるユーザー一覧'
		@roomstates.each do |roomstates|
			user_all = user_all + "<br>" + roomstates.username
		end
		user_state[2] = user_all

		webuserchannel = "websocket_user_channel_" + session[:room_id]
		WebsocketRails[webuserchannel].trigger "websocket_user_channel",user_state
		p user_state
	end

	def client_connected
		p 'abfffffffffffffffffffff'
		session[:connection_id] = message()
	end 

	def client_disconnected
		p 'a55555555555555555555555'
		Roomstate.where(['connection_id = ?', session[:connection_id]]).destroy_all
	end 
end