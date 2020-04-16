# frozen_string_literal: true

module Watchdog
  class Widget
    attr_accessor :id, :title, :subtitle, :group, :style, :type, :url

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

    end

    def css_classes
    end
  end
end
