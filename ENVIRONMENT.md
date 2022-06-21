# Setting up your Environment

Before you start testing you must first create a .env file that will be read into your docker-compose containers.
The following fields must be set with their appropriate values:

```dotenv
OAUTH_GITHUB_CLIENT_ID=
OAUTH_GITHUB_CLIENT_SECRET=
OAUTH_GITHUB_REDIRECT_URL=http://localhost:8080/auth_redirect

JWT_SIGNING_KEY=
AES_CIPHER=
```

## Github OAuth

To fill in the environmental variables beginnging with OAUTH_GITHUB
follow [this tutorial](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app) on how to
setup a Github OAuth app. The application name, homepage url, and callback url do not matter.
Make sure to tick the box that says "__Enable Device Flow__"

## JWT Signing Key
You can smash your hands on your keyboard and create an under 100 character string.

## AES Cipher
Similarly to the JWT Signing Key, you can smash your hands on your keyboard and create an **exactly** 32 character string. 