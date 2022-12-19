# Docker WSL

## Instalação

1. Atualize e configure o repositório:

    ```sh
    sudo apt-get update
    sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release -y
    ```

2. Adicione a chave GPG oficial:

    **Ubuntu**

    ```sh
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

    **Debian**

    ```sh
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

3. Adicione as configurações ao repositório:

    **Ubuntu**

    ```sh
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

    **Debian**

    ```sh
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

4. Instale os pacotes do docker:

    ```sh
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    ```

5. Verifique se a instalação foi bem-sucedida:

    ```sh
    sudo docker run hello-world
    ```

6. **(Opcional)** Adicione seu usuário ao grupo docker para executar comandos sem sudo:

    ´´´sh
    sudo usermod -aG docker $USER
    newgrp docker
    ´´´

7. **(Opcional)** Instale o Portainer, interface web para gerenciamento Docker.

    ```sh
    sudo docker run -d \
      -p 8000:8000 \
      -p 9443:9443 \
      --name portainer \
      --restart=always \
      --pull=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v /home/docker/portainer/data:/data \
      portainer/portainer-ce:latest \
      -H unix:///var/run/docker.sock
    ```

    Acesse <https://localhost:9443>

## Atualização

Baixe o arquivo de pacote mais recente repetindo somente o processo de [instalação](#instalação) no passo 4.

## Desinstalação

1. Procure e desinstale todos os pacotes **docker**:

    ```sh
    dpkg -l | grep -i docker
    sudo apt purge -y docker-ce docker-ce-cli docker-ce-rootless-extras docker-compose-plugin docker-scan-plugin
    sudo apt autoremove -y docker-ce docker-ce-cli docker-ce-rootless-extras docker-compose-plugin docker-scan-plugin
    ```

2. Exclua todos os resíduos deixados, imagens, containers, volumes e remova o grupo docker:

    ```sh
    sudo rm -rfv /var/lib/docker /etc/docker /var/lib/containerd /var/run/docker.sock /etc/apt/keyrings/docker.gpg
    sudo groupdel docker
    ```

3. Remova a interface de rede Docker com os pacote `net-tools` e `bridge-utils`:

    ```sh
    sudo apt install net-tools bridge-utils
    sudo ifconfig docker0 down
    sudo ifconfig docker_gwbridge down
    sudo brctl delbr docker0
    sudo brctl delbr docker_gwbridge
    ```

## Veja mais

- Para permite que seu usuário execute o `sudo` sem digitar senha a todo momento que chamar o comando `docker`. Use essa opção ou a adicione seu usuário ao grupo docker (veja no passo 6 da [instalação](#instalação)).

    ```sh
    sudo visudo
    ```

    Adicione na ultima linha do arquivo.

    ```conf
    <nome_de_usuário> ALL=(ALL) NOPASSWD: /usr/bin/dockerd
    ```

- Iniciando Docker com WSL no Windows 10. Você precisa ter o [zsh](/zsh.md) instalado para funcionar.

    ```sh
    echo '# Start Docker daemon automatically when logging in if not running.' >> ~/.zshrc
    echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.zshrc
    echo 'if [ -z "$RUNNING" ]; then' >> ~/.zshrc
    echo '    sudo dockerd > /dev/null 2>&1 &' >> ~/.zshrc
    echo '    disown' >> ~/.zshrc
    echo 'fi' >> ~/.zshrc
    source .zshrc
    ```

- Iniciando Docker com WSL no Windows 11. Adicione a linha abaixo ou configure o arquivo [wsl.conf](/README.md/#local), se já houver esse campo. Caso exista a opção `systemd=true`, não será necessário adicionar essa linha.

    ```sh
    [boot]
    command="service docker start"
    ```

## Problemas

- *Got permission denied while trying to connect to the Docker daemon socket at unix*

    Caso se depare com um erro do tipo utilizando comandos do Docker CLI sem `sudo`, você poderá resolve-lo adicionando seu usuário ao grupo `docker` ou seguindo o passo do primeiro item em [veja mais](#veja-mais).

    ```sh
    sudo usermod -aG docker $USER
    newgrp docker
    ```

## Referências

<https://docs.docker.com/get-docker>

<https://docs.microsoft.com/pt-br/windows/wsl/install-win10>
