class ApplicationController < ActionController::Base
  include ImplicitResource

  protect_from_forgery with: :null_session
  respond_to :json
end
