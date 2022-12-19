# asdf

Gerenciador de versões para ferramentas e linguagens.

## Instalação

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
```

## Configuração

### ZSH

* [Adicione](/zsh.md/#Plugins) `asdf` aos plugins no arquivo `.zshrc` para ser executado na inicialização.

### Plugins

Veja mais na sobre plugins na [documentação](https://asdf-vm.com/guide/getting-started.html#_4-install-a-plugin).

* Comandos para adição e atualização:

→ asdf plugin add nome_do_plugin
→ asdf plugin add nome_do_plugin url_do_github
→ asdf plugin update nome_do_plugin
→ asdf plugin update nome_do_plugin url_do_github
→ asdf plugin update --all

### Linguagens & Ferramentas

#### Java

* Adição do plugin, instalação da versão 11 do OpenJDK e atribuição global.

    ```sh
    asdf plugin add java
    asdf install java openjdk-11
    asdf global java openjdk-11
    java -version
    ```

Você pode listar todas as versões com `asdf list all java` ou filtrar apenas versões Temurin `asdf list all java | grep temurin`.

#### NodeJS

* Adição do plugin, instalação da versão lts e atribuição global.

    ```sh
    asdf plugin add nodejs
    asdf install node lts
    asdf global node lts
    node -v
    ```

#### Python

* Adição do plugin, instalação da ultima versão e atribuição global.

    ```sh
    asdf plugin add python
    asdf install python latest
    asdf global python latest
    ```

### Golang

* Adição do plugin, instalação da ultima versão e atribuição global.

    ```sh
    asdf plugin add golang
    asdf install golang latest
    asdf global golang latest
    go --version
    ```

#### Lua

* Adição do plugin, instalação da ultima versão e atribuição global.

    ```sh
    asdf plugin add lua
    asdf install lua latest
    asdf global lua latest
    lua --version
    ```
