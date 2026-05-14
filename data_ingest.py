import pandas as pd
import sqlite3

# Function to ingest "data_usable" folder CSV files into SQLite database
def ingest_data_to_sqlite(db_name='database.db'):
    conn = sqlite3.connect(database=db_name)
    
    #List of CSV files to ingest
    csv_files = [
        'data_usable/gsc_congestion_clean.csv',
        'data_usable/gsc_disruption_events_clean.csv',
        'data_usable/gsc_industry_exposure_clean.csv',
        'data_usable/gsc_shipping_rates_clean.csv',
        'data_usable/gsc_trade_flows_clean.csv'
    ]
    for file in csv_files:
        df = pd.read_csv(file)
        table_name = file.split('/')[-1].split('.')[0]  # Extract table name from file name
        df.to_sql(table_name, conn, if_exists='replace', index=False)  # Ingest data into SQLite
    conn.close()

ingest_data_to_sqlite();


