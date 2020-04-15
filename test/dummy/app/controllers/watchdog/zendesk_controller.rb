module Watchdog
  class ZendeskController < ApplicationController
    def unanswered_tickets
      render json: [[3, 2], [4, 2]]
    end

    def answered_tickets
    end
  end
end
