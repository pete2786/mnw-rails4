class Phrase < ActiveRecord::Base
  has_many :phrase_votes
  acts_as_taggable
  mount_uploader :custom_image, ImageUploader
end
