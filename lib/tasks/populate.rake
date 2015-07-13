# require 'populator'

desc "Populate StubHub"
task  :populate => :environment do
  @venues = Venue.all
  @categories = Category.all
  @images = Image.all
  Event.populate(30000) do |event|
    event.title = Faker::Company.name
    event.description = Faker::Company.catch_phrase
    event.date = 30.days.from_now
    event.start_time = "2000-01-01 22:30:00"
    event.approved = true
    event.image_id = @images.sample.id
    event.venue_id = @venues.sample.id
    event.category_id = @categories.sample.id
  end

  @events = Event.all

  User.populate(200000) do |user|
    user.full_name        = Faker::Name.name
    user.email            = Faker::Internet.email
    user.password_digest  = "password"
    user.street_1         = Faker::Address.street_address
    user.street_2         = Faker::Address.secondary_address
    user.city             = Faker::Address.city
    user.state            = Faker::Address.state
    user.zipcode          = 80123
    user.display_name     = Faker::Internet.user_name

    Item.populate(3) do |item|
      item.unit_price = rand(1000..10000)
      item.pending = false
      item.sold = false
      item.section = rand(1..100)
      item.row = rand(1..50)
      item.seat = rand(1..20)
      item.delivery_method = "physical"
      item.event_id = @events.sample
      item.user_id = user.id
    end
  end
end
