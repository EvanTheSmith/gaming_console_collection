require './config/environment'

use Rack::MethodOverride
use UsersController
use ConsolesController
run ApplicationController