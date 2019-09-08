class TicketsController < ApplicationController
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
      # TODO: add filter for tag when association exists
      @tickets = @tickets.joins(:tags).where('tags.id': params[:tag])
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    @ticket = Ticket.find(params[:id])

    if @ticket.destroy
      flash[:notice] = "Ticket successfully deleted."
      redirect_to tickets_path
    else
      render :tickets
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    # TODO: assign creator (current_user)
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      flash[:notice] ="Your ticket was created."
      redirect_to tickets_path
    else
      render :new
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])

    binding.pry

    if @ticket.update(ticket_params)
      flash[:notice] ="Your ticket was updated."
      redirect_to tickets_path      
    else
      render :new
    end
  end

  private

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

