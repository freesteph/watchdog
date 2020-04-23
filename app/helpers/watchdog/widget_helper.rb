module Watchdog
  module WidgetHelper
    def css_classes(widget)
      widget.style
    end

    def css_id(widget)
      [widget.group, widget.id].join('-')
    end

    def render_attributes(widget)
      attrs = {}

      attrs[:refresh] = widget.refresh_rate if widget.refresh_rate.present?

      attrs
    end
  end
end
