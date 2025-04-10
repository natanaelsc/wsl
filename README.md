# Subsistema do Windows para Linux (WSL)

O WSL permite executar distribuições Linux no Windows (como Ubuntu, Debian, Arch Linux, etc) sem modificação, sem a sobrecarga de uma máquina virtual ou configuração em dual boot.

## Requisitos

* Windows 10 versão 2004 ou superior (Build 19041 ou superior) ou o Windows 11.

* Mínimo 8GB de RAM disponível.

* Virtualização habilitada na BIOS.

## [Instalação](https://learn.microsoft.com/pt-br/windows/wsl/install)

1. Habilite o recurso **Subsistema do Windows para Linux** e **Plataforma de Máquina Virtual** em **Recursos do Windows** ou execute os comandos abaixo como administrador no PowerShell:

    ```powershell
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

2. Ainda como administrador, execute o comando de instalação:

    ```powershell
    wsl --install -d <Distribution Name>
    ```

    Distribuições Linux disponíveis:

    ```powershell
    wsl --list --online
    ```

3. Reinicie o computador.

4. Na inicialização, será apresentada a janela de sua distro para definição do usuário.

5. Atualize os pacotes:

    ```sh
    sudo apt update && sudo apt upgrade -y
    sudo apt install curl -y
    ```

## [Configuração](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config)

### [Windows](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config#wslconfig)

1. Defina as configurações no Windows para todas as distribuições Linux **WSL2**.

    No PowerShell, execute o comando:

    ```powershell
    notepad $env:USERPROFILE\.wslconfig
    ```

    Ou, no Windows Explorer, navegue até o caminho:

    ```powershell
    %USERPROFILE%
    ```

    E crie o arquivo `.wslconfig` na pasta do usuário.

2. Copie e cole as linhas abaixo no arquivo. [Exemplo](./config/.wslconfig):

    ````conf
    [wsl2]
    memory=8GB
    processors=1
    ````

3. Reinicie a distro após editar o arquivo:

    ```powershell
    wsl --shutdown <Distribution Name>
    ```

### [Distro](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config#wslconf)

1. Defina a configuração local para a distro.

    No terminal da distribuição, execute o comando:

    ```sh
    sudo nano /etc/wsl.conf
    ```

2. Copie e cole as linhas abaixo no arquivo. [Exemplo](./config/wsl.conf):

    ```conf
    [boot]
    systemd=true

    [automount]
    enabled = true
    root = /mnt
    ```

3. No terminal do Windows, reinicie a distribuição:

    ```powershell
    wsl --shutdown <Distribution Name>
    ```

## Ferramentas

### [Git](git.md)

### [Asdf](asdf.md])

### [Docker](docker.md)

### [ZSH](zsh.md)

## Dicas e Truques

### Otimizando Disco Virtual (.vhdx) da Distribuição

* Optimize-VHD (Não funciona no Windows Home)**

Hyper-V deve estar habilitado para usar o comando `Optimize-VHD`.

```shell
Optimize-VHD -Path C:\Users\Natanael\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx -Mode Full
Optimize-VHD -Path C:\Users\Natanael\AppData\Local\Docker\wsl\data\ext4.vhdx -Mode Full
```

* DiskPart

1. Desligue a distribuição:

    ```shell
    wsl --shutdown <Distribution Name>
    ```

2. Abra o DiskPart:

    ```shell
    diskpart
    ```

3. Selecione o arquivo de disco virtual (.vhdx) do seu WSL. Verifique qual o caminho que está localizada na sua máquina seguindo como exemplo o caminho abaixo:

    ```shell
    select vdisk file="C:\Users\Natanael\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx"
    ```

4. Anexe o disco:

    ```shell
    attach vdisk readonly
    ```

5. Compacte:

    ```shell
    compact vdisk
    ```

6. Desanexe o disco e saia:

    ```shell
    detach vdisk
    exit
    ```

## Desinstalar Distribuição

1. Siga para ***Configurações → Aplicativos → Aplicativos instalados → Selecione sua distro → Desinstalar***.
2. Como administrador, abra o terminal e execute o comando:

    ```sh
    wsl --unregister <Distribution Name>
    ```

3. Reinicie o PC.

## Desinstalar WSL

1. Siga para ***Configurações → Aplicativos → Aplicativos instalados → Selecione sua distro → Desinstalar***.

2. Na mesma aba de aplicativos, procure por ***Windows Subsystem for Linux update*** e coisas parecidas com ***subs*** e ***linux***, desinstale todas, cuidado pra não desinstalar seu sistema.

3. Desinstale os componentes do WSL2. Pesquise por ***Recursos do Windows***, você deverá ver algo como ***Ativar ou desativar recursos do Windows***, selecione e siga em frente. Desative ***Subsistema do Windows para Linux*** e ***Plataforma de Máquina Virtual***.

4. Como administrador, abra o terminal e execute o comando:

    ```sh
    wsl --unregister <Distribution Name>
    ```

5. Reinicie o PC.

6. Após a desinstalação, pode ser que permaneça resíduos em sua máquina como o disco virtual (.vhdx) do seu WSL. Exclua, caso não tenha a pretensão de anexar esse disco em uma futura instalação.

    ```powershell
    %UserProfile%\AppData\Local\Packages
    ```

    Procure por pastas com o nome da sua distribuição Linux, como `CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc` e exclua.

## Referências

<https://learn.microsoft.com/pt-br/windows/wsl/install>

<https://pureinfotech.com/uninstall-wsl2-windows-10/>

<https://learn.microsoft.com/pt-BR/windows/wsl/wsl-config>
