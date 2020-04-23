# frozen_string_literal: true

module Watchdog
  class Widget
    include ActiveModel::Model
    include ApplicationHelper

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

    def validate!
      validate_controller! && validate_action!
    end

    def valid?
      errors.empty?
    end

    def data_url
      "/watchdog/widgets/#{@group}/#{@id}"
    end

    def logo
    end

    private

    def validate_controller!
      controller = widget_controller_name(group)

      valid = false

      begin
        controller.constantize
        valid = true
      rescue NameError
        errors.add(:group, :missing_controller, { controller: controller })
      end

      valid
    end

    def validate_action!
      name = widget_controller_name(group)
      controller = name.constantize

      unless controller.new.respond_to?(id)
        errors.add(:id, :missing_action, { controller: name })
      end
    end
  end
end
