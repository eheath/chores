# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A chore management app built on Rails 8 with Hotwire (Turbo + Stimulus). Users create chores (with title, notes, points, days-of-week), create doers (people who perform chores), and track assignments via ChoreTracker.

## Tech Stack

- Ruby 3.4.1, Rails 8.0
- SQLite3 (separate DBs for cache/queue/cable via Solid gems)
- Hotwire: Turbo (Frames + Streams) for SPA-like interactivity, Stimulus for JS
- Bootstrap 5 + Bootstrap Icons (loaded via CDN)
- Propshaft (asset pipeline), importmap-rails (no JS build step)
- Devise (authentication), simple_form (forms)
- Puma + Thruster (server), Kamal (deployment)

## Common Commands

```bash
bin/setup                          # First-time setup
bin/dev                            # Start dev server (uses Procfile.dev)
bin/rails server                   # Start Rails server only
bin/rails test                     # Run all tests
bin/rails test test/models/        # Run model tests
bin/rails test test/models/chore_test.rb        # Run a single test file
bin/rails test test/models/chore_test.rb:7      # Run a single test by line
bin/rails db:migrate               # Run pending migrations
bin/rubocop                        # Lint (rubocop-rails-omakase style)
bin/brakeman                       # Security scanning
```

## Architecture

### Authentication

All controllers require authentication via Devise (`before_action :authenticate_user!` in ApplicationController). All models are scoped to the current user.

### Data Model

```
User -< Chore -< Doer (through ChoreTracker)
User -< Doer -< ChoreTracker
User -< ChoreTracker
ChoreTracker belongs_to :doer, :chore, :user
```

Chore stores `days` as a JSON array of day names. Both Chore and Doer use `is_deleted`/`is_active` for soft deletion.

### Turbo Patterns (Key Architecture)

This app relies heavily on Turbo Frames and Turbo Streams for CRUD without page reloads:

- **Turbo Frames** wrap forms and lists for scoped replacement: `chore_form_turbo_frame`, `chores_list_turbo_frame`, `doer_form_turbo_frame`, `doers_turbo_frame`, plus individual frames per record.
- **Turbo Stream responses** (`create.turbo_stream.erb`, `update.turbo_stream.erb`, `destroy.turbo_stream.erb`) prepend/replace/remove DOM elements after mutations.
- Controllers respond with Turbo Stream format on create/update, rendering stream templates that update multiple page sections simultaneously.
- The home#index view is the main dashboard, displaying both chores and doers with inline forms.

### Controllers

Controllers use inline filtering on the current_user's associations (e.g., `current_user.chores.detect{|c| c.id == params[:id].to_i}`) rather than direct `find` calls.

### View Helpers

`ApplicationHelper` provides `button_icon(icon_class, text)` for Bootstrap Icon badges and `check_day(chore, day)` for day-of-week checkbox state.

## Testing

Minitest with parallelization. Fixtures in `test/fixtures/`. Capybara + Selenium for system tests. Test user fixtures use Devise's `password` virtual attribute pattern.
