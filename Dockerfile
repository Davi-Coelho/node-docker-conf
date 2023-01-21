FROM node:16-alpine
ARG PORT
ENV DB_USER=DB_USER
ENV DB_PASS=DB_PASS
ENV DB=DB
ENV PORT=PORT
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
RUN npm install
COPY . .
COPY --chown=node:node . .
USER node
EXPOSE $PORT
