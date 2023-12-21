import os
from dotenv import load_dotenv

load_dotenv()

akey_host = os.environ['akey_host']
akey_gateway = os.environ['akey_gateway']
access_id = os.environ['AKEYLESS_ACCESS_ID']
access_key = os.environ['AKEYLESS_ACCESS_KEY']

db_host = os.environ['db_host']
db_name = os.environ['db_name']
db_table = os.environ['db_table']