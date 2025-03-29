# Shell Security Toolkit

## Description
Ce script Shell est conçu pour automatiser diverses vérifications de sécurité sur un système. Il inclut plusieurs outils d'audit et de surveillance pour garantir que votre environnement soit sécurisé et à jour.

## Fonctionnalités
Le script exécute une série de tests et d'audits pour évaluer la sécurité de votre système, y compris la vérification des comptes utilisateurs, des mises à jour logicielles, des permissions sur les fichiers sensibles, et bien plus.

### Options du menu :
1. Auditer les comptes utilisateurs
2. Vérifier les mises à jour de sécurité
3. Vérifier la configuration du pare-feu
4. Scanner les vulnérabilités locales
5. Vérifier les permissions des fichiers sensibles
6. Surveiller les tentatives de connexion échouées
7. Vérifier l'intégrité des fichiers système
8. Surveiller les connexions réseau
9. Générer un mot de passe sécurisé
10. Vérifier les paramètres de sécurité du navigateur

## Les Prérequis
Avant d'exécuter ce script, assurez-vous que vous avez les outils nécessaires installés sur votre machine. Le script utilise des commandes spécifiques à un environnement Linux/Unix (ou PowerShell pour Windows).

- `curl`
- `nmap` (pour les vérifications réseau)
- `openssl` (pour la génération de mots de passe)
- Autres outils dépendants des fonctionnalités que vous voulez activer.

## Installation

1. Clonez ce repository :
    ```bash
    git clone https://github.com/exist697/Shell-Security-Toolkit.git
    cd Shell-Security-Toolkit
    ```

2. Assurez-vous que le script est exécutable (si nécessaire) :
    ```bash
    chmod +x main.sh
    ```

## Utilisation

1. Exécutez le script avec :
    ```bash
    ./main.sh
    ```

2. Vous serez accueilli par un menu où vous pourrez choisir l'option à exécuter en fonction de vos besoins.

## Exemple de sortie
Une fois exécuté, voici à quoi pourrait ressembler la sortie du script :

```bash
 ███████╗██╗  ██╗██╗███████╗████████╗    ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
 ██╔════╝╚██╗██╔╝██║██╔════╝╚══██╔══╝    ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
 █████╗   ╚███╔╝ ██║███████╗   ██║       ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
 ██╔══╝   ██╔██╗ ██║╚════██║   ██║       ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
 ███████╗██╔╝ ██╗██║███████║   ██║       ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
 ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝       ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝ 

========= MENU =========
1. Auditer les comptes utilisateurs
2. Vérifier les mises à jour de sécurité
3. Vérifier la configuration du pare-feu
4. Scanner les vulnérabilités locales
5. Vérifier les permissions des fichiers sensibles
6. Surveiller les tentatives de connexion échouées
7. Vérifier l'intégrité des fichiers système
8. Surveiller les connexions réseau
9. Générer un mot de passe sécurisé
10. Vérifier les paramètres de sécurité du navigateur
Q. Quitter
Entrez votre choix: 1

Auditing user accounts...
