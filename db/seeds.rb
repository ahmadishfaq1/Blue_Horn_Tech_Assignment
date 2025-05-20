# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
caregiver = Caregiver.create!(name: "Jane Doe")
client = Client.create!(name: "John Smith", address: "123 Main St, Anytown, USA")

Shift.create!(
  date: Date.today,
  start_time: Time.parse("09:00 AM"),
  end_time: Time.parse("05:00 PM"),
  caregiver: caregiver,
  client: client
)