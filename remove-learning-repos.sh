#!/bin/bash

set -x
# Deletar repositórios
gh repo delete thiago1souto/learning-docker --confirm
gh repo delete thiago1souto/learning-terraform --confirm
gh repo delete thiago1souto/learning-github --confirm
gh repo delete thiago1souto/learning-gitlab --confirm
gh repo delete thiago1souto/learning-kubernetes-deployments --confirm
gh repo delete thiago1souto/learning-ansible --confirm
gh repo delete thiago1souto/learning-kubernetes-configmaps --confirm
gh repo delete thiago1souto/learning-kubernetes-pv-pvc --confirm
gh repo delete thiago1souto/learning-kubernetes-statefulsets --confirm
gh repo delete thiago1souto/learning-scripts --confirm
gh repo delete thiago1souto/learning-kubernetes-secrets --confirm
gh repo delete thiago1souto/learning-ci-cd --confirm
gh repo delete thiago1souto/learning --confirm

