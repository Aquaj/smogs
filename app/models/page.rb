# == Schema Information
#
# Table name: pages
#
#  id             :bigint           not null, primary key
#  content        :text
#  position       :bigint
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint           not null
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

  validates_presence_of :title, :content, :position
end
