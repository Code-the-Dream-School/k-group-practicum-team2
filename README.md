# Web Developer Hub

The Web Developer Hub is a platform designed to connect developers, provide resources, and showcase projects. Users can create profiles, list their skills, share resources, post projects, and bookmark both resources and projects for future reference. The system emphasizes user-generated content while maintaining structured skill management for consistent categorization.

---

## 🧑‍🎓 Team Members

- [Brittany Halterman](https://github.com/briHalterman)
- [Abraham Flores](https://github.com/abrahamflres)
- [Sisi Wang](https://github.com/Sisi-tech)

---

## 🧑‍🏫 Mentors

- [Daniel Sinn](https://github.com/dsinn)
- [Olga Goncharenko](https://github.com/OGoncharenko)
- [Anamaria Maldonado](https://github.com/acmv19)

---

## 🚀 Core Features

- **User Registration & Authentication** – Sign up, log in, and manage account securely using Devise.
- **Profile Management** – Create a detailed profile with bio, avatar, and skills.
- **Skill Management** – Admins can add/remove skills for consistent categorization.
- **Resource Sharing** – Users can post, edit, and share developer resources.
- **Project Showcasing** – Users can post projects including related skills.
- **Bookmarking** – Save favorite resources and projects for future reference.
- **Dashboard** – View personal resources, projects, bookmarks, and skills.
- **Search & Filtering** – Find resources and projects by skill or keyword.
- **Security** – Brakeman scans and Devise authentication for user safety.

---

## 🛢 Database Models & Associations

### User
- `id` (primary key)
- `email` (unique, not null)
- `encrypted_password` (not null)
- `created_at`, `updated_at`
**Associations:**
`has_one :profile`
`has_many :resources`
`has_many :projects`
`has_many :bookmarked_resources`
`has_many :bookmarked_projects`

### Skill (admin only)
- `id` (primary key)
- `name`

### Profile
- `id`, `user_id` (foreign key)
- `first_name`, `last_name` (not null)
- `bio`, `skills`, `avatar`
- `created_at`, `updated_at`
**Associations:**
`belongs_to :user`
`has_many :skills`

### ProfileSkill
- `user_id`, `skill_id` (foreign keys)

### Resource
- `id`, `user_id` (foreign key)
- `title`, `description`, `url`
- `created_at`, `updated_at`
**Associations:**
`belongs_to :user`
`has_many :bookmarked_resources`

### Project
- `id`, `user_id` (foreign key)
- `title`, `description`
- `created_at`, `updated_at`
**Associations:**
`belongs_to :user`
`has_many :skills`

### ProjectSkill
- `project_id`, `skill_id` (foreign keys)

### BookmarkedResource
- `id`, `user_id`, `resource_id` (foreign keys)
- `created_at`, `updated_at`
**Associations:**
`belongs_to :resource`
`belongs_to :user`

### BookmarkedProject
- `id`, `user_id`, `project_id` (foreign keys)
- `created_at`, `updated_at`
**Associations:**
`belongs_to :project`
`belongs_to :user`

---

## 🎥 Demo
> _Coming soon – deployment/video demo will be added in next update._

---

## 🛠 Technology Stack
- **Frontend:** HTML, ERB, TailwindCSS
- **Backend:** Ruby on Rails
- **Database:** PostgreSQL
- **Authentication:** Devise
- **Version Control:** Git & GitHub
- **Project Management:** Jira, Slack
- **Design:** Figma

---

## 🌐 Routes (Current)

| Route | Controller#Action | Purpose |
|---|---|---|
| `/` | `home#index` | Landing page |
| `/dashboard` | `dashboard#index` | User dashboard |

> More routes will be added as features are built.

---

## 🔐 Security Tools
- **Brakeman** — Rails static security scanner
- Devise authentication to secure user accounts

---

## ⚙ Project Setup & Development

### 🔢 Versions
- **Ruby:** `3.2.5`
- **Rails:** `8.1`

### 1. Clone the project

```bash
git clone https://github.com/Code-the-Dream-School/k-group-practicum-team2.git
cd k-group-practicum-team2
```

### 2. Install dependencies

```bash
bundle install
npm install
```

### 3. Setup database

```bash
bin/rails db:prepare
```

### 4. Start development server

```bash
bin/dev
```

👉 App will run at <http://localhost:3000>

### Seeding the Database

Run the seed file:
`bin/rails db:seed`

---
## 🧪 Testing

This project uses RSpec for automated testing. All previous Minitest tests have been migrated to RSpec request specs.

Run the test suite

```bash
# Run all specs
bundle exec rspec

# Run a single spec file
bundle exec rspec spec/requests/home_spec.rb
bundle exec rspec spec/requests/profiles_spec.rb
bundle exec rspec spec/requests/projects_spec.rb
bundle exec rspec spec/models/profile_spec.rb
```

### 5. Running Tests with Coverage

Run the test suite with code coverage enabled:

```bash
COVERAGE=true bundle exec rspec
```

**Viewing Coverage Reports:**

- **Console Output** — Coverage summary and file-by-file breakdown are displayed directly in the terminal after tests complete
- **HTML Report** — Detailed coverage report with line-by-line highlighting is generated in `coverage/index.html`. Open this file in your browser for an interactive view
- **CI Logs** — In GitHub Actions, expand the "Run RSpec" step to view console coverage output. HTML reports are available as downloadable artifacts
