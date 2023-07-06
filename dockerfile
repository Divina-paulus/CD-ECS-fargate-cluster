# Use an official Node.js runtime as a parent image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Set the environment variable for the application port
ENV PORT=3000

# Expose the port on which the application will listen
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
