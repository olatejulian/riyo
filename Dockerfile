FROM node:lts-alpine AS base

RUN apk add --no-cache libc6-compat

RUN corepack enable && corepack prepare pnpm@latest --activate

FROM base AS dep

WORKDIR /dep

COPY package.json pnpm-lock.yaml .

RUN pnpm install --frozen-lockfile --prod

FROM base AS builder

WORKDIR /builder

COPY src src
COPY package.json pnpm-lock.yaml .
COPY tsconfig.base.json tsconfig.build.json tsconfig.json .

RUN pnpm install --frozen-lockfile
RUN pnpm build

FROM node:lts-alpine

WORKDIR /app

COPY --from=dep /dep/node_modules node_modules
COPY --from=builder /builder/dist .

USER node

CMD ["node", "main.js"]

