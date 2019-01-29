require 'danger_boss/alert'

module DangerBoss
  class AlertService
    attr_reader :driver

    def initialize(driver:)
      @driver = driver
    end

    def all(params: {})
      driver.get(path: 'alerts', params: params) do |m|
        m.success do |raw_alerts|
          raw_alerts.map {|alert| Alert.new(alert)}
        end

        m.failure do |error|
          raise error
        end
      end
    end
  end
end
