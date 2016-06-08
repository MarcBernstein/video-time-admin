require "uri"
require "net/http"

class MessagesController < ApplicationController
  http_basic_authenticate_with name: "p", password: "6896", except: [:index, :show]

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def edit
    @message = Message.find(params[:id])
  end

  def copy
    @message = Message.find(params[:format])
    puts @message
    @new_message = @message.dup
    send_msg(@new_message)
  end
 
  def create
    @message = Message.new(params.require(:message).permit(:minutes, :reason, :from))
    send_msg(@message)
  end


  def destroy
    @message = Message.find(params[:id])
    @message.destroy
 
    redirect_to messages_path
  end

  def send_msg(message)
    @token = "chXlfIB-EZA:APA91bHhyw9s7HFSZxSd2zn0y1UtLbqJotw-2CwBZaOhMpyzLAbCYgV0qs_pBCoPqfKbAXbjoExW7VKqcCpHpfbpZeKJbvpZ9BHHHrWw08tzwwZxg8fKN98ZDYbg64Uyg_jwtv0UuddQ"
      
    if message.save
      uri = URI.parse("https://fcm.googleapis.com/fcm/send")
      uri.query = URI.encode_www_form(
                       "data.minutes" => message.minutes,
                       "data.reason" => message.reason,
                       "data.from_who" => message.from,
                      "to" => @token)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field 'Authorization', 'key=AIzaSyDOKv0PXEdhswb8IzEl5JhFOqODHdFDG94'
      request.add_field 'Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8'
      puts http.request(request).body
      
      redirect_to message
    else
      render 'new'
    end
  end
end
