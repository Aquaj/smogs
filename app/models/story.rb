# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  name       :string
#  url_slug   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ApplicationRecord
  has_many :arcs
  has_many :updates, through: :arcs
  has_many :pages, through: :updates

  has_one_attached :cover

  validates_presence_of :name, :url_slug
  validates_uniqueness_of :url_slug

  scope :published, -> { joins(:updates).merge(Update.published) }
end
