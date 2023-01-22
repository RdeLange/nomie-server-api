# syntax=docker/dockerfile:1

FROM amd64/python:3.12.0a4-slim-bullseye

RUN apt update
RUN apt install -y npm
RUN npm install -g --unsafe-perm node-red


WORKDIR /usr/local/lib/node_modules/node-red

RUN npm install node-red-node-sqlite
RUN npm install node-red-dashboard
RUN npm install node-red-contrib-twin-bcrypt
RUN npm install node-red-contrib-moment

COPY icon64x64.png ./node_modules/node-red-dashboard/dist/icon64x64.png
COPY icon120x120.png ./node_modules/node-red-dashboard/dist/icon120x120.png
COPY icon192x192.png ./node_modules/node-red-dashboard/dist/icon192x192.png

WORKDIR /root
COPY flows.json ./.node-red/flows.json
COPY settings.js ./.node-red/settings.js


EXPOSE 1880/tcp
CMD node-red


