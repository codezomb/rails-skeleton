class RootController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { }
  end
end
