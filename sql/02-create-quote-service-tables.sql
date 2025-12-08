-- ============================================
-- Quote Service Database Schema
-- ============================================
-- 数据库: quote
-- 用于 quote-service 服务

USE quote;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. tb_exchange - 交易所表
-- ============================================
DROP TABLE IF EXISTS tb_exchange;
CREATE TABLE tb_exchange (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_name varchar(255) NOT NULL COMMENT '交易所名称',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易所表';

-- ============================================
-- 2. tb_data_type - 数据类型表
-- ============================================
DROP TABLE IF EXISTS tb_data_type;
CREATE TABLE tb_data_type (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  data_type varchar(255) NOT NULL COMMENT '数据类型',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据类型表';

-- ============================================
-- 3. tb_symbol - 币对表
-- ============================================
DROP TABLE IF EXISTS tb_symbol;
CREATE TABLE tb_symbol (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  bhex_symbol varchar(255) NOT NULL COMMENT 'BHEX币对',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币对表';

-- ============================================
-- 4. tb_symbol_map - 币对映射表
-- ============================================
DROP TABLE IF EXISTS tb_symbol_map;
CREATE TABLE tb_symbol_map (
  bhex_symbol_id bigint(20) NOT NULL COMMENT 'BHEX币对ID',
  exchange_id bigint(20) NOT NULL COMMENT '交易所ID',
  third_symbol varchar(255) NOT NULL COMMENT '第三方交易所币对',
  PRIMARY KEY (bhex_symbol_id),
  KEY idx_exchange_id (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币对映射表';

-- ============================================
-- 5. tb_task - 任务表
-- ============================================
DROP TABLE IF EXISTS tb_task;
CREATE TABLE tb_task (
  exchange_id bigint(20) NOT NULL COMMENT '交易所ID',
  data_type_id bigint(20) NOT NULL COMMENT '数据类型ID',
  symbol_ids varchar(512) NOT NULL COMMENT '币对ID列表，以逗号分隔',
  PRIMARY KEY (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务表';

-- ============================================
-- 6. tb_index_config - 指数配置表
-- ============================================
DROP TABLE IF EXISTS tb_index_config;
CREATE TABLE tb_index_config (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL COMMENT '指数名称',
  strategy int(11) NOT NULL COMMENT '策略类型',
  formula varchar(512) NOT NULL COMMENT '公式',
  create_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指数配置表';

SET FOREIGN_KEY_CHECKS = 1;
