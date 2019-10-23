class PagesController < ApplicationController
  before_action :set_story

  def show
    @page = @story.pages.published.find_page(params[:position])
  end

  private

    def set_story
      @story = Story.order(:created_at).first
    end
end
