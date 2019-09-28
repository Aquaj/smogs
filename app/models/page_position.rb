# == Schema Information
#
# Table name: page_positions
#
#  id                   :bigint
#  arc_position         :bigint
#  publication_position :bigint
#  story_position       :bigint
#  arc_id               :bigint
#  page_id              :bigint
#  publication_id       :bigint
#  story_id             :bigint
#

class PagePosition < ViewBackedModel
  belongs_to :page

  belongs_to :publication, optional: true
  belongs_to :arc, optional: true
  belongs_to :story, optional: true
end
