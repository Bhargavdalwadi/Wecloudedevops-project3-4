FROM node:10-alpine as base 

WORKDIR /var/www/todoapp

COPY . .
RUN npm install

FROM base as production
ENV NODE_ENV production



#EXPOSE 8080
CMD [ "node", "server.js" ]
