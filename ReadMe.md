# AI-CLI
## About
`AI-CLI` is a script, developed to simplify the execution of [MLflow Projects](https://www.mlflow.org/docs/latest/projects.html).  Whether you intend to run from a local folder structure or want to execute a remote project from a GitLab repository, both ways are supported in `ai-cli`. 
MLflow uses docker container to manage the dependencies of different projects. 'ai-cli' manages them for you automatically and provides additional functionality for convenience to speedup your workflow.

 - Run MLflow projects with one command
 - Easy access to related docker images
 - Jupyter integration

## Setup
Use `sudo make install` to install ai-cli system-wide. Each user has to execute `ai-cli init` before their first usage.
```bash
make install
make uninstall
```
When using ai-cli, the following dependencies are expected to be installed and running

 - requires git which is set-up with user name and email!
 - requires running docker deamon
 - requires htpasswd (apache2-utils), folder must exist and have permissions of user
 - requires jupyter(-core) to be installed

The script checks if dependencies are correctly configured and notifies the user at the start of each execution if something is not correctly configured.

### Configuration
You can set the url which is used as a base for MLflow and Jupyter access.
The configuration file is located at `/etc/ai-cli/`


Uninstall target does _not_ touch some internal configurations.
For a clean install

 - htpasswd
 - docker network mlflow-bridge
 - docker server and workspace

need to be cleared manually.
## Usage

    ai-cli [OPTIONS] COMMAND [ARGS]

### Options

    -h  Show help
    -c  Specify cuda version
    -v  Mount additional folder as volume
    -e  Specify environment file
    -n  Specify experiment name (default $MLFLOW_EXPERIMENT_NAME)
    -g  Specify visible GPUs (default $GPUS)

### Commands

    init              initialize user workspace
    start-server      start mlflow server
    stop-server       stop mlflow server
    restart-server    restart mlflow server
    upgrade           pull and rebuild the docker containers
    bash              start bash shell inside ai-cli container
    notebook          start jupyter notebook inside ai-cli container
    lab               start jupyter lab inside ai-cli container
    status            show overview over docker images
    exec PROGRAM      execute PROGRAMM inside ai-cli container
    run PATH          run MLProject from PATH inside ai-cli container
    run-from-git URI  run MLProject from git repo at URI inside ai-cli container

### Example

    Assume a mlflow project at current working directory:

    "ai-cli -n MyCoolProject bash"
    "ai-cli run ."
    "ai-cli -e .env run" (with .env as defautl environment file)
    "ai-cli -e the_envir run-from-git" (with MLFLOW_GIT_PROJECT defined)
    "ai-cli run-from-git "https://<token>:<password>@<uri>#<path/to/MLProject (optional)> -v <branch or commit hash>"

## License
    AI-CLI Simplifying AI Experiments
    Copyright (C) 2022  Marcel Arpogaus, Julian Jandeleit

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
## Acknowledgments
Parts of this work have been funded by the Federal Ministry for the Environment, Nature Conservation and Nuclear Safety due to a decision of the German Federal Parliament (AI4Grids: 67KI2012A).
