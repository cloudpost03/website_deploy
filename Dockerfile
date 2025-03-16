# Use the official Nginx image as the base
FROM nginx:alpine

# Set the working directory
WORKDIR /var/www/html

# Copy the application files to the container
COPY . .

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
