FROM python:3.7.3-slim-stretch

COPY src /app/src

RUN pip install -r /app/src/requirements.txt

EXPOSE 8081
ENTRYPOINT [ "python", "/app/src/app.py" ]
