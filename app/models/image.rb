# tableless class

class Image
  # Image Magick
  require 'rmagick'
  include Magick

  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :content_type

  def initialize(file = nil)
    return unless file

    @file         = file
    @content_type = file.content_type
    @content      = file.read
    @image        = Image.from_blob(@content).first

    glitchify!
  end

  def base64
    return unless @content
    Base64.encode64(@content)
  end

  def persisted?
    false
  end

  private

  def glitchify!
    @image = @image.add_noise(LaplacianNoise)

    # binding.pry

    @content = @image.to_blob
  end
end
