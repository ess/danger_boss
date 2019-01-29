require 'danger_boss/alert_service'

module DangerBoss
  class Client
    attr_reader :driver

    def initialize(driver:)
      @driver = driver
    end

    def alerts
      @alerts ||= AlertService.new(driver: driver)
    end
  end
end
