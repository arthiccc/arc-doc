# ARC-DOC | Campus Archive Repository

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-8.1-CC0000.svg?style=flat-square&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC.svg?style=flat-square&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)

A sophisticated document management system designed for institutional memory, featuring a "Digital Paper" aesthetic and a deep-extraction search engine.

<div align="center">
  <h3>[ 60-Second Technical Demo ]</h3>
  <p><i>Watch the deep search and text extraction in action:</i></p>
  <a href="YOUR_VIDEO_LINK_HERE">
    <img src="https://via.placeholder.com/800x450.png?text=Click+to+Watch+Project+Walkthrough" alt="Technical Demo" width="600">
  </a>
</div>

## 🚀 Technical Highlights

- **Digital Paper UI/UX:** Architected a refined academic aesthetic using **Tailwind CSS v4** and **Playfair Display** typography, focusing on high-contrast readability and "paper-like" tactile feedback.
- **Deep Search Engine:** Engineered a specialized ActiveRecord scope that parses natural language date fragments (e.g., "Jan", "2026") and performs cross-table joins for metadata discovery.
- **Automated Content Extraction:** Integrated `pdftotext` via **Active Storage** lifecycle hooks to automatically extract, store, and index searchable text from PDF and TXT uploads.
- **Relational Data Logic:** Implemented complex sorting systems handling cross-table data, including sorting by department/category relationships and actual file blob sizes.
- **Security & Authorization:** Fine-grained access control implemented via **Pundit**, ensuring staff can only manage documents within their assigned departments.

## 🛠 Tech Stack

- **Framework:** Ruby on Rails 8.1
- **Styling:** Tailwind CSS 4.0
- **Database:** SQLite (Development/Test)
- **Authentication:** Devise (Custom Styled)
- **Authorization:** Pundit
- **File Storage:** Active Storage
- **Testing:** Minitest (Integration & Policy coverage)

## ⚙️ Setup & Installation

```bash
# Clone the repository
git clone https://github.com/arthiccc/arc-doc.git
cd arc-doc

# Install dependencies
bundle install

# Setup database and seed 100 realistic documents
bin/rails db:setup
bin/rails db:seed

# Start development server (Rails + Tailwind Watcher)
./bin/dev
```

## 🧪 Running Tests

The project includes a robust suite of controller and policy tests.

```bash
bin/rails test
```

---
*Created by [arthiccc](https://github.com/arthiccc) — Jan 2026*