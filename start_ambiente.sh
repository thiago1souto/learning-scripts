#!/usr/bin/env bash
#######################################################################################################################################
# Programa .....: start_ambiente.sh
# Descrição ....: Reinicia ambiente e grava log sempre que ocorrer
# Data Criação .: 02/01/2023
# Atualização ..:
# Modo de Uso ..: ./start_ambiente.sh
#######################################################################################################################################

#---[ Global Environment Variables ]
source /root/.bashrc
logDate=$(TZ=":America/Fortaleza" date +%d-%m-%Y)
dayWeekName=$(TZ=":America/Fortaleza" date +%a)  # |Mon |Tue ... |Sun
logTime=$(TZ=":America/Fortaleza" date +%H:%M)
logTimeFile=$(TZ=":America/Fortaleza" date +%H%M)
logDirectory=/var/tmp
workDirectoryFile="${ITSM_DIR}/docker-compose.yml"
logFile="$logDirectory/$(basename -s .sh "$0").log"
appVersion=2.2

#---[ System Function ]
functionBanner() {
  echo   ""
  echo   "╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
  echo   "║                                                                                                                        ║"
  printf "║$(tput bold) %-118s $(tput sgr0)║\n" "$@"
  echo   "║                                                                                                                        ║"
  echo   "╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝"
  echo ""
}

logGenerate () {
  case $1 in
    0) logLevel=INFO;;
    1) logLevel=ERROR;;
    2) logLevel=WARNING;;
    *) logLevel=UNKNOWN;;
  esac
  logTime=$(TZ=":America/Fortaleza" date +%T)
  echo "[$logLevel] $logDate [$dayWeekName] $logTime $2" >> "$logFile"
}

#---[ Log control ]
[[ ! -f "$logFile" ]] && : > "$logFile" && logGenerate 0 "Arquivo de log criado"
totalLines=$(wc -l < "$logFile")
[[ "$totalLines" -ge 500 ]] && sed -i '1,100d' "$logFile" && logGenerate 0 "Removida linhas antigas do arquivo de log"

#---[ Verify runITSM Container ]
containerExecution=$(docker container ls -a --format "table {{.Names}}" | grep runITSM)
if [ "$containerExecution" = 0 ];
then
  workDirectoryFile=$(docker inspect "$containerExecution" | grep com.docker.compose.project.config_files |  awk '{ print $2 }' | tr -d \"\,)
  logGenerate 0 "Container runITSM em execução"
else
  logGenerate 1 "Container runITSM não está em execução"
fi

#---[ Start procedure ]
functionBanner "Initializing ITSM Environment"
# Preserve log
cp -Rap "$ITSM_DIR/log/server.log" "$ITSM_DIR/log/server.log.$logDate-$logTimeFile.log"
startEnvirounment=$(docker compose -f "$workDirectoryFile" stop && yes | docker compose -f "$workDirectoryFile" rm && yes | docker volume prune && docker compose -f "$workDirectoryFile" up -d)
if [ $? -eq 0 ];
then
  logGenerate 0 "Restart - Rotina executada com sucesso."
else
  logGenerate 1 "Restart - Problemas durante a rotina executada."
fi

