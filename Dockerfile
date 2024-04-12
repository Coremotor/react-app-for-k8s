FROM node:lts AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock .yarn .yarnrc.yml ./

RUN yarn set version stable
RUN yarn install

COPY . .

RUN yarn build

FROM nginx:latest

COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

COPY /config/nginx /etc/nginx

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
