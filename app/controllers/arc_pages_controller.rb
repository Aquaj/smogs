class ArcPagesController < ApplicationController
  before_action :set_story_and_arc

  def show
    @page = @arc.pages.published.find_page(params[:position])
  end

  private

    def set_story_and_arc
      @story = Story.published.find_by!(slug: params[:story_slug])
      @arc = @story.arcs.find_by!(slug: params[:arc_slug])
    end
end
