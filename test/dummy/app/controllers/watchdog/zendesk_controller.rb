module Watchdog
  class ZendeskController < ApplicationController
    def unanswered_tickets
      render json: [[3, 2], [4, 2]]
    end

    def answered_tickets
      render json: [[0, 1], [1, 2], [2, 0], [3, 3]]
    end
  end
end
