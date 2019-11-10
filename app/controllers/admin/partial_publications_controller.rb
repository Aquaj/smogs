class Admin::PartialPublicationsController < Admin::BaseController
  def create
    @publication = Publication.new(pages: Page.unpublished.find(params[:page_ids]))
  end
end
