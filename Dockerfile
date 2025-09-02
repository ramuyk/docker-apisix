FROM apache/apisix:3.13.0-debian

# Switch to root to install packages
USER root

# Install Certbot with nginx plugin and cron
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx cron sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for certificates and set permissions
RUN mkdir -p /etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt && \
    chmod 755 /etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt

# Allow apisix user to run certbot with sudo
RUN echo "apisix ALL=(ALL) NOPASSWD: /usr/bin/certbot" >> /etc/sudoers

# Expose HTTPS port
EXPOSE 9443

# Stay as root for certbot operations
# USER apisix
