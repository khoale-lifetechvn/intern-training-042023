FROM node:18-alpine
WORKDIR /react-docker/server
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production
COPY . .
CMD [ "node", "index.js" ] 