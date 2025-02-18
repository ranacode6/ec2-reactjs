FROM node:22-alpine

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

EXPOSE 3000

CMD ["npm", "start"]

