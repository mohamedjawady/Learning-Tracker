# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding the database..."

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
  difficulty_level: "Intermediate"
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
  difficulty_level: "Beginner"
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
    watched_minutes: 15,
    completed: true,
    completed_at: 2.weeks.ago
  },
  {
    course: course1,
    title: "First Rails App",
    description: "Creating your first Rails application",
    order_number: 2,
    duration_minutes: 30,
    watched_minutes: 20,
    completed: false
  },
  {
    course: course1,
    title: "Understanding MVC",
    description: "Model-View-Controller architecture",
    order_number: 3,
    duration_minutes: 25,
    watched_minutes: 0,
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
    order_number: 1,
    completed: true,
    completed_at: 1.week.ago,
    notes: "Completed successfully. Added extra CSS styling."
  },
  {
    course: course1,
    title: "User Authentication",
    description: "Implement user login and registration",
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
  start_date: 3.weeks.ago,
  target_completion_date: 2.weeks.from_now,
  current_page: 150,
  total_pages: 464
)

book2 = Book.create!(
  title: "The Pragmatic Programmer",
  author: "David Thomas, Andrew Hunt",
  description: "Your journey to mastery",
  isbn: "978-0135957059",
  status: "not_started",
  current_page: 0,
  total_pages: 352
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
    completed_at: 2.weeks.ago,
    page_start: 17,
    page_end: 30
  },
  {
    book: book1,
    title: "Functions",
    description: "Writing clean and maintainable functions",
    order_number: 2,
    completed: true,
    completed_at: 1.week.ago,
    page_start: 31,
    page_end: 52
  },
  {
    book: book1,
    title: "Comments",
    description: "When and how to write good comments",
    order_number: 3,
    completed: false,
    page_start: 53,
    page_end: 70
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
    time_spent: 18
  },
  {
    title: "JavaScript Async/Await Explained",
    author: "Tech Blog",
    url: "https://example.com/async-await",
    description: "Understanding asynchronous JavaScript",
    status: "in_progress",
    estimated_read_time: 20,
    time_spent: 12
  },
  {
    title: "Database Design Principles",
    author: "DB Expert",
    url: "https://example.com/db-design",
    description: "Fundamentals of good database design",
    status: "not_started",
    estimated_read_time: 25,
    time_spent: 0
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
    completed: false
  },
  {
    title: "Practice JavaScript exercises",
    description: "Complete 5 coding challenges on HackerRank",
    priority: "medium",
    due_date: 1.week.from_now,
    completed: false
  },
  {
    title: "Setup development environment",
    description: "Install Ruby, Rails, and configure text editor",
    priority: "high",
    completed: true,
    completed_at: 1.week.ago
  },
  {
    title: "Read Clean Code chapter 4",
    description: "Comments chapter in Clean Code book",
    priority: "medium",
    due_date: 5.days.from_now,
    completed: false
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
    eventable: course1
  },
  {
    title: "Clean Code Reading",
    description: "Read Comments chapter",
    start_date: 3.days.from_now.change(hour: 14, min: 0),
    end_date: 3.days.from_now.change(hour: 15, min: 30),
    event_type: "study_session",
    eventable: book1
  },
  {
    title: "Course Assignment Deadline",
    description: "Submit User Authentication lab",
    start_date: 5.days.from_now.change(hour: 23, min: 59),
    event_type: "deadline",
    eventable: course1,
    all_day: false
  },
  {
    title: "Weekly Learning Review",
    description: "Review progress and plan next week",
    start_date: 7.days.from_now.change(hour: 9, min: 0),
    end_date: 7.days.from_now.change(hour: 10, min: 0),
    event_type: "reminder"
  }
])

puts "✅ Database seeded successfully!"
puts ""
puts "📊 Created:"
puts "  - #{Course.count} courses"
puts "  - #{Book.count} books"
puts "  - #{Article.count} articles"
puts "  - #{Chapter.count} chapters"
puts "  - #{Video.count} videos"
puts "  - #{Lab.count} labs"
puts "  - #{Todo.count} todos"
puts "  - #{CalendarEvent.count} calendar events"
puts ""
puts "🚀 Your learning tracker is ready to go!"
puts "   Visit http://localhost:3000 to get started"
