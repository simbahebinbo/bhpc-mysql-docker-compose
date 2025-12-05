-- ============================================
-- Margin Server Database Schema
-- ============================================
-- 数据库: bh_server
-- 注意：margin-server 使用 bh_server 数据库
-- Margin 服务相关表
--
-- 重要：此文件需要与以下文件保持完全一致：
--   - margin-service/margin-server/sql/01-create-tables.sql
-- 修改此文件时，请同步更新上述文件，确保重启 MySQL 时不会出错。

USE bh_server;

-- ============================================
-- 1. tb_margin_token_config - 杠杆币种配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_token_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  org_id BIGINT(20) NOT NULL DEFAULT 1 COMMENT '券商id',
  exchange_id BIGINT(20) DEFAULT NULL COMMENT '交易所ID',
  token_id VARCHAR(100) NOT NULL COMMENT 'token id',
  convert_rate DECIMAL(65,18) NOT NULL DEFAULT 1.0 COMMENT '折算率',
  leverage TINYINT(4) NOT NULL DEFAULT 2 COMMENT '杠杆倍数',
  is_open INT(11) DEFAULT NULL COMMENT '是否开启',
  can_borrow TINYINT(4) NOT NULL DEFAULT 0 COMMENT '是否可借',
  max_quantity DECIMAL(65,18) NOT NULL DEFAULT 99999999.0 COMMENT '融币最大数量',
  min_quantity DECIMAL(65,18) NOT NULL DEFAULT 0.0 COMMENT '融币最小数量',
  quantity_precision TINYINT(4) NOT NULL DEFAULT 2 COMMENT '融币数量精度',
  show_interest_precision INT(11) DEFAULT NULL COMMENT '显示利息精度',
  repay_min_quantity DECIMAL(65,18) NOT NULL DEFAULT 2 COMMENT '最小还币数量',
  created BIGINT(20) NOT NULL COMMENT '创建时间',
  updated BIGINT(20) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY TOKEN_UNIQUE_ORG_ID_TOKEN (org_id, token_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='杠杆币种配置表';

-- ============================================
-- 2. tb_margin_interest - 币种利息表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_interest (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  org_id BIGINT(20) NOT NULL DEFAULT 1 COMMENT '券商id',
  token_id VARCHAR(100) NOT NULL COMMENT 'token id',
  interest DECIMAL(65,18) NOT NULL DEFAULT 0.000001 COMMENT '利率',
  interest_period INT(11) NOT NULL DEFAULT 3600 COMMENT '利率单位（秒）',
  calculation_period INT(11) NOT NULL DEFAULT 3600 COMMENT '计息周期',
  settlement_period INT(11) NOT NULL DEFAULT 3600 COMMENT '结息周期',
  show_interest DECIMAL(65,18) DEFAULT NULL COMMENT '显示利率',
  level_config_id BIGINT(20) DEFAULT 0 COMMENT '级别配置ID',
  created BIGINT(20) NOT NULL COMMENT '创建时间',
  updated BIGINT(20) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY TOKEN_UNIQUE_ORG_ID_TOKEN (org_id, token_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='币种利息表';

-- ============================================
-- 3. tb_margin_risk_config - 风控设置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_risk_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  org_id BIGINT(20) NOT NULL DEFAULT 1 COMMENT '券商id',
  withdraw_line DECIMAL(65,18) NOT NULL DEFAULT 2 COMMENT '提币线',
  warn_line DECIMAL(65,18) NOT NULL DEFAULT 2 COMMENT '预警线',
  append_line DECIMAL(65,18) NOT NULL DEFAULT 2 COMMENT '追加线',
  stop_line DECIMAL(65,18) NOT NULL DEFAULT 2 COMMENT '止损线',
  max_loan_limit DECIMAL(65,18) DEFAULT NULL COMMENT '最大借贷限额',
  max_loan_limit_vip1 DECIMAL(65,18) DEFAULT NULL COMMENT 'VIP1最大借贷限额',
  max_loan_limit_vip2 DECIMAL(65,18) DEFAULT NULL COMMENT 'VIP2最大借贷限额',
  max_loan_limit_vip3 DECIMAL(65,18) DEFAULT NULL COMMENT 'VIP3最大借贷限额',
  notify_type INT(11) DEFAULT NULL COMMENT '通知类型',
  notify_number VARCHAR(255) DEFAULT NULL COMMENT '通知号码',
  created BIGINT(20) NOT NULL COMMENT '创建时间',
  updated BIGINT(20) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY org_id_idx (org_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='风控设置表';

-- ============================================
-- 4. tb_margin_symbol_config - Margin 币对配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_symbol_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  org_id BIGINT(20) DEFAULT NULL COMMENT '券商ID',
  exchange_id BIGINT(20) DEFAULT NULL COMMENT '交易所ID',
  symbol_id VARCHAR(255) DEFAULT NULL COMMENT '币对ID',
  allow_trade INT(11) DEFAULT NULL COMMENT '是否允许交易',
  min_trade_quantity DECIMAL(65,18) DEFAULT NULL COMMENT '最小交易数量',
  min_trade_amount DECIMAL(65,18) DEFAULT NULL COMMENT '最小交易金额',
  min_price_precision DECIMAL(65,18) DEFAULT NULL COMMENT '最小价格精度',
  base_precision DECIMAL(65,18) DEFAULT NULL COMMENT '基础币种精度',
  quote_precision DECIMAL(65,18) DEFAULT NULL COMMENT '计价币种精度',
  created BIGINT(20) DEFAULT NULL COMMENT '创建时间',
  updated BIGINT(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='margin symbol config';

-- ============================================
-- 5. tb_margin_special_loan_limit - Margin 特殊借贷限额表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_special_loan_limit (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  org_id BIGINT(20) DEFAULT NULL COMMENT '券商ID',
  user_id BIGINT(20) DEFAULT NULL COMMENT '用户ID',
  account_id BIGINT(20) DEFAULT NULL COMMENT '账户ID',
  loan_limit DECIMAL(65,18) DEFAULT NULL COMMENT '借贷限额',
  is_open INT(11) DEFAULT NULL COMMENT '是否开启',
  created BIGINT(20) DEFAULT NULL COMMENT '创建时间',
  updated BIGINT(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='margin special loan limit';

-- ============================================
-- 6. tb_margin_loan_limit_vip_level - Margin VIP 级别借贷限额表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_loan_limit_vip_level (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  org_id BIGINT(20) DEFAULT NULL COMMENT '券商ID',
  broker_user_id BIGINT(20) DEFAULT NULL COMMENT '券商用户ID',
  account_id BIGINT(20) DEFAULT NULL COMMENT '账户ID',
  vip_level INT(11) DEFAULT NULL COMMENT 'VIP级别',
  created BIGINT(20) DEFAULT NULL COMMENT '创建时间',
  updated BIGINT(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='margin loan limit vip level';

-- ============================================
-- 7. tb_margin_force_close_record - Margin 强制平仓记录表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_force_close_record (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  force_id BIGINT(20) DEFAULT NULL COMMENT '强制平仓ID',
  org_id BIGINT(20) DEFAULT NULL COMMENT '券商ID',
  admin_user_id BIGINT(20) DEFAULT NULL COMMENT '管理员用户ID',
  account_id BIGINT(20) DEFAULT NULL COMMENT '账户ID',
  safety DECIMAL(65,18) DEFAULT NULL COMMENT '安全系数',
  all_position DECIMAL(65,18) DEFAULT NULL COMMENT '总持仓',
  all_loan DECIMAL(65,18) DEFAULT NULL COMMENT '总借贷',
  force_type INT(11) DEFAULT NULL COMMENT '强制平仓类型',
  deal_status INT(11) DEFAULT NULL COMMENT '处理状态',
  force_desc VARCHAR(500) DEFAULT NULL COMMENT '强制平仓描述',
  created BIGINT(20) DEFAULT NULL COMMENT '创建时间',
  updated BIGINT(20) DEFAULT NULL COMMENT '更新时间',
  last_safety DECIMAL(65,18) DEFAULT NULL COMMENT '上次安全系数',
  last_cal_time BIGINT(20) DEFAULT NULL COMMENT '上次计算时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='margin force close record';

-- ============================================
-- 8. tb_margin_risk_black_list - Margin 风控黑名单表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_margin_risk_black_list (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  org_id BIGINT(20) DEFAULT NULL COMMENT '券商ID',
  conf_group VARCHAR(255) DEFAULT NULL COMMENT '配置组',
  user_id BIGINT(20) DEFAULT NULL COMMENT '用户ID',
  account_id BIGINT(20) DEFAULT NULL COMMENT '账户ID',
  admin_user_name VARCHAR(255) DEFAULT NULL COMMENT '管理员用户名',
  reason VARCHAR(500) DEFAULT NULL COMMENT '原因',
  created BIGINT(20) DEFAULT NULL COMMENT '创建时间',
  updated BIGINT(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_conf_account (org_id, conf_group, account_id),
  KEY idx_conf_group (conf_group)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='margin risk black list';

