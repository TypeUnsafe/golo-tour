


#Installation

##Webservice

###Livrables

Le dossier service web (`MyPerformanceWS`) contient la partie service web à déployer en production.

    - /bin/*.* (assemblies)
        MyPerformanceWS.dll
        Newtonsoft.json.dll
        System.Net.Http.Formatting.dll
        System.Web.Http.dll
        System.Web.Http.WebHost.dll
    - /logs/*.*
    - /Web References/*.* (1 dossier par méthode SAP exposée)
    - /*.* (fichiers de configuration)
        Global.asax
        Globale.asax.cs
        packages.config
        Web.config

###Procédure

Le service web MyPerformanceWS doit fonctionner sur un IIS avec 

- les propriétés `Anonymous Authentication` disabled (Authentification Anonyme désactivée) 
- `Windows Authentication` enabled (Authentification Windows activée).

- Dans le fichier `Web.config`, il faut adapter dans la section configuration (`appSettings`) l'élément `value` de la clé `PictureUrlFormat` avec l'url d'accès aux photos de production ses employés. **Important**: il faut conserver le `{0}` qui sert de marqeur de substitution pour le `userId` de l'employee issu de l'AD.
- Dans le fichier `Web.config`, il faut adapter dans la section configuration `appSettings` l'élément `value` des clés `SAP_UserName`, `SAP_Password` avec respectivement le nom d'utilisateur et le mot de passe pour l'appel du formulaire SAP de production.
- Dans le fichier `Web.config`, il faut adapter dans la section configuration (`appSettings`) l'élément `value` des clés `SAP_Url_A2`, `SAP_Url_E2`, `SAP_Url_E3` avec les parties fixes de l'url d'appel du formulaire SAP de production.
- Dans le fichier `Web.config`, il faut adapter dans la section configuration (`appSettings`) l'élément `value` de la clé `AM_Url_Manager`, avec l'url d'appel de la page "`assessment monitoring`" de production pour les managers. Il est aussi possible d'indiquer une url dans l'élément `value` pour les clés `AM_URL_Employee`, `AM_Url_HR` si une page "`assessment monitoring`" devient nécessaire pour les employés, et le personnel HR.
- Dans le fichier `Web.config`, il faut adapter dans la section configuration (`appSettings`) l'élément `value` des clés `TM_Url_Employee`, `TM_Url_HR`, `TM_Url_Manager` avec l'url d'appel de la page "`trainings materials`" de production pour les employés, le personnel HR, et les managers.
- Dans le fichier `Web.config`, il faut adapter dans la section configuration (`applicationSettings`) `MyPerformanceWS.Properties.Settings` (éléments `setting`/`value`) pour chacune des urls d'appel des services web SAP (`zeu_get_appraisal`, `zeu_change_status`, `zeu_get_appraisee`) de production.

##Front

###Livrables

Le dossier `MyPerformance` contient les sources à jour de la partie front. 







