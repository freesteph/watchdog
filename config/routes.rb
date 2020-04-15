Watchdog::Engine.routes.draw do
  get '/widgets', to: 'widgets#index'
  get '/widgets/:group/:id', to: 'widgets#resolve'
end
