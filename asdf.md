# asdf

asdf é um gerenciador de versões. Todas as definições de versão estão contidas em um arquivo (.tool-versions) que você pode adicionar no repositório Git do seu projeto para compartilhar com sua equipe, garantindo que todos estejam usando exatamente as mesmas versões de ferramentas.

## Instalação

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
```

## Configuração

### ZSH

* [Adicione](/zsh.md/#Plugins) `asdf` aos plugins no arquivo `.zshrc` para sempre ser executado na inicialização do seu host.

### Plugins

Você pode instalar diversos plugins, veja mais na [documentação](https://asdf-vm.com/guide/getting-started.html#_4-install-a-plugin).

* Comandos para adição e atualização:

→ asdf plugin add nome_do_plugin
→ asdf plugin add nome_do_plugin url_do_github
→ asdf plugin update nome_do_plugin
→ asdf plugin update nome_do_plugin url_do_github
→ asdf plugin update --all

### Linguagens

#### Java

* Adição do plugin, instalação da versão 11 do OpenJDK e atribuindo como padrão global.

    ```sh
    asdf plugin add java
    asdf install java openjdk-11
    asdf global java openjdk-11
    ```

Você ainda pode listar todas as versões com `asdf list all java` ou filtrar só pelas versões Temurin `asdf list all java | grep temurin`.

#### NodeJS

* Adição do plugin, instalação a versão lts e atribuindo como padrão global.

    ```sh
    asdf plugin add nodejs
    asdf install node lts
    asdf global node lts
    ```

#### Python

* Adição do plugin, instalação da ultima versão e atribuindo como padrão global.

    ```sh
    asdf plugin add python
    asdf install python latest
    asdf global python latest
    ```

### Golang

* Adição do plugin, instalação da ultima versão e atribuindo como padrão global.

    ```sh
    asdf plugin add golang
    asdf install golang latest
    asdf global golang latest
    ```

#### Lua

* Adição do plugin, instalação da ultima versão e atribuindo como padrão global.

    ```sh
    asdf plugin add lua
    asdf install lua latest
    asdf global lua latest
    ```
