# Use Ubuntu as the base image
FROM ubuntu:latest

# Install curl and other necessary utilities
RUN apt-get update && apt-get install -y curl iptables iputils-ping ethtool

# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Copy the entrypoint script into the container
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /docker-entrypoint.sh

# Set the entrypoint script to run on container start
ENTRYPOINT ["/docker-entrypoint.sh"]

# Keep the container running (this command can be overridden by the entrypoint script)
CMD ["tail", "-f", "/dev/null"]
