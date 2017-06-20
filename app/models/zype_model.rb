require 'zype-cli'

class ZypeModel
  attr_reader :zype_client

  def initialize
    @zype_client = ZypeCli.new
  end
end

