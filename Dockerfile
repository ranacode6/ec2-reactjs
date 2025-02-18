FROM node:22-alpine

# Declare environment variables in build time
ARG VITE_SERVER_URL

# Set default values for environment variables
ENV VITE_SERVER_URL=${VITE_SERVER_URL}

# Build App
WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


# Serve with Nginx
FROM nginx:1-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf *

COPY --from=build /app/build .

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off" ]

