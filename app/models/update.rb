# == Schema Information
#
# Table name: updates
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  arc_id       :bigint           not null
#
# Indexes
#
#  index_updates_on_arc_id  (arc_id)
#
# Foreign Keys
#
#  fk_rails_...  (arc_id => arcs.id)
#

class Update < ApplicationRecord
  belongs_to :arc
  has_one :story, through: :arc
  has_many :pages
end
