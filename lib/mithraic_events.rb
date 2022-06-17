# frozen_string_literal: true

require_relative 'mithraic_events/version'
require 'httparty'

module MithraicEvents
  include HTTParty

  class Error < StandardError; end

  def get(url, query: nil, headers: nil, body: nil)
    headers = build_request(headers)
    response = HTTParty.get(url, query: query, headers: headers, body: body.to_json)
    print_info('GET', url, query, headers, body, response) if ISPDF == 'true'
    response
  end

  def post(url, query: nil, headers: nil, body: nil)
    body = body.to_json unless body.eql?('grant_type=client_credentials')
    headers = build_request(headers)
    response = HTTParty.post(url, query: query, headers: headers, body: body, timeout: 180)
    print_info('POST', url, query, headers, body, response) if ISPDF == 'true'
    response
  end

  def put(url, query: nil, headers: nil, body: nil)
    headers = build_request(headers)
    response = HTTParty.put(url, query: query, headers: headers, body: body.to_json)
    print_info('PUT', url, query, headers, body, response) if ISPDF == 'true'
    response
  end

  def patch(url, query: nil, headers: nil, body: nil)
    headers = build_request(headers)
    response = HTTParty.patch(url, query: query, headers: headers, body: body.to_json)
    print_info('PATCH', url, query, headers, body, response) if ISPDF == 'true'
    response
  end

  def delete(url, query: nil, headers: nil, body: nil)
    headers = build_request(headers)
    response = HTTParty.delete(url, query: query, headers: headers, body: body.to_json)
    print_info('DELETE', url, query, headers, body, response) if ISPDF == 'true'
    response
  end

  def prepare_new_token(token)
    @@token = token
  end

  def build_request(headers)
    headers = { 'Content-Type': 'application/json' } if headers.nil?
    headers.merge!('Content-Type': 'application/json') unless headers.key?(:'Content-Type')
    headers.merge!(Authorization: @@token) unless defined?(@@token).nil?
    headers
  end

  def print_info(verb, url, query, headers, body, response)
    write_evidence('Request Method:', verb)
    write_evidence('Request URL:', url)
    write_evidence('Response Status:', response.code)
    write_evidence('Query params:', query) unless query.nil?
    write_evidence('Headers:', headers) unless headers.nil?
    write_evidence('Request Body:', body) unless body.nil?
    write_evidence('Response Body:', response.parsed_response) unless response.body.nil? || response.body.empty?
  end

  def write_evidence(text, value)
    if value.instance_of?(Hash) || value.instance_of?(HTTParty::Response)
      value = JSON.pretty_generate(value,
                                   indent: Prawn::Text::NBSP * 5)
    end
    EVIDENCE.text("\n#{text}", size: 10, style: :bold)
    EVIDENCE.text(value.to_s, size: 8)
  end

  def convert_hash_keys_to_string(hash)
    JSON.parse(JSON.dump(hash))
  end

  def prepare_mock_invalid(payload, field, max_length, character)
    json_navigate = field.split(/-/)
    object = JSON.parse(payload.to_json)
    value = ''.rjust(max_length.to_i, character)
    payload = set_value_iter(object, json_navigate, value)
    payload.to_h
  end

  def set_value_iter(obj, params, value)
    tmp_obj = obj
    if params.count > 1
      params[0..(params.count - 2)].each do |p|
        tmp_obj = tmp_obj[p]
      end
      tmp_obj[params[-1]] = value
    else
      tmp_obj[params[0]] = value
    end
    obj
  end

  def wait(timeout, &block)
    timeout.times do
      break if block.call

      sleep 1
    end
  end
end
