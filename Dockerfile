FROM node:16 AS ui-build
WORKDIR /app
COPY frontend/ ./frontend/
RUN cd frontend && npm run build

FROM node:16 AS server-build
WORKDIR /root/
COPY --from=ui-build /app/frontend/build ./frontend/build
COPY server/ ./server/
RUN cd server && npm run build

EXPOSE 8888

CMD npm start --prefix server