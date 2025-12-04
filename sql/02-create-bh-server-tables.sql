-- ============================================
-- BH Server Database Schema
-- ============================================
-- 从代码中提取的表结构定义
-- 数据库: bh_server
--
-- 注意：此文件与 bh/bh-server/sql/01-create-tables.sql 同步维护
-- 修改表结构时，请同时更新两个文件

USE bh_server;

-- ============================================
-- 1. tb_snowflake_id - 雪花ID生成器表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_snowflake_id (
  datacenter_id BIGINT(20) NOT NULL COMMENT '数据中心ID',
  work_id BIGINT(20) NOT NULL COMMENT '工作节点ID',
  updated_at BIGINT(20) NOT NULL COMMENT '更新时间（毫秒时间戳）',
  PRIMARY KEY (datacenter_id, work_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='雪花ID生成器表';

-- 初始化数据：datacenter_id=4, work_id=1（根据 SnowflakeIdServiceImpl 中的配置）
INSERT INTO tb_snowflake_id (datacenter_id, work_id, updated_at) 
VALUES (4, 1, UNIX_TIMESTAMP() * 1000 - 1200000)
ON DUPLICATE KEY UPDATE updated_at = UNIX_TIMESTAMP() * 1000 - 1200000;

-- ============================================
-- 2. tb_shard - 分片信息表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_shard (
  id BIGINT(20) NOT NULL COMMENT '分片ID',
  host VARCHAR(255) DEFAULT NULL COMMENT '分片主机',
  port INT(11) DEFAULT NULL COMMENT '分片端口',
  config VARCHAR(800) DEFAULT NULL COMMENT '分片配置',
  default_shard INT(2) DEFAULT 0,
  org_id BIGINT(20) DEFAULT NULL COMMENT '关联 tb_org',
  area_id BIGINT(20) DEFAULT NULL COMMENT '地区ID',
  PRIMARY KEY (id),
  UNIQUE KEY UK_ORG_SHARD (org_id, id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分片信息表';

-- 插入初始数据
INSERT IGNORE INTO tb_shard (id, host, port, default_shard) VALUES (1, 'localhost', 8080, 1);

-- ============================================
-- 3. tb_broker_exchange_contract - 券商交易所合约表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_broker_exchange_contract (
  id INT(11) NOT NULL AUTO_INCREMENT,
  broker_id BIGINT(20) NOT NULL COMMENT '券商ID',
  exchange_id BIGINT(20) NOT NULL,
  is_effective TINYINT(1) DEFAULT 1 COMMENT '是否生效',
  is_trust TINYINT(1) DEFAULT 0 COMMENT '是否是信任关系，即broker可以有exchange的权限',
  created_at TIMESTAMP(3) NULL DEFAULT NULL,
  updated_at TIMESTAMP(3) NULL DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY brokerId_exchangeId_idx (broker_id, exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='broker exchange contract';

-- ============================================
-- 4. tb_account - 账户表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_account (
  id BIGINT(11) NOT NULL AUTO_INCREMENT,
  account_id BIGINT(20) NOT NULL COMMENT '平台生成，全局唯一',
  org_user_id BIGINT(20) DEFAULT NULL COMMENT '关联 tb_org_user',
  org_id BIGINT(20) DEFAULT NULL COMMENT '关联 tb_org',
  broker_user_id VARCHAR(255) DEFAULT NULL,
  status TINYINT(4) DEFAULT NULL COMMENT '账户状态：正常（0）、冻结（1）',
  is_delete TINYINT(4) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1：删除',
  type TINYINT(4) NOT NULL COMMENT '账户类型：普通托管账户(0)、独立账户(1)、系统账户(2)、做市商账户(3)',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  main_account_level TINYINT(4) DEFAULT NULL,
  shard_id BIGINT(20) DEFAULT NULL COMMENT '分片ID',
  account_index TINYINT(4) NOT NULL DEFAULT 0 COMMENT '用于子帐户的索引',
  PRIMARY KEY (id),
  KEY IDX_ACCOUNT_ID (account_id),
  KEY idx_broker_user_id (broker_user_id),
  KEY idx_broker_user_org_id_type_index (broker_user_id, org_id, type, account_index)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户表 分片';
