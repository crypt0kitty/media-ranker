require 'faker'
require 'date'
require 'csv'

# we already provide a filled out works_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new works_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

WORK_FILE = Rails.root.join('db', 'seed_data', 'works-seeds.csv')

CSV.open(
  WORK_FILE,
  'w',
  write_headers: true,
  headers: %w[category title creator publication_year description]
) do |csv|
  25.times do
    category = %w[album book movie].sample
    title = Faker::Coffee.blend_name
    creator = Faker::Name.name
    publication_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::Lorem.sentence

    csv << [category, title, creator, publication_year, description]
  end
end
