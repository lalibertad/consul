class Admin::TagsController < Admin::BaseController
  before_action :find_tag, :all_tags, only: [:update, :destroy]

  respond_to :html, :js

  def index
    all_tags
    @tag = ActsAsTaggableOn::Tag.category.new
  end

  def create
    ActsAsTaggableOn::Tag.category.create(tag_params)
    redirect_to admin_tags_path
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path
  end

  def order
    @tags = all_tags
    i = 1
    params[:order].each do |k|
      @tags.each do |tag|
        if tag.id == k.to_f
          tag.order = i
          tag.save
          i += 1
          break
        end
      end
    end
    render :json => 1
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end

    def find_tag
      @tag = ActsAsTaggableOn::Tag.category.find(params[:id])
    end

    def all_tags
      @tags = ActsAsTaggableOn::Tag.category.all
    end

end
