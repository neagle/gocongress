class AddJobIdToUserJobs < ActiveRecord::Migration
  def self.up
    add_column :user_jobs, :job_id, :integer
  end

  def self.down
    remove_column :user_jobs, :job_id
  end
end
