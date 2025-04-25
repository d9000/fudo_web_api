require 'json'

class AuthenticationEndpoint
  def authenticate(req, res)
    auth_header = req.env['HTTP_AUTHORIZATION']

    # Check for Bearer token in Authorization header
    if auth_header && auth_header.start_with?('Bearer ')
      token = auth_header.split(' ').last
      if valid_token?(token)
        res.write({ message: 'Authenticated with token' }.to_json)
      else
        res.status = 401
        res.write({ error: 'Invalid token' }.to_json)
      end
    else
      begin
        data = JSON.parse(req.body.read)
        if data['user'] && data['password'] && valid_credentials?(data['user'], data['password'])
          token = generate_token(data['user'])
          res.write({ message: 'Authenticated with user and password', token: token }.to_json)
        else
          res.status = 401
          res.write({ error: 'Invalid user or password' }.to_json)
        end
      rescue JSON::ParserError
        res.status = 400
        res.write({ error: 'Invalid JSON' }.to_json)
      end
    end
  end

  private

  def valid_token?(token)
    # For demonstration, we assume "valid_token" is the only valid token
    token == 'valid_token'
  end

  def valid_credentials?(user, password)
    user == 'admin' && password == 'password123'
  end

  def generate_token(user)
    'valid_token'
  end
end
