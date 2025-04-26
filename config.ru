require './app'
require './middleware/authorization'
require './middleware/gzip'

use Authorization
use Gzip
run App.new
