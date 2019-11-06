class Admin::UnpublishedPagesController < Admin::BaseController
  def index
    image = Struct.new(:path).new('comic-example.png')
    page = Struct.new(:id, :image, :description, :created_at)
    @pages = (1..7).map do |id|
      description = (id % 3 == 0) ? "Lorem ipsum dolor sit amet" : ""
      page.new(id, image, description, Time.now + id.hours)
    end
  end
end
