#!/bin/bash

kubectlVersion=$(jq -r '.kubectlVersion' ${HOME}/install/config.json)
helmVersion=$(jq -r '.helmVersion' ${HOME}/install/config.json)

tempDir=$(mktemp -d)
pushd ${tempDir}
curl -LO https://storage.googleapis.com/kubernetes-release/release/v${kubectlVersion}/bin/linux/amd64/kubectl
chmod 744 ${tempDir}/kubectl
mv ${tempDir}/kubectl /usr/local/bin/kubectl

curl -LO https://get.helm.sh/helm-v${helmVersion}-linux-amd64.tar.gz
tar xvf helm*.tar.gz
chmod 744 ${tempDir}/linux-amd64/helm
mv ${tempDir}/linux-amd64/helm /usr/local/bin/helm

popd
rm -rf ${tempDir}

echo '' >> ${HOME}/.bashrc
echo 'source /etc/bash_completion' >> ${HOME}/.bashrc
echo 'source ${HOME}/.kuberc' >> ${HOME}/.bashrc
echo 'source <(kubectl completion bash)' >> ${HOME}/.bashrc
echo 'source <(helm completion bash)' >> ${HOME}/.bashrc
