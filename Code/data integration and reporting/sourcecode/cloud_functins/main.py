import pandas as pd
from pandas.io import gbq
from google.cloud import bigquery
from google.cloud import logging

'''
Python Dependencies to be installed
gcsfs
fsspec
pandas
pandas-gbq
'''

def hello_gcs_finalized(event, context):
    """Triggered by a change to a Cloud Storage bucket.
    Args:
        event (dict): Event payload.
        context (google.cloud.functions. Context): Metadata for the event.
    """
    logging_client = logging.Client()
    log_name = "my-log"
    logger = logging_client.logger(log_name)

    lst = [] # creer une liste 
    file_name = event ['name']
    table_name = file_name.split('.')[0]
    file_extension = file_name.split('.')[-1] # extraire l'extension du fichier

    # Event, File metadata details writing into Big Query
    dct={
        'Event_ID': context.event_id,
        'Event_type': context.event_type,
        'Bucket_name': event ['bucket'],
        'File_name': event ['name'],
        'Created': event ['timeCreated'],
        'Updated': event ['updated']
        }
    lst.append(dct) # remplir la liste avec le dct 
    df_metadata = pd.DataFrame.from_records (lst) # transformer la liste en un dataframe
    df_metadata.to_gbq('kyr_sandbox_test_abo_bqd_exo_dataset.data_loading_metadata',
                        project_id='kyr-sandbox-test-abo',
                        if_exists='append',
                        location='europe-west1') # envoyer le df des metadonnees a Bigquery 
   
 # Actual file data writing to Big Query
    # Use appropriate reader depending on the file extension
    if file_extension == 'csv':
        df_data = pd.read_csv('gs://' + event ['bucket'] + '/' + file_name) # lire le df csv dans google cloud storage 
    elif file_extension == 'xlsx':
        df_data = pd.read_excel('gs://' + event ['bucket'] + '/' + file_name) # lire le df xlsx dans google cloud storage 
    else:
        logger.log_text('File format not supported : {}'.format(file_name), severity='ERROR')
        return

    df_data.to_gbq('kyr_sandbox_test_abo_bqd_exo_dataset.' + table_name,
                    project_id='kyr-sandbox-test-abo',
                    if_exists='append',
                    location='europe-west1',
                    table_schema=schema)  # envoyer le df.csv a Bigquery avec le schema 
    # Add warning log entry
    #logging.warning('Fichier reçu : {}'.format(file_name), severity='WARNING')
    logger.log_text('Fichier reçu : {}'.format(file_name), severity='WARNING')
