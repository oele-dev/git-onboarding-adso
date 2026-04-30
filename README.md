# Git + GitHub — Onboarding ADSO 228118

> 🎓 Repo de práctica para **fichas 3235898 / 3235899** — primera experiencia con Git + GitHub.

## ¿Qué es esto?

Un repo donde cada aprendiz **agrega su propia presentación** como un archivo Markdown en `aprendices/`. Practicamos el flujo completo de Git + GitHub que vamos a usar en el proyecto formativo:

1. Hacer **fork** de este repo
2. Crear una **branch**
3. Agregar **tu archivo** de presentación
4. Hacer **commit** y **push**
5. Abrir un **Pull Request**
6. Esperar que **GitHub Actions** valide
7. Hacer **merge** a main

## Tu ejercicio

### 1. Fork

Click en **"Fork"** arriba a la derecha → "Create fork" en tu cuenta personal.

### 2. Clone tu fork

```bash
git clone https://github.com/{tu-usuario}/git-onboarding-adso.git
cd git-onboarding-adso
```

### 3. Crear tu branch

Reemplaza `juan-perez` por tu nombre en formato kebab-case:

```bash
git checkout -b presentacion/juan-perez
```

### 4. Crear tu archivo de presentación

Copia la plantilla y renómbrala a tu nombre:

```bash
cp aprendices/_ejemplo.md aprendices/juan-perez.md
```

Edita `aprendices/juan-perez.md` con tu información (mínimo: Nombre, Ficha, Sobre mí). Mira `_ejemplo.md` como referencia.

### 5. Commit + push

```bash
git add aprendices/juan-perez.md
git commit -m "feat: agrega presentacion de Juan Perez"
git push origin presentacion/juan-perez
```

### 6. Abrir Pull Request

GitHub te dará un link directo después del push. Si no, ve a tu fork → "Pull requests" → "New pull request".

**Base repository:** `oele-dev/git-onboarding-adso` · **base:** `main`
**Head repository:** `{tu-usuario}/git-onboarding-adso` · **compare:** `presentacion/juan-perez`

### 7. Espera el autograding

GitHub Actions valida automáticamente:

- ✅ Tu archivo está en `aprendices/`
- ✅ Filename en kebab-case (lowercase, guiones)
- ✅ Tiene secciones requeridas: `## Nombre`, `## Ficha`, `## Sobre mí`
- ✅ NO modificaste archivos de otros compañeros

Si todo está verde → **mergea**. Si hay rojo → lee el error, arregla, vuelve a hacer push.

## Reglas

✅ Solo agregas TU archivo en `aprendices/`
❌ No tocas archivos de otros (los tests fallan)
❌ No editas archivos del repo (solo `aprendices/{tu-nombre}.md`)

## ¿Para qué sirve este ejercicio?

Para que cuando vayamos al **proyecto formativo en serio** (`proyecto-formativo-adso`) ya tengas:

- ✅ Cuenta GitHub funcionando
- ✅ Git instalado y configurado
- ✅ VS Code listo
- ✅ Sepas qué es un fork, branch, commit, push, PR
- ✅ Hayas visto Actions correr en algo tuyo

---

**Sesión sincrónica:** jueves 30/04/2026 8pm Teams · 1 hora
**Instructor:** olcaicedo@sena.edu.co
