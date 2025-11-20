FROM node:lts-alpine
WORKDIR /app
COPY . .
RUN corepack enable \
	&& corepack prepare yarn@4.11.0 --activate \
	&& yarn install
CMD ["node", "src/index.js"]
EXPOSE 3000