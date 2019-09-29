class StoryPagesController < ApplicationController
  before_action :set_story

  def show
    @page = @story.pages.published.find_page(params[:position])
  end

  private

    def set_story
      @story = Story.published.find_by!(slug: params[:story_slug])
    end
end
