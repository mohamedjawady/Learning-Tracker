# Learning Tracker 📚

A comprehensive personal learning tracker built with Ruby on Rails. Track your progress through courses, books, articles, and organize your learning with an integrated calendar and todo system.

## Features ✨

### 📖 Learning Resources Management
- **Courses**: Track online courses with chapters, videos, and labs
- **Books**: Manage your reading list with PDF upload and viewer
- **Articles**: Keep track of articles you want to read

### 📊 Progress Tracking
- Visual progress bars for all learning resources
- Chapter-by-chapter progress for courses and books
- Time tracking for articles and videos
- Completion statistics and analytics

### 📅 Calendar & Planning
- Integrated calendar for scheduling study sessions
- Deadline tracking and reminders
- Event types: Study sessions, deadlines, reminders, todos

### ✅ Todo Management
- Priority-based todo system
- Due date tracking
- Quick completion toggles

### 📄 PDF Viewer
- Upload and view PDF books directly in the app
- Integrated reading experience
- Page progress tracking

### 🎨 Modern UI/UX
- Clean, minimalist design with Tailwind CSS
- Responsive layout for all devices
- Interactive progress animations
- Intuitive navigation

## Features in Action

- **Dashboard**: Clean overview showing your learning progress with charts and statistics
- **Course Management**: Comprehensive course tracking with videos, chapters, and labs
- **Calendar Integration**: Schedule study sessions and track deadlines
- **Progress Tracking**: Visual indicators for completion status across all resources

## Technology Stack 🛠️

- **Backend**: Ruby on Rails 7.1
- **Database**: SQLite3 (easily configurable for PostgreSQL)
- **Frontend**: HTML5, Tailwind CSS (via CDN), Stimulus JS
- **File Upload**: CarrierWave (configured but extensible)
- **Charts**: Chart.js for progress visualization
- **Icons**: Font Awesome for UI icons

## Installation & Setup 🚀

### Prerequisites

Ensure you have the following installed:
- Ruby 3.2.0 or higher
- Rails 7.1.0 or higher
- SQLite3
- Node.js (for Tailwind CSS)

### Setup Instructions

1. **Clone or navigate to the project directory**
   ```bash
   cd learning-tracker
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the development server**
   ```bash
   rails server
   ```

5. **Visit the application**
   Open your browser and go to `http://localhost:3000`

The seed command will populate your database with sample data to help you get started quickly.

## Usage Guide 📋

### Getting Started

1. **Dashboard**: Your central hub showing progress overview, recent activity, and today's schedule
2. **Add Learning Resources**: Use the quick actions to add courses, books, or articles
3. **Track Progress**: Mark chapters, videos, or labs as complete as you progress
4. **Schedule Learning**: Create calendar events for study sessions and deadlines
5. **Manage Tasks**: Use the todo system to track learning-related tasks

### Course Management

- Add courses with instructor, platform, and difficulty information
- Break down courses into chapters, videos, and labs
- Track completion status and overall progress
- Link calendar events to specific courses

### Book Management

- Upload PDF files for direct viewing in the app
- Track reading progress by page number
- Organize books into chapters
- Monitor reading velocity and completion estimates

### Article Tracking

- Save articles with URLs for easy access
- Estimate reading time and track actual time spent
- Mark progress and completion status
- Organize by topic or priority

### Calendar & Todos

- Schedule study sessions and set deadlines
- Create different types of events (study, deadline, reminder, todo)
- Link events to specific learning resources
- Manage priority-based todos with due dates

## Customization 🎨

### Styling

The app uses Tailwind CSS for styling. You can customize the appearance by:

1. **Modifying colors**: Edit the color classes in views
2. **Updating layout**: Modify the application layout in `app/views/layouts/application.html.erb`
3. **Custom CSS**: Add custom styles in `app/assets/stylesheets/application.css`

### Adding New Features

The app is built with extensibility in mind. Common extensions:

1. **New learning resource types**: Create new models following the existing pattern
2. **Additional progress metrics**: Extend models with new tracking fields  
3. **Integration with external APIs**: Add services for platforms like Coursera, Udemy
4. **Advanced analytics**: Create new views and controllers for detailed reporting

## Database Schema 🗄️

### Main Models

- **Course**: Online courses with associated content
- **Book**: Physical or digital books with PDF support
- **Article**: Web articles and blog posts
- **Chapter**: Subdivisions of courses or books
- **Video**: Course video content
- **Lab**: Hands-on exercises and labs
- **CalendarEvent**: Scheduled events and reminders
- **Todo**: Task management

### Relationships

- Courses have many chapters, videos, and labs
- Books have many chapters
- All learning resources can have calendar events
- Polymorphic associations for flexible event linking

## Contributing 🤝

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support 💬

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/learning-tracker/issues) page
2. Create a new issue with detailed information
3. Provide steps to reproduce any bugs

## Roadmap 🗺️

Future enhancements planned:

- [ ] Mobile app companion
- [ ] Advanced analytics and reporting
- [ ] Export functionality for progress reports
- [ ] Gamification elements (streaks, achievements)
- [ ] AI-powered learning recommendations

---

**Happy Learning! 🎓**

Start tracking your learning journey today and never lose sight of your educational goals!
