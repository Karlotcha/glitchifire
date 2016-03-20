# tableless class

class Image
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :content_type

  def initialize(file = nil)
    return unless file

    @file         = file
    @content_type = file.content_type
    @content      = file.read

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
    headers = @content.split("\n")[0..4]
    body = @content.split("\n")[5..-1]
    new_body = body
    new_body[0] = Base64.decode64(Base64.encode64(new_body[0]).sub('A', 'AA'))
    # new_body = body.map { |l| Base64.decode64(Base64.encode64(l).sub('A', 'B')) }

    # binding.pry

    @content =(headers + new_body).join("\n")
  end
end
