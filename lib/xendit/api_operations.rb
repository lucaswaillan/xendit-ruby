# frozen_string_literal: true

require 'faraday'
require 'json'

module Xendit
  class APIOperations
    class << self
      def get(url, params = nil)
        conn = create_connection
        conn.get url, params
      end

      def post(url, params, headers = {})
        conn = create_connection(headers)
        conn.post url, JSON.generate(params)
      end

      private

      def create_connection(custom_headers = {})
        headers = {'Content-Type' => 'application/json'}
        headers.merge!(custom_headers)
        Faraday.new(
          url: Xendit.base_url,
          headers: headers
        ) do |conn|
          conn.request :authorization, :basic, Xendit.api_key, ''
        end
      end
    end
  end
end
