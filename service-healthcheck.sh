# Solicitud
# Bash script que realice las siguientes operaciones

# Verificar quien está online entre Mdn1 y Mdn2
# Los siguientes pasos solo se realizarán en el servidor que se encuentre online
# Reiniciar la aplicación AgentProxy
# esperar 5 segundos
# Revisar el estado del AgentProxy
# Si el AgentProxy está corriendo, avisarlo en la pantalla y salir
# Si no está coriendo, enviar un Mensaje de texto a las personas involucradas en el proyecto con la aplicación SMSAPP, 
# informando el servidor, la falla, y los usuarios conectados actualmente a # la TV Móvil.
 


#! /bin/bash
# AgentProxy_restart_script.sh
# Script encargado de reiniciar el AgentProxy, a ejecutarse cada 2 semanas mediante crontab.

SMSAPP=/home/mtvadmin/bin/SSE/APP
LOG=/home/huawei/mdn2000/ms-h/logs/ms-h/perf/Pmsh
server=$(uname -n)
usuarioAct=$(tail -1 $LOG | grep LIVE: | cut -b 74-79)
VCS=$(sudo /opt/VRTS/bin/hagrp -state | grep $server | grep msh | tr -s ' ' | cut -d ' ' -f 4)
temp=$(echo $?)

if [ $VCS != "|ONLINE|" ]
then
        echo -e "\e[94m  $server esta $VCS , no necesita reinicio del AgentProxy \e[0m  "
else
        #si esta ONLINE en VCS
        echo -e "\e[94m **  Reiniciando el AgentProxy de $server  **"

        #Reinicia el AgenProxy
                apsvc restart

        #espera 5 segundos
        echo -e "\e[2mEsperando 5 segundos  \e[1m"
        sleep 5
        #revisa el estatus
        status=$(apsvc status| grep 'running' | cut -b 27-33)
        echo -e "AgentProxy is \e[32m $status \e[94m "

                if [ $status == running ]
                then
                echo -e "AgentProxy es estable \e[0m "

                        else
                         #si el AgentProxy no esta corriendo
                         echo "AgentProxy es inestable, enviando SMS............./"

                        #SMS grupal
                        $SMSAPP/sms_group "MTV ($server) La aplicacion AgentProxy no se reinicio correctamente, se debe ejecutar 'apsvc start' - Total de abonados conectados: $usuarioAct"

                #SMS individual $SMSAPP/sms_client mtvalr mtvalr 1586073793 "MTV ($server) La aplicacion AgentProxy no se reinicio correctamente, se debe ejecutar 'apsvc start' - Total de abonados conectados: $usuarioAct"

                        echo -e "SMS enviado \e[0m "

                 fi
           fi
exit 0 
