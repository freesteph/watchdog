# frozen_string_literal: true

module Watchdog
  class Widget
    attr_accessor :id,
                  :title,
                  :subtitle,
                  :group,
                  :style,
                  :type,
                  :url,
                  :refresh_rate

    def initialize(attrs)
      attrs.each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end
    end

    def data_url
      "/watchdog/widgets/#{@group}/#{@id}"
    end

    def logo
    end

    def css_id
      [group, id].join('-')
    end

    def css_classes
      style
    end

    def render_attributes
      attrs = {}

      if refresh_rate.present?
        attrs[:refresh] = refresh_rate
      end

      attrs
    end
  end
end
