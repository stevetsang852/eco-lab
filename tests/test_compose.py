from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_compose_declares_mysql_and_tests():
    text = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
    assert "mysql:" in text
    assert "contract-tests:" in text
    assert "schema-min.sql" in text
    assert "3306:3306" in text


def test_dockerfile_exists_and_runs_pytest():
    text = (ROOT / "docker" / "Dockerfile").read_text(encoding="utf-8")
    assert "FROM python:3.12-slim" in text
    assert "pytest" in text


def test_readme_states_not_full_server():
    text = (ROOT / "README.md").read_text(encoding="utf-8")
    assert "not" in text.lower()
    assert "EcoServerEmulator" in text
    assert "SagaECO" in text
    assert "17831" in text
