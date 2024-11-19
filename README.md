# Outil de gestion des redirections

Vous pouvez par exemple rediriger : https://workinfrance.beta.gouv.fr vers https://work-in-france.incubateur.social.gouv.fr/

## Comment utiliser ?

La redirection fonctionne sous réserve de ces *trois* conditions:
1. configuration de la redirection `anciendomaine` -> `nouveaudomaine` dans ce dépôt: créez une pull request en ajoutant votre domaine dans `servers.conf.erb` (si vous voulez de l'aide sur le config nginx, vous pouvez demander sur `#incubateur-ops` sur le Mattermost); le déploiement est automatique
2. configuration du DNS: `anciendomaine` est un CNAME vers `betagouv-redirections.osc-fr1.scalingo.io.`
    - Vous devez avoir accès à la configuration DNS du domaine redirigé. Si `anciendomaine` est de la forme `ancien.beta.gouv.fr` c'est la zone DNS `beta.gouv.fr` qu'il faut modifier sur OVH (vous pouvez demander sur `#incubateur-ops` sur le Mattermost)
3. configuration de Scalingo: déclarer `anciendomaine` parmi les domaines de l'app redirection
    - Vous devez avoir accès à la console Scalingo de l'app `betagouv-redirection`. A défaut, vous coordonner avec des personnes qui ont ces accès; vous pouvez demander sur le chan `#incubateur-ops` du Mattermost beta. Il faut faire idéalement cette action juste après avoir ajouté le cname dans les DNS.


## Notes
Si vous hésitez, demandez de l'aide sur Mattermost:

Redirections possible:
- Soit utilisation de `rewrite`:
Si vous hésitez entre rewrite "permanent" ou pas:
  * avec rewrite "permanent" -> les moteurs de recherche vont remplacer l'ancienne adresse par la nouvelle, les navigateurs vont garder la redirection en cache et afficheront directement le nouveau site.
  * si on ne met pas "permanent" -> les moteurs de recherche garde affiché l'ancienne adresse dans les résultats, les navigateurs testeront toujours l'ancienne adresse. C'est utile si l'ancienne adresse doit continuer à être utilisé et que l'on veut se permettre de pouvoir changer la redirection.
  * Le `$1` a la fin de l'url de redirection indique que vous conservez la partie après le domaine ( `https://workinfrance.beta.gouv.fr/mapage?params` devient `https://work-in-france.incubateur.social.gouv.fr/mapage?params`

- Soit utilisation de `return 301`: les navigateurs afficheront directement le nouveau site. Le plus simple, rapide et demande moins de traitement pour nginx
```
server {
  server_name anciendomaine;
  listen <%= ENV['PORT'] %>;
  return 301 $scheme://nouveaudomaine$request_uri;
}
```
