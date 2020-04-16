module Watchdog
  WIDGETS_CONF_PATH = 'config/widgets.yml'.freeze

  class Engine < ::Rails::Engine
    isolate_namespace Watchdog

    initializer "watchdog.assets.precompile" do |app|
      app.config.assets.precompile += %w(config/watchdog_manifest.js)
    end

    initializer "watchdog.widgets.load" do |app|
      path = File.join(Rails.root, WIDGETS_CONF_PATH)

      if File.exist? path
        config = YAML.safe_load File.read(path)
      else
        warn("You haven't declared any widgets in config/widgets.yml")
        config = { widgets: [] }
      end

      Rails.application.config.widgets = config
    end
  end
end
