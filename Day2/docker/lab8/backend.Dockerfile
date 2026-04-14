FROM python:3.10-slim

WORKDIR /app

COPY Docker5/backend .

RUN pip install flask

EXPOSE 5000

CMD ["python", "app.py"]
