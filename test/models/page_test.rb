# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  content    :text
#  position   :bigint
#  title      :string
#  url_slug   :string
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

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
