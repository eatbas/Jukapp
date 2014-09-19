class WebsocketService
  def self.send_message(message)
    ws = Faye::WebSocket::Client.new("ws://#{Jukapp::Config.app_host}")
    ws.send({operation: message}.to_json)
    ws.close
  end
end
