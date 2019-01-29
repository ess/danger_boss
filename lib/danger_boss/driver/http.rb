require 'danger_boss/driver/base'
require 'dry/matcher'
require 'dry/matcher/result_matcher'
require 'faraday'
require 'json'

module DangerBoss
  module Driver
    class Http
      include Base

      include Dry::Matcher.for(:get, with: Dry::Matcher::ResultMatcher)

      attr_reader :raw

      def initialize(base_url:, username: nil, password: nil)
        @base_url = base_url
        @username = username
        @password = password
        @raw = Faraday.new(url: base_url) do |faraday|
          if username && password
            faraday.basic_auth(username, password)
          end

          faraday.headers.merge!(
            {
              'Content-Type' => 'application/json',
              'Accept' => 'application/json',
              'User-Agent' => "danger_boss/#{VERSION} (https://github.com/ess/danger_boss)",
            }
          )

          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end

      def get(path:, params: {})
        Try() {raw.get(path, params)}.
          bind {|response| process_response(response)}
      end

      private
      def construct_url(path:, params: {})
        base_url.tap do |url|
          url.path = File.join(url.path, path)
          url.query_values = params
          return url
        end
      end

      def process_response(response)
        Success(response).
          bind {|response| check_http_status(response)}.
          bind {|body| parse_body(body)}.
          bind {|objectified| check_response_status(objectified)}
      end

      def check_http_status(response)
        Success(response).
          bind {|response|
            status = response.status
  
            if status < 200 || status > 299
              return Failure("API returned a #{status} status")
            end

            Success(response.body)
          }
      end

      def check_response_status(objectified)
        if objectified['status'].to_s.downcase != 'success'
          return Failure("API returned an unsuccessful response")
        end

        Success(objectified['data'])
      end

      def parse_body(body)
        Try() {JSON.load(body)}.to_result
      end

    end
  end
end
