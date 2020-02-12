FROM python:3.7.2-slim

COPY . /app 
WORKDIR /app

RUN pip3 install --upgrade pip 
RUN pip3 install -r requirements.txt

ENTRYPOINT [ "gunicorn", "-b", ":8080", "main:APP" ]

# docker build -t jwt-api-test .
# python main.py 
# docker run --env-file=env_file -p 80:8080 jwt-api-test 
