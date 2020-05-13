# Outil de gestion dedirections

## Comment utiliser ?

- Faite une pull request en ajoutant votre domaine dans `servers.conf.erb` (si vous voulez de l'aide sur le config nginx, vous pouvez demander sur `#incubateur-ops` sur le Slack)
- Il faut déployer la nouvelle version sur Scalingo (demander sur `#incubateur-ops` sur le Slack pour être admin)
- Ajouter le domaine dans la config de Scalingo (Scalingo s'occupera automatiquement du certificat SSL)
