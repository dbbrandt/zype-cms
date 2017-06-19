class StaticPagesController < ApplicationController

  def index
    @item = HomePage.instance rescue nil
    @videos = video.list
  end

  def show
    @video = params[:id] == "1" ? video.headline : video.find(params[:id])

    @app_key = ENV["ZYPE_APP_KEY"]
    @access_token = "b6b7084bf677ec2615644e748b052c1e77821aae6257d3cab1330cd285299a64"
    @item = DetailPage.instance rescue nil
  end

  def page
    page_name = (params[:page] + "_page").classify

    @item = page_name.constantize.instance rescue nil
   
    render "static_pages/#{params[:page]}"
  end

  def video
    Video.new
  end
end
