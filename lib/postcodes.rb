require 'rest-client'
require 'uri'
require 'multi_json'
require 'cgi'
require 'postcodes/postcode'
require 'postcodes/util'
require 'postcodes/errors'

module Postcodes
	@base_url = 'https://api.openpostcodes.com'
	@version = '1'

	class << self
		attr_accessor :api_key, :base_url, :version
	end

	def self.request(method, path, params = {})
		unless @api_key
			raise Postcodes::AuthenticationError.new('No API Key provided. ' +
				'Set your API key using Postcodes.api_key = #your_key')
		end

		url = URI.parse(resource_url(path))
		params.merge! api_key: @api_key
		url.query = Util.merge_params(params)
		request_options = {
			method: method.downcase.to_sym,
			url: url.to_s
		}

		begin
			response = generate_request(request_options)
		rescue RestClient::ExceptionWithResponse => error
			if rcode = error.http_code && rbody = error.http_body
				handle_error(rcode, rbody)
			else
				handle_client_error(error)
			end
		rescue RestClient::Exception, Errno::ECONNREFUSED => error
			handle_client_error(e)
		end
		parse response.body
	end

	private

	def self.resource_url(path='')
		URI.escape "#{@base_url}/v#{@version}/#{path}"
	end

	def self.generate_request(options)
		RestClient::Request.execute(options)
	end

	def self.parse(response)
		begin
      Util.keys_to_sym MultiJson.load(response)
    rescue MultiJson::DecodeError => e
      raise handle_client_error(e)
    end
	end

	def self.handle_error(http_code, http_body)
    error = parse http_body

		opc_code, opc_message = error[:code], error[:message]
		
		case opc_code
		when 4010
			raise AuthenticationError.new opc_message, http_code, http_body, opc_code
		when 4011
			raise RefererExcludedError.new opc_message, http_code, http_body, opc_code
		when 4020
			raise TokenExhaustedError.new opc_message, http_code, http_body, opc_code
		when 4021
			raise LimitReachedError.new opc_message, http_code, http_body, opc_code
		when 4040
			raise ResourceNotFoundError.new opc_message, http_code, http_body, opc_code
		when 4220
			raise InvalidInputError.new opc_message, http_code, http_body, opc_code
		else
			raise PostcodesError.new opc_message, http_code, http_body, opc_code
		end
	end

	def self.handle_client_error(error)
		raise PostcodesError.new("Unexpected error occurred: #{error.message})")
	end

	def self.general_error(response_code, response_body)
		PostcodesError.new "Invalid response object", response_code, response_body
	end

end