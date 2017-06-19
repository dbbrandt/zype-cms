require 'zype-cli'

class ZypeModel
  attr_reader :zype_client, :params

  def initialize
    @zype_client = ZypeCli.new
  end

end

