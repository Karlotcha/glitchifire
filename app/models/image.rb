# tableless class

class Image
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def persisted?
    false
  end
end
