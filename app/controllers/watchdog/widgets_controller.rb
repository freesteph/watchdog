module Watchdog
  class WidgetsController < ApplicationController
    before_action :index, :map_widgets, :check_widgets

    def resolve
      id = params[:id]
      controller = controller_name params[:group]

      c = controller.constantize.new
      c.request = request
      c.response = response

      render json: c.send(id)
    end

    def index
    end

    private

    def map_widgets
      puts Rails.application.config.respond_to? :widgets
      return unless Rails.application.config.respond_to? :widgets

      data = Rails.application.config.widgets

      @widgets = data['groups'].map do |group|
        group['widgets'].map do |widget|
          Widget.new group, widget
        end
      end.flatten
    end

    def check_widgets
      return if @widgets.nil?

      flash[:alert] = []

      @widgets.select! do |widget|
        name = controller_name(widget.group)

        begin
          name.constantize
          true
        rescue NameError
          flash[:alert] << [widget, name]
          false
        end
      end
    end

    def controller_name(controller)
      "Watchdog::" + ActiveSupport::Inflector.classify(controller + '_controller')
    end

    def logo_for widget
    end

    def widget_id widget
    end

    def widget_classes widget
    end
  end
end
