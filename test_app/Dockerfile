# To choese image that  you need  to use in continer
FROM node:18-alpine as base
#  inside the continer go to this path
WORKDIR /src

# copy   package files to  / Path
COPY package*.json /

# Run continer  on 3000 Port
EXPOSE 3000

# Set Env var inside continer 
ENV NODE_ENV=development
# run this commands inside continer (shell commands)
RUN npm install -g nodemon && npm install
# copy command to copy files to from repo  inside continer 
COPY . /
# run commnad when container starts
CMD ["nodemon", "bin/www"]

FROM base as dev
ENV NODE_ENV=development
RUN npm install -g nodemon && npm install
COPY . /
CMD ["nodemon", "bin/www"]
