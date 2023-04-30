# Subsistema do Windows para Linux (WSL)

O WSL te permite instalar distros Linux no Windows (como Ubuntu, Debian, Arch Linux, etc) sem modificação, sem a sobrecarga de uma máquina virtual ou configuração dual boot.

## Visão Geral

- [Requisitos](#requisitos)

- [Instalação](#instalação)

- [Configuração](#configuração)

  - [Global](#global)

  - [Local](#local)

  - [Git](/git.md)

  - [Docker](/docker.md)

  - [zsh](/zsh.md)

  - [asdf](/asdf.md)

- [Otimizando Disco Virtual (.vhdx)](#otimizando-disco-virtual-vhdx)

- [Desinstalação](#desinstalação)

- [Referências](#referências)

## Requisitos

- Windows 10 versão 2004 ou superior (Build 19041 ou superior) ou o Windows 11.

- No mínimo 8GB de RAM.

## Instalação

1. Habilite o recurso do **Subsistema do Windows para Linux** e a **Plataforma de Máquina Virtual**:

    ```powershell
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

2. Atribua a versão padrão do WSL para a versão 2:

    ```powershell
    wsl --set-default-version 2
    ```

3. Execute o comando de instalação:

    ```powershell
    wsl --install -d Ubuntu
    ```

    Outras distribuições Linux disponíveis podem ser visualizadas com:

    ```powershell
    wsl --list --online
    ```

4. Reinicie o computador.

5. Na inicialização, será apresentada a janela de sua distro para definição do usuário.

6. Atualize os pacotes:

```sh
sudo apt update && sudo apt upgrade -y
```

## Configuração

### Global

Definição de configuração global para todas as distribuições Linux **WSL2**.

1. Crie o arquivo `.wslconfig` na pasta do usuário no Windows.

    ```cmd
    notepad %USERPROFILE%\.wslconfig
    ```

2. Copie e cole as linhas abaixo no arquivo. Você pode ver mais no [site oficial](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config) ou [minha configuração atual](/my-config-files/.wslconfig).

    ````conf
    [wsl2]
    memory=8GB
    processors=1
    ````

3. Reinicie a distro após editar o arquivo:

    ```powershell
    wsl --shutdown
    ```

### Local

Definição de configuração local para distro. Aplicado em ambos, WSL e WSL2.

1. Crie o arquivo `wsl.conf` em `/etc` na distro desejada.

    ```sh
    sudo nano /etc/wsl.conf
    ```

2. Copie e cole as linhas abaixo no arquivo. Você pode ver mais no [site oficial](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config) ou [minha configuração atual](/my-config-files/wsl.conf).

    ```conf
    [boot]
    systemd=true

    [automount]
    enabled = true
    root = /mnt
    ```

3. Reinicie sua distro.

    ```powershell
    wsl --shutdown
    ```

## Otimizando Disco Virtual (.vhdx)

### Optimize-VHD (Não funciona no Windows Home)**

Antes, verifique se o Hyper-V está habilitado.

```shell
Optimize-VHD -Path C:\Users\Natanael\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx -Mode Full
Optimize-VHD -Path C:\Users\Natanael\AppData\Local\Docker\wsl\data\ext4.vhdx -Mode Full
```

### DiskPart (Qualquer versão do Windows)

1. Desligue sua distro:

    ```shell
    wsl --shutdown
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

5. Compacte.

    ```shell
    compact vdisk
    ```

6. Desanexe o disco e saia.

    ```shell
    detach vdisk
    exit
    ```

## Desinstalação

1. Siga: ***Configurações → Aplicativos → Aplicativos instalados ou algo parecido → Pesquise sua distro → Selecione desinstalar → Desinstalar de novo***. Esses passos devem está corretos ou fazerem algum sentido, eu realmente não me recordo.

2. Na mesma aba de aplicativos, procure por ***Windows Subsystem for Linux update*** e coisas parecidas com ***subs*** e ***linux***, desinstale todas, cuidado pra não desinstalar seu sistema.

3. Desinstale os componentes do WSL2. Pesquise por ***Recursos do Windows***, você deverá ver algo como ***Ativar ou desativar recursos do Windows***, selecione e siga em frente. Desative ***Subsistema do Windows para Linux*** e ***Plataforma de Máquina Virtual***.

4. Como administrador, abra o PowerSheel ou CMD e execute o comando:

    ```sh
    wsl --unregister <Distro>
    ```

5. Reinicie seu PC.

6. Após a desinstalação, pode ser que permaneça resíduos em sua máquina como o disco virtual (.vhdx) do seu WSL. Exclua, caso não tenha a pretensão de anexar esse disco em uma futura instalação.

    ```powershell
    %UserProfile%\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState
    ```

## Referências

<https://learn.microsoft.com/pt-br/windows/wsl/install>

<https://pureinfotech.com/uninstall-wsl2-windows-10/>

<https://learn.microsoft.com/pt-BR/windows/wsl/wsl-config>
