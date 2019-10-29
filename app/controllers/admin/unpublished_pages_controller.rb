class Admin::UnpublishedPagesController < Admin::BaseController
  def index
    @pages = ('a'..'e').to_a #FIXME: Temporary, to develop UI
  end
end
