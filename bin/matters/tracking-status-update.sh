#!/bin/bash

set -e

# TIMEWARRIORDB="$HOME/.local/share/timewarrior/data"
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
    sed -e 's/^.*\/\(#[^-]*-[^-]*\).*/\1/g'
      )
  IFS='-' read -r ISSUE ESTIMATE <<< "$DETAILS"
fi

if [[ -n "$ESTIMATE" ]]; then
  ESTIMATE=/${ESTIMATE}h
fi

# have_active_task=$(timew get dom.active)
ACTIVE_TAG=$(clockify-cli show --format {{.Description}} 2>/dev/null || true)
if [ -z "$ISSUE" ] || [[ ! "$ISSUE" =~ ^#[0-9]+$ ]] || [[ "$ACTIVE_TAG"  == manual_* ]] || [[ "$ACTIVE_TAG"  == m_* ]] || [[ "$ACTIVE_TAG"  == me_* ]]; then
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

# 2. Exécuter 'timew summary' pour le tag spécifié
# Le ':' est la syntaxe de Timewarrior pour les tags
# summary_output=$(timew summary $ISSUE)
# DURATION=${summary_output##* }
# IFS=: read -r hours minutes seconds <<< "$DURATION"


# logged_duration_s=$((10#$hours * 3600 + 10#$minutes * 60 + 10#$seconds))
# active_duration_s=$(($(date '+%s') - $(date -j -f '%Y-%m-%dT%H:%M:%S' "$(timew get dom.active.start)" '+%s')))
# grand_total_s=$((logged_duration_s + active_duration_s))

# final_hours=$((grand_total_s / 3600))
# final_min=$(((grand_total_s % 3600) / 60))

# logged_formatted=$(format_duration $final_hours $final_min)
if [[ "$ISSUE"  == manual_* ]]; then
  logged_formatted=$(clockify-cli log today -d "$ISSUE" -S --duration-float)
else
  logged_formatted=$(echo "scale=2; $(clockify-cli log this-month -d "$ISSUE" -S --duration-float) + $(clockify-cli log last-month -d "$ISSUE" -S --duration-float)" | bc -l)

fi

## TODO make burn alert

# Affiche la chaîne finale pour Starship
echo -e "   $logged_formatted${ESTIMATE}$TAG" > $TIME_STATUS_FILE
rm "$LOCK_FILE"

exit 0
