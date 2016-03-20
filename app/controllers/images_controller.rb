class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    # params['image']['file']
  end
end
