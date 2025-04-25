require './app'
require './middleware/authentication'
require './middleware/gzip'

use Authentication
use Gzip
run App.new
