module ApplicationHelper

  def open_ticket_count(project)
    project.tickets.count { |ticket| ticket.status != 'fixed' }
  end

  def comma_separated_tags(ticket)
    ticket.tags.map { |t| t.name }.join(', ')
  end
end
