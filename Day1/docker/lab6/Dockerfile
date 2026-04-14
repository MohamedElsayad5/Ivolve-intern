# Python base image
FROM python:3.10-slim

# Work directory
WORKDIR /app

# Copy app
COPY Docker-3 .

# Install Flask
RUN pip install flask

# Production defaults (Dockerfile env)
ENV APP_MODE=production
ENV APP_REGION=canada-west

# Expose port
EXPOSE 8080

# Run app
CMD ["python", "app.py"]
