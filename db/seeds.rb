# db/seeds.rb

# Create sports
sports = Sport.create([
  { name: 'Football', description: 'A team sport played with a round ball.', image: 'football_image_url' },
  { name: 'Basketball', description: 'A team sport where players try to score by shooting a ball through a hoop.', image: 'basketball_image_url' },
  { name: 'Tennis', description: 'A racket sport played individually against a single opponent or between two teams of two players each.', image: 'tennis_image_url' }
])

# Create locations
locations = Location.create([
  { name: 'Stadium A', address: '123 Main St', pincode: '12345' },
  { name: 'Arena B', address: '456 Elm St', pincode: '67890' },
  { name: 'Court C', address: '789 Oak St', pincode: '54321' },
  { name: 'Field D', address: '101 Pine St', pincode: '98765' }
])

# Create users
users = User.create([
  { username: 'john_doe', email: 'john@example.com', first_name: 'John', last_name: 'Doe', password: 'password123', admin: false },
  { username: 'jane_smith', email: 'jane@example.com', first_name: 'Jane', last_name: 'Smith', password: 'password456', admin: false },
  { username: 'admin_user', email: 'admin@example.com', first_name: 'Admin', last_name: 'User', password: 'adminpassword', admin: true },
  { username: 'alice_jones', email: 'alice@example.com', first_name: 'Alice', last_name: 'Jones', password: 'alicepassword', admin: false }
])

# Create events
events = Event.create([
  { name: 'Football Match', description: 'Exciting football match between local teams.', total_seats: 100, sport_id: Sport.find_by(name: 'Football').id, location_id: Location.find_by(name: 'Stadium A').id, start_time: '2024-09-01 15:00:00', end_time: '2024-09-01 17:00:00' },
  { name: 'Basketball Tournament', description: 'Annual basketball tournament with several teams participating.', total_seats: 200, sport_id: Sport.find_by(name: 'Basketball').id, location_id: Location.find_by(name: 'Arena B').id, start_time: '2024-09-05 18:00:00', end_time: '2024-09-05 20:00:00' },
  { name: 'Tennis Open', description: 'Regional tennis open for players of all levels.', total_seats: 150, sport_id: Sport.find_by(name: 'Tennis').id, location_id: Location.find_by(name: 'Court C').id, start_time: '2024-09-10 10:00:00', end_time: '2024-09-10 17:00:00' },
  { name: 'Football Charity Match', description: 'Charity match with teams from different regions.', total_seats: 120, sport_id: Sport.find_by(name: 'Football').id, location_id: Location.find_by(name: 'Field D').id, start_time: '2024-09-15 16:00:00', end_time: '2024-09-15 18:00:00' }
])

# Create orders
orders = Order.create([
  { user_id: User.find_by(username: 'john_doe').id, event_id: Event.find_by(name: 'Football Match').id, status: 'confirmed' },
  { user_id: User.find_by(username: 'jane_smith').id, event_id: Event.find_by(name: 'Basketball Tournament').id, status: 'pending' },
  { user_id: User.find_by(username: 'admin_user').id, event_id: Event.find_by(name: 'Tennis Open').id, status: 'confirmed' },
  { user_id: User.find_by(username: 'alice_jones').id, event_id: Event.find_by(name: 'Football Charity Match').id, status: 'canceled' }
])
