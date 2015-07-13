require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
desc "Load test"
task :load_test => :environment do
  4.times.map { Thread.new { load_activity } }.map(&:join)
end

def load_activity
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit("http://pure-inlet-7635.herokuapp.com")
    session.click_link("All Tickets")
    puts "All Tickets"
    session.click_link("Sports")
    puts "Sports"
    session.click_link("Music")
    puts "Music"
    session.click_link("Theater")
    puts "Theater"
    session.click_link("All")
    puts "All"
    session.all("p.event-name a").sample.click
    puts "Sample Event Clicked"
    session.all("tr").sample.find(:css, "input.btn").click
    puts "Sample Button Clicked"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password]", with: "password"
    session.click_button("Create m account!")
    puts "Login"
  end
end
