module Watchdog
  class Engine < ::Rails::Engine
    isolate_namespace Watchdog

    initializer "watchdog.assets.precompile" do |app|
      app.config.assets.precompile += %w(config/watchdog_manifest.js)
    end
  end
end
