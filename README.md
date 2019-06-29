# devenv
Experimental development environment in an Ubuntu container that can be started with Telepresence and attached to vscode. The goal is to dynamically switch to debug code inside a Kubernetes cluster alonside a real deployment.

## Prerequisites
Install telepresence with: -

    curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | sudo bash
    sudo apt install --no-install-recommends telepresence
