#!/bin/bash

set -e

RED='\033[0;31m'    # Rouge pour isBurning
YELLOW='\033[0;33m' # Jaune pour isAlmostBurning
NC='\033[0m'        # No Color - Réinitialise la couleur
BURNING="🔥"           # Emoji de feu
ALMOST_BURNING="🚨"
BOLD='\033[1m'

DEBUG_MODE="false"

truncate_text() {
  # 1. Déclare les variables comme locales pour ne pas polluer l'environnement.
  local input_string="$1"
  local max_length="${2:-20}" # Longueur maximale (20 par défaut)
  local ellipsis_chars=3       # Nombre de caractères pour "..."
  local truncation_limit=$((max_length - ellipsis_chars))
  local string_length=${#input_string}

  # 2. Vérifie si la longueur de la chaîne dépasse la limite (20)
  if (( string_length > max_length )); then
    # 3. Tronque la chaîne et ajoute les points de suspension
    # ${input_string:0:TRUNCATION_LIMIT} extrait la sous-chaîne.
    truncated=$(trim "${input_string:0:truncation_limit}")
    echo "${truncated}…"
  else
    # 4. Retourne la chaîne originale
    echo "$input_string"
  fi
}

trim() {
  local var="$1"

  echo "$var" | xargs
}

# Check for --debug argument
for arg in "$@"; do
    if [[ "$arg" == "--debug" ]]; then
        DEBUG_MODE="true"
        # We can also handle the argument removal here if needed
        # (e.g., using a filter or restructuring the loop)
        break
    fi
done

TIMEWARRIORDB="$HOME/.local/share/timewarrior/data"
LOCK_FILE="$TIME_STATUS_FILE.lock"
LOCK_DURATION_MINUTES=5
if [[ "$DEBUG_MODE" == "false" ]]; then
  if [ -f "$LOCK_FILE" ]; then
    if find "$LOCK_FILE" -mmin -"$LOCK_DURATION_MINUTES" -quit 2>/dev/null | grep -q "$LOCK_FILE"; then
      exit 0 # Termine le script sans erreur
    else
      rm -f "$LOCK_FILE"
    fi
  fi

  echo date > "$LOCK_FILE"
fi

if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
  DETAILS=$(echo "$BRANCH_NAME" | \
    sed -e 's/^.*\/\(#*\(SEN-\)*[0-9]*-[0-9.]*\).*/\1/g'
      )
  ISSUE=$(echo "$DETAILS" | sed -e 's/-[^-]*$//g')
  ESTIMATE=$(echo "$DETAILS" | sed -e 's/^#*\(SEN-\)*[^-]*-//g')
fi

currentRunningTimeResponse=$(curl --request GET \
  --url "https://api.clickup.com/api/v2/team/${CLICKUP_TEAM_ID}/time_entries/current" \
  --header "Authorization: ${CLICKUP_TOKEN}" \
  --header 'Accept: application/json' \
  --silent)

if [ $? -ne 0 ]; then
  ACTIVE_TAG=""
  CURRENT_TIME=0
  TASK_NAME=""
else
  TASK_NAME=$(trim "$(echo "$currentRunningTimeResponse" | jq -r '.data | .task.name')")
  TASK_NAME=" - $(truncate_text "$TASK_NAME" 15)"
  ACTIVE_TAG=$(echo "$currentRunningTimeResponse" | jq -r '.data | .task.custom_id')
  CURRENT_TIME=$(echo "$currentRunningTimeResponse" | jq '.data | .task.duration')
fi

if [ -z "$ISSUE" ] && [ -z "$ACTIVE_TAG" ]; then
  if [[ "$DEBUG_MODE" == "false" ]]; then
    rm -f "$LOCK_FILE"
  fi
  exit 0
fi

if [[ "$ISSUE" != "$ACTIVE_TAG" ]]; then
  if [[ "$ACTIVE_TAG" == "null" ]]; then
    ACTIVE_TAG="󱦠 "
  else
    TAG=" 󰓼 (${BOLD}${YELLOW}${ACTIVE_TAG}${NC}$TASK_NAME)"
  fi
else
  TAG=" 󰓼 ($ISSUE)"
fi

taskApiResponse=$(curl --request GET \
  --url "https://api.clickup.com/api/v2/task/${ISSUE}?custom_task_ids=true&team_id=${CLICKUP_TEAM_ID}&include_subtasks=true" \
  --header "Authorization: ${CLICKUP_TOKEN}" \
  --header 'Accept: application/json' \
  --silent)

if [ $? -ne 0 ]; then
  TIME_SPENT=0
  TIME_ESTIMATE=$ESTIMATE
else
  TIME_SPENT=$(echo "$taskApiResponse" | jq '.time_spent')
  TIME_ESTIMATE=$(echo "$taskApiResponse" | jq '.time_estimate')
  ESTIMATE=$(echo "scale=2; ${TIME_ESTIMATE} / 3600000" | bc -l)
fi


# Fonction pour convertir les secondes en format Hh Mm
format_duration() {
  hours=$(($1 + 0))
  minutes=$(($2 + 0))
  output=""
  if [ $hours -gt "0" ]; then
    output="${hours}h"
  fi

  if [ $minutes -gt "0" ]; then
    output="$output${minutes}m"
  fi

  echo $output
}

logged_formatted=$(echo "scale=2; ${TIME_SPENT} / 3600000 + ${CURRENT_TIME} / 3600000" | bc -l)


if [[ -n "$ESTIMATE" ]] && [[ "$ESTIMATE" != "0" ]]; then
  ALMOST_BURNING_THRESHOLD=$(echo "$ESTIMATE * 0.8" | bc)

  # La comparaison en virgule flottante utilise la commande 'bc' dans des conditions [ ]
  # Règle 1: isBurning
  # logged_formatted > 0 && logged_formatted >= estimate
  if [ $(echo "$logged_formatted > 0 && $logged_formatted >= $ESTIMATE" | bc -l) -eq 1 ]; then
      # Formatage: 🔥${RED}Valeur🔥
      logged_formatted="${BURNING}${RED}${BOLD}${logged_formatted}"
  # Règle 2: isAlmostBurning
  # logged_formatted > estimate * 0.8
  elif [ $(echo "$logged_formatted >= $ALMOST_BURNING_THRESHOLD" | bc -l) -eq 1 ]; then
      # Formatage: ${YELLOW}Valeur
      logged_formatted="${ALMOST_BURNING} ${YELLOW}${BOLD}${logged_formatted}"
  fi
  ESTIMATE=/${ESTIMATE}h
fi

# Affiche la chaîne finale pour Starship
if [[ "$DEBUG_MODE" == "false" ]]; then
  echo -e "   ${logged_formatted}h${NC}${ESTIMATE}$TAG" > $TIME_STATUS_FILE

  rm "$LOCK_FILE"
else
  echo -e "   ${logged_formatted}h${NC}${ESTIMATE}$TAG"
fi


exit 0
