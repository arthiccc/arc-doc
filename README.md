# ARC-DOC

High-performance Campus Archive built with Rails 8.1 and Tailwind CSS v4.

### ⚡️ Features
- **Chad Search:** Natural language date parsing (`Jan 2026`) + cross-table metadata discovery.
- **Deep Indexing:** Automated `pdftotext` extraction on upload for full-text search inside PDFs.
- **Digital Paper UI:** Refined academic aesthetic using Playfair Display & custom Tailwind tokens.
- **Complex Sorting:** SQL-heavy sorting by relational IDs and Active Storage blob sizes.
- **Solid Auth:** Devise + Pundit for department-level scoped access.

### 🛠 Tech
- Rails 8.1 (Propshaft, Importmaps)
- Tailwind CSS v4
- SQLite
- Active Storage + Pundit

### 🚀 Quick Start
```bash
bundle install
bin/rails db:setup db:seed
./bin/dev
```

[**WATCH DEMO**](YOUR_VIDEO_LINK_HERE)
