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

    # glitchify!
  end

  def width
    @width ||= @image.columns
  end

  def height
    @height ||= @image.rows
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
    noises = [
      UniformNoise,
      GaussianNoise,
      MultiplicativeGaussianNoise,
      ImpulseNoise,
      LaplacianNoise,
      PoissonNoise,
      RandomNoise,
    ]

    random = Random.new

    50.times do
      x = random.rand(width)
      y = random.rand(height)
      w = random.rand((width - x)/10 + 1)
      h = random.rand((height - y)/10 + 1)
      # crop  = @image.crop(x, y, w, h).add_noise(noises.sample)
      crop  = @image.crop(x, y, w, h).add_noise(LaplacianNoise)
      @image = @image.composite(crop, x, y, OverCompositeOp)
    end

    200.times do
      x = random.rand(width)
      y = random.rand(height)
      w = random.rand((width - x)/10 + 1)
      h = random.rand((height - y)/10 + 1)
      crop  = @image.crop(x, y, w, h)
      x_moved = x - 20 + random.rand(20)
      y_moved = y - 20 + random.rand(20)
      @image = @image.composite(crop, x_moved, y_moved, OverCompositeOp)
    end

    # binding.pry

    # gc = Magick::Draw.new
    # gc.stroke('red')
    # gc.stroke_width(2)
    # gc.fill('none')
    # gc.rectangle(x, y, x+w, y+h)
    # gc.draw(@image)

    @content = @image.to_blob
  end
end
