# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding the database..."

# Clear existing data in proper order (respecting foreign keys)
puts "Clearing existing data..."
Note.delete_all
CalendarEvent.delete_all
Todo.delete_all
Article.delete_all
Lab.delete_all
Video.delete_all
Chapter.delete_all
Book.delete_all
Course.delete_all
User.delete_all

# Create sample users
puts "Creating users..."

john_user = User.create!(
  name: "John Smith",
  email: "john@example.com",
  password: "password123",
  password_confirmation: "password123"
)

jane_user = User.create!(
  name: "Jane Doe",
  email: "jane@example.com", 
  password: "password123",
  password_confirmation: "password123"
)

# Create sample courses
puts "Creating courses..."

course1 = Course.create!(
  title: "Ruby on Rails Mastery",
  description: "Complete guide to building web applications with Ruby on Rails",
  instructor: "John Smith",
  platform: "Udemy",
  url: "https://udemy.com/rails-course",
  status: "in_progress",
  start_date: 1.month.ago,
  target_completion_date: 1.month.from_now,
  total_duration_hours: 40,
  difficulty_level: "Intermediate",
  user: john_user
)

course2 = Course.create!(
  title: "JavaScript ES6+ Fundamentals",
  description: "Modern JavaScript concepts and best practices",
  instructor: "Jane Doe",
  platform: "Coursera",
  url: "https://coursera.org/js-course",
  status: "not_started",
  target_completion_date: 2.months.from_now,
  total_duration_hours: 25,
  difficulty_level: "Beginner",
  user: jane_user
)

# Create chapters for course1
puts "Creating chapters..."

Chapter.create!([
  {
    course: course1,
    title: "Introduction to Rails",
    description: "Getting started with Rails framework",
    order_number: 1,
    completed: true,
    completed_at: 2.weeks.ago
  },
  {
    course: course1,
    title: "Models and ActiveRecord",
    description: "Database models and ORM concepts",
    order_number: 2,
    completed: true,
    completed_at: 1.week.ago
  },
  {
    course: course1,
    title: "Controllers and Routing",
    description: "Handling requests and responses",
    order_number: 3,
    completed: false
  },
  {
    course: course1,
    title: "Views and Helpers",
    description: "Creating dynamic user interfaces",
    order_number: 4,
    completed: false
  }
])

# Create videos for course1
puts "Creating videos..."

Video.create!([
  {
    course: course1,
    title: "Rails Installation",
    description: "Setting up Rails development environment",
    order_number: 1,
    duration_minutes: 15,
    completed: true,
    completed_at: 2.weeks.ago
  },
  {
    course: course1,
    title: "First Rails App",
    description: "Creating your first Rails application",
    order_number: 2,
    duration_minutes: 30,
    completed: false
  },
  {
    course: course1,
    title: "Understanding MVC",
    description: "Model-View-Controller architecture",
    order_number: 3,
    duration_minutes: 25,
    completed: false
  }
])

# Create labs for course1
puts "Creating labs..."

Lab.create!([
  {
    course: course1,
    title: "Build a Blog App",
    description: "Create a simple blog application",
    instructions: "Follow the Rails guide to build a basic blog with posts and comments",
    order_number: 1,
    completed: true,
    completed_at: 1.week.ago
  },
  {
    course: course1,
    title: "User Authentication",
    description: "Implement user login and registration",
    instructions: "Add user authentication using Rails built-in features",
    order_number: 2,
    completed: false
  }
])

# Create sample books
puts "Creating books..."

book1 = Book.create!(
  title: "Clean Code",
  author: "Robert C. Martin",
  description: "A handbook of agile software craftsmanship",
  isbn: "978-0132350884",
  status: "in_progress",
  current_page: 150,
  total_pages: 464,
  start_date: 1.month.ago,
  target_completion_date: 2.months.from_now,
  user: john_user
)

book2 = Book.create!(
  title: "The Pragmatic Programmer",
  author: "David Thomas, Andrew Hunt",
  description: "Your journey to mastery",
  isbn: "978-0135957059",
  status: "not_started",
  current_page: 0,
  total_pages: 352,
  target_completion_date: 3.months.from_now,
  user: jane_user
)

# Create chapters for books
puts "Creating book chapters..."

Chapter.create!([
  {
    book: book1,
    title: "Meaningful Names",
    description: "How to choose good names for variables and functions",
    order_number: 1,
    completed: true,
    completed_at: 2.weeks.ago
  },
  {
    book: book1,
    title: "Functions",
    description: "Writing clean and maintainable functions",
    order_number: 2,
    completed: true,
    completed_at: 1.week.ago
  },
  {
    book: book1,
    title: "Comments",
    description: "When and how to write good comments",
    order_number: 3,
    completed: false
  }
])

# Create sample articles
puts "Creating articles..."

Article.create!([
  {
    title: "10 Ruby on Rails Best Practices",
    author: "Rails Community",
    url: "https://example.com/rails-best-practices",
    description: "Essential practices for Rails developers",
    status: "completed",
    estimated_read_time: 15,
    time_spent: 18,
    user: john_user
  },
  {
    title: "JavaScript Async/Await Explained",
    author: "Tech Blog",
    url: "https://example.com/async-await",
    description: "Understanding asynchronous JavaScript",
    status: "in_progress",
    estimated_read_time: 20,
    time_spent: 12,
    user: jane_user
  },
  {
    title: "Database Design Principles",
    author: "DB Expert",
    url: "https://example.com/db-design",
    description: "Fundamentals of good database design",
    status: "not_started",
    estimated_read_time: 25,
    time_spent: 0,
    user: john_user
  }
])

