module Combable
  extend ActiveSupport::Concern

  module ClassMethods
    def combable(*attributes)
      class_attribute :combable_attributes
      self.combable_attributes = Array(attributes)
    end
  end

  def combable?(attribute)
    self.combable_attributes.include?(attribute)
  end
end
