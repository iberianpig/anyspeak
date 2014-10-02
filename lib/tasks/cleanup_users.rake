namespace :users do
  # task needs description
  desc 'Cleanup users from table'

  task cleanup: :environment do
    # write to clean user table
    User.all.each do |user|
      user.destroy
    end
  end
end
