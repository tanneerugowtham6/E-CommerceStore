FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 3003
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3s \
    CMD wget --quiet --tries=1 --spider http://localhost:3003/health || exit 1
CMD ["node", "server.js"]