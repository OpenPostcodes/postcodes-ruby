module Postcodes
	class PostcodesError < StandardError
		attr_reader :message
		attr_reader :http_code
		attr_reader :http_body
		attr_reader :response_code

		def initialize(message = nil, http_code = nil, http_body = nil, response_code = nil)
			@message = message
			@http_code = http_code
			@http_body = http_body
			@response_code = response_code
		end

		def to_s
			status = @http_code.nil? ? "" : "#{@http_code} error."
			opc_code = @response_code.nil ? "" : "(#{@response_code})"
			"#{status} error. (#{opc_code}) #{message}"
		end
	end

	class AuthenticationError < PostcodesError
	end
	
	class RefererExcludedError < PostcodesError
	end

	class TokenExhaustedError < PostcodesError
	end

	class LimitReachedError < PostcodesError
	end

	class ResourceNotFoundError < PostcodesError
	end

	class InvalidInputError < PostcodesError
	end
end