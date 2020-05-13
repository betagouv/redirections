# Outil de gestion dedirections

Vous pouvez par exemple rediriger : https://workinfrance.beta.gouv.fr vers https://work-in-france.incubateur.social.gouv.fr/

## Comment utiliser ?

- Faite une pull request en ajoutant votre domaine dans `servers.conf.erb` (si vous voulez de l'aide sur le config nginx, vous pouvez demander sur `#incubateur-ops` sur le Slack)
- Il faut déployer la nouvelle version sur Scalingo (demander sur `#incubateur-ops` sur le Slack pour être admin)
- Ajouter le domaine dans la config de Scalingo (Scalingo s'occupera automatiquement du certificat SSL)


## Notes
- Si vous hésitez entre "permanent" ou pas, n'hésitez pas à demander de l'aide
- Le `$1` a la fin de l'url de redirection indique que vous conservez la partie après le domaine ( `https://workinfrance.beta.gouv.fr/mapage?params` deviens `https://work-in-france.incubateur.social.gouv.fr/mapage?params`
