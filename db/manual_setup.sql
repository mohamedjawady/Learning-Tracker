-- Learning Tracker Database Schema
-- This script creates the database structure manually

-- Users table (authentication)
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255),
  email VARCHAR(255) NOT NULL UNIQUE,
  password_digest VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- Courses table
CREATE TABLE IF NOT EXISTS courses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  instructor VARCHAR(255),
  platform VARCHAR(255),
  url VARCHAR(255),
  status INTEGER DEFAULT 0,
  start_date DATE,
  target_completion_date DATE,
  total_duration_hours INTEGER,
  difficulty_level VARCHAR(255),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Books table
CREATE TABLE IF NOT EXISTS books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  description TEXT,
  isbn VARCHAR(255),
  genre VARCHAR(255),
  total_pages INTEGER,
  current_page INTEGER DEFAULT 0,
  publication_year INTEGER,
  status INTEGER DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Articles table
CREATE TABLE IF NOT EXISTS articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  description TEXT,
  author VARCHAR(255),
  publication_date DATE,
  estimated_read_time INTEGER,
  time_spent INTEGER DEFAULT 0,
  status INTEGER DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Todos table
CREATE TABLE IF NOT EXISTS todos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  priority INTEGER,
  due_date DATE,
  completed BOOLEAN DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Notes table
CREATE TABLE IF NOT EXISTS notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  notable_type VARCHAR(255),
  notable_id INTEGER,
  parent_id INTEGER,
  position INTEGER DEFAULT 0,
  is_folder BOOLEAN DEFAULT 0,
  color VARCHAR(7) DEFAULT '#3B82F6',
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES notes(id)
);

-- Calendar Events table
CREATE TABLE IF NOT EXISTS calendar_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  start_date DATETIME NOT NULL,
  end_date DATETIME,
  event_type INTEGER DEFAULT 0,
  all_day BOOLEAN DEFAULT 0,
  eventable_type VARCHAR(255),
  eventable_id INTEGER,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Chapters table (for courses and books)
CREATE TABLE IF NOT EXISTS chapters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_id INTEGER,
  book_id INTEGER,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  order_number INTEGER,
  completed BOOLEAN DEFAULT 0,
  completed_at DATETIME,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (book_id) REFERENCES books(id)
);

-- Videos table (for courses)
CREATE TABLE IF NOT EXISTS videos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  url VARCHAR(255),
  duration_minutes INTEGER,
  order_number INTEGER,
  completed BOOLEAN DEFAULT 0,
  completed_at DATETIME,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Labs table (for courses)
CREATE TABLE IF NOT EXISTS labs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  instructions TEXT,
  order_number INTEGER,
  completed BOOLEAN DEFAULT 0,
  completed_at DATETIME,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Simple todos table
CREATE TABLE IF NOT EXISTS simple_todos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  completed BOOLEAN DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_courses_user_id ON courses(user_id);
CREATE INDEX IF NOT EXISTS idx_courses_status ON courses(status);
CREATE INDEX IF NOT EXISTS idx_books_user_id ON books(user_id);
CREATE INDEX IF NOT EXISTS idx_books_status ON books(status);
CREATE INDEX IF NOT EXISTS idx_articles_user_id ON articles(user_id);
CREATE INDEX IF NOT EXISTS idx_todos_user_id ON todos(user_id);
CREATE INDEX IF NOT EXISTS idx_notes_user_id ON notes(user_id);
CREATE INDEX IF NOT EXISTS idx_calendar_events_user_id ON calendar_events(user_id);

-- Insert sample admin user (password: password123)
INSERT OR IGNORE INTO users (id, name, email, password_digest, created_at, updated_at) 
VALUES (1, 'Admin User', 'admin@learningtracker.com', '$2a$12$Pf.t7kL6HuTdXmZYcF5pZ.QqJrJtxGgE1wdQgH5XGPaAPWJOKM9sW', datetime('now'), datetime('now'));

INSERT OR IGNORE INTO users (id, name, email, password_digest, created_at, updated_at) 
VALUES (2, 'Demo User', 'demo@learningtracker.com', '$2a$12$Pf.t7kL6HuTdXmZYcF5pZ.QqJrJtxGgE1wdQgH5XGPaAPWJOKM9sW', datetime('now'), datetime('now'));
