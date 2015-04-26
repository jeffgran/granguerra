class PhotosController < ApplicationController
  DISABLED=true

  def index
    if DISABLED
      render template: 'shared/coming_soon'
    else
      render 'index'
    end
  end
end
