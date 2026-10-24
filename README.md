# ⏱️ PayeTesheures

[![Licence MIT](https://img.shields.io/badge/licence-MIT-blue.svg)](LICENSE)

**Application Android de pointage et de suivi du temps de travail**, développée en **Kotlin + Jetpack Compose**, avec **Firebase Authentication** et **Cloud Firestore**.

*Un projet de Huguen’s — © 2026 Huguen's.*

> **Statut : prototype / démonstrateur.** Le code est fourni comme base d’apprentissage et de contribution. Il ne constitue pas à lui seul un système de paie certifié ni un dispositif anti-fraude GPS. Les droits Firebase et l’application doivent être testés avant tout déploiement professionnel.

## ✨ Fonctionnalités

- **Pointage GPS** à l’arrivée et au départ, avec affichage de la **ville** dans l’interface.
- **Bilans par semaine et par mois**, consultation de l’historique et correction des horaires avec justification.
- **Équipes distinctes** : un responsable consulte son équipe en lecture seule, sans modifier les heures des autres.
- **Managers pointants** : un responsable peut également pointer et corriger **ses propres** horaires.
- **Planning matin / après-midi** par téléphone et **notifications de rappel** (non garanties à la minute).
- **Historique** : événements GPS originaux et journal de correction prévus pour être non modifiables côté client.

## 🛠️ Stack technique

| Partie | Technologie |
|---|---|
| Android | Kotlin, Jetpack Compose, Material 3 |
| Authentification | Firebase Authentication (e-mail / mot de passe) |
| Données | Cloud Firestore, Security Rules |
| Position | Google Play Services Location + géocodage Android |
| Rappels | Android WorkManager |
| Build | Gradle, Android Gradle Plugin |

## 🚀 Installer le projet (développement)

**Pré-requis** : Android Studio compatible avec les versions du projet, JDK 17+, Android SDK 35, accès Internet, un projet Firebase de test.

1. Cloner ou télécharger le dépôt, puis ouvrir le dossier contenant `settings.gradle.kts` dans Android Studio.
2. Dans la [Firebase Console](https://console.firebase.google.com/), enregistrer une application Android avec l’identifiant **`fr.payetesheures.app`** (ou adapter `applicationId` dans `app/build.gradle.kts`).
3. Télécharger votre fichier `google-services.json` et le déposer dans `app/google-services.json`. **Ne pas le publier dans le dépôt.**
4. Activer la connexion **E-mail / mot de passe** dans Authentication et créer une base Firestore.
5. Configurer les documents de test `teams`, `users` et les règles de sécurité.
6. Vérifier la configuration Gradle. Si le Wrapper est absent, le script `PREPARER-WINDOWS.cmd` permet de récupérer le Wrapper officiel sous Windows ; examiner tout script avant exécution.
7. Synchroniser Gradle, compiler et exécuter sur un émulateur ou un téléphone Android. Pour générer un APK de test : **Build → Build APK(s)**.

> **Ne publiez pas `google-services.json`, vos clés de service Firebase Admin, vos clés de signature ni des exports de pointages réels.**


## 📱 Télécharger PayeTesheures sur Android 

Téléchargez gratuitement l'application Android,
sans passer par le Google Play Store.

[⬇️ Télécharger PayeTesheures (APK)](https://github.com/VOTRE_PSEUDO/PayeTesheures/releases/latest/download/PayeTesheures.apk)

**Installation :** téléchargez l'APK sur votre téléphone
Android, ouvrez-le et autorisez l'installation depuis
cette source si Android le demande.


## 🧪 Tests et limites

- Les horaires et jours de travail sont **stockés localement sur chaque téléphone** ; les notifications peuvent être retardées ou désactivées.
- Les données GPS originales sont protégées contre la modification par les utilisateurs ordinaires via les règles prévues, **mais une position fournie par un téléphone n’est pas une preuve infalsifiable**.
- Un service chevauchant minuit est comptabilisé dans la période de sa date de début dans cette version.

## ⚖️ Licence MIT et réutilisation

**© 2026 Huguen's — distribué sous [licence MIT](LICENSE).**

Vous pouvez **utiliser, copier, modifier, partager et redistribuer** ce code, y compris dans des projets commerciaux, sous réserve de **conserver la notice de copyright et le texte de licence MIT** dans les copies ou parties substantielles du logiciel. Vous n’êtes pas obligé de publier vos modifications sous une licence MIT ni de rendre votre propre code source public.

Cette autorisation ne concède pas les droits de tiers sur les bibliothèques Android, Firebase et autres dépendances. Le dépôt n’inclut ni configuration Firebase privée, ni clé de signature, ni données de salariés. La mention **Huguen's** est le nom du titulaire indiqué dans la licence ; les personnes réutilisant le code doivent conserver cette notice de licence, mais ne sont pas tenues d'afficher cette mention dans leur interface.

Contributions et retours bienvenus : lisez [CONTRIBUTING.md](CONTRIBUTING.md). Avant de publier vos propres modifications, vérifiez que vous avez les droits nécessaires sur tous les fichiers inclus.

**© 2026 Huguen's**
