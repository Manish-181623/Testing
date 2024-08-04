# Use the official Node.js 18 image with Alpine Linux
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application to the working directory
COPY . .

# Build the application
RUN npm run build

# Clean up node_modules and reinstall only production dependencies
RUN rm -rf node_modules && \
    npm install --only=production && \
    npm install -g serve

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to serve the built app
CMD ["serve", "-s", "dist"]
