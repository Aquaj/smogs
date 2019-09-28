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
  include Slugged, Covered

  has_many :arcs
  has_many :updates, through: :arcs
  has_many :pages, through: :updates

  has_one_attached :cover

  scope :published, -> { joins(:arcs).merge(Arc.published) }
end
