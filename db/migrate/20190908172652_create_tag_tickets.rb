class CreateTagTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_tickets do |t|
      t.integer :ticket_id, :tag_id
      t.timestamps      
    end
  end
end
