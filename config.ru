require './app'
require './middlewares/authentication'

use Authentication
run App.new
