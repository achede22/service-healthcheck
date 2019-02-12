# service-healthcheck
Restart the service, check servise health, and report if service is unhealthy

Achedé22
2014

# Request
 Bash script that performs the following operations:

- Verify who is online between Mdn1 and Mdn2
- The following steps will only be carried out on the server that is online
- Restart the AgentProxy application
- wait 5 seconds
- Check the status of the AgentProxy
- If the AgentProxy is running, warn it on the screen and exit
- If you are not running, send a text message to the people involved in the project with the SMSAPP application,
- reporting the server, the failure, and the users currently connected to # Mobile TV.
 

 AgentProxy_restart_script.sh
 Script responsible for restarting the AgentProxy, to be executed every 2 weeks through crontab.
