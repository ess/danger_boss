require 'danger_boss/version'
require 'danger_boss/client'
require 'danger_boss/driver/http'

module DangerBoss
  def self.client(base_url:,username: nil, password: nil)
    Client.new(
      driver: Driver::Http.new(base_url: base_url, username: username, password: password)
    )
  end
end
