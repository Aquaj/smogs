class Admin::UnpublishedPagesController < Admin::BaseController
  def index
    @pages = Page.unpublished
  end
end
