FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 80
CMD ["python", "app.py"]
