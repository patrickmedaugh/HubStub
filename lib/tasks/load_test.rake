require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
desc "Load test"
task :load_test => :environment do
  4.times.map { Thread.new { load_activity } }.map(&:join)
end

def load_activity
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit("http://localhost:3000/")
    puts "At root"
    session.visit("http://localhost:3000/admin/venues")
    puts "unauthorized user tried to visit admin page"
    session.click_link("Login")
    session.fill_in "session[email]", with: email
    session.fill_in "session[password]", with: password
    session.click_link_or_button("Log in")
    puts "User is logged in"
    session.click_link("My Hubstub")
    session.click_link("Past Orders")
    session.click_link("My Hubstub")
    session.click_link("My Listings")
    puts "Viewed user's past orders"orders
    session.click_link("Adventure")
    puts "Visited Adventure path"
    session.click_link("My Hubstub")
    session.click_link("Manage Account")
    session.click_link("Edit User Profile")
    session.fill_in "user[city]", with: "Denver"
    session.click_button("Update Account")
    puts "Profile edited"
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    puts "Visited List a Ticket"
    session.fill_in "item[event_id]", with: rand(1..20000)
    session.fill_in "item[section]", with: "A3"
    session.fill_in "item[row]", with: "123"
    session.fill_in "item[seat]", with: "5"
    session.fill_in "item[unit_price]", with: 33
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    puts "Ticket created"
    session.click_link("My Hubstub")
    session.click_link("My Listings")
    session.all(:css, "tr.item-row").last.click_button("Edit Listing")
    session.fill_in "item[section]", with: "A3"
    session.click_button("Submit")
    puts "Ticket edited"
    session.all(:css, "tr.item-row").last.click_button("Delete Listing")
    puts "Ticket deleted"
    session.click_link("Logout")
    puts "User logged out"
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.click_link("All")
    session.click_link("Sports")
    session.click_link("Music")
    session.click_link("Comedy")
    session.click_link("Conference")
    session.click_link("Attaction")
    session.click_link("Tour")
    session.click_link("Seminar")
    session.click_link("Networking")
    session.click_link("Tournament")
    session.click_link("Festival")
    session.click_link("Rally")
    session.click_link("Expo")
    session.click_link("Party")
    puts "events filter used"
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.all("p.event-name a").sample.click
    session.first(:button, "Add to cart").click
    puts "Item added to cart"
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")
    session.fill_in "user[full_name]", with: "Shaq"
    session.fill_in "user[display_name]", with: ("A".."Z").to_a.shuffle.first(2).join
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "Main St."
    session.fill_in "user[city]", with: "Denver"
    session.select  "Colorado", from: "user[state]"
    session.fill_in "user[zipcode]", with: "80301"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")
    session.click_link("Cart(1)")
    session.click_link_or_button("Remove")
    puts "add item to cart, create account, and remove cart item"
  end
end
