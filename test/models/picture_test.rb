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

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
