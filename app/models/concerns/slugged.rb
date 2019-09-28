module Slugged
  extend ActiveSupport::Concern

  included do
    validates_presence_of :url_slug
    validates_uniqueness_of :url_slug
    alias_attribute :slug, :url_slug
  end
end
