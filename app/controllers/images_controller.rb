class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = params['image'] ? Image.new(params['image']['file']) : Image.new
    render 'new'
  end
end
