FROM python:3.12-slim

WORKDIR /lab
COPY tests/requirements.txt tests/requirements.txt
RUN pip install --no-cache-dir -r tests/requirements.txt

COPY contract contract
COPY tests tests
COPY docker-compose.yml docker-compose.yml

ENV PYTHONUNBUFFERED=1
CMD ["python", "-m", "pytest", "tests", "-q"]
