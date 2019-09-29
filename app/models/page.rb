# == Schema Information
#
# Table name: pages
#
#  id                :bigint           not null, primary key
#  content           :text
#  publication_order :bigint
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  publication_id    :bigint
#
# Indexes
#
#  index_pages_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class Page < ApplicationRecord
  belongs_to :publication, optional: true
  has_one :arc, through: :publication
  has_one :story, through: :arc
  has_many :pictures

  has_one :position, class_name: 'PagePosition'
  default_scope -> { left_joins(:position).order(:story_position) }

  validates_presence_of :title, :content
  validates_presence_of :publication_order, if: :publication_id?

  scope :published, -> { joins(:publication).merge(Publication.published) }
end
