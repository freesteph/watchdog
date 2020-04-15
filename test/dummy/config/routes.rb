Rails.application.routes.draw do
  mount Watchdog::Engine => "/watchdog"
end
