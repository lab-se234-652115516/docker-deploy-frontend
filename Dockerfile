# Stage 0: 构建 Angular 应用
FROM node:10-alpine as node
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG TARGET=ng-deploy
RUN npm run ${TARGET}

# Stage 1: 生产环境 Nginx
FROM nginx:1.13
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80