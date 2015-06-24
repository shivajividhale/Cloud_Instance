class AddClockSpeedAndFactorToCloudinstance < ActiveRecord::Migration
  def change
    add_column :cloud_instances, :clock_speed, :decimal
  	add_column :cloud_instances, :factor, :integer
    
  end
end
