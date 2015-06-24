class AddInstanceIdToCloudInstances < ActiveRecord::Migration
  def change
    add_column :cloud_instances, :instance_id, :string
    add_column :cloud_instances, :provider, :string
    add_column :cloud_instances, :instance_type, :string
    add_column :cloud_instances, :cores, :integer
    add_column :cloud_instances, :memory, :decimal
    add_column :cloud_instances, :cost, :string
    add_column :cloud_instances, :ratio, :string
  end
end
