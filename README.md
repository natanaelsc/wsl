# Windows Subsystem for Linux (WSL)

A melhor forma de aproveitar o Linux e o Windows ao mesmo tempo em um máquina com Windows é o WSL. 

Esse sistema te permite instalar uma distro Linux (como Ubuntu, Debian, Arch Linux, etc) e brincar com os utilitários e ferramentas de linha de comando bash, isso sem modificação, sem a sobrecarga de uma máquina virtual ou configuração dual boot.

## Visão Geral

- [Requisitos](#requisitos)

- [Instalação](#instalação)

- [Desisntalação](#desinstalação)

## Requisitos

- Windows 10 versão 2004 e superior (Build 19041 e superior) ou o Windows 11.

- Recomendo no mínimo 8GB de RAM.

## Instalação

1. Abra o PowerShell ou CMD como administrador e insira o comando abaixo:

    ```powershell
    wsl --install
    ```

2. Reinicie seu PC.

Isso mesmo que você pensou, meu chapa. Com apenas esse comando tu faz o mundo girar.

A distro instalada por padrão é a Ubuntu, você pode instalar outras e quantas quiser, o limite é sua máquina.

    ```
    wsl --install <Distro>
    ```

## Desinstalação

Se você não gostou da distro instalada ou simplemente quer se livrar dessa bagaça, está no lugar certo. Daqui em diante vou te mostrar como ser feliz de novo.

1. Desinstale o app da sua distro. Siga: ***Configurações > Aplicativos > Aplicativos instalados ou algo parecido > Pesquise sua distro > Selecione desinstalar > Desinstalar de novo***. Esses passos devem está corretos ou fazerem algum sentido, eu realmente não me recordo.

2. Na mesma aba de aplicativos, procure por *Windows Subsystem for Linux update* e coisas parecidas com *subs* e *linux*, desinstale todas, cuidado pra não desinstalar seu sistema.

3. Desinstale os componentes do WSL2. Pesquise por *Recursos do Windows*, você deverá ver algo como ***Ativar ou desativar recursos do Windows***, selecione e siga em frente. Desative *Subsistema do Windows para Linux* e *Plataforma de Máquina Virtual*.

4. Reinicie seu PC.

5. Após a desinstalação, poderá permanecer alguns resíduos em sua máquina como o disco virtual (.vhdx) do seu WSL. Exclua, caso não tenha a pretenção de anexar esse disco em uma futura instalação.

    ```powershell
    C:\Users\<Usuário>\AppData\Local\Packages\<Distro>\LocalState
    ```
