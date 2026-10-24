# Contrôle avant publication sur GitHub

L’archive de partage est assemblée à partir du **dernier projet V2.4 corrigé**. Ce dépôt public est un **exemple de code** et ne doit contenir aucun élément lié à votre déploiement privé.

## Exclusions

- `app/google-services.json` et autres fichiers `google-services*.json` ; fichiers `firebase-adminsdk*.json`, `service-account*.json` et clés de service.
- Fichiers de signature Android : `*.jks`, `*.keystore`, `*.p12`, `*.pem`, `*.key`, `keystore.properties`, etc.
- Données locales Android : `local.properties`, `.gradle/`, `.idea/`, `**/build/`, APK/AAB, caches.
- Variables d’environnement, jetons et configurations locales (`.env*`, `.firebaserc`, `*.log`, etc.).
- Exports de Firestore ou données réelles (horaires de salariés, UID/e-mails, latitudes et longitudes personnelles).

Le fichier `firestore.rules` ne contient pas de clé secrète ; il peut faire partie du dépôt à des fins d’exemple et d’audit. Il ne donne pas accès à votre base Firebase tant que vous ne publiez pas les règles sur votre instance.

## Vérifications manuelles recommandées

1. Vérifiez les fichiers réels du dossier à publier, et non seulement le contenu du ZIP généré.
2. Avant de faire `git add`, vérifiez `git status --short --untracked-files=all` puis `git ls-files` après l'ajout.
3. Recherchez les chaînes sensibles (UID réels, e-mails, noms, clés et URL privées) dans les documents, commits et historiques éventuels.
4. Ne commitez pas les captures d’écran prises avec de vraies données de collaborateurs.
5. Si une clé privée a déjà été publiée, **révoquez-la et remplacez-la** : supprimer un fichier d’un commit ne suffit pas.
6. Demandez l’avis des personnes concernées avant de publier des captures ou des jeux de données dérivés de vrais pointages.

Ce contrôle automatisé ne garantit pas qu’aucune information sensible ne soit présente : **relisez le code et l’historique du dépôt avant de le rendre public**.

## Licence et droits

Le code original du projet est distribué sous licence MIT : voir [`LICENSE`](LICENSE). Vérifiez les droits des éléments externes et des éventuelles contributions avant redistribution. Les licences de bibliothèques tierces continuent de s’appliquer.
