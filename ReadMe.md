# AI-CLI
[![test ci][ci-shiled]][ci-url]
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Apache License 2.0][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

## About
`ai-cli` is a command line script, developed to simplify the execution of [MLflow Projects](https://www.mlflow.org/docs/latest/projects.html).
Whether you intend to run from a local folder structure or want to execute a remote project from a GitLab repository, both ways are supported in `ai-cli`. 
Docker containers are used to manage the dependencies and isolate different projects from the host system.
`ai-cli` helps to manages these containers and provides additional functionality, like:

- Run MLflow projects with one command
- Manage project dependecies in differnet docker images
- CUDA support
- [Jupyter Lab](https://github.com/jupyterlab/jupyterlab) integration
- easy management of different [CML runners](https://github.com/iterative/cml) for differnet git repositories.

## Setup

Use `sudo make install` to install ai-cli system-wide. Each user has to execute `ai-cli init` before their first usage.

```bash
make install
make uninstall
```

When using `ai-cli`, the following dependencies are expected to be installed and running

- requires git which is set-up with user name and email!
- requires running docker deamon
- requires htpasswd (apache2-utils), folder must exist and have permissions of user
- requires jupyter(-core) to be installed

The script checks if dependencies are correctly configured and notifies the user at the start of each execution if something is not correctly configured.

## Configuration

You can set the url which is used as a base for MLflow and Jupyter access.
The configuration file is located at `/etc/ai-cli/`

Uninstall target does _not_ touch some internal configurations.
For a clean install

- htpasswd
- docker network mlflow-bridge
- docker server and workspace

need to be cleared manually.

## Usage

    ai-cli [OPTIONS] COMMAND [ARGS...]

### Options

    -v VOLUME            Specify additional docker VOLUMEs
    -e FILE              Specify environment FILE
    -g GPUS              Enable gpu support. Set specific GPUS, e.g. 0,1 for gpu 0 and 1.
    -r RUNTIME           Specify specific RUNTIME. Default is read from docker info.
    -n NAME              Specify experiment NAME
    -c CUDA              Build with cuda support. Specify CUDA version to use. Tags image with 'c<VERSION>' by default.
    -i IMAGE             Specify docker IMAGE to be used.
    -t TAG               Specify image TAG to be used.
    -h                   Show help

### Commands

    init                 initialize this script for your user
    start-server         start mlflow server
    stop-server          stop mlflow server
    restart-server       restart mlflow server
    status               show status of your environment
    build                build image from dockerfile
    bash                 start bash shell inside container
    notebook             start jupyter notebook server
    lab                  start jupyter lab server
    exec PROGRAMM        execute PROGRAMM inside container
    run PATH             run MLProject from PATH inside container
    run-from-git URI     run MLProject from git repo at URI inside container
    reset-password       Reset Password for mlflow you will setup a new one at next server start

### Workflow

After a fresh install, each user needs to execute `ai-cli init` before starting to work.
To use the mlflow dashboard, the mlflow server needs to be started using `ai-cli start-server`.

`ai-cli` is based on docker images/containers. The list of images associated to a user can be seen with `ai-cli status`.
The image ai-cli/<USER>:default is used by default. 
A different associated image can selected by specifying the -t flag.

At the start, no image exists. A basic image get created using `ai-cli build`.
Now `ai-cli` is ready to be used, examples are provided below.

### Example commands

Assume a mlflow project at current working directory:

| comand                                                                                                            | comment                                                                                 |
|-------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| `ai-cli lab`                                                                                                      | opens jupyter lab at https://[USER]-lab.[HOST]. Use token from command output to login. |
| `ai-cli run .`                                                                                                    | runs local mlflow project                                                               |
| `ai-cli bash`                                                                                                     | open bash for local project in docker image.                                            |
| --- legacy ---                                                                                                    | --- ---                                                                                 |
| `ai-cli -e .env run .`                                                                                            | with .env as defautl environment file                                                   |
| `ai-cli -e the_envir run-from-git`                                                                                | with MLFLOW_GIT_PROJECT defined                                                         |
| `ai-cli run-from-git "https://<token>:<password>@<uri>#<path/to/MLProject (optional)> -v <branch or commit hash>` |                                                                                         |

## Cuda Support

`ai-cli` is built to support tensorflow with cuda.
To use cuda, a cuda-enabled image is necessary. 
To create a cuda image, use the build command and specify the desired cuda version using the `-c` switch.
`ai-cli -c 11.2 build`.

For the cuda image to work, add the `-g` option when using any command to actually include gpus that cuda can use. 
This makes the specified gpu(s) available and switches the runtime to "nvidia".
Note that, the docker-nvidia-runtime needs to be set up correctly beforehand.

For example `ai-cli -g 0 -c 11.2 bash` opens a bash command line with inside the container, exposing gpu "0" with support for cuda 11.2. Note, that the images for cuda 11.2 need to be built beforhand as stated above.
It can be verified that the gpu is used, using `nvidia-smi` inside the container. Note, that the cuda version shown by nvidia-smi does not necessarily represent the correct version because of differences between driver API and runtime API version.
Also, the command is not installed by default.

## CML Runner

`ai-cli` supports starting a CML runner locally for your CI/CD Workflow.

Here is how to use `ai-cli runner GIT-ORIGIN-HTTPS ACCESS-TOKEN`.

1. Create access token for your project (as owner, scope: api in gitlab) or personal access token.
2. Enable CI for your repository. (Settings->General->Visibility, project features, permissions->Repository->CI/CD->Save Changes in gitlab)
3. Configure pipeline (.gitlab-ci.yml, in gitlab). For the local runner to pickup a job, the job needs to have the tag `ai-cli`.
   For Example:
   ```yml
   test:
    tags:
     - ai-cli
    script:
     - echo "Hello World" >> report.md
     - cml comment create report.md
   ```
4. Copy the https clone link for your repository. Start your local runner using this link.

Now the runner is ready to pick up your jobs.


## Troubleshooting

| issue                                                 | help                                                                                                                                        |
|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `run` fails with error "too many 500 error responses" | Provide experiment name with `-n` flag. If name already used, try with new name. Names deleted on the mlflow-dashboard still count as used. |

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

[ci-shiled]: https://github.com/MArpogaus/ai-cli/actions/workflows/test-ci.yml/badge.svg?style=flat-square
[ci-url]: https://github.com/MArpogaus/ai-cli/actions
[contributors-shield]: https://img.shields.io/github/contributors/marpogaus/ai-cli.svg?style=flat-square
[contributors-url]: https://github.com/marpogaus/ai-cli/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/marpogaus/ai-cli.svg?style=flat-square
[forks-url]: https://github.com/marpogaus/ai-cli/network/members
[stars-shield]: https://img.shields.io/github/stars/marpogaus/ai-cli.svg?style=flat-square
[stars-url]: https://github.com/marpogaus/ai-cli/stargazers
[issues-shield]: https://img.shields.io/github/issues/marpogaus/ai-cli.svg?style=flat-square
[issues-url]: https://github.com/marpogaus/ai-cli/issues
[license-shield]: https://img.shields.io/github/license/marpogaus/ai-cli.svg?style=flat-square
[license-url]: https://github.com/marpogaus/ai-cli/blob/master/COPYING
[linkedin-shield]: https://img.shields.io/badge/-linkedin-black.svg?style=flat-square&logo=linkedin&colorb=555
[linkedin-url]: https://linkedin.com/in/marpogaus
