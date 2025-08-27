# FROM node:alpine3.18 as build
# #Declare build tide environment variables
# ARG REACT_APP_NODE_ENV
# ARG REACT APP_SERVER_BASE_URL
# #Set default values for environment variables
# ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
# ENV REACT APP SERVER BASE_URL=SREACT_APP_SERVER BASE URL
# #Build App
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build
# #Serve with Nginx
# FROM nginx:1.23-alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf *
# COPY --from=build/ app/build .
# EXPOSE 80
# ENTRYPOINT [ "nginx", "-g", "daemon off;"]

# Step 1: Build React app
FROM node:20-alpine AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve with Nginx
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .

EXPOSE 5173
ENTRYPOINT ["nginx", "-g", "daemon off;"]
