
class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :edit]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:notice] = "Tag successfully created."
      redirect_to tags_path
    else
      render :new
    end 
  end

  def edit
  end

  def update
    if @tag.update(tag_params)    
      flash[:notice] = "Tag successfully updated."
      redirect_to tags_path(@tag)
    else
      render :edit
    end
  end


  private

  def tag_params
    params.require(:tag).permit!
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end