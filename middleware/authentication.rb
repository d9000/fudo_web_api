require_relative '../config/routes'

class Authentication
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    protected_endpoints = Routes::PROTECTED_ENDPOINTS

    if protected_endpoints.include?(request.path_info) && !authenticated?(request)
      return unauthorized_response
    end
    @app.call(env)
  end

  private

  def authenticated?(request)
    request.get_header('HTTP_AUTHORIZATION') == "Bearer valid_token"
  end

  def unauthorized_response
    [401, { 'content-type' => 'application/json' }, [{ error: 'Unauthorized' }.to_json]]
  end
end
