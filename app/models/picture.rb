# == Schema Information
#
# Table name: pictures
#
#  id         :bigint           not null, primary key
#  alt_text   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint           not null
#
# Indexes
#
#  index_pictures_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#

class Picture < ApplicationRecord
  belongs_to :pages

  has_one_attached :image

  validates_presence_of :alt_text
end
