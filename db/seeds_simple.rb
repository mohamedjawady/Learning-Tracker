puts "🌱 Seeding the database..."

# Clear existing users
puts "Clearing existing users..."
User.delete_all

# Create sample users
puts "Creating users..."

admin_user = User.create!(
  email: "admin@learningtracker.com",
  password: "password123",
  password_confirmation: "password123"
)

demo_user = User.create!(
  email: "demo@learningtracker.com", 
  password: "password123",
  password_confirmation: "password123"
)

puts "✅ Created users:"
puts "- #{admin_user.email}"
puts "- #{demo_user.email}"

# Test authentication
puts "\n🔐 Testing authentication:"
test_user = User.find_by(email: 'admin@learningtracker.com')
auth_result = test_user.authenticate('password123')
puts "Authentication for admin@learningtracker.com: #{auth_result.present? ? '✅ SUCCESS' : '❌ FAILED'}"

puts "\n🌱 Database seeding completed!"
