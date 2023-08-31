# **Systeme-d-integration-et-de-reporting-de-donnees**

![exo-montee-gcp](https://github.com/ali21pr/Systeme-d-integration-et-de-reporting-de-donnees/assets/116568003/c2f5f311-4108-46ab-9fba-3bf59e1faf98)

**Scénario** : 
L'utilisateur peut soumettre un fichier sur le bucket en utilisant un script Python.

Lorsqu'un fichier arrive sur le bucket, une cloud function est déclenchée et détecte cet événement.
La cloud function ajoute une entrée en warning dans Cloud Logging pour signaler la réception du fichier.

La cloud function insère ensuite les informations relatives au fichier (nom du fichier et date d'insertion) dans un Bigquery Dataset, afin de les stocker pour une utilisation ultérieure.

**méthodologies**  :
**Développer le code Terraform et Python nécessaire au déploiement des ressources** :
code Terraform qui définit les ressources à déployer
code Python qui sera exécuté par la Cloud Function
les règles IAM nécessaires au bon fonctionnement du scenario.
Adapter le pipeline Cloud Build pour automatiser le deploiement selon l'approche GitOps suivante:
Push/Merge vers la branche master → terraform init, terraform plan, terraform apply [CD]

Push vers tout autre branche → terraform init, terraform plan [CI]
Créer un repo Cloud Source repository 

Réaliser le mirroring entre le repo Gitlab et le repo Cloud Source Repository crée précedemment.

Configurer un ou plusieurs Cloud Build Trigger(s) pour déclencher un build à chaque push du code sur Gitlab

Déployer les ressources avec le push du code :
Éffectuer un push du code sur Gitlab pour déclencher le Cloud Build Trigger.
Le pipeline Cloud Build doit alors se lancer pour déployer les ressources Terraform
Tester le scénario et valider les résultats :
Vérification que les ressources Terraform sont bien déployées.
Accéder en SSH à la VM et upload le script python
Développer un script qui permet de faire le upload d'un fichier sur le bucket
Upload un fichier sur le bucket à l'aide de script python.
Vérifier que les informations relatives aux fichiers sont correctement insérées dans le Dataset et qu'une entrée de log en warning est présente dans Cloud Logging.

visualisation avec looker 

![looker](https://github.com/ali21pr/Systeme-d-integration-et-de-reporting-de-donnees/assets/116568003/cffd9bdc-410d-45c7-8161-f401f190b872)
