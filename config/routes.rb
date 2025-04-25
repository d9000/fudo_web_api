require_relative '../endpoints/v1/authentication_endpoint.rb'
require_relative '../endpoints/v1/products_endpoint.rb'
require_relative '../lib/file_render.rb'

module Routes
  AUTH_PATH = '/v1/auth'.freeze
  PRODUCTS_PATH = '/v1/products'.freeze
  OPENAPI_PATH = '/v1/openapi.yaml'.freeze
  AUTHORS_PATH = '/v1/AUTHORS'.freeze

  PROTECTED_ENDPOINTS = [
    PRODUCTS_PATH,
  ]

  def self.dispatch(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    case [request.request_method, request.path_info]
    when ['POST', AUTH_PATH]
      # authenticate user
      auth_endpoint = AuthenticationEndpoint.new
      auth_endpoint.authenticate(request, response)
    when ['POST', PRODUCTS_PATH]
      products_endpoint = ProductsEndpoint.new
      products_endpoint.create(request, response)
    when ['GET', PRODUCTS_PATH]
      products_endpoint = ProductsEndpoint.new
      products_endpoint.list(request, response)
    when ['GET', OPENAPI_PATH]
      FileRender.v1_render(response, 'openapi.yaml', 'no-cache')
    when ['GET', AUTHORS_PATH]
      FileRender.v1_render(response, 'AUTHORS', 'max-age=86400')
    else
      response.status = 404
      response.write({ error: 'Not Found' }.to_json)
    end

    response['content-type'] = 'application/json'

    response.finish
  end
end
