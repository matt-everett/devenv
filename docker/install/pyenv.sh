#!/bin/bash

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

echo '' >> ${HOME}/.bashrc
#echo 'source ${HOME}/.pyenvrc' >> ${HOME}/.bashrc
source ${HOME}/.pyenvrc

function install_python_version () {
    pyenv install $1
    echo "Installed python version $1"
}

declare -A versions

globalVersion=$(jq -r '[.globalPythonVersion] | @tsv' ${HOME}/install/config.json)
if [ ! -z "${globalVersion}" ]; then
    if [ ! ${versions[${globalVersion}]+_} ]; then
        versions[${globalVersion}]="created"
        install_python_version ${globalVersion}
    fi

    pyenv global ${globalVersion}
    pip install --upgrade tox
    pip install --upgrade virtualenv
    pip install --upgrade pip
    echo "Python version ${globalVersion} used as global python."
fi

mkdir -p ${HOME}/.virtualenvs
while IFS=$'\t' read -r name version src; do
    if [ ! ${versions[${version}]+_} ]; then
        versions[${version}]="created"
        install_python_version ${version}
    fi
    
    #pyenv virtualenv ${version} ${name}
    #pyenv activate ${name}

    pyenv local ${version}

    # Upgrade pip to latest to avoid warnings
    #pip install --upgrade pip
    # vscode needs pylint
    #pip install --upgrade pylint
    pythonPath=$(pyenv which python)
    echo "pythonPath: ${pythonPath}"

    pyenv local --unset

    virtualenv --python ${pythonPath} ${HOME}/.virtualenvs/${name}
    source ${HOME}/.virtualenvs/${name}/bin/activate
    pip install --upgrade pip
    pip install --upgrade pylint
    deactivate

    #pyenv deactivate
    echo "Created/initialised virtualenv for ${name} with version ${version}."
done < <(jq -r '.microservices[] | [.name,.pythonVersion,.src] | @tsv' ${HOME}/install/config.json)
