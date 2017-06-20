require 'zype'
require 'zype/commands'

class ZypeCli
  def initialize
    command = Zype::Commands.new
    @zype = command.init_client
  end

  def list_videos(params = {})
    @zype.videos.all(params)
  rescue ArgumentError => e
     puts "Zype videos.all call exception: #{e}"
     return []
  end

  def find_video(video_id)
    @zype.videos.find(video_id)
  rescue ArgumentError => e
    puts "Zype videos.find call exception: #{e}"
    return nil
  end

  def login(username, password)
     result = @zype.login({username: username, password: password})
     JSON.parse(result.body)['access_token']
  rescue ArgumentError => e
    puts "Zype login call exception: #{e}"
    return nil
  end
end

