# Git

## Visão Geral

* [Instalação](#instalação)

* [Configuração](#configuração)

  * [Integração Windows/WSL](#integração-windowswsl-recomendada)

  * [Chave SSH](#chave-ssh)

  * [Assinatura de Commits com Chave GPG](#assinatura-de-commits-com-chave-gpg)

* [Mais](#mais)

  * [Inicializando Agent SSH com chave de segurança](#inicializando-agent-ssh)

  * [O arquivo .gitconfig](#o-arquivo-gitconfig)

## Instalação

Por padrão, o git vem instalado nas distribuições WSL, no entanto, você pode querer atualizar para a versão mais recente.

```sh
sudo apt-get install git -y
```

## Configuração

Escolha uma das opções abaixo para configurar.

### Integração Windows/WSL **(Recomendada)**

Você precisa ter o Git Bash instalado no Windows e com uma conta previamente configurada.

Baixe o pacote de instalação mais recente no [site oficial do Git](https://git-scm.com/download/win).

1. Com as instalações concluídas no Windows e no [WSL](#instalação), configure o arquivo `.gitconfig`. No terminal, entre com os comandos abaixo substituindo as informações dos atributos para os campos de `user.name` e `user.email` pelas suas.

    No meu caso:

    ```sh
    git config --global user.name "natanaelsc"
    git config --global user.email "natanael96@live.com"
    ```

2. Configure o *Git Credential Manager*:

    ```sh
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
    ```

O arquivo de configuração pode ser encontrados em `\\wsl$\distro\home\$USER\.gitconfig`.

### Chave SSH

1. Use o comando abaixo para gerar uma *passphrase* forte aleatória com até 48 caracteres:

    ```sh
    openssl rand -base64 48
    ```

2. Na sua distro execute o comando abaixo para gerar uma nova chave:

    ```sh
    ssh-keygen -t ed25519 -C "seu_email_github@example.com"
    ```

3. Observer que será exibido onde será guardada a chave, normalmente em `~/.ssh`. Mas se preferir você pode definir outro caminho. Caso contrário [Pressione Enter] pra prosseguir e salvar por padrão.

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

    ***Hi seuusuário! You've successfully authenticated, but GitHub does not provide shell access.***

    Para clonar um repositório privado, use a conexão SSH ao invés do endereço do mesmo.

### Assinatura de Commits com Chave GPG

1. Execute o comando para gerar chave GPG:

    ```sh
    gpg --full-generate-key
    ```

2. Nas etapas seguinte defina as opções:

    1. **1** para o tipo `(1) RSA and RSA (default)`

    2. **4096** para o tamanho da chave.

    3. **1y** ano para período de expiração e OK.

3. Adicione seu nome real e email do github. Sua chave será armazenada em `~/.gnupg`.

4. Liste suas chaves GPG e copie o ID da chave que você deseja adicionar ao GitHub. Está localizado entre `sec   rsa4096/` e a data de criação. Exemplo: `sec   rsa4096/<chave_id> 2023-01-23 [SC] [expires: 2024-01-23]`.

    ```sh
    gpg --list-secret-key --keyid-form LONG
    ```

5. Exporte a chave publica:

    ```sh
    gpg --armor --export <chave_id> # ID de sua chave
    ```

6. Na sua conta do GitHub siga para **Settings → SSH and GPG keys → GPG keys → New GPG key**. Cole a chave pública exportada e **add GPG key**.

7. Defina sua chave padrão de assinatura:

    ```sh
    git config --global user.signingkey <chave_id> # ID de sua chave
    ```

8. Adicione a variável `export GPG_TTY=$(tty)` ao arquivo `~/.bash_profile` ou `~/.zshrc`.

    ```sh
    echo "export GPG_TTY=$(tty)" >> ~/.bash_profile
    ```

    ```sh
    echo "export GPG_TTY=$(tty)" >> ~/.zshrc
    ```

9. Defina assinatura com chave GPG como padrão para **commits** de todos os repositórios:

    ```sh
    git config --global commit.gpgsign true
    ```

10. Defina assinatura com chave GPG como padrão para **tags** de todos os repositórios:

    ```sh
    git config --global tag.gpgsign true
    ```

11. Adicione a linha `use-agent` no arquivo `~/.gnupg/gpp.conf` e execute o agent gpg.

    ```sh
    echo "use-agent" >> ~/.gnupg/gpp.conf
    gpgconf --launch gpg-agent
    ```

#### Adicionando mais um email

1. Execute os comandos a seguir por etapa:

    ```sh
    gpg --edit-key 95693A1975F2F1F0
    ```

    ```sh
    adduid
    ```

    Repeti o procedimento de adição seguido no [item 3](#assinatura-de-commits-com-chave-gpg).

2. Selecione o email adicionado digitando `uid 2`, sendo 2 o valor do ID no meu caso. Digite `trust`, defina como `5` *5 = I trust ultimately* e confirme com `y`. Digite `save`

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
