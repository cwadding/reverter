module Reverter
  class Engine < ::Rails::Engine
  	engine_name 'reverter'
    isolate_namespace Reverter
	config.generators do |g|
		g.test_framework :rspec, :view_specs => false
	end
  end
end
