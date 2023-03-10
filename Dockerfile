FROM node:16-alpine
ENV DB_USER=DB_USER
ENV DB_PASS=DB_PASS
ENV DB=DB
ENV PORT=PORT
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
RUN apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
RUN npm install
COPY . .
COPY --chown=node:node . .
USER node
EXPOSE $PORT
