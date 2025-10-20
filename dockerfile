# Use linuxserver's code-server base image
FROM lscr.io/linuxserver/code-server:latest

# Switch to root to install packages
USER root

# Install python3 and pip, clean apt cache to keep image small
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Install python tools globally
RUN pip3 install --no-cache-dir --break-system-packages \
    virtualenv

# Optional: install helpful python tools (uncomment if you want)
# RUN pip3 install --no-cache-dir --break-system-packages black flake8 jupyter

# Optional: Pre-install Python extension (uncomment if desired)
# Note: This may require running as the abc user or adjusting permissions
# RUN --mount=type=cache,target=/root/.cache \
#     code-server --install-extension ms-python.python

# Ensure workspace directory exists
WORKDIR /config/workspace

# Port is already exposed in base image, but declared for clarity
EXPOSE 8443

# Base image provides CMD/ENTRYPOINT
