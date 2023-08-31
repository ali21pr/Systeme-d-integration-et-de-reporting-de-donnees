# -*- coding: utf-8 -*-
from google.cloud import storage

# Créez un objet client de stockage GCS en utilisant les informations d'identification de votre compte de service.
client = storage.Client()

# Obtenir une référence au bucket que je souhaite utiliser.
bucket = client.get_bucket('kyr-sandbox-test-abo-gcs-ew1-gcs_exo')

# chemin d'accès local du mon fichier.
local_file_path = 'Data_source.csv'

# Spécifiez le nom de mon fichier dans le GCS.
remote_file_name = 'Data_source.csv'

# Creation de l'objet Blob qui représente mon fichier dans GCS.
blob = bucket.blob(remote_file_name)

# Chargement de contenu du fichier dans GCS.
blob.upload_from_filename(local_file_path)

print(f'Le fichier {local_file_path} a été chargé dans le bucket {bucket.name} sous le nom {remote_file_name}.')
