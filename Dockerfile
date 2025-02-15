FROM node:22-alpine

# Declare environment variables in build time
ARG REACT_APP_NODE_ENV
ARG REACT_APP_SERVER_BASE_URL

# Set default values for environment variables
ENV REACT_APP_NODE_ENV=${REACT_APP_NODE_ENV}
ENV REACT_APP_SERVER_BASE_URL=${REACT_APP_SERVER_BASE_URL}

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

