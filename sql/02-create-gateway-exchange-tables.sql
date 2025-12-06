-- ============================================
-- Gateway Exchange Database Schema
-- ============================================
-- 数据库: gateway_exchange
-- 用于 match-engine 和其他 gateway 服务

USE gateway_exchange;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. tb_exchange - 交易所表
-- ============================================
DROP TABLE IF EXISTS tb_exchange;
CREATE TABLE tb_exchange (
  id bigint(20) NOT NULL COMMENT '交易所id',
  name varchar(255) DEFAULT NULL COMMENT '交易所名',
  instance_name varchar(128) NOT NULL COMMENT '实例名',
  create_at bigint(20) DEFAULT NULL,
  update_at bigint(20) DEFAULT NULL,
  remark varchar(255) DEFAULT NULL,
  status smallint(6) NOT NULL DEFAULT '1' COMMENT '当前交易所状态；0：closed，1：opened，2：stopped',
  status_string varchar(128) DEFAULT NULL COMMENT 'opened,closed,stopped',
  PRIMARY KEY (id,instance_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易所表';

-- ============================================
-- 2. tb_gateway - 网关表
-- ============================================
DROP TABLE IF EXISTS tb_gateway;
CREATE TABLE tb_gateway (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(128) DEFAULT NULL,
  domain varchar(255) DEFAULT NULL COMMENT '网关域名',
  host varchar(128) DEFAULT NULL COMMENT '主机地址',
  port int(11) DEFAULT NULL COMMENT '主机端口',
  create_at bigint(20) DEFAULT NULL,
  update_at bigint(20) DEFAULT NULL,
  remark varchar(128) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关表';

-- ============================================
-- 3. tb_instance - 引擎实例表
-- ============================================
DROP TABLE IF EXISTS tb_instance;
CREATE TABLE tb_instance (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL COMMENT '实例名',
  host varchar(64) DEFAULT NULL COMMENT '实例运行所在主机',
  port int(11) DEFAULT NULL COMMENT '实例所在端口',
  cluster varchar(32) DEFAULT NULL COMMENT '实例所在的集群',
  instance_type smallint(6) NOT NULL COMMENT '实例类型：0：match，1：quote',
  instance_type_string varchar(128) DEFAULT NULL COMMENT 'match,quote',
  create_at bigint(20) DEFAULT NULL,
  update_at bigint(20) DEFAULT NULL,
  last_keepalived_time bigint(20) DEFAULT NULL COMMENT '最后一次心跳时间',
  online_time bigint(20) DEFAULT NULL COMMENT '在线时长',
  replica_sets int(11) DEFAULT NULL COMMENT '副本集数量',
  remark varchar(255) DEFAULT NULL COMMENT '实例附加说明',
  status_string varchar(128) DEFAULT NULL COMMENT 'opened,closed,stopped',
  status smallint(6) NOT NULL DEFAULT '1' COMMENT '实例当前状态：0:关闭，1：开放，2：暂停',
  node_type smallint(6) NOT NULL COMMENT '节点类型，0：master，1：Slave',
  node_type_string varchar(128) DEFAULT NULL COMMENT 'master/slave',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='引擎实例表';

-- ============================================
-- 4. tb_market - 币对配置表
-- ============================================
DROP TABLE IF EXISTS tb_market;
CREATE TABLE tb_market (
  exchange_id bigint(20) NOT NULL COMMENT '交易所id',
  symbol_id varchar(64) NOT NULL COMMENT '币对id',
  symbol_name varchar(64) DEFAULT NULL COMMENT '币对名',
  instance_name varchar(128) DEFAULT 'match-engine.exchange' COMMENT '实例名',
  create_at bigint(20) DEFAULT NULL,
  update_at bigint(20) DEFAULT NULL,
  remark varchar(255) DEFAULT NULL,
  status smallint(6) NOT NULL DEFAULT '1' COMMENT '当前币对状态；0：closed，1：opened，2：stopped',
  status_string varchar(128) DEFAULT NULL COMMENT 'closed，opened，stopped',
  topic_name varchar(32) DEFAULT NULL COMMENT 'Market的队列名称',
  partition_name varchar(255) DEFAULT NULL COMMENT 'Exchange下Market所在分区名称',
  reverse tinyint(1) DEFAULT 0 COMMENT '是否反向',
  PRIMARY KEY (exchange_id,symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币对配置表';

-- ============================================
-- 5. tb_partition - 分片表
-- ============================================
DROP TABLE IF EXISTS tb_partition;
CREATE TABLE tb_partition (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL COMMENT '分片名',
  port int(11) NOT NULL COMMENT '分片所在端口',
  partition_type smallint(6) NOT NULL DEFAULT 0 COMMENT '分片类型：0：match，1：quote',
  status smallint(6) NOT NULL DEFAULT 1 COMMENT '分片状态，1为打开，0为关闭',
  create_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分片表';

SET FOREIGN_KEY_CHECKS = 1;

