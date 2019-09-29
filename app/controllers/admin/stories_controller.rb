class Admin::StoriesController < Admin::BaseController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = scope
  end

  def show
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to [:admin, @story]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to [:admin, @story]
    else
      render :edit
    end
  end

  def destroy
    if @story.destroy
      #TODO: notify success
    else
      #TODO: notify failure
    end
  end

  private

    def scope
      Story.all
    end

    def set_story
      @story = scope.find(params[:story_id])
    end

    def story_params
      params.require(:story).permit(:name, :url_slug)
    end
end
