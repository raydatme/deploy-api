# Flask API
 
Server Deployment, Containerization, and Testing.

This Flask app is a simple API with three endpoints:

- `GET '/'`: Simple health check, which returns the response 'Healthy'. 
- `POST '/auth'`: Takes an email and a password as json arguments and returns a JWT based on a custom secret.
- `GET '/contents'`: Requires a valid JWT, and returns the un-encrpyted contents of that token. 

The app relies on a secret set as the environment variable `JWT_SECRET` to produce a JWT. The built-in Flask server is adequate for local development, but not production, the production-ready [Gunicorn](https://gunicorn.org/) server is used to deploy the app.

## Dependencies

- Docker Engine
    - Installation instructions for all OSes can be found [here](https://docs.docker.com/install/).
    - For Mac users, if you have no previous Docker Toolbox installation, you can install Docker Desktop for Mac. If you already have a Docker Toolbox installation, please read [this](https://docs.docker.com/docker-for-mac/docker-toolbox/) before installing.
 - AWS Account

## Description
Dockerfile for simple Flask Api. Uses an EKS cluster, stores `JWT_SECRET` in AWS Parameter Store, and employs a CodePipeline triggered by GitHub commits. Codebuild stage builds, tests, and deploys code. 
