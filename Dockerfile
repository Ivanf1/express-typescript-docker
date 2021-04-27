# stage 1 building
FROM node:16-alpine3.11 as build

# create a directory for the app
WORKDIR /app

# copy package.json and package-lock.json
COPY package*.json ./

# install dependencies
RUN npm install

COPY . .

RUN npm run build

###############################################################

# stage 2 final
FROM node as final

RUN mkdir -p /home/node/app/dist && chown -R node:node /home/node/app

WORKDIR /home/node/app
COPY --chown=node:node package*.json ./

# switch to user node
USER node

RUN npm install --production

# copy code files and give ownership to user node
COPY --from=build --chown=node:node /app/dist ./dist

EXPOSE 4000

CMD node ./dist/index.js