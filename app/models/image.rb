# tableless class

class Image
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :content_type

  def initialize(file = nil)
    return unless file

    @content_type = file.content_type
    @content = file.read
  end

  def base64
    return unless @content
    Base64.encode64(@content)
  end

  def persisted?
    false
  end
end
