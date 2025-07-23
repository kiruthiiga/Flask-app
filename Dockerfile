FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .          # ✅ Copy only the requirements first
RUN pip install -r requirements.txt

COPY . .                         # ✅ Then copy the rest of the source code

EXPOSE 80
CMD ["python", "app.py"]
