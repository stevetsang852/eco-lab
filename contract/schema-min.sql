-- Minimal schema extracted for CI (Account + Chara only).
-- Not a substitute for upstream sql/eco.sql.

CREATE TABLE IF NOT EXISTS Account (
  id int unsigned NOT NULL AUTO_INCREMENT,
  username varchar(16) NOT NULL,
  password varchar(32) NOT NULL,
  is_online tinyint(1) NOT NULL DEFAULT 0,
  last_login_time datetime DEFAULT NULL,
  last_login_ip varchar(50) DEFAULT NULL,
  is_banned tinyint(1) NOT NULL DEFAULT 0,
  chara_slot1 int NOT NULL DEFAULT 0,
  chara_slot2 int NOT NULL DEFAULT 0,
  chara_slot3 int NOT NULL DEFAULT 0,
  chara_slot4 int NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Chara (
  id int unsigned NOT NULL AUTO_INCREMENT,
  account_id int unsigned NOT NULL,
  Slot tinyint unsigned NOT NULL,
  Name varchar(16) NOT NULL DEFAULT '',
  Race tinyint unsigned NOT NULL DEFAULT 0,
  Form tinyint unsigned NOT NULL DEFAULT 0,
  Sex tinyint unsigned NOT NULL DEFAULT 0,
  HairStyle smallint unsigned NOT NULL DEFAULT 0,
  HairColor tinyint unsigned NOT NULL DEFAULT 0,
  Wig smallint unsigned NOT NULL DEFAULT 255,
  IsEmptySlot tinyint unsigned NOT NULL DEFAULT 0,
  Face smallint unsigned NOT NULL DEFAULT 0,
  RebirthLv tinyint unsigned NOT NULL DEFAULT 0,
  Ex tinyint unsigned NOT NULL DEFAULT 0,
  Wing tinyint unsigned NOT NULL DEFAULT 0,
  WingColor tinyint unsigned NOT NULL DEFAULT 0,
  Job tinyint unsigned NOT NULL DEFAULT 0,
  Map int unsigned NOT NULL DEFAULT 0,
  LvBase tinyint unsigned NOT NULL DEFAULT 0,
  LvJob1 tinyint unsigned NOT NULL DEFAULT 0,
  Quest smallint unsigned NOT NULL DEFAULT 5,
  LvJob2x tinyint unsigned NOT NULL DEFAULT 0,
  LvJob2t tinyint unsigned NOT NULL DEFAULT 0,
  LvJob3 tinyint unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY account_index (account_id)
);
