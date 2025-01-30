# Generated by https://smithery.ai. See: https://smithery.ai/docs/config#dockerfile
# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.13-slim AS uv

# Set the working directory
WORKDIR /app

# Copy the necessary files
COPY pyproject.toml uv.lock ./

# Install the project's dependencies
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-dev --no-editable

# Copy the rest of the application files
COPY . .

# Set environment variable for ANTHROPIC_API_KEY
# This can be overridden at runtime
ENV ANTHROPIC_API_KEY=your_api_key_here

# Expose the port that the server will run on
EXPOSE 8080

# Default command to run the server
CMD ["uv", "run", "weather.py"]
