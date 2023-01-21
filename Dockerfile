FROM node:16-alpine
ARG PORT
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
RUN export DB_USER=DB_USER \
    export DB_PASS=DB_PASS \
    export DB=DB \
    export PORT=PORT
WORKDIR /home/node/app
COPY package*.json ./
RUN npm install
COPY . .
COPY --chown=node:node . .
USER node
EXPOSE $PORT
