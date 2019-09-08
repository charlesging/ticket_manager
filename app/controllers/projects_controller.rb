
class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :create, :new]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Your project was created."
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)    
      flash[:notice] = "The project has been updated."
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @project.destroy
    flash[:notice] = "The project was deleted."
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit!
  end

  def set_project
    @project = Project.find(params[:id])
  end
end