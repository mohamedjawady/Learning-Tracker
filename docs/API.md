# 🔌 Learning Tracker API Documentation

## Authentication Endpoints

### POST /login
Login with email and password.

**Request:**
```json
{
  "session": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```

**Response (Success):**
- Status: 302 Redirect to dashboard
- Sets session cookie

**Response (Error):**
- Status: 422 Unprocessable Entity
- Flash alert with error message

### DELETE /logout
Logout current user.

**Response:**
- Status: 302 Redirect to login
- Clears session cookie

### GET /register
Display registration form.

### POST /users
Create new user account.

**Request:**
```json
{
  "user": {
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```

## Learning Resources API

### Courses API

#### GET /courses
List all courses for the current user.

**Query Parameters:**
- `search` (optional): Search in title and description
- `status` (optional): Filter by status (not_started, in_progress, completed, paused)
- `page` (optional): Pagination page number

**Response:**
```json
{
  "courses": [
    {
      "id": 1,
      "title": "Ruby on Rails Mastery",
      "description": "Complete guide to Rails",
      "instructor": "John Smith",
      "platform": "Udemy",
      "status": "in_progress",
      "progress_percentage": 65.5,
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-15T12:30:00Z"
    }
  ]
}
```

#### POST /courses
Create a new course.

**Request:**
```json
{
  "course": {
    "title": "New Course",
    "description": "Course description",
    "instructor": "Teacher Name",
    "platform": "Platform Name",
    "url": "https://example.com/course",
    "status": "not_started",
    "difficulty_level": "Intermediate",
    "total_duration_hours": 40
  }
}
```

#### GET /courses/:id
Get specific course details.

#### PATCH /courses/:id
Update course information.

#### DELETE /courses/:id
Delete a course and all associated data.

### Books API

#### GET /books
List all books for the current user.

**Query Parameters:**
- `search` (optional): Search in title, author, and description
- `status` (optional): Filter by reading status
- `genre` (optional): Filter by genre

#### POST /books
Create a new book entry.

**Request:**
```json
{
  "book": {
    "title": "Book Title",
    "author": "Author Name",
    "description": "Book description",
    "isbn": "978-0123456789",
    "genre": "Technology",
    "total_pages": 300,
    "current_page": 0,
    "publication_year": 2024
  }
}
```

### Articles API

#### GET /articles
List saved articles.

#### POST /articles
Save a new article.

**Request:**
```json
{
  "article": {
    "title": "Article Title",
    "url": "https://example.com/article",
    "description": "Article summary",
    "author": "Author Name",
    "publication_date": "2024-01-01"
  }
}
```

### Notes API

#### GET /notes
List all notes (supports polymorphic filtering).

**Query Parameters:**
- `notable_type` (optional): Filter by associated resource type (Course, Book, Article)
- `notable_id` (optional): Filter by specific resource ID

#### POST /notes
Create a new note.

**Request:**
```json
{
  "note": {
    "title": "Note Title",
    "content": "Note content in HTML",
    "notable_type": "Course",
    "notable_id": 1,
    "tags": ["important", "review"]
  }
}
```

### Todos API

#### GET /todos
List all todos.

**Query Parameters:**
- `completed` (optional): Filter by completion status
- `priority` (optional): Filter by priority level
- `due_date` (optional): Filter by due date

#### POST /todos
Create a new todo.

**Request:**
```json
{
  "todo": {
    "title": "Task Title",
    "description": "Task description",
    "priority": "high",
    "due_date": "2024-02-01",
    "completed": false
  }
}
```

#### PATCH /todos/:id/toggle
Toggle todo completion status.

### Calendar Events API

#### GET /calendar_events
List calendar events.

**Query Parameters:**
- `start_date` (optional): Filter events from date
- `end_date` (optional): Filter events until date
- `eventable_type` (optional): Filter by associated resource type

#### POST /calendar_events
Create a new calendar event.

**Request:**
```json
{
  "calendar_event": {
    "title": "Study Session",
    "description": "Rails chapter review",
    "event_date": "2024-02-01",
    "start_time": "14:00:00",
    "end_time": "16:00:00",
    "eventable_type": "Course",
    "eventable_id": 1
  }
}
```

## Search API

### GET /search
Global search across all resources.

**Query Parameters:**
- `q` (required): Search query
- `type` (optional): Limit search to specific resource type

**Response:**
```json
{
  "results": {
    "courses": [...],
    "books": [...],
    "articles": [...],
    "notes": [...]
  },
  "total_count": 25
}
```

## Analytics API

### GET /analytics/dashboard
Get dashboard analytics data.

**Response:**
```json
{
  "overview": {
    "total_courses": 10,
    "completed_courses": 3,
    "total_books": 5,
    "completed_books": 2,
    "total_todos": 15,
    "completed_todos": 8
  },
  "progress": {
    "courses_completion_rate": 30.0,
    "books_completion_rate": 40.0,
    "average_course_completion_time": 25.5,
    "learning_streak_days": 7
  },
  "recent_activity": [
    {
      "type": "course_completed",
      "resource": "Ruby on Rails Mastery",
      "date": "2024-01-15"
    }
  ]
}
```

### GET /analytics/progress
Get detailed progress analytics.

**Query Parameters:**
- `period` (optional): Time period (week, month, year)
- `resource_type` (optional): Filter by resource type

## Error Responses

### Standard Error Format
```json
{
  "error": "Error message",
  "details": "Additional error details",
  "code": "ERROR_CODE"
}
```

### Common HTTP Status Codes
- `200` - Success
- `201` - Created
- `302` - Redirect (for form submissions)
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Unprocessable Entity (validation errors)
- `429` - Too Many Requests (rate limited)
- `500` - Internal Server Error

## Rate Limiting

- **Limit**: 60 requests per minute per user
- **Headers**: 
  - `X-RateLimit-Limit`: Request limit
  - `X-RateLimit-Remaining`: Remaining requests
  - `X-RateLimit-Reset`: Reset time

## Authentication

All API endpoints except public routes require authentication via session cookies. Include the session cookie in your requests.

For API clients, you can authenticate by:
1. POST to `/login` with credentials
2. Store the returned session cookie
3. Include cookie in subsequent requests

## Pagination

List endpoints support pagination:
- `page`: Page number (default: 1)
- `per_page`: Items per page (default: 10, max: 100)

**Response includes pagination metadata:**
```json
{
  "data": [...],
  "pagination": {
    "current_page": 1,
    "total_pages": 5,
    "total_count": 50,
    "per_page": 10
  }
}
```

## Content Types

- **Request**: `application/json` or `application/x-www-form-urlencoded`
- **Response**: `application/json` or `text/html` (for form responses)

## Security Notes

- All endpoints protected against CSRF attacks
- Input validation and sanitization applied
- SQL injection prevention through parameterized queries
- XSS protection through content sanitization
- Rate limiting to prevent abuse
