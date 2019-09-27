# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ApplicationRecord
  has_many :arcs
  has_many :updates, through: :arcs
  has_many :pages, through: :updates

  has_one_attached :cover

  validates_presence_of :name
end
