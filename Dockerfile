# Use multi-stage build to build frontend and backend separately

# Stage 1: Build the frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/ .
RUN npm install && npm run build

# Stage 2: Build the backend
FROM python:3.10 AS backend-build
WORKDIR /app/api
COPY api/ .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 3: Final image
FROM python:3.10
WORKDIR /app
COPY --from=backend-build /app/api /app/api
COPY --from=frontend-build /app/frontend/dist /app/frontend
RUN pip install --no-cache-dir -r api/requirements.txt

# Environment variables for ports
ENV FRONTEND_PORT=3000
ENV API_PORT=8000

# Serve frontend and API using a simple Python server for static files
CMD ["sh", "-c", "uvicorn api:app --host 0.0.0.0 --port $API_PORT & python -m http.server $FRONTEND_PORT --directory /app/frontend"]
