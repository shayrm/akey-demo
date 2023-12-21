import akeyless
import time
from pprint import pprint
from akeyless.rest import ApiException

# using public API endpoint
configuration = akeyless.Configuration(
        host = "https://api.akeyless.io"
)

api_client = akeyless.ApiClient(configuration)
api = akeyless.V2Api(api_client)

body = akeyless.Auth(access_id='p-qalc9g8dr31dam', access_key='/7nHKZ7nmCnmiWbnwAsfUdAwbwkm4UJmZPvtrD6736U=')
res = api.auth(body)
token = res.token

body = akeyless.GetSecretValue(names=['/dev/projects/test-aky/MySod1', '/dev/projects/test-aky/MySod2'], token=token)
res = api.get_secret_value(body)
print("First secret: " + res['/dev/projects/test-aky/MySod1'])
print("Second secret: " + res['/dev/projects/test-aky/MySod2'])

configuration = akeyless.Configuration(
        host = "http://13.57.245.231:8000"
)
api_client = akeyless.ApiClient()
api = akeyless.V2Api(api_client)

body = akeyless.Auth(gateway_url='http://13.57.245.231:8000', access_id='p-jui1hjbpm117am', access_key='gha1Z2EPbB90OXALrA1V73gr0w/y2hd8I5LzKR6YU2s=')
res = api.auth(body)
print(res)
token = res.token

exit

with akeyless.ApiClient() as api_client:
    # Create an instance of the API class
    api_instance = akeyless.V2Api(api_client)
    body = akeyless.GetDynamicSecretValue(name='/mySQLds-1', token=token) # GetDynamicSecretValue | 

    try:
        api_response = api_instance.get_dynamic_secret_value(body)
        #pprint(api_response)
        user = api_response['user']
        password = api_response['password']

        print(f'will loging with username: {user} \n and password: {password}' )

    except ApiException as e:
        print("Exception when calling V2Api->get_dynamic_secret_value: %s\n" % e)


#body = akeyless.GetDynamicSecretValue(name=['/mySQLds-1'], token=token)
#res = api.get_dynamic_secret_value(body)
#print(res)
