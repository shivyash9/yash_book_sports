User.delete_all
Sport.delete_all
Location.delete_all
Event.delete_all
Order.delete_all

users = User.create!([
  { username: 'john_doe', email: 'john@example.com', encrypted_password: 'password123', first_name: 'John', last_name: 'Doe', admin: false },
  { username: 'jane_smith', email: 'jane@example.com', encrypted_password: 'password123', first_name: 'Jane', last_name: 'Smith', admin: true }
])

sports = Sport.create!([
  { name: 'Football', description: 'A team sport played with a spherical ball.' },
  { name: 'Basketball', description: 'A sport where two teams try to score by throwing a ball through a hoop.' }
])

locations = Location.create!([
  { name: 'Main Stadium', address: '123 Stadium Lane', pincode: '12345' },
  { name: 'City Arena', address: '456 Arena Blvd', pincode: '67890' }
])

events = Event.create!([
  { name: 'Football Match', description: 'A thrilling football match between two teams.', total_seats: 500, sport_id: sports.first.id, location_id: locations.first.id, start_time: Time.now + 1.day, end_time: Time.now + 1.day + 2.hours },
  { name: 'Basketball Game', description: 'An exciting basketball game with top teams.', total_seats: 300, sport_id: sports.second.id, location_id: locations.second.id, start_time: Time.now + 2.days, end_time: Time.now + 2.days + 2.hours }
])

Order.create!([
  { user_id: users.first.id, event: events.first, status: 'pending' },
  { user_id: users.second.id, event: events.second, status: 'confirmed' }
])
