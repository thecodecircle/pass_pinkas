# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

unless Admin.find_by(email: "codecircle13@gmail.com").present?
  Admin.create(email: "codecircle13@gmail.com", password: "mered1913")
  puts "Inserted Admin"
  end

require 'csv'

if File.file?(Rails.root.join('lib/task_seeds.csv'))
  counter = 0
  CSV.foreach(Rails.root.join('lib/task_seeds.csv'), headers: true) do |row|
    Task.create!({
      name: row[0],
      description: row[1],
      difficulty: row[2],
      age: row[3],
      publicity: 1,
      status: 1
    })
    counter += 1
  end
  puts "Inserted #{counter} Tasks"
end
