

class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_ticket
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_creator, only: [:edit, :update, :destroy]


  def edit
  end

  def create
    # TODOL fix these params
    @comment = Comment.new(body: params[:comment][:body], ticket_id: params[:ticket_id], user_id: current_user.id)
    

    if @comment.save
      if params[:ticket_status].present?
        @ticket.update_attribute(:status, params[:ticket_status])
      end
      flash[:notice] = 'Comment was created.'
      redirect_to @ticket
    else
      render :edit
    end
  end

  def update
    if @comment.update(comment_params)
      if params[:ticket_status].present?
        @ticket.update_attribute(:status, params[:ticket_status])
      end
      flash[:notice] = 'Comment was updated.'
      redirect_to @ticket
    else
      render :edit
    end

  end

  private

  def require_creator
    if @comment.user_id != current_user.id
      flash[:error] = "You can only edit your own comments."
      redirect_to ticket_path(@ticket)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end