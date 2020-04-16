module Watchdog
  module ApplicationHelper
    def widget_controller_name(group)
      'Watchdog::' + ActiveSupport::Inflector.classify(group + '_controller')
    end
  end
end
