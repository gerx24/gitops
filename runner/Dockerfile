FROM postgres:latest

USER root

# Install base tools, Python, pip, AWS CLI, and curl
RUN apt-get update && apt-get install -y \
    dnsutils \
    tcpdump \
    telnet \
    curl \
    ca-certificates \
    apt-transport-https \
    gnupg \
    python3 \
    python3-pip && \
    pip3 install --no-cache-dir awscli --upgrade --user --break-system-packages && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Get the latest kubectl version
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(uname -m)/kubectl"


# Make kubectl executable and move to /usr/local/bin
RUN chmod +x kubectl && mv kubectl /usr/local/bin/

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add AWS CLI to PATH
ENV PATH="/root/.local/bin:${PATH}"

# Default command (PostgreSQL server starts automatically)
CMD ["/bin/bash"]