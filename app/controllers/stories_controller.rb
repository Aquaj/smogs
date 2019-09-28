class StoriesController < ApplicationController
  def index
    @stories = scope
  end

  def show
    @story = scope.find(params[:id])
    @arcs = @story.arcs.published
  end

  private

    def scope
      Story.published
    end
end
