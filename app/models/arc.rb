# == Schema Information
#
# Table name: arcs
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :bigint
#  url_slug   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_arcs_on_story_id  (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (story_id => stories.id)
#

class Arc < ApplicationRecord
  include Slugged, Covered

  belongs_to :story
  has_many :publications
  has_many :pages, through: :publications

  validates_presence_of :position, :name

  scope :published, -> { joins(:publications).merge(Publication.published) }
end
