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

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
