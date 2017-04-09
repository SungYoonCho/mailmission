require 'mailgun'
class HomeController < ApplicationController
  def index
  end 
  def write
    @title1=params[:title]
    @email1=params[:email]
    @content2=params[:content]

    
    mg_client = Mailgun::Client.new("key-31dec6f9b8b6e83a527c43b2c5a2d3c2")

    message_params =  {
                       from: 'sungyoon1111@hufs.ac.kr',
                       to:   @email1,
                       subject: @title1,
                       text:    @content2
                      }
    
    result = mg_client.send_message('sandboxf3024afa22a84d0593d3dcbe58c3cbe2.mailgun.org', message_params).to_h!
    
    message_id = result['id']
    message = result['message']
  
    new_post = Post.new
    new_post.title = @title1
    new_post.content = @content2
    new_post.email = @email1
    new_post.save
    redirect_to "/list"
    
  end
  def list
    @board = Post.all
  end
end
