# Use a base image suitable for your application
#FROM node:16

# Set the working directory
#WORKDIR /app

# Copy the frontend code into the container
#COPY frontend/ ./frontend/

# Copy the backend code into the container
#COPY server/ ./server/

# Install backend dependencies
#RUN cd server && npm run build && npm install --legacy-peer-deps

# Expose the ports for frontend and backend
#EXPOSE 3000 8888

# Define the command to start the backend and then the frontend
#CMD npm start --prefix server & sleep 10 && npm start --prefix frontend

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

#