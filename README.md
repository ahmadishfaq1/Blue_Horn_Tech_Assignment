# Blue_Horn_Tech_Assignment
Assignment

A Ruby on Rails application for homecare workers to log visit verifications with geolocation.

## Features

- View assigned shift details (date, time, client info)
- Log visit start/end events with timestamps
- Automatic geolocation capture using browser API
- View visit log history
- Simple, responsive interface

## Tech Stack

- **Backend**: Ruby on Rails 7
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Database**: SQLite (development)
- **Styling**: Tailwind CSS
- **Geolocation**: Browser Geolocation API

## Installation

### Prerequisites
- Ruby 3.x
- Rails 7.x
- Node.js
- SQLite3

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/Blue_Horn_Tech_Assignment.git
   cd Blue_Horn_Tech_Assignment
   
2. bundle install
   yarn install
3. rails db:create db:migrate db:seed
4. rails server
5. http://localhost:3000
