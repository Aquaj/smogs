# == Schema Information
#
# Table name: publications
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  arc_id       :bigint           not null
#
# Indexes
#
#  index_publications_on_arc_id  (arc_id)
#
# Foreign Keys
#
#  fk_rails_...  (arc_id => arcs.id)
#

class Publication < ApplicationRecord
  belongs_to :arc
  has_one :story, through: :arc
  has_many :pages

  scope :published, -> (at: DateTime.now) { where(arel_table[:published_at].lteq(at)) }
end
