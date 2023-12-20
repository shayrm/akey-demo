import akeyless

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
