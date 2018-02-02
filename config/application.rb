require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
		config.sass.load_paths << bower_path
		config.assets.paths << bower_path
	end
	# Precompile Bootstrap fonts
	config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
	# Minimum Sass number precision required by bootstrap-sass
	::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max
  config.autoload_paths += %W(#{config.root}/lib) # add this line
  end
end
