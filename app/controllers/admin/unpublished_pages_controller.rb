class Admin::UnpublishedPagesController < Admin::BaseController
  def index
    page = Struct.new(:id, :created_at)
    @pages = (1..7).map { |id| page.new(id, Time.now + id.hours) }
  end
end
