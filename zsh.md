# ZSH

## Visão Geral

* [Instalação](#instalação)

  * [Oh My Zsh](#oh-my-zsh)

  * [Powerlevel10K](#powerlevel10k)

* [Plugins](#plugins)

  * [Zsh Autosuggestions](#zsh-autosuggestions)
  
  * [Zsh NVM](#zsh-nvm)

* [Definindo terminal padrão no VSCode](#definido-terminal-padrão-no-vscode)

## Instalação

```sh
sudo apt-get install zsh -y
```

### [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### [Powerlevel10K](https://github.com/romkatv/powerlevel10k)

Tema customizado para Oh My Zsh.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Para uma melhor experiência, instale as fontes [MesloLGS NF](/fonts/MesloLGS%20NF.zip).

1. Abra o arquivo `.zshrc`:

    ```sh
    nano .zshrc
    ```

2. Defina como seu tema padrão. Substitua o valor de `ZSH_THEME` por:

    ```conf
    ZSH_THEME="powerlevel10k/powerlevel10k"
    ```

3. Aplique as alterações e configure o powerlevel10k pela primeira vez.

    ```sh
    source .zshrc
    ```

    Caso deseje reconfigurar, sempre pode chamar pelo comando `p10k configure`.

## Plugins

Você pode adicionar diversos plugins ao zsh.

[GitHub](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)

1. Para adicionar um plugin basta apenas adicionar o nome no campo `plugins=()` em `.zshrc`:

    ```sh
    nano .zshrc
    ```

2. Aplique a configuração:

    ```sh
    source .zshrc
    ```

### [Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

* Adicione `zsh-autosuggestions` aos plugins no arquivo `.zshrc`.

### [Zsh nvm](https://github.com/lukechilds/zsh-nvm)

Gerenciado de versões do NodeJS.

```sh
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/plugins/zsh-nvm
```

* Adicione `zsh-nvm` aos plugins no arquivo `.zshrc`.

* Para ver as opções do plugin execute o comando `nvm --help`.

### [asdf](https://github.com/asdf-vm/asdf)

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
```

* Adicione `asdf` aos plugins no arquivo `.zshrc`.

* Para ver as opções do plugin execute o comando `asdf --help`.

### [Autoenv](https://github.com/hyperupcall/autoenv)

Esse plugins carrega o [Autoenv](https://github.com/hyperupcall/autoenv).

* Adicione `autoenv` aos plugins no arquivo `.zshrc`.

### Definido terminal padrão no VSCode

Adicione as suas configurações (settings.json) a linha abaixo:

```json
  "terminal.integrated.defaultProfile.linux": "zsh",
```
