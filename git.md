# Git

## Visão Geral

* [Instalação](#instalação)

  * [Integração Windows/WSL](#integração-windowswsl-recomendada)

  * [Assinatura de Commits com Chave GPG](#assinatura-de-commits-com-chave-gpg)

## Instalação

Por padrão, o git vem instalado nas distribuições WSL, no entanto, você pode querer atualizar para a versão mais recente.

```sh
sudo apt-get install git -y
```

### Integração Windows/WSL **(Recomendada)**

Necessário ter o [Git Bash](https://git-scm.com/download/win) instalado no Windows e com uma conta previamente configurada.

1. Com as instalações concluídas no Windows e no [WSL](#instalação), configure o arquivo `.gitconfig`. No terminal, entre com os comandos abaixo substituindo as informações dos atributos para os campos de `user.name` e `user.email` pelas suas.

    No meu caso:

    ```sh
    git config --global user.name "<USER_NAME>"
    git config --global user.email "<EMAIL>"
    ```

2. Configure o *Git Credential Manager*:

    ```sh
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
    ```

O arquivo de configuração pode ser encontrados em `\\wsl$\distro\home\$USER\.gitconfig`.

## Dicas e Truques

### Assinatura de Commits com Chave GPG

```sh
sudo apt-get install gnupg -y
```

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

### Arquivo de Configuração

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
