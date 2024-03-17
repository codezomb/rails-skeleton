class RootController < ApplicationController
  before_action :authenticate

  def index
    render json: {}
  end
end
