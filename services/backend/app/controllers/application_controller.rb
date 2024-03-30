class ApplicationController < ActionController::Base
  include ImplicitResource
  respond_to :json
end
