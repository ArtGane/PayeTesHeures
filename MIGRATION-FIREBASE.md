# MIGRATION Firebase — PayeTesheures V2.4.0

⚠️ **Ne publiez pas les règles avant de préparer les données et de sauvegarder Firestore.**
Cette version passe d'une application à manager global à des **équipes isolées**.
Les données originales (horaires GPS, événements, pauses) sont conservées.

## Ordre conseillé

1. **Sauvegarder Firestore**, de préférence par export administrateur. Vérifier au minimum la présence des documents `shifts` et sous-collections `events`. Éviter tout changement au milieu de la journée avec des services ouverts.
2. Ouvrir [Firebase Console](https://console.firebase.google.com/) → votre projet → **Firestore Database → Données**.
3. Créer une collection **`teams`** et ces documents d'exemple :

   - Document **`equipe_a`** : `name` (string) = `Équipe A`, `managerUid` (string) = `UID_MANAGER_A`
   - Document **`equipe_b`** : `name` (string) = `Équipe B`, `managerUid` (string) = `UID_MANAGER_B`

4. Dans **Authentication → Users**, conserver tous les comptes existants et leurs UID.
5. Dans **`users/{UID}`**, conserver `role` (`employee` ou `manager`) et `name` (le prénom suffit) et ajouter **`teamId`** (string), par exemple `equipe_a`, pour TOUS les employés ET managers concernés. Ne modifiez pas les UID.
6. **Migrer les anciens `shifts`** : pour chaque document `shifts/{sid}` sans `teamId`, ajouter `teamId` = l'équipe du propriétaire `users/{shift.uid}`. Ne pas modifier les sous-collections `events` ni leurs coordonnées GPS. Pour beaucoup de services, voir le script administrateur `scripts/migrate-team-ids.mjs`. Simulez-le sans `--apply` puis vérifiez avant de l'appliquer. Il n'est PAS lancé automatiquement par l'APK.
7. Publier le fichier **`firestore.rules`** dans Firebase Console → Firestore Database → **Rules** → Publish, ou via Firebase CLI configuré pour le bon projet : `firebase deploy --only firestore:rules`.
8. Mettre à jour l'APK sur chaque appareil (même `applicationId` = `fr.payetesheures.app`, même signature, versionCode augmenté). **Une ancienne APK peut rencontrer PERMISSION_DENIED** après le changement des règles : planifiez le déploiement ensemble.
9. Tester en vrais comptes A et B avant de distribuer à tous : salarié A pointe et corrige son service terminé ; manager A pointe et corrige **son propre service**, voit seulement les membres A ; manager B ne peut pas lire les documents A ; les coordonnées GPS originales restent immuables.

## Structure de Firestore

```text
teams/equipe_a: {name: "Équipe A", managerUid: "UID_MANAGER_A"}
teams/equipe_b: {name: "Équipe B", managerUid: "UID_MANAGER_B"}
users/UID_EMP_A: {name: "Thomas", role: "employee", teamId: "equipe_a"}
users/UID_MGR_A: {name: "Julien", role: "manager", teamId: "equipe_a"}
users/UID_EMP_B: {name: "Emma", role: "employee", teamId: "equipe_b"}
users/UID_MGR_B: {name: "Sophie", role: "manager", teamId: "equipe_b"}
shifts/SHIFT_ID: {uid: "UID_EMP_A", teamId: "equipe_a", state: "CLOSED", ...}
shifts/SHIFT_ID/events/EVENT_ID: {uid, type, at, lat, lng, accuracyMeters}
shifts/SHIFT_ID/corrections/CORR_ID: {uid, at, startAt, endAt, breakMinutes, reason}
```

N'ajoutez pas de document vide aux sous-collections `events` ou `corrections`.

## Droits de sécurité prévus

| Opération | Employé | Manager |
|---|---|---|
| Consulter ses propres heures | Oui | Oui |
| Pointer sa propre arrivée/départ | Oui | Oui |
| Démarrer/terminer ses pauses | Oui | Oui |
| Corriger ses propres heures terminées (motif requis) | Oui | Oui |
| Consulter heures de son équipe | Non | Oui, lecture seule |
| Consulter l'autre équipe | Non | Non |
| Modifier les horaires des autres | Non | Non |
| Modifier/supprimer GPS d'origine ou journal de corrections | Non | Non |
| Modifier rôle/teamId via l'application | Non | Non |

Les droits sont vérifiés par **Firestore Security Rules**, pas seulement en masquant des boutons. Les règles empêchent l'édition des coordonnées existantes, mais **ne prouvent pas qu'un GPS client est authentique** ; ne considérez pas ce système comme une preuve antifraude suffisante pour la paie.

## Managers et historique

Le rôle `manager` doit correspondre exactement au champ `teams/{teamId}.managerUid` pour accéder à la vue de son équipe. Le manager a **Pointer, Pauses et Mes heures** pour ses propres services, et **Équipe** en lecture seule pour ses salariés. Un service reste attribué à son `teamId` historique. Si un salarié change d'équipe, établissez une politique sur l'accès aux anciens services et adaptez la migration au besoin.

## Horaires et notifications

Les quatre horaires matin/après-midi et les jours travaillés sont **stockés localement sur chaque téléphone**, par compte connecté. Il faut saisir ces horaires sur chaque nouvel appareil. Les notifications Android peuvent être retardées ou désactivées par l'utilisateur et ne déclenchent pas de pointage automatique. **Le planning n'est pas encore administrable par le manager dans Firebase** et les règles Firestore ne peuvent pas imposer l'existence d'un planning local.

## Données et vie privée

La ville affichée est déduite du GPS par le géocodeur Android ; Firebase conserve les coordonnées originales. Pour une utilisation professionnelle réelle, informer les salariés, définir la durée de conservation, restreindre les accès administrateurs et prévoir l'exercice de leurs droits. Les corrections d'horaires sont enregistrées dans une sous-collection non modifiable depuis l'application.

## Dépannage

- `PERMISSION_DENIED` à l'ouverture : vérifier `users/{UID}.role` et `teamId`, publication des règles, et migration des `shifts`.
- Manager sans services de son équipe : vérifier `teamId` sur **chaque** shift historique et chaque utilisateur ; ne pas utiliser les règles anciennes globales.
- `google-services.json missing` : copier l'original dans `app/` (ne pas partager le fichier d'identification ni de clé admin).
- Mettre à jour l'APK **par-dessus** l'ancienne avec la même signature ; ne pas désinstaller avant de vérifier que tous les pointages sont synchronisés.
