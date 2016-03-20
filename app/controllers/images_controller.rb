class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    binding.pry
  end
end
