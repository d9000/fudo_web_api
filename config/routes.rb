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
    when ['POST', PRODUCTS_PATH]
      # create a product
    when ['GET', PRODUCTS_PATH]
      # list of products
    when ['GET', OPENAPI_PATH]
      # renders openapi.yaml file
    when ['GET', AUTHORS_PATH]
      # renders authors file
    else
      response.status = 404
      response.write({ error: 'Not Found' }.to_json)
    end

    response['Content-Type'] = 'application/json'

    response.finish
  end
end
