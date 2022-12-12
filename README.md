# Windows Subsystem for Linux (WSL)

A melhor forma de aproveitar o Linux e o Windows ao mesmo tempo em um máquina com Windows é o WSL.

Esse sistema te permite instalar uma distro Linux (como Ubuntu, Debian, Arch Linux, etc) e brincar com os utilitários e ferramentas de linha de comando bash, isso sem modificação, sem a sobrecarga de uma máquina virtual ou configuração dual boot.

## Visão Geral

- [Requisitos](#requisitos)

- [Instalação](#instalação)

- [Desisntalação](#desinstalação)

- [Configurações](#configurações)

  - [Configuração Global](#configuração-global)

  - [Configuração Local](#configuração-local)

  - [GitHub](/github.md)

  -

- [Referência](#referência)

## Requisitos

- Windows 10 versão 2004 e superior (Build 19041 e superior) ou o Windows 11.

- Recomendo no mínimo 8GB de RAM.

## Instalação

1. Abra o PowerShell ou CMD como administrador e insira o comando abaixo:

    ```powershell
    wsl --install
    ```

2. Reinicie seu PC.

- Na inicialização será aberta a janela da sua distro para que você defina sua senha.

- A distro instalada por padrão é a Ubuntu, você pode instalar outras e quantas quiser, o limite é sua máquina.

    ```powershell
    wsl --install <Distro>
    ```

- Recomendo atualizar os pacotes.

    ```sh
    sudo apt update && sudo apt upgrade -y
    ```

## Desinstalação

Se você não gostou da distro instalada ou simplemente quer se livrar dessa bagaça, está no lugar certo. Daqui em diante vou te mostrar como ser feliz de novo.

1. Siga: ***Configurações > Aplicativos > Aplicativos instalados ou algo parecido > Pesquise sua distro > Selecione desinstalar > Desinstalar de novo***. Esses passos devem está corretos ou fazerem algum sentido, eu realmente não me recordo.

2. Na mesma aba de aplicativos, procure por *Windows Subsystem for Linux update* e coisas parecidas com *subs* e *linux*, desinstale todas, cuidado pra não desinstalar seu sistema.

3. Desinstale os componentes do WSL2. Pesquise por *Recursos do Windows*, você deverá ver algo como ***Ativar ou desativar recursos do Windows***, selecione e siga em frente. Desative *Subsistema do Windows para Linux* e *Plataforma de Máquina Virtual*.

4. Como administrador, abra o PowerSheel ou CMD e execute o comando:

    ```sh
    wsl --unregister <Distro>
    ```

5. Reinicie seu PC.

6. Após a desinstalação, poderá permanecer alguns resíduos em sua máquina como o disco virtual (.vhdx) do seu WSL. Exclua, caso não tenha a pretenção de anexar esse disco em uma futura instalação.

    ```powershell
    C:\Users\<Usuário>\AppData\Local\Packages\<Distro>\LocalState
    ```

## Configurações

### Configuração Global

Defina a configuração que engloba todas as suas distribuições Linux instaladas. Funciona somente na versão 2 do WSL.

1. Abra ou crie o arquivo `.wslconfig` na sua pasta de usuário `%UserProfile%` do Windows.

    ```powershell
    notepad C:\Users\<Usuário>\.wslconfig
    ```

2. Copie e cole as linhas abaixo no arquivo ou ajuste se houver alguma configuração.

    ````conf
    [wsl2]
    memory=4GB # Limita quantidade de memória RAM
    processors=1 # Limita quantidade de processadores virtuais
    ````

3. Reinicie suas distro

    ```powershell
    wsl --shutdown
    ```

Essa é **[minha configuração](/config-files/.wslconfig)**, você pode encontrar mais exemplos no arquivo [.wslconfig.exemple](/config-files/.wslconfig.exemple)

### Configuração Local

Pode ser usada no WSL1 e WS2. Essa configuração é aplicada localmente, na distro instalada.

1. Abra ou crie o arquivo `wsl.conf` em `/etc` dentro da sua distro em execução.

    ```sh
    sudo nano /etc/wsl.conf
    ```

2. Você pode definir algumas dessas configurações:

    ```conf
    [boot]
    systemd=true

    [automount]
    enabled = true
    root = /mnt
    ```

3. Reinicie suas distro

    ```powershell
    wsl --shutdown
    ```

Essa é **[minha configuração](/config-files/wsl.conf)**, você pode encontrar mais exemplos no arquivo [wsl.conf.exemple](/config-files/wsl.conf.exemple)

## Referência

<https://learn.microsoft.com/pt-br/windows/wsl/install>

<https://pureinfotech.com/uninstall-wsl2-windows-10/>

<https://learn.microsoft.com/pt-BR/windows/wsl/wsl-config>
