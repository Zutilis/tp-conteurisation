FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

ENTRYPOINT ["sh", "-c", "cp -r /app/dist/. /frontend-dist && echo 'Frontend OK.'"]