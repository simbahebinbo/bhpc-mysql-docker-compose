-- ============================================
-- BH Server Database Schema
-- ============================================
-- 数据库: bh_server


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

-- ============================================
-- 5. tb_org - 组织表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_org (
  org_id BIGINT(20) NOT NULL COMMENT '平台生成',
  name VARCHAR(32) NOT NULL COMMENT '注册时输入的字符ID，唯一索引, 最长32字符',
  full_name VARCHAR(255) DEFAULT NULL COMMENT '全名',
  group_name VARCHAR(32) DEFAULT NULL COMMENT '组名，可为空',
  subject_dn VARCHAR(255) DEFAULT NULL COMMENT 'ssl 证书 DN',
  saas_id BIGINT(20) DEFAULT NULL COMMENT '创建 org 的 saasId, 可为空',
  role TINYINT(4) DEFAULT NULL COMMENT '有枚举值。可以是 broker exchange 等',
  saas_enable TINYINT(4) DEFAULT 0 COMMENT 'saas 控制，默认为0，1为开启',
  platform_disable TINYINT(4) DEFAULT 0 COMMENT '平台一键禁用，默认为0，1为禁用。为1 则不能开启enable',
  status TINYINT(4) DEFAULT NULL COMMENT '状态',
  area_id BIGINT(20) DEFAULT NULL COMMENT '地区 ID',
  domain_id INT(11) DEFAULT NULL COMMENT '域名ID',
  support_cold_wallet TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否支持冷钱包',
  is_private TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否私有',
  created_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '创建时间',
  updated_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (org_id),
  UNIQUE KEY name_idx (name) COMMENT '字符ID 唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='组织表';

-- ============================================
-- 6. tb_symbol - 币对表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_symbol (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  symbol_id VARCHAR(255) DEFAULT NULL COMMENT '币对ID',
  symbol_name VARCHAR(255) NOT NULL COMMENT '币对名称',
  base_token_id VARCHAR(255) NOT NULL COMMENT '基础币种ID',
  quote_token_id VARCHAR(255) NOT NULL COMMENT '计价币种ID',
  symbol_alias VARCHAR(255) DEFAULT NULL COMMENT '币对别名',
  status TINYINT(4) DEFAULT NULL COMMENT '状态',
  min_trade_quantity DECIMAL(65,18) NOT NULL COMMENT '单次交易最小交易base的数量',
  min_trade_amount DECIMAL(65,18) NOT NULL COMMENT '最小交易额',
  min_price_precision DECIMAL(65,18) NOT NULL COMMENT '每次价格变动，最小的变动单位',
  digit_merge_list VARCHAR(64) DEFAULT NULL COMMENT '深度合并。格式：0.01,0.0001,0.000001',
  base_precision DECIMAL(65,18) DEFAULT NULL COMMENT '基础币种精度',
  quote_precision DECIMAL(65,18) DEFAULT NULL COMMENT '计价币种精度',
  allow_trade TINYINT(4) NOT NULL COMMENT '允许交易。1：允许',
  is_published TINYINT(4) NOT NULL DEFAULT 1 COMMENT '上架下架。0：下架 1：上架',
  online_time TIMESTAMP(3) NULL DEFAULT NULL COMMENT '上线时间',
  security_type TINYINT(4) NOT NULL DEFAULT 0 COMMENT '证券类型',
  futures_multiplier DECIMAL(65,18) NOT NULL DEFAULT 0 COMMENT '期货乘数',
  funding_lower_bound DECIMAL(65,18) NOT NULL DEFAULT 0 COMMENT '资金费率下限',
  funding_upper_bound DECIMAL(65,18) NOT NULL DEFAULT 0 COMMENT '资金费率上限',
  created_at TIMESTAMP(3) NOT NULL COMMENT '创建时间',
  updated_at TIMESTAMP(3) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='币对表';

-- ============================================
-- 7. tb_exchange_symbol - 交易所币对表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_exchange_symbol (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  exchange_id BIGINT(20) NOT NULL COMMENT '币对所属交易所ID',
  symbol_id VARCHAR(255) NOT NULL COMMENT '币对',
  match_type TINYINT(4) NOT NULL COMMENT '0: self_match. 1: forward',
  match_exchange_id BIGINT(20) DEFAULT NULL COMMENT '真正执行撮合的交易所ID',
  host VARCHAR(255) NOT NULL COMMENT '主机地址',
  port INT(11) NOT NULL COMMENT '端口',
  service VARCHAR(255) DEFAULT NULL COMMENT '服务名称，用于HA',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='db 表放在平台，后续的写入要放在交易所的后台中。读取主要是 trade 读';

-- 插入初始数据：tb_exchange_symbol 至少需要一条记录
INSERT IGNORE INTO tb_exchange_symbol (exchange_id, symbol_id, match_type, host, port, service) 
VALUES (1, 'BTCUSDT', 0, 'localhost', 8080, 'bh-match-1');

-- ============================================
-- 8. tb_futures_insurance_fund_config - 期货保险基金配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_futures_insurance_fund_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  exchange_id BIGINT(20) NOT NULL COMMENT '交易所ID',
  symbol_id VARCHAR(255) NOT NULL COMMENT '币对',
  token_id VARCHAR(255) DEFAULT NULL COMMENT '币种',
  income_account_id BIGINT(20) DEFAULT NULL COMMENT '收入账户 account id',
  funding_account_id BIGINT(20) DEFAULT NULL COMMENT '保险基金账户 account id',
  funding_min_balance DECIMAL(65,18) DEFAULT NULL COMMENT '保险基金账户最小余额警戒线',
  funding_maintaining_balance DECIMAL(65,18) DEFAULT NULL COMMENT '保险基金账户维持余额',
  created_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '创建时间',
  updated_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY exchange_symbol_idx (exchange_id, symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期货保险基金配置表';

-- ============================================
-- 9. tb_broker_maker_bonus_config - 券商Maker奖励配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_broker_maker_bonus_config (
  id INT(11) NOT NULL AUTO_INCREMENT,
  broker_id BIGINT(20) NOT NULL COMMENT '券商ID',
  symbol_id VARCHAR(255) NOT NULL COMMENT '币对',
  maker_bonus_rate DECIMAL(65,18) DEFAULT NULL COMMENT 'Maker奖励费率',
  min_interest_fee_rate DECIMAL(65,18) DEFAULT NULL COMMENT '最小利息费率',
  min_taker_fee_rate DECIMAL(65,18) DEFAULT NULL COMMENT '最小Taker费率',
  created_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '创建时间',
  updated_at TIMESTAMP(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY broker_symbol_idx (broker_id, symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='券商Maker奖励配置表';

-- ============================================
-- 10. tb_token_option - Token期权扩展表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_token_option (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  token_id VARCHAR(255) NOT NULL COMMENT '期权名称',
  strike_price DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '行权价',
  issue_date DATETIME NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '生效/上线日期',
  settlement_date DATETIME NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '到期/交割时间',
  is_call TINYINT(1) NOT NULL COMMENT 'call or put',
  max_pay_off DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '最大赔付',
  coin_token VARCHAR(255) NOT NULL COMMENT '交易(quote)token',
  index_token VARCHAR(255) NOT NULL COMMENT '标的指数(symbol)',
  position_limit DECIMAL(20,8) NOT NULL DEFAULT '100.00000000' COMMENT '单帐户仓位限制,做多做空相同',
  underlying_id VARCHAR(255) DEFAULT '' COMMENT '标的id',
  created_at TIMESTAMP(3) NOT NULL,
  updated_at TIMESTAMP(3) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY token_id_idx (token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Token期权扩展表';

-- ============================================
-- 11. tb_symbol_futures - 期货币对扩展表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_symbol_futures (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  symbol_id VARCHAR(255) NOT NULL COMMENT '期货名称',
  issue_date DATETIME NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '生效/上线日期',
  settlement_date DATETIME NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '到期/交割时间',
  display_token VARCHAR(50) NOT NULL DEFAULT '' COMMENT '显示用的估价token',
  underlying_id VARCHAR(255) DEFAULT NULL COMMENT '标的id',
  currency VARCHAR(25) NOT NULL DEFAULT '' COMMENT '计价单位(token_id)',
  currency_display VARCHAR(25) NOT NULL DEFAULT '' COMMENT '显示价格单位',
  contract_multiplier DECIMAL(65,8) UNSIGNED NOT NULL DEFAULT '0.00000000' COMMENT '合约乘数',
  limit_down_in_trading_hours DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '交易时段内下跌限价',
  limit_up_in_trading_hours DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '交易时段内上涨限价',
  limit_down_out_trading_hours DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '交易时段外下跌限价',
  limit_up_out_trading_hours DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '交易时段外上涨限价',
  max_leverage DECIMAL(65,8) NOT NULL DEFAULT '0.00000000' COMMENT '最大杠杆',
  leverage_range VARCHAR(100) NOT NULL DEFAULT '' COMMENT '杠杆范围',
  over_price_range VARCHAR(100) NOT NULL DEFAULT '' COMMENT '超价浮动范围',
  market_price_range VARCHAR(100) NOT NULL DEFAULT '' COMMENT '市价浮动范围',
  is_perpetual_swap TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否永续合约',
  index_token VARCHAR(255) DEFAULT NULL COMMENT '指数名称',
  display_index_token VARCHAR(255) DEFAULT NULL COMMENT '用于页面显示指数价格(正向=index_token,反则反之)',
  funding_lower_bound DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '永续合约资金费率下限',
  funding_upper_bound DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '永续合约资金费率上限',
  funding_interest DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '永续合约两币种借贷利率之和',
  is_reverse TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否反向合约',
  margin_precision DECIMAL(65,8) NOT NULL DEFAULT '0.00000001' COMMENT '用户修改保证金的最小精度',
  owner_exchange_id BIGINT(20) DEFAULT NULL COMMENT '归属交易所id',
  safe_price_bound DECIMAL(65,18) DEFAULT NULL COMMENT '安全价格浮动比率（用于爆仓和市价平仓价格保护）',
  ref_price_type INT(11) DEFAULT NULL COMMENT '引用价格（0-指数价格，1-标记价格）',
  symbol_name_locale_json TEXT DEFAULT NULL COMMENT '币对名称多语言JSON',
  display_underlying_id VARCHAR(255) DEFAULT NULL COMMENT '期货名义标的ID（用于对外展示，忽略正反向区别）',
  created_at TIMESTAMP(3) NOT NULL,
  updated_at TIMESTAMP(3) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY token_id_idx (symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期货币对扩展表';

-- ============================================
-- 12. tb_underlying - 标地表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_underlying (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  underlying_id VARCHAR(255) NOT NULL DEFAULT '' COMMENT '标的id',
  type TINYINT(4) NOT NULL COMMENT '标的类型，1=期权 2=期货',
  parent_underlying_id VARCHAR(255) DEFAULT NULL COMMENT '父级标的id',
  levels INT(4) NOT NULL DEFAULT '0' COMMENT '级别',
  tag VARCHAR(255) DEFAULT NULL COMMENT '标的标签 explore=体验区 默认为NULL',
  PRIMARY KEY (id),
  UNIQUE KEY underlying_id_idx (underlying_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标地表';

-- ============================================
-- 13. tb_futures_risk_limit - 期货风险限额字典表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_futures_risk_limit (
  risk_limit_id BIGINT(20) NOT NULL COMMENT '风险限额id',
  underlying_id VARCHAR(255) DEFAULT NULL COMMENT '标的id',
  symbol_id VARCHAR(255) DEFAULT NULL COMMENT '合约ID',
  risk_limit_amount DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '风险限额(最大持仓量)',
  maintain_margin DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '维持保证金率。（解释： 0.03 = 3%）',
  initial_margin DECIMAL(65,18) NOT NULL DEFAULT '0.000000000000000000' COMMENT '起始保证金率。（解释： 0.1 = 10%）',
  created_at TIMESTAMP(3) NULL DEFAULT NULL,
  updated_at TIMESTAMP(3) NULL DEFAULT NULL,
  PRIMARY KEY (risk_limit_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期货风险限额字典表';
