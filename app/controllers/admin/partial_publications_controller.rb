class Admin::PartialPublicationsController < Admin::BaseController
  def create
    # @publication = Publication.new(pages: Page.find(params[:page_ids]))
    @publication = Struct.new(:pages).new(pages.select { |p|
      params[:page_ids].include? p.id.to_s
    })
  end

  private

  def pages
    image = Struct.new(:path).new('comic-example.png')
    page = Struct.new(:id, :image, :description, :created_at)
    (1..7).map do |id|
      description = (id % 3 == 0) ? "Lorem ipsum dolor sit amet" : ""
      page.new(id, image, description, Time.now + id.hours)
    end
  end
end
