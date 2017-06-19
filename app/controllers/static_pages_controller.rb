class StaticPagesController < ApplicationController

  def index
    @item = HomePage.instance rescue nil
    @videos = []
  end

  def show
    @video_id = params[:id]
    @item = DetailPage.instance rescue nil
    if @video_id == "1"
      @video_image = 'sarcastic-eddie-murphy.jpg'
    else
      @video_image = 'visions.jpg'
    end
    @video = nil
  end

  def page
    page_name = (params[:page] + "_page").classify

    @item = page_name.constantize.instance rescue nil
   
    render "static_pages/#{params[:page]}"
  end
end
