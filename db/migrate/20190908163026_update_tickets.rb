class UpdateTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :assignee, :string, { default: nil }
  end
end
