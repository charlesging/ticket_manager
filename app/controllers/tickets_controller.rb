class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :destroy, :edit, :update]
  before_action :require_user, except: [:index, :show]

  # TODO: ensure only the creator of a ticket can edit it (same_user?)

  def index
    @tickets = Ticket.all
    @tickets = if params[:project].present?
                  Project.find(params[:project]).tickets
               else
                  Ticket.all
               end

    if params[:status].present?
      @tickets = @tickets.where("status = ?", params[:status])
    end

    if params[:tag].present?
      @tickets = @tickets.joins(:tags).where('tags.id': params[:tag])
    end
  end

  def show
  end

  def destroy
    if @ticket.destroy
      flash[:notice] = "Ticket successfully deleted."
      redirect_to tickets_path
    else
      render :index
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    # TODO: assign creator (current_user)
    @ticket = Ticket.new(ticket_params)
    @ticket.creator = current_user

    if @ticket.save

      flash[:notice] ="Your ticket was created."
      redirect_to tickets_path
    else
      render :new
    end
  end

  def edit
  end

  def update    
    if @ticket.update(ticket_params)
      flash[:notice] ="Your ticket was updated."
      redirect_to tickets_path      
    else
      render :edit
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def filter_tickets(tickets)
    if params[:project] != 'all'
      tickets = tickets.select { |t| t.project_id == params[:project_id]}
    end

    if params[:status] != 'all'
      tickets = tickets.select { |t| t.status == params[:status]}
    end
    tickets
  end

  def ticket_params
    params.require(:ticket).permit!
  end

end

