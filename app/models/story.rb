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
  has_many :publications, through: :arcs
  has_many :pages, through: :publications do
    def find_page(position)
      PagePosition.where(page: self).find_by!(
        story_position: position,
        story_id: proxy_association.owner.id).page
    end
  end

  has_one_attached :cover

  scope :published, -> { joins(:arcs).merge(Arc.published) }
end
