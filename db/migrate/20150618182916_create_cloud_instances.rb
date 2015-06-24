class CreateCloudInstances < ActiveRecord::Migration
  def change
    create_table :cloud_instances do |t|

      t.timestamps null: false
    end
  end
end
