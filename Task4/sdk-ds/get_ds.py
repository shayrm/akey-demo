import akeyless
import time
import env as env
from pprint import pprint
from akeyless.rest import ApiException
import datetime
import mysql.connector

#load_dotenv()
#akey_host = os.environ['akey_host']
#akey_gateway = os.environ['akey_gateway']
#access_id = os.environ['access_id']
#access_key = os.environ['access_key']
#ds_name = ""

# using public API endpoint
configuration = akeyless.Configuration(
        host = env.akey_host
)

api_client = akeyless.ApiClient(configuration)
api = akeyless.V2Api(api_client)

body = akeyless.Auth(access_id=f'{env.access_id}', access_key=f'{env.access_key}')
res = api.auth(body)
token = res.token

body = akeyless.GetSecretValue(names=['/dev/projects/test-aky/MySod1', '/dev/projects/test-aky/MySod2'], token=token)
res = api.get_secret_value(body)
print("First secret: " + res['/dev/projects/test-aky/MySod1'])
print("Second secret: " + res['/dev/projects/test-aky/MySod2'])

configuration = akeyless.Configuration(
        host = f"{env.akey_gateway}"
)
api_client = akeyless.ApiClient()
api = akeyless.V2Api(api_client)

body = akeyless.Auth(gateway_url=f'{env.akey_gateway}', access_id=f'{env.access_id}', access_key=f'{env.access_key}')
res = api.auth(body)
token = res.token

with akeyless.ApiClient() as api_client:
    # Create an instance of the API class
    api_instance = akeyless.V2Api(api_client)
    body = akeyless.GetDynamicSecretValue(name='/mySQLds-1', token=token) # GetDynamicSecretValue | 

    try:
        api_response = api_instance.get_dynamic_secret_value(body)
        #pprint(api_response)
        user = api_response['user']
        password = api_response['password']

        print(f'** will loging with username: {user} \n**and password: {password}' )

    except ApiException as e:
        print("Exception when calling V2Api->get_dynamic_secret_value: %s\n" % e)


#body = akeyless.GetDynamicSecretValue(name=['/mySQLds-1'], token=token)
#res = api.get_dynamic_secret_value(body)
#print(res)

cnx = mysql.connector.connect(user=f'{user}', password=f'{password}',
                              host=f'{env.db_host}',
                              database=f'{env.db_name}')
cursor = cnx.cursor()

query = (f'SELECT user_name, email, color FROM {env.db_table};')

cursor.execute(query)
q_result = cursor.fetchall()

for x in q_result:
  print(x)

cursor.close()
cnx.close()