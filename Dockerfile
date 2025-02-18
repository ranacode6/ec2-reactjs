FROM node:22-alpine as builder

# Declare environment variables in build time
ARG VITE_SERVER_URL

# Set default values for environment variables
ENV VITE_SERVER_URL=${VITE_SERVER_URL}

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:1-alpine

# Copy the built assets from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

