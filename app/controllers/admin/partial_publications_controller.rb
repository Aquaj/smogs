class Admin::PartialPublicationsController < Admin::BaseController
  def create
    @publication = Publication.new(pages: Page.find(params[:page_ids]))
  end
end
