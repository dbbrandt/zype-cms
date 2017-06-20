class Video < ZypeModel

  def initialize
    super
    @headline_video_id = "56a7b83e69702d2f83abdcb7"
  end

  def list(params = {})
    return @videos unless params
    @zype_client.list_videos(params)
  end

  def find(video_id)
     @zype_client.find_video(video_id) if video_id
  end

  def headline
    @zype_client.find_video(@headline_video_id)
  end
end