class CopyOwnerIdToGroupIdForDashboards < ActiveRecord::Migration[5.1]
  class MiqSet < ActiveRecord::Base; end

  def up
    say_with_time("Copying owner_id to group_id in miq_sets table for each dashboard assigned to group") do
      MiqSet.where(:set_type => "MiqWidgetSet", :owner_type => "MiqGroup").find_each do |dashboard|
        dashboard.update(:group_id => dashboard.owner_id)
      end
    end
  end

  def down
    say_with_time("Nullifying group_id column in miw_sets table for each dashboard assigned to group") do
      MiqSet.where(:set_type => "MiqWidgetSet", :owner_type => "MiqGroup").find_each do |dashboard|
        dashboard.update(:group_id => nil)
      end
    end
  end
end
