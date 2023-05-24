# Build stage
FROM node:14-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm run obfuscate

# Final stage
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app/dist-obfuscated ./dist
CMD ["node", "dist/index/index.js"]
