
[ djavue2] Steps
================================================================================

Adding VS Code .devcontainer to this template:

* https://github.com/evolutio/djavue2

## 1. Added .devcontainer files from previous tdd-django-vue project

* pointed .devcontainer/requirements.txt to template/requirements.txt
* commented out client build in install-dev-tools.sh

## 2. init myproject following readme.md instructions:

* added @vue/cli-init to .devcontainer dockerfile and rebuilt devcontainer

``` bash
$ vue init evolutio/djavue2 myproject
```

## 3. follow instructions in myproject/readme.md

```bash
source dev.sh  # import useful bash functions
devhelp  # like this one ;)
dkbuild  # builds the docker image for this project. The first time Will take a while.
```
* commented out mkdir /run/nginx command in myproject/Dockerfile as this seems to already be created and build was failing
* commented out network_mode: "host" on nginx service in dev.yaml as this was giving an error
* modified these commands in dev.sh:

```bash
dknpminstall  # I'll explain later!
dkup  # Brings up everything
```

* [dkup] - make this use .devcontainer docker-compose.yml to override volumes so they are named correctly for running docker-compose in devcontainer

