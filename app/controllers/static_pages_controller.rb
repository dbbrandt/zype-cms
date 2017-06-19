class StaticPagesController < ApplicationController

  def index
    @item = HomePage.instance rescue nil
    @videos = []
  end

  def show
    @video_id = params[:id]
    @item = DetailPage.instance rescue nil
    if @video_id == "1"
      @video = {subscription: true, image: 'sarcastic-eddie-murphy.jpg', title: "Eddie Murphy: Ha Ha Ha Very Funny", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta rhoncus quam, nec sollicitudin lectus gravida in. Maecenas congue nunc eget augue lobortis viverra. Mauris."}
    else
      @video = {subscription: false, image: 'visions.jpg', title: "Ahh, so nice to get for free...", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta rhoncus quam, nec sollicitudin lectus gravida in. Maecenas congue nunc eget augue lobortis viverra. Mauris."}
    end
  end

  def page
    page_name = (params[:page] + "_page").classify

    @item = page_name.constantize.instance rescue nil
   
    render "static_pages/#{params[:page]}"
  end
end
