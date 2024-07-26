# [Docker](https://www.docker.com)

[Docker](https://www.docker.com) é uma plataforma de software que permite a criação, teste e implantação de aplicativos em contêineres. Os contêineres são uma forma de empacotar um aplicativo com todas as partes necessárias, como bibliotecas e outras dependências, e enviá-lo como um único pacote. Ao fazer isso, o aplicativo será executado em qualquer ambiente: de um laptop a um servidor, na nuvem ou em um data center.

* [Instalação](#instalação)

* [Problemas](#problemas)

## [Instalação](https://docs.docker.com/desktop/wsl)

## Problemas

* *Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?*

    ```sh
    sudo service docker start
    ```

* *Got permission denied while trying to connect to the Docker daemon socket at unix*

    Caso se depare com um erro desse tipo utilizando comandos do Docker CLI sem `sudo`, você poderá resolve-lo adicionando seu usuário ao grupo `docker`.

    ```sh
    sudo usermod -aG docker $USER
    newgrp docker
    ```
