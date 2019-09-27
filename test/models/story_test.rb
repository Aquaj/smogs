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

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
