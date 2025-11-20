FROM node:lts-alpine
WORKDIR /app

# Enable Corepack for Yarn 4
RUN corepack enable

COPY package.json yarn.lock ./
RUN yarn install --production

COPY . .
CMD ["node", "src/index.js"]

FROM node:lts AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn run build # for React apps, or skip if Node backend only

# Stage 2: production
FROM node:lts-alpine
WORKDIR /app
COPY --from=build /app ./
CMD ["node", "src/index.js"]