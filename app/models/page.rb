# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  content    :text
#  position   :bigint
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  update_id  :bigint           not null
#
# Indexes
#
#  index_pages_on_update_id  (update_id)
#
# Foreign Keys
#
#  fk_rails_...  (update_id => updates.id)
#

class Page < ApplicationRecord
  belongs_to :update, optional: true
  has_one :arc, through: :update
  has_one :story, through: :arc
  has_many :pictures

  validates_presence_of :title, :content, :position
end
