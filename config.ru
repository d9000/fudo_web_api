require './app'
require './middlewares/authentication'
require './middlewares/gzip'

use Authentication
use Gzip
run App.new
