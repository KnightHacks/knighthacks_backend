# Testing

## Explanation

When coding this project some features may be difficult to test due to the dependent nature of this project.

One of the more notable issues in setting up local testing is authentication. For now authentication is handled via
the [OAuth2](https://oauth.net/2/) standard. In short this means that we support logging in using another company's
authentication. For
example: [Github](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps).

## Requirements

Locally, we use [docker-compose](https://docs.docker.com/compose/) for testing. To install
this [follow the instructions](https://docs.docker.com/compose/install/) for your operating system on the docker
website. The quickest way is to use the __Docker Desktop__.

## Environmental Variables

Environmental variables are a way that we pass information from the host machine into the container running in docker.
For the scope of this project, think of environmental variables as key-value pairs that we get to set for each container
and retrieve from the container at runtime, similarly to a configuration file.

In this project we store these environmental variables in a file named ".env". This file will hold constants that we
define across [events](https://github.com/KnightHacks/knighthacks_events)
, [hackathon](https://github.com/KnightHacks/knighthacks_hackathon)
, [sponsors](https://github.com/KnightHacks/knighthacks_sponsors),
and [users](https://github.com/KnightHacks/knighthacks_users).

The following excerpt shows what the .env file will look like without the values set:

```bash
OAUTH_GITHUB_CLIENT_ID=
OAUTH_GITHUB_CLIENT_SECRET=
OAUTH_GITHUB_REDIRECT_URL=

JWT_SIGNING_KEY=
AES_CIPHER=
```

You should __create__ this .env file in the root directory in the project, meaning that the .env file should be in the
same
folder as the [docker-compose.yaml](https://github.com/KnightHacks/knighthacks_backend/blob/main/docker-compose.yaml)
file is.

### GitHub OAuth App

#### What is this?

As previous mentioned we use the [OAuth2](https://oauth.net/2/) standard for authenticating with 3rd party platforms.
Creating this OAuth2 app is what allows us to retrieve this information from the users, when the user selects "Login
with GitHub" on the website it will redirect them to GitHub with a popup asking if the user permits giving us their
email address and other public information like their GitHub name. After granting us the permission the user will be
redirected to the link set in the **OAUTH_GITHUB_REDIRECT_URL** environmental variable.

#### Setup

To fill in the environmental variables beginning with OAUTH_GITHUB
follow [this tutorial](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app) on how to
create a GitHub OAuth app. The application name and homepage url do not matter. The callback url should be set
to http://localhost:8080/auth_redirect for testing using
the [knighthacks_cli](https://github.com/KnightHacks/knighthacks_cli/).
Make sure to tick the box that says "__Enable Device Flow__".

After creating the OAuth App, retrieve the client id and client secret and set those values in the corresponding .env
file entries. Set **OAUTH_GITHUB_REDIRECT_URL** to http://localhost:8080/auth_redirect.

##### JWT Signing Key

You can smash your hands on your keyboard and create an under 100 character string.

##### AES Cipher

Similarly to the JWT Signing Key, you can smash your hands on your keyboard and create an **exactly** 32 character
string.

## Schema Composition

For the router microservice you first need to compose your schema from all of your microservice "subschemas" follow the
instructions on installing [Rover](https://www.apollographql.com/docs/rover/getting-started).
Rover is the program that handles supergraph schema composition. For information on super and subgraphs
checkout [this](https://www.apollographql.com/docs/federation).

In the router microservice there is a compose.sh file that you can run like so:

```bash
bash compose.sh dev
```

This command will generate a file called schema.graphql that will be **NOT be source controlled** and whenever you make
a change to any of the other microservice's schemas you must re-run this command.

## Running the Project

Using docker-compose, and it's configuration stored in
the  [docker-compose.yaml](https://github.com/KnightHacks/knighthacks_backend/blob/main/docker-compose.yaml) you can use
the [docker-compose up](https://docs.docker.com/engine/reference/commandline/compose_up/) command to run the project.

**Before going any further** make sure to do the following command in the main directory of the project the before
proceeding:

```bash
docker-compose up --build postgres
```

After about 30 seconds of the program running it should say postgres can now accept

If a change was made to the code since the last build of the docker image append the `--build` flag at the end of
command.

For example:

```bash
docker-compose up --build
```

If you would like to just spin up a certain service you can do the previous command with the name of the service
provided in the [docker-compose.yaml](https://github.com/KnightHacks/knighthacks_backend/blob/main/docker-compose.yaml)
file appended. For example, to start up the postgres service you would do the following:

```bash
docker-compose up --build postgres
```

If you just want to start up a single service, for example: users, you can do:

```bash
docker-compose up --build users
```

This will turn on the users service, and its dependent services such as postgres and router.

## Shutting down the project

Whenever you do `docker-compose up` by default it runs live in the current terminal widow

## Connecting

Connecting to the Apollo Router microservice now running is as simple as opening your browser and going to
http://localhost:4000. Once you open that you will be able to open Apollo Studio and explore the GraphQL API.

## Signing in

Using the KnightHacks CLI in the [knighthacks_cli](https://github.com/KnightHacks/knighthacks_cli/) repository you can
register, sign in, or do whatever you'd like to do with the API. Ensure you follow the instructions on the knighthacks_cli repository.

Most importantly, you need a [JWT](https://jwt.io/) to be able to send authenticated requests to the backend. To get
that JWT you must use the [knighthacks_cli](https://github.com/KnightHacks/knighthacks_cli/).

First, register an account using the CLI. For example:

```bash
./knighthacks_cli auth register --first-name Joe --last-name Mama --email joe.mama@test.com --phone 1234567890 
```

Then, login to the account:

```bash
./knighthacks_cli auth login
```

Copy the JWT it gives when you execute the login command. Ensure that the copied JWT does not have any spaces in it then
add it as a HTTP header in the apollo studio website where the header name/key is `authorization` and the value
is `bearer JWT` where `JWT` is the JWT you copied.

## Setting up admin user

The next step is to set the role of the user you just registered as an admin. To do that you will use
the `set_user_role.sh` script. Ensure the database is online when using this command.

First, using the previous knighthacks_cli login command retrieve the `User ID` from the output of the command.

Enter the scripts folder and execute the following command:

```shell
bash set_user_role.sh {USER_ID} ADMIN
```
Where `{USER_ID}` is the ID from the login command.
