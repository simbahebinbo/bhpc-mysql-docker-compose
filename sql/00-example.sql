SET NAMES 'utf8mb4';

DROP TABLE IF EXISTS person;

CREATE TABLE person (
  id bigint(20) unsigned auto_increment COMMENT 'primary key',
  username varchar(64) NOT NULL DEFAULT '' COMMENT 'username',
  age int NOT NULL DEFAULT '0' COMMENT 'age',
  create_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  PRIMARY KEY (id),
  UNIQUE KEY unique_username (username),
  KEY index_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='person table';

INSERT INTO person (username, age) VALUES ('simba', 33);
INSERT INTO person (username, age) VALUES ('buckshot', 66);

DROP TABLE IF EXISTS hero;

CREATE TABLE hero
(
    id bigint(20) unsigned auto_increment COMMENT 'primary key',
    username varchar(64) NOT NULL DEFAULT '' COMMENT 'username',
    age int NOT NULL DEFAULT '0' COMMENT 'age',
    create_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
    PRIMARY KEY (id),
    UNIQUE KEY unique_username (username),
    KEY index_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='hero table';

