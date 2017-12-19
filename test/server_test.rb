require './test/test_helper'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_instantiates
    server = Server.new
    assert_instance_of Server, server
  end
end
