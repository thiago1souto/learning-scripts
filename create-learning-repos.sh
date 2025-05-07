#!/bin/bash

# Substitua pelo seu usuário do GitHub
USER="thiago1souto"

# Cria repositório principal com README
gh repo create "$USER/learning" --public --description "Repositório principal com submódulos" --add-readme
git clone "git@github.com:$USER/learning.git"
cd learning || exit

# Mapeamento dos submódulos
declare -A repos=(
  [kubernetes/deployments]="learning-kubernetes-deployments"
  [kubernetes/statefulsets]="learning-kubernetes-statefulsets"
  [kubernetes/pv-pvc]="learning-kubernetes-pv-pvc"
  [kubernetes/secrets]="learning-kubernetes-secrets"
  [kubernetes/configmaps]="learning-kubernetes-configmaps"
  [github]="learning-github"
  [gitlab]="learning-gitlab"
  [docker]="learning-docker"
  [terraform]="learning-terraform"
  [ansible]="learning-ansible"
  [scripts]="learning-scripts"
  [ci-cd]="learning-ci-cd"
)

for path in "${!repos[@]}"; do
  repo="${repos[$path]}"

  # Cria sub-repositório com README
  gh repo create "$USER/$repo" --public --description "Submódulo $repo" --add-readme

  # Remove diretório temporário, se existir, antes de clonar
  rm -rf "temp-$repo"

  # Clona, faz commit inicial (caso necessário) e push
  git clone "git@github.com:$USER/$repo.git" "temp-$repo"
  cd "temp-$repo" || exit
  touch .gitkeep
  git add .gitkeep
  git commit -m "Initial commit with .gitkeep"
  git push origin main
  cd ..

  # Adiciona como submódulo (usando SSH)
  git submodule add "git@github.com:$USER/$repo.git" "$path"
  
  # Remove temporário
  rm -rf "temp-$repo"
done

# Adiciona e faz o commit final
git add . 
git commit -m "Adiciona submódulos com estrutura inicial"
git push origin main

