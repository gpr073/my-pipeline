FROM node:18-alpine3.14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
RUN npm audit fix
COPY . .
EXPOSE 3000
CMD [ "npm", "start" ]