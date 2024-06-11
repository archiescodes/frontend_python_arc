# Dockerfile for ReactJS
FROM node:14-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . ./
# defined environment variable
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL


RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

# Define environment variable
ENV PORT=80

CMD ["nginx", "-g", "daemon off;"]