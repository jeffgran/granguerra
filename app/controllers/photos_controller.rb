class PhotosController < ApplicationController
  DISABLED=false

  def index
    if DISABLED
      render template: 'shared/coming_soon'
    else
      render 'index'
    end
  end
end
