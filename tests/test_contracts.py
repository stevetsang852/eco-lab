from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "contract"


def test_opcodes_yaml_loads():
    data = yaml.safe_load((CONTRACT / "opcodes.yaml").read_text(encoding="utf-8"))
    assert data["version"] == 1
    assert data["client_target"] == "jp-2017-08-31"
    for name in ("world", "login", "map"):
        assert name in data["processes"]
        proc = data["processes"][name]
        assert isinstance(proc["port"], int)
        assert proc["opcodes"], name
        ids = [op["id"] for op in proc["opcodes"]]
        assert len(ids) == len(set(ids)), f"duplicate opcode in {name}"
        for op in proc["opcodes"]:
            assert op["status"] in {"confirmed", "guessed", "ignore"}
            assert op["seen_in"] in {"emulator", "saga", "both"}
            assert int(op["id"], 16) >= 0


def test_expected_ports():
    data = yaml.safe_load((CONTRACT / "opcodes.yaml").read_text(encoding="utf-8"))
    assert data["processes"]["world"]["port"] == 17831
    assert data["processes"]["login"]["port"] == 17832
    assert data["processes"]["map"]["port"] == 17833


def test_required_login_opcodes_present():
    data = yaml.safe_load((CONTRACT / "opcodes.yaml").read_text(encoding="utf-8"))
    names = {op["name"] for op in data["processes"]["login"]["opcodes"]}
    assert {"UserLogin", "CreateChara", "RequestMapServer"} <= names


def test_required_map_move_opcode_present():
    data = yaml.safe_load((CONTRACT / "opcodes.yaml").read_text(encoding="utf-8"))
    names = {op["name"] for op in data["processes"]["map"]["opcodes"]}
    assert "RequestMove" in names
    assert "CharaMove" in names


def test_boundaries_document_mentions_start_order():
    text = (CONTRACT / "boundaries.md").read_text(encoding="utf-8")
    assert "WorldServer" in text
    assert "LoginServer" in text
    assert "MapServer" in text
    assert "17831" in text


def test_schema_min_has_account_and_chara():
    sql = (CONTRACT / "schema-min.sql").read_text(encoding="utf-8")
    assert "CREATE TABLE IF NOT EXISTS Account" in sql
    assert "CREATE TABLE IF NOT EXISTS Chara" in sql
    assert "username" in sql
    assert "account_id" in sql
