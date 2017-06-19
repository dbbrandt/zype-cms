class StaticPagesController < ApplicationController

  def index
    @item = HomePage.instance rescue nil
    @videos = []
  end

  def show
    @item = DetailPage.instance rescue nil
    @video = nil
  end

  def page
    page_name = (params[:page] + "_page").classify

    @item = page_name.constantize.instance rescue nil
   
    render "static_pages/#{params[:page]}"
  end
end
