namespace :user do
  # add rake task and execute is with Cron every 10 minutes for example
  task :set_ranks => :environment do
     User.desc(:score).asc(:solution_count).each_with_index do |user, position|
       user.update_attribute(:rank, position + 1)
     end
  end
end