# Use Node.js 18 base image
FROM node:18

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install -f

# Install PM2 globally
RUN npm install -g pm2

# Copy application source code
COPY . .

# Expose application port (change if your app uses a different port)
EXPOSE 3000

# Start the application using PM2
CMD ["pm2-runtime", "server.js"]

