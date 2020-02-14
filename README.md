# Flask API
 
Server Deployment, Containerization, and Testing.

This Flask app is a simple API with three endpoints:

- `GET '/'`: Simple health check, which returns the response 'Healthy'. 
- `POST '/auth'`: Takes an email and a password as json arguments and returns a JWT based on a custom secret.
- `GET '/contents'`: Requires a valid JWT, and returns the un-encrpyted contents of that token. 

The app relies on a secret set as the environment variable `JWT_SECRET` to produce a JWT. The built-in Flask server is adequate for local development, but not production. The production-ready [Gunicorn](https://gunicorn.org/) server is used to deploy the app.

## Run Locally Without Containerization 
Install Python dependencies.
``` pip install -r requirements.txt```

Set up the environment.
``` export JWT_SECRET='myjwtsecret'
 export LOG_LEVEL=DEBUG
 ```
 
 Run the app using the flask server.
 ``` python main.py```
 
 Test the endpoints.
```
export TOKEN=`curl -d '{"email":"<EMAIL>","password":"<PASSWORD>"}' -H "Content-Type: application/json" -X POST localhost:8080/auth  | jq -r '.token'`
echo $TOKEN
curl --request GET 'http://127.0.0.1:8080/contents' -H "Authorization: Bearer ${TOKEN}" | jq .
```

## Containerize and Run Locally
Run the app using flask server.
`python3 main.py` 

Build a local Docker image. 
`docker build --tag test .`

Run image locally using Gunicorn server. 
```docker run --env-file=env_file -p 80:8080 test```

Get the id of the running container when done.
`docker ps`

Stop the container.
`docker stop <CONTAINER_Id>`

## Dependencies

- Docker Engine
    - Installation instructions for all OSes can be found [here](https://docs.docker.com/install/).
    - For Mac users, if you have no previous Docker Toolbox installation, you can install Docker Desktop for Mac. If you already have a Docker Toolbox installation, please read [this](https://docs.docker.com/docker-for-mac/docker-toolbox/) before installing.
 - AWS Account

## Description
Dockerfile for simple Flask Api. Uses a Kubernetes EKS cluster, grants role-based access to cluster, stores `JWT_SECRET` in AWS Parameter Store, and employs a CodePipeline triggered by GitHub commits. Codebuild stage builds, tests, and deploys code. 

## Execution
To run, you need the `EXTERNAL IP`.
Example commands to test the api: 

```
export TOKEN=`curl -d '{"email":"<EMAIL>","password":"<PASSWORD>"}' -H "Content-Type: application/json" -X POST <EXTERNAL-IP URL>/auth  | jq -r '.token'`
curl --request GET '<EXTERNAL-IP URL>/contents' -H "Authorization: Bearer ${TOKEN}" | jq 
```
