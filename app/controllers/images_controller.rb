class ImagesController < ApplicationController
  def new
    @image = Image.new
    binding.pry
  end

  def create

  end
end
