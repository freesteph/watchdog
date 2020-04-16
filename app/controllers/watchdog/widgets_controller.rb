module Watchdog
  class WidgetsController < ApplicationController
    before_action :index, :setup_flash, :map_widgets, :check_widgets

    def resolve
      id = params[:id]
      controller = helpers.widget_controller_name params[:group]

      c = controller.constantize.new
      c.request = request
      c.response = response

      render json: c.send(id)
    end

    def index
    end

    private

    def map_widgets
      if not Rails.application.config.respond_to? :widgets
        flash[:notice] = "Your <code>Rails.config.application</code> does not contain a <code>widgets</code> property. Make sure you have an initializer to set it up."
        @widgets = []
        return
      end

      data = Rails.application.config.widgets

      @widgets = data['widgets'].map do |attrs|
        Widget.new(attrs)
      end
    end

    def check_widgets
      return if @widgets.nil?

      @widgets.select! do |widget|
        name = helpers.widget_controller_name(widget.group)

        valid = true

        begin
          c = name.constantize

          if not c.new.respond_to?(widget.id)
            flash[:errors][:widgets] << [widget, :missing_action]
            valid = false
          end

          true
        rescue NameError
          flash[:errors][:widgets] << [widget, :missing_controller]
          valid = false
        end

        valid
      end
    end

    def setup_flash
      flash[:errors] = {
        widgets: []
      }
    end

    def logo_for widget
    end

    def widget_id widget
    end

    def widget_classes widget
    end
  end
end
