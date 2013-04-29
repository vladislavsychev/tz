# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tz::Application.initialize!

Date::DATE_FORMATS[:ru_date] = "%d.%m.%Y"
