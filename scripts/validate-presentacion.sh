#!/bin/bash
#
# Valida el PR de un aprendiz al repo git-onboarding-adso.
# Reglas:
#   1. Debe agregar UN archivo nuevo en aprendices/{nombre}.md
#   2. NO debe modificar archivos de otros aprendices
#   3. Filename debe ser kebab-case (a-z, 0-9, guiones)
#   4. El archivo debe tener secciones: ## Nombre, ## Ficha, ## Sobre mí

set -e

# Detectar cambios contra main
BASE="${1:-origin/main}"
ADDED=$(git diff --name-only --diff-filter=A "$BASE"...HEAD -- aprendices/ | grep -v '^aprendices/_ejemplo.md$' || true)
MODIFIED=$(git diff --name-only --diff-filter=M "$BASE"...HEAD -- aprendices/ || true)
DELETED=$(git diff --name-only --diff-filter=D "$BASE"...HEAD -- aprendices/ || true)

ERRORS=0

echo "🔍 Validando tu presentación..."
echo ""

# Regla 1: debe agregar al menos 1 archivo nuevo en aprendices/
if [ -z "$ADDED" ]; then
  echo "::error::❌ No agregaste ningún archivo en aprendices/"
  echo ""
  echo "Tienes que crear un archivo en aprendices/{tu-nombre}.md"
  echo "Ejemplo:"
  echo "  cp aprendices/_ejemplo.md aprendices/juan-perez.md"
  echo "  # editas el archivo, luego:"
  echo "  git add aprendices/juan-perez.md"
  echo "  git commit -m 'feat: agrega presentacion de Juan Perez'"
  echo "  git push"
  ERRORS=$((ERRORS + 1))
fi

# Regla 2: NO modificar archivos de otros
if [ -n "$MODIFIED" ]; then
  echo "::error::❌ Modificaste archivos de otros aprendices:"
  echo "$MODIFIED"
  echo ""
  echo "Solo agrega TU archivo, no toques los de otros compañeros."
  ERRORS=$((ERRORS + 1))
fi

if [ -n "$DELETED" ]; then
  echo "::error::❌ Eliminaste archivos:"
  echo "$DELETED"
  echo ""
  echo "No elimines presentaciones de otros."
  ERRORS=$((ERRORS + 1))
fi

# Regla 3 + 4: validar cada archivo nuevo
for FILE in $ADDED; do
  echo "📄 Revisando $FILE..."

  BASENAME=$(basename "$FILE" .md)

  # Filename kebab-case
  if [[ ! "$BASENAME" =~ ^[a-z0-9-]+$ ]]; then
    echo "::error file=$FILE::Filename '$BASENAME' debe ser kebab-case (solo a-z, 0-9, guiones)"
    echo "  Ejemplos validos: juan-perez, maria-rodriguez, carlos-fernando-ruiz"
    echo "  Ejemplos invalidos: Juan Perez (espacios), JuanPerez (mayúsculas), juan_perez (guion bajo)"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Secciones requeridas
  for SECTION in "## Nombre" "## Ficha" "## Sobre mí"; do
    if ! grep -qF "$SECTION" "$FILE"; then
      echo "::error file=$FILE::Falta la sección '$SECTION'"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Tamaño mínimo (no archivo vacío)
  WORDS=$(wc -w < "$FILE")
  if [ "$WORDS" -lt 30 ]; then
    echo "::error file=$FILE::Tu archivo tiene solo $WORDS palabras — escribe al menos 30 (cuéntanos algo de ti)"
    ERRORS=$((ERRORS + 1))
  fi

  if [ $ERRORS -eq 0 ]; then
    echo "  ✅ $FILE valido"
  fi
done

echo ""
if [ $ERRORS -gt 0 ]; then
  echo "❌ Encontre $ERRORS error(es). Lee los mensajes arriba, arregla y vuelve a hacer push."
  exit 1
fi

echo "✅ Tu presentación es valida — listo para mergear a main."
