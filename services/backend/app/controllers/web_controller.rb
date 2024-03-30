class WebController < ApplicationController
  respond_to :html

  def show
    render html: nil, layout: true
  end
end
