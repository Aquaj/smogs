class ViewBackedModel < ApplicationRecord
  self.abstract_class = true

  def readonly?
    true
  end
end
