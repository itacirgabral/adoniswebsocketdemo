# build modules
FROM node:14 AS stage1
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ic
RUN npm prune --production

# FROM gcr.io/distroless/nodejs
FROM node:14-alpine
WORKDIR /usr/src/app
COPY --from=stage1 /usr/src/app/node_modules /usr/src/app/node_modules

# copy source code
COPY . .

# start app
EXPOSE 333
CMD [ "npm", "start" ]