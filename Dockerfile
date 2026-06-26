FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir zensical

COPY . .

RUN zensical build

EXPOSE 8086

CMD ["sh", "-c", "python -m http.server 8086 -d site --bind 0.0.0.0"]
