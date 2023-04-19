FROM node:18-alpine
WORKDIR /app
COPY package*.json .
RUN npm install --no-audit --progress=false
COPY . .
EXPOSE 5000
CMD [ "node", "./app.js" ]