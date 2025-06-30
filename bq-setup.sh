# gcloud init
bq mk --location=EU raw
# bq mk --location=EU staging

# raw dataset
bq mk --table raw.customers \
row_id:INTEGER,customer_id:STRING,first_name:STRING,last_name:STRING,country:STRING
bq mk --table raw.orders \
order_id:STRING,customer_id:STRING,order_date:STRING,ship_date:STRING,total_value:STRING
bq mk --table raw.shipments \
shipment_id:STRING,order_id:STRING,ship_date:STRING,delivery_date:STRING

# Load data from CSV files
bq load --skip_leading_rows=1 --source_format=CSV raw.customers ./data/customers.csv
bq load --skip_leading_rows=1 --source_format=CSV raw.orders ./data/orders.csv
bq load --skip_leading_rows=1 --source_format=CSV raw.shipments ./data/shipments.csv