# Web Developer Hub

The Web Developer Hub is a platform designed to connect developers, provide resources, and showcase projects. Users can create profiles, list their skills, share resources, post projects, and bookmark both resources and projects for future reference. The system emphasizes user-generated content while maintaining structured skill management for consistent categorization.

---

## 👥 Team Members

- [Brittany Halterman](https://github.com/briHalterman)
- [Abraham Flores](https://github.com/abrahamflres)
- [Sisi Wang](https://github.com/Sisi-tech)

---

## 🚀 Core Features

- **User Registration & Authentication** – Sign up, log in, and manage account securely using Devise.
- **Profile Management** – Create a detailed profile with bio, avatar, and skills.
- **Skill Management** – Admins can add/remove skills for consistent categorization.
- **Resource Sharing** – Users can post, edit, and share developer resources.
- **Project Showcasing** – Users can post projects, include tech stack and related skills.
- **Bookmarking** – Save favorite resources and projects for future reference.
- **Dashboard** – View personal resources, projects, bookmarks, and skills.
- **Search & Filtering** – Find resources and projects by skill or keyword.
- **Security** – Brakeman scans and Devise authentication for user safety.

---

## 🗂 Database Models & Associations

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
- `title`, `description`, `tech_stack`
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

### 3.Setup database

```bash 
bin/rails db:prepare
``` 

### 4.Start development server

```bash 
bin/dev 
``` 

### App will run at
👉 [http://localhost:3000](http://localhost:3000)

