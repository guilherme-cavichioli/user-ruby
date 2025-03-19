# Use an official Ruby image
FROM ruby:3.2

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_PATH=/gems

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    postgresql-client \
    libpq-dev

# Set the working directory
WORKDIR /app

# Copy the Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN gem install rails

# Copy the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0"]