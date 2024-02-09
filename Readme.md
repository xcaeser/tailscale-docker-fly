# Dockerized Tailscale Exit Node Setup

This Docker setup guide details how to create a containerized Tailscale exit node using Ubuntu as the base image. The exit node allows devices on your Tailscale network to access the internet through this container's network connection.

## Prerequisites

- Docker installed on your host machine.
- A Tailscale account and an authentication key. You can generate an auth key from the Tailscale admin console.

## Setup Steps

1. **Base Image and Utilities Installation**:
    - The Dockerfile uses `ubuntu:latest` as the base image.
    - Essential utilities such as `curl`, `iptables`, `iputils-ping`, and `ethtool` are installed to ensure the proper setup and troubleshooting of network connections.

2. **Tailscale Installation**:
    - Tailscale is installed using its official install script fetched via `curl`.

3. **Entrypoint Script**:
    - A custom entrypoint script (`docker-entrypoint.sh`) is prepared and copied into the container. This script configures system settings and starts the Tailscale daemon.
    - The script is made executable and set to run when the container starts.

4. **Container Execution**:
    - By default, the container is configured to run `tail -f /dev/null` to keep running. This behavior can be overridden by the entrypoint script to execute other long-running commands as needed.

## Entrypoint Script Details

The `docker-entrypoint.sh` script performs the following actions:
- Enables IP forwarding to allow the container to forward traffic.
- Adjusts Ethernet settings for performance optimization.
- Starts the Tailscale daemon in the background.
- Authenticates the node with Tailscale using an auth key (replace `TO BE REPLACED` with your actual auth key) and configures it as an exit node.

## Usage Instructions

1. **Build the Docker Image**:
    ```
    docker build -t tailscale-exit-node .
    ```

2. **Run the Container**:
    - Replace `YOUR_AUTH_KEY` with your actual Tailscale auth key.
    ```
    docker run -d --name tailscale-exit-node --privileged tailscale-exit-node --authkey YOUR_AUTH_KEY
    ```

Note: Running the container with `--privileged` is necessary for network manipulation and to allow Tailscale to configure the network properly.

## Run on Fly.io
   ```
    fly run . sleep infinity
    ```

## Security Considerations

- Ensure that your Tailscale auth key is kept secure.
- Regularly update the base image and Tailscale to their latest versions to incorporate security fixes.

## Troubleshooting

- If you encounter network issues, verify the container's network settings and ensure IP forwarding is enabled.
- For authentication issues, check the validity of your Tailscale auth key.

For more detailed information and support, visit the [Tailscale documentation](https://tailscale.com/kb/).

