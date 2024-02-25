FROM alpine:latest

# Install curl
RUN apk --no-cache add curl

# Copy bash script
COPY metrics.sh /usr/local/bin/

# Make script executable
RUN chmod +x /usr/local/bin/metrics.sh

# Run script on container startup
CMD ["/bin/sh", "-c","/usr/local/bin/metrics.sh"]
