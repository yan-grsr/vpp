# Module Registrar Asterisk - Téléphone VoIP

Ce dossier contient la configuration du serveur Asterisk agissant comme "Registrar" et PBX pour notre projet de téléphone à cadran rétrofit (intégrant un STM32) et notre application client en C.

## Architecture du module

Le serveur SIP est configuré pour gérer l'authentification des périphériques et le routage des appels (Peer-to-Peer et Serveur Vocal Interactif). 

* **`pjsip.conf`** : Configuration du transport réseau et gestion des comptes SIP (Endpoints, Auth, AOR). 
  * Ext 31 & 32 : Softphones PC pour les tests.
  * Ext 35 : Application client en C (pour le téléphone physique).
* **`extensions.conf`** : Le plan de numérotation (*Dialplan*). Définit le comportement du serveur lors d'un appel et inclut notre SVI (robot) sur l'extension 39.
* **`deploy.sh`** : Script d'automatisation pour appliquer les configurations sur le serveur local.

## Comment déployer les modifications

Il ne faut jamais modifier les fichiers directement dans `/etc/asterisk/`. 
Faites vos modifications dans ce dépôt Git, puis utilisez le script de déploiement pour les appliquer au serveur Asterisk en cours d'exécution.

1. Apportez vos modifications aux fichiers `.conf` localement.
2. Exécutez le script de déploiement avec les privilèges administrateur :

```bash
sudo ./deploy.sh
