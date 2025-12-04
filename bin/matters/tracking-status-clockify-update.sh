#!/bin/bash

set -e

TIMEWARRIORDB="$HOME/.local/share/timewarrior/data"
LOCK_FILE="$TIME_STATUS_FILE.lock"
LOCK_DURATION_MINUTES=5

if [ -f "$LOCK_FILE" ]; then
    if find "$LOCK_FILE" -mmin -"$LOCK_DURATION_MINUTES" -quit 2>/dev/null | grep -q "$LOCK_FILE"; then
        exit 0 # Termine le script sans erreur
    else
        rm -f "$LOCK_FILE"
    fi
fi

echo date > "$LOCK_FILE"

if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
  DETAILS=$(echo "$BRANCH_NAME" | \
    sed -e 's/^.*\/\(#*\(SEN-\)*[0-9]*-[0-9.]*\).*/\1/g'
      )
  ISSUE=$(echo "$DETAILS" | sed -e 's/-[^-]*$//g')
  ESTIMATE=$(echo "$DETAILS" | sed -e 's/^#*\(SEN-\)*[^-]*-//g')
fi


# have_active_task=$(timew get dom.active)
ACTIVE_TAG=$(clockify-cli show --format {{.Description}} 2>/dev/null || true)
if [ -z "$ISSUE" ] || [[ "$ACTIVE_TAG"  == manual_* ]] || [[ "$ACTIVE_TAG"  == m_* ]] || [[ "$ACTIVE_TAG"  == me_* ]]; then
  if [ -z "$ACTIVE_TAG" ]; then
    echo "󱦠 "
    exit
  fi

  ISSUE=$ACTIVE_TAG
  CLEAN_TAG=$(echo $ISSUE| sed -E 's/^(manual_|m_|me_)//')
  TAG=" 󰓼 ($CLEAN_TAG)"
  ESTIMATE=""
else
  # to update summary
  # timew start $ISSUE :quiet
  if [[ "$ISSUE" != "$ACTIVE_TAG" ]]; then
    clockify-cli in -i=0 "" "$ISSUE" -q > /dev/null
  fi

  # REMOTE_URL=$(git remote get-url origin 2>/dev/null)
  # PROJECT_DOMAIN=$(echo $REMOTE_URL | sed 's/git@//g' | sed 's/\:.*$//g')
  # PROJECT_PATH_WITH_GIT="${REMOTE_URL##*:}"
  # PROJECT_NAME="${PROJECT_PATH_WITH_GIT%.git}"
  # LINK="https://${PROJECT_DOMAIN}/${PROJECT_NAME}/-/issues/$(echo $ISSUE|sed 's/^#//g')"
  # TAG=" 󰓼 (\033]8;;$LINK\033\\$ISSUE\033]8;;\033\\)"
  TAG=" 󰓼 ($ISSUE)"
# LINK="https://www.rendevuke.com/uploads/songs/Tu%20trouveras%20-%20Natasha%20St%20Pier%20-%20Dm_1271.pdf"
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

# logged_formatted=$(format_duration $final_hours $final_min)
if [[ "$ISSUE"  == manual_* ]]; then
  logged_formatted=$(clockify-cli log today -d "$ISSUE" -S --duration-float)
else
  logged_formatted=$(echo "scale=2; $(clockify-cli log this-month -d "$ISSUE" -S --duration-float) + $(clockify-cli log last-month -d "$ISSUE" -S --duration-float)" | bc -l)

fi

RED='\033[0;31m'    # Rouge pour isBurning
YELLOW='\033[0;33m' # Jaune pour isAlmostBurning
NC='\033[0m'        # No Color - Réinitialise la couleur
BURNING="🔥"           # Emoji de feu
ALMOST_BURNING="🚨"
BOLD='\033[1m'

if [[ -n "$ESTIMATE" ]]; then
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
echo -e "   ${logged_formatted}h${NC}${ESTIMATE}$TAG" > $TIME_STATUS_FILE
rm "$LOCK_FILE"

exit 0
