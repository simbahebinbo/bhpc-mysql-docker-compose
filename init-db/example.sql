SET NAMES 'utf8mb4';
use example;

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


DROP TABLE IF EXISTS consumer;

CREATE TABLE consumer
(
    id bigint(20) unsigned auto_increment COMMENT 'primary key',
    username varchar(64) NOT NULL DEFAULT '' COMMENT 'username',
    password varchar(64) NOT NULL DEFAULT '' COMMENT 'password',
    role varchar(64) NOT NULL DEFAULT '' COMMENT 'role',
    PRIMARY KEY (id),
    UNIQUE KEY unique_username (username),
    KEY index_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='consumer table';



DROP TABLE IF EXISTS tbl_role;

CREATE TABLE tbl_role (
  id varchar(50)  NOT NULL,
  rolename varchar(500)  DEFAULT NULL,
  createdby varchar(255)  DEFAULT NULL,
  createddate datetime DEFAULT NULL,
  updatedby varchar(255)  DEFAULT NULL,
  data varchar(500)  DEFAULT NULL,
  updateddate datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



DROP TABLE IF EXISTS tbl_user;

CREATE TABLE tbl_user (
  id varchar(50)  NOT NULL,
  address varchar(500)  DEFAULT NULL,
  authenticate varchar(500)  DEFAULT NULL,
  mail varchar(500)  DEFAULT NULL,
  name varchar(500)  DEFAULT NULL,
  password varchar(500)  DEFAULT NULL,
  phone varchar(500)  DEFAULT NULL,
  sex varchar(500)  DEFAULT NULL,
  updatedby varchar(500)  DEFAULT NULL,
  mobile varchar(500)  DEFAULT NULL,
  updateddate datetime DEFAULT NULL,
  realname varchar(500)  DEFAULT NULL,
  dob datetime DEFAULT NULL,
  logo varchar(500)  DEFAULT NULL,
  createdby varchar(255)  DEFAULT NULL,
  createddate datetime DEFAULT NULL,
  openid varchar(255)  DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS tbl_user_permission;

CREATE TABLE tbl_user_permission (
  id varchar(50)  NOT NULL,
  userid varchar(500)  DEFAULT NULL,
  permission varchar(500)  DEFAULT NULL,
  createddate datetime DEFAULT NULL,
  createdby varchar(500)  DEFAULT NULL,
  updateddate datetime DEFAULT NULL,
  updatedby varchar(50)  DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




