FROM node:12.14.0 AS builder

COPY . /app
WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com && \
    npm install && \
    npm run build

FROM nginx:1.22-alpine

COPY --from=builder /app/dist /app/www
COPY web.conf /etc/nginx/conf.d/default.conf

EXPOSE 80