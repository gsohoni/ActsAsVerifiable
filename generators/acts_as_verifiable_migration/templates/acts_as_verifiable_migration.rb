class ActsAsVerifiableMigration < ActiveRecord::Migration
  def self.up
    create_table :verification_statuses do |t|
      t.boolean :is_verified
      t.integer :verifiable_id
      t.string :verifiable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :verification_statuses
  end
end