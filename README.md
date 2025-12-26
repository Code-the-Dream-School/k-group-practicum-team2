# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

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

