# Learning-Scripts
Submódulo learning-scripts

Fazer o push do repositorio scripts/  (submódulo Git) na estrutura abaixo:


learning/
├── kubernetes/
│   ├── deployments/      (submódulo Git)
│   ├── statefulsets/     (submódulo Git)
│   ├── pv-pvc/           (submódulo Git)
│   ├── secrets/          (submódulo Git)
│   └── configmaps/       (submódulo Git)
├── github/               (submódulo Git)
├── gitlab/               (submódulo Git)
├── docker/               (submódulo Git)
├── terraform/            (submódulo Git)
├── ansible/              (submódulo Git)
├── scripts/              (submódulo Git)
└── ci-cd/                (submódulo Git)

Para dar push no submódulo scripts/, precisa entrar no diretório scripts/ (que é um repositório Git separado) e fazer o push normalmente, como em qualquer repositório Git.

Aqui está o passo a passo:

### ✅ 1. Acesse o submódulo:
```bash
cd scripts/
```
---

### ✅ 2. Verifique o status:
Veja se há algo para commitar/push:
```bash
git status
```
---
### ✅ 3. Adicione e faça commit (se necessário):
Se você modificou ou adicionou arquivos:
```bash
git add .
git commit -m "Mensagem do commit no submódulo scripts"
```
---

### ✅ 4. Dê push no repositório do submódulo:
Substitua main pelo branch atual, se for outro (como master, por exemplo).
```bash
git push origin main
```
---

### 🔄 5. Volte para o repositório principal (pai) e atualize o ponteiro:
Depois de dar o push no submódulo, volte ao repositório learning/ e registre o novo commit do submódulo:
```bash
cd ..
git add scripts/
git commit -m "Atualiza submódulo scripts para novo commit"
git push origin main
```
Isso atualiza o ponteiro do submódulo no repositório principal.

---

## ✅ Resumo:
O submódulo é um repositório independente.

O push deve ser feito dentro do diretório do submódulo.

O repositório principal (learning/) guarda apenas um ponteiro (hash do commit) para cada submódulo.

Depois do push no submódulo, você precisa commitar o novo ponteiro no repositório pai.✅ Resumo:
O submódulo é um repositório independente.

O push deve ser feito dentro do diretório do submódulo.

O repositório principal (learning/) guarda apenas um ponteiro (hash do commit) para cada submódulo.

Depois do push no submódulo, você precisa commitar o novo ponteiro no repositório pai.

### Last Modified 
2025/05/06  README.md


