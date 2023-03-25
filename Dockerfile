
FROM python:3.8-alpine
# RUN python -m pip install --upgrade pip
WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt

CMD [ "python3", "app.py" ]

