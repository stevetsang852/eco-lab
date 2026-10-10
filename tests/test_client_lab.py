from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]


def test_client_compose_has_both_supply_options():
    data = yaml.safe_load((ROOT / "docker-compose.client.yml").read_text())
    svc = data["services"]["eco-client"]
    assert svc["build"]["args"]["INSTALL_CLIENT"] == "${INSTALL_CLIENT:-0}"
    assert "ECO_CLIENT_PATH" in svc["volumes"][0]
    assert "6080:6080" in svc["ports"]
    assert any("host.docker.internal" in h for h in svc["extra_hosts"])


def test_client_lab_files_exist():
    needed = [
        "docker/client-lab/Dockerfile",
        "docker/client-lab/entrypoint.sh",
        "scripts/start-client-bind.bat",
        "scripts/start-client-baked.bat",
        "scripts/stop-client.bat",
        "scripts/start_in_local.bat",
        "scripts/start_in_docker.bat",
        "start_in_local.bat",
        "start_in_docker.bat",
    ]
    for rel in needed:
        assert (ROOT / rel).is_file(), rel


def test_image_does_not_vendor_a_client():
    docker = (ROOT / "docker/client-lab/Dockerfile").read_text()
    assert "INSTALL_CLIENT" in docker
    assert "eco.exe" not in (ROOT / "docker/client-lab/client-src/README.md").read_text().split("eco.exe")[0]
    assert not list((ROOT / "docker/client-lab/client-src").glob("*.exe"))
