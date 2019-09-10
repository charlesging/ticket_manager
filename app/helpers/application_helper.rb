module ApplicationHelper

  def open_ticket_count(project)
    project.tickets.count { |ticket| ticket.status != 'fixed' }
  end

  def comma_separated_tags(ticket)
    ticket.tags.map { |t| t.name }.join(', ')
  end

  def assignee_name(ticket)
    return '' if ticket.assignee.empty?
    User.find(ticket.assignee.to_i).name
  end

  def comment_updated?(comment)
    comment.updated_at != comment.created_at
  end

  def alphabetical(tags)
    tags.sort { |a, b| a.name.downcase <=> b.name.downcase }
  end
end
