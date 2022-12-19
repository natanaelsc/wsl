# GitHub

Nessa sessão você verá como instalar e configurar o git na sua WSL.

## Visão Geral

* [Instalação](#instalação)

* [Configuração](#configuração)

  * [Integração Windows/WSL](#integração-windowswsl-recomendada)

  * [Chave SSH](#chave-ssh)

* [Mais](#mais)

  * [Inicializando Agent SSH com chave de segurança](#inicializando-agent-ssh)

  * [O arquivo .gitconfig](#o-arquivo-gitconfig)

## Instalação

O Git já vem instalado na maioria das distribuições WSL, no entanto, você pode querer atualizar para a versão mais recente.

```sh
sudo apt-get install git -y
```

## Configuração

Escolha uma das opções abaixo para configurar.

### Integração Windows/WSL **(Recomendada)**

Você precisa ter o Git instalado no Windows. Baixe o pacote de instalação mais recente no [site oficial do Git](https://git-scm.com/download/win).

1. Com as instalações concluídas no Windows e no [WSL](#instalação), configure o arquivo `.gitconfig`. No terminal, entre com os comandos abaixo substituindo as informações dos atributos para os campos de `user.name` e `user.email` pelas suas. Execute primeiro no Windows e depois no seu WSL.

    ```sh
    git config --global user.name "nome_de_usuário"
    git config --global user.email "seu_email@exemplo.com"
    ```

2. Configure o Git Credential Manager. Apenas na sua distribuição Linux no WSL insira o comando abaixo:

    ```sh
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
    ```

O arquivo de configuração pode ser encontrados em `%USERPROFILE%\.gitconfig` no Windows e em `\\wsl$\distro\home\$USER\.gitconfig` no WSL ou com `nano ~/.gitconfig`.

### Chave SSH

1. Na sua distro execute o comando abaixo para gerar uma nova chave:

    ```sh
    ssh-keygen -t id_ed25519 -C "seu_email_github@example.com"
    ```

2. Observer que será exibido onde será guardada a chave, normalmente em `~/.ssh`. Mas se preferir você pode definir outro caminho. Caso contrário [Pressione Enter] pra prosseguir e salvar na pasta padrão.

3. Na próxima etapa será pedido que você defina uma *passphrase* e a confirmação, pode ser deixado em branco, mas recomendo que defina uma forte e salve em um gerenciador de senhas. Use o comando abaixo caso necessário para gerar uma senha forte aleatória com até 48 caracteres:

    ```sh
    openssl rand -base64 48
    ```

4. Serão criados dois arquivos na pasta `.ssh`, o arquivo `id_ed25519` com a chave privada e o arquivo `id_ed25519.pub` com a chave pública. Você pode visualiza-los com o comando abaixo, apenas trocando pelo nome do arquivo desejado.

    ```sh
    cat ~/.ssh/id_ed25519
    ```

5. Inicie o `ssh-agent` e adicione sua chave privada:

    ```sh
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    ```

6. Copie sua chave publica.

    ```sh
    cat ~/.ssh/id_ed25519.pub
    ```

7. Acesse sua conta do GitHub e siga para ***Perfil → Settings → SSH and GPG keys → SSH keys → New SSH key***. No campo ***Title*** atribua um nome, em ***Key type*** defina como `Authentication key` e em ***Key*** cole sua chave pública copiada do seu host. Depois disso selecione ***Add SSH key***. Você verá que sua chave foi adicionada e está listada. Para testar a conexão, use o comando abaixo:

    ```sh
    ssh -T git@github.com
    ```

    Se tudo estiver funcionando corretamente você verá:

    ***Hi natanaelsc! You've successfully authenticated, but GitHub does not provide shell access.***

    Para clonar um repositório privado, use a conexão SSH ao invés do endereço do mesmo.

## Mais

### Inicializando Agent SSH

Adicione o plugin do `ssh-agent` no [zsh](/zsh.md/#plugins). É necessário já o ter instalado, siga o [guia de instalação](/zsh.md/#instalação).

Com o zsh instalado, abra o arquivo de configuração e adicione o plugin `ssh-agent` aos demais, caso já possua algum, separe com espaço. Exemplo: `plugins=(git ssh-agent)`.

```sh
nano .zshrc
```

### O arquivo .gitconfig

* Defina o VSCode para abrir o arquivo de configuração:

    ```sh
    git config --global core.editor code
    ```

    Use `code .gitconfig` ou `git config --global --edit`.

* Defina a branch `main` ou qualquer outra como a branch padrão.

    ```sh
    git config --global init.defaultBranch main
    ```

* Liste todas as suas configurações:

    ```sh
    git config --global --list
    ```

## Erros no Git

* GH007: Your push would publish a private email address.

Ao ativar o recurso “Block command line pushes that expose my email”, você também deve configurar o Git para usar seu endereço de e-mail sem resposta. Resolva com o comando abaixo ou desativando o recurso em ***Settings → Emails***, desabilite ***Block command line pushes that expose my email***:

```sh
git config --global user.email "{ID}+{username}@users.noreply.github.com"
git rebase -i
git commit --amend --reset-author
git rebase --continue
git push
```

## Referência

<https://learn.microsoft.com/pt-BR/windows/wsl/tutorials/wsl-git>

<https://docs.github.com/en/authentication/connecting-to-github-with-ssh>
