require 'rack'
require_relative 'config/routes'

class App
  def call(env)
    Routes.dispatch(env)
  end
end