# Create sample todos
puts "Creating todos..."

Todo.create!([
  {
    title: "Review Rails authentication chapter",
    description: "Go through the user authentication section again",
    priority: "high",
    due_date: 3.days.from_now,
    completed: false,
    user: john_user
  },
  {
    title: "Practice JavaScript exercises",
    description: "Complete 5 coding challenges on HackerRank",
    priority: "medium",
    due_date: 1.week.from_now,
    completed: false,
    user: jane_user
  },
  {
    title: "Setup development environment",
    description: "Install Ruby, Rails, and configure text editor",
    priority: "medium",
    completed: true,
    completed_at: 1.week.ago,
    user: john_user
  },
  {
    title: "Read Clean Code chapter 4",
    description: "Comments chapter in Clean Code book",
    priority: "medium",
    due_date: 5.days.from_now,
    completed: false,
    user: jane_user
  }
])

# Create sample calendar events
puts "Creating calendar events..."

CalendarEvent.create!([
  {
    title: "Rails Course Study Session",
    description: "Continue with Controllers chapter",
    start_date: 2.days.from_now.change(hour: 10, min: 0),
    end_date: 2.days.from_now.change(hour: 12, min: 0),
    event_type: "study_session",
    eventable: course1,
    user: john_user
  },
  {
    title: "Clean Code Reading",
    description: "Read Comments chapter",
    start_date: 3.days.from_now.change(hour: 14, min: 0),
    end_date: 3.days.from_now.change(hour: 15, min: 30),
    event_type: "study_session",
    eventable: book1,
    user: john_user
  },
  {
    title: "Course Assignment Deadline",
    description: "Submit User Authentication lab",
    start_date: 5.days.from_now.change(hour: 23, min: 59),
    event_type: "deadline",
    eventable: course1,
    all_day: false,
    user: john_user
  },
  {
    title: "Weekly Learning Review",
    description: "Review progress and plan next week",
    start_date: 7.days.from_now.change(hour: 9, min: 0),
    end_date: 7.days.from_now.change(hour: 10, min: 0),
    event_type: "reminder",
    user: jane_user
  }
])

# Create sample notes
puts "Creating notes..."

# Create some global notes
study_folder = Note.create!(
  title: "Study Notes",
  is_folder: true,
  color: "#FEF3C7",
  position: 1,
  user: john_user
)

Note.create!(
  title: "Learning Strategy",
  content: "<h2>My Learning Strategy</h2><p>Focus on <strong>practical projects</strong> while studying theory.</p><ul><li>Code along with tutorials</li><li>Build personal projects</li><li>Take detailed notes</li></ul>",
  parent: study_folder,
  position: 1,
  user: john_user
)

Note.create!(
  title: "Daily Learning Schedule",
  content: "<h3>Morning (9-11 AM)</h3><p>📚 Read technical books</p><h3>Afternoon (2-4 PM)</h3><p>💻 Hands-on coding</p><h3>Evening (7-8 PM)</h3><p>📝 Review and note-taking</p>",
  parent: study_folder,
  position: 2,
  user: john_user
)

# Create course-specific notes
course1_notes_folder = Note.create!(
  title: "Rails Course Notes",
  notable: course1,
  is_folder: true,
  color: "#DBEAFE",
  position: 1,
  user: john_user
)

Note.create!(
  title: "MVC Architecture",
  content: "<h2>Model-View-Controller Pattern</h2><p>Rails follows the MVC architectural pattern:</p><ul><li><strong>Model:</strong> Data and business logic</li><li><strong>View:</strong> User interface presentation</li><li><strong>Controller:</strong> Handles user input and coordinates model/view</li></ul><p>This separation makes code more maintainable and scalable.</p>",
  notable: course1,
  parent: course1_notes_folder,
  position: 1,
  user: john_user
)

Note.create!(
  title: "ActiveRecord Tips",
  content: "<h3>Important ActiveRecord Methods</h3><code>User.find(1)</code> - Find by ID<br><code>User.where(name: 'John')</code> - Filter records<br><code>User.create(name: 'Jane')</code> - Create new record<br><br><p><em>Remember to use strong parameters in controllers!</em></p>",
  notable: course1,
  parent: course1_notes_folder,
  position: 2,
  user: john_user
)

# Create book-specific notes
book_notes = Note.create!(
  title: "Key Insights from Clean Code",
  notable: book1,
  content: "<h2>Clean Code Principles</h2><blockquote>Clean code is simple and direct. Clean code reads like well-written prose.</blockquote><p><strong>Main principles:</strong></p><ol><li>Meaningful names</li><li>Small functions</li><li>Clear comments (when necessary)</li><li>Consistent formatting</li></ol>",
  position: 1,
  user: john_user
)

puts "✅ Database seeded successfully!"
puts ""
puts "� Users created:"
puts "  - John Smith (john@example.com)"
puts "  - Jane Doe (jane@example.com)"
puts ""
puts "�📊 Learning content created:"
puts "  - #{Course.count} courses"
puts "  - #{Book.count} books"
puts "  - #{Article.count} articles"
puts "  - #{Chapter.count} chapters"
puts "  - #{Video.count} videos"
puts "  - #{Lab.count} labs"
puts "  - #{Todo.count} todos"
puts "  - #{CalendarEvent.count} calendar events"
puts "  - #{Note.count} notes"
puts ""
puts "🔐 Login credentials:"
puts "  Email: john@example.com or jane@example.com"
puts "  Password: password123"
puts "  - #{Note.count} notes"
puts ""
puts "🚀 Your learning tracker is ready to go!"
puts "   Visit http://localhost:3000 to get started"
