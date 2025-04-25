# Use Ruby 3.4 slim image
FROM ruby:3.4-slim

# Install rack and webrick gems globally
RUN gem install rack webrick rackup

# Set working directory
WORKDIR /usr/src/app

# Copy application code
COPY . .

# Expose port
EXPOSE 9292

# Run rackup directly
CMD ["rackup", "--host", "0.0.0.0"]