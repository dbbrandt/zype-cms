require 'zype-cli'

class StaticPagesController < ApplicationController

  def index
    @item = HomePage.instance rescue nil
    @videos = video.list
  end

  def show
    @access_token = cookies[:access_token]

    @video = params[:id] == "1" ? video.headline : video.find(params[:id])

    @app_key = ENV["ZYPE_APP_KEY"]

    # TODO setup the static content in fae-cms
    #@item = DetailPage.instance rescue nil
  end

  def page
    page_name = (params[:page] + "_page").classify
    @item = page_name.constantize.instance rescue nil
   
    render "static_pages/#{params[:page]}"
  end

  def login
    @access_token = zype_cli.login(params["email"], params["password"])
    if @access_token.nil?
      flash[:error] = "Login Failed :("
    else
      #TODO use a more secure method to store the token (e.g. Session::CookieStore)
      cookies[:access_token] = @access_token
    end

    redirect_to show_path(id: params["id"])
  end

  def logout
    cookies.delete :access_token
    redirect_to root_path
  end


  private
  
  def video
    Video.new
  end

  def zype_cli
    ZypeCli.new
  end
end
