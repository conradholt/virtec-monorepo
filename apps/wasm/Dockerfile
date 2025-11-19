# Stage 1 - deps install (cache npm install)
FROM node:lts-bookworm-slim AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --only=production

# Stage 2 - app
FROM node:lts-bookworm-slim AS runtime
WORKDIR /app

# copy production node_modules from deps stage
COPY --from=deps /app/node_modules ./node_modules

# copy app files (index.js and the precompiled .wasm)
COPY index.js test.wasm ./

# If you want to expose a port (for servers), add EXPOSE 3000
# EXPOSE 3000

CMD ["node", "index.js"]