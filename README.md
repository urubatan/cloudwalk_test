# README

This project was created as a response to Cloudwork Software Engineering Test (https://gist.github.com/cloudwalk-tests/704a555a0fe475ae0284ad9088e203f1)

The project has two possible answers implemented, a console based, that can be run with the command:
`bin/quake_report 'quake log file'`

The project might also be executed as a web application with the command:
`rails c`
and acessed via browser on (https://localhost:3000)
The log file will then be uploaded and the requested reports will be available through the web interface

General comments:

* the log reader was implemented using serial file reading to allow for huge log file processing
* the web version uses backend log file processing to not lock the user during the processing of big log files
* the implementation of the backend log parser only considers local storage and a single machine, this can be changed for more complex environments
* the web version was implemented as a SPA using Hotwire/Stimulus and the lowest ammount of javascript possible
* the automatic screen update after the backend log file finished is unreliable because I didn't want to add redis as a dependency for this small app