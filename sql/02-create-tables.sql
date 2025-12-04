-- ============================================
-- Broker Server Database Schema
-- ============================================
-- 从代码中提取的表结构定义

-- ============================================
-- 1. tb_sub_business_subject - 子业务科目表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_sub_business_subject (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  parent_subject INT(11) NOT NULL COMMENT '父流水类型',
  subject INT(11) NOT NULL COMMENT '流水类型',
  subject_name VARCHAR(255) NOT NULL COMMENT '流水名称',
  language VARCHAR(50) NOT NULL COMMENT '语言',
  status INT(11) NOT NULL DEFAULT 1 COMMENT '状态 1 启用 0 禁用',
  created BIGINT(20) NOT NULL COMMENT '创建时间',
  updated BIGINT(20) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_parent_subject (org_id, parent_subject, subject),
  KEY idx_org_subject_language (org_id, subject, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='子业务科目表';

-- ============================================
-- 2. tb_base_config - 基础配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_base_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  conf_group VARCHAR(255) NOT NULL COMMENT '配置组',
  conf_key VARCHAR(255) NOT NULL COMMENT '配置键',
  conf_value TEXT COMMENT '配置值',
  extra_value TEXT COMMENT '额外值',
  status INT(11) NOT NULL DEFAULT 1 COMMENT '状态',
  language VARCHAR(50) COMMENT '语言',
  admin_user_name VARCHAR(255) COMMENT '管理员用户名',
  created BIGINT(20) NOT NULL COMMENT '创建时间',
  updated BIGINT(20) NOT NULL COMMENT '更新时间',
  new_conf_value TEXT COMMENT '新配置值',
  new_extra_value TEXT COMMENT '新额外值',
  new_start_time BIGINT(20) COMMENT '新配置开始时间',
  new_end_time BIGINT(20) COMMENT '新配置结束时间',
  PRIMARY KEY (id),
  KEY idx_org_group_key (org_id, conf_group, conf_key),
  KEY idx_org_status (org_id, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='基础配置表';

-- ============================================
-- 3. tb_user_level_config - 用户等级配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_user_level_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  level_icon VARCHAR(255) COMMENT '等级图标',
  level_value VARCHAR(255) COMMENT '级别名称（多语言配置用json表示）',
  level_position BIGINT(20) COMMENT '级别排序，小值在前面',
  level_condition VARCHAR(255) COMMENT '等级配置（用字符串表示，使用时要解析）',
  spot_buy_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '现货买入Maker折扣',
  spot_buy_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '现货买入Taker折扣',
  spot_sell_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '现货卖出Maker折扣',
  spot_sell_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '现货卖出Taker折扣',
  option_buy_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '期权买入Maker折扣',
  option_buy_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '期权买入Taker折扣',
  option_sell_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '期权卖出Maker折扣',
  option_sell_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '期权卖出Taker折扣',
  contract_buy_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '合约买入Maker折扣',
  contract_buy_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '合约买入Taker折扣',
  contract_sell_maker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '合约卖出Maker折扣',
  contract_sell_taker_discount DECIMAL(10,4) DEFAULT 1.0000 COMMENT '合约卖出Taker折扣',
  withdraw_upper_limit_in_btc DECIMAL(20,8) DEFAULT 0.00000000 COMMENT 'BTC提现上限',
  cancel_otc24h_withdraw_limit INT(11) DEFAULT 0 COMMENT '取消OTC 24小时提现限制 1-是 0-否',
  is_base_level INT(11) DEFAULT 0 COMMENT '是否基础等级',
  invite_bonus_status INT(11) DEFAULT 1 COMMENT '邀请奖励状态',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  stat_date BIGINT(20) COMMENT '统计日期',
  leader_status INT(11) COMMENT '队长专用标志',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_org_status (org_id, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户等级配置表';

-- ============================================
-- 4. tb_third_party_app_open_function - 第三方应用开放功能表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_third_party_app_open_function (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  function_name VARCHAR(255) NOT NULL COMMENT '功能名称，如：get_user_info',
  show_name VARCHAR(500) COMMENT '显示名称（多语言json格式）',
  show_desc VARCHAR(1000) COMMENT '显示描述（多语言json格式）',
  language VARCHAR(50) COMMENT '语言',
  sort INT(11) COMMENT '排序',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_function_name (function_name),
  KEY idx_language (language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='第三方应用开放功能表';

-- ============================================
-- 5. tb_country - 国家表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_country (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  national_code VARCHAR(50) COMMENT '国家代码',
  domain_short_name VARCHAR(50) COMMENT '域名简称',
  custom_order INT(11) COMMENT '自定义排序',
  currency_code VARCHAR(10) COMMENT '货币代码',
  country_name VARCHAR(255) COMMENT '国家名称',
  for_area_code INT(11) COMMENT '用于区号',
  for_nationality INT(11) COMMENT '用于国籍',
  status INT(11) DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (id),
  KEY idx_national_code (national_code),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='国家表';

-- ============================================
-- 6. tb_country_detail - 国家详情表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_country_detail (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  country_id BIGINT(20) NOT NULL COMMENT '国家ID',
  country_name VARCHAR(255) NOT NULL COMMENT '国家名称',
  index_name VARCHAR(255) COMMENT '索引名称',
  language VARCHAR(50) NOT NULL COMMENT '语言',
  created BIGINT(20) COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_country_id (country_id),
  KEY idx_language (language),
  KEY idx_country_language (country_id, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='国家详情表';

-- ============================================
-- 7. tb_broker - 券商表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_broker (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  broker_name VARCHAR(255) COMMENT '券商名称',
  api_domain VARCHAR(255) COMMENT 'API域名',
  backup_api_domain VARCHAR(255) COMMENT '备用API域名',
  huawei_cloud_key VARCHAR(255) COMMENT '华为云密钥',
  huawei_cloud_domains VARCHAR(500) COMMENT '华为云域名',
  domain_random_key VARCHAR(255) COMMENT '域名随机密钥',
  private_key TEXT COMMENT '私钥',
  public_key TEXT COMMENT '公钥',
  key_version INT(11) COMMENT '密钥版本',
  app_request_sign_salt VARCHAR(255) COMMENT '应用请求签名盐',
  sign_name VARCHAR(255) COMMENT '签名名称',
  functions TEXT COMMENT '功能配置（JSON格式）',
  support_languages TEXT COMMENT '支持语言（JSON格式）',
  language_show_type INT(11) COMMENT '语言显示类型',
  org_api INT(11) COMMENT '券商是否有使用OrgApi的权限',
  login_need2fa INT(11) COMMENT '登录是否需要2FA',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  superior INT(11) COMMENT '上级',
  realtime_interval VARCHAR(50) COMMENT '实时间隔',
  time_zone VARCHAR(50) COMMENT '时区',
  filter_top_base_token INT(11) COMMENT '过滤顶级基础代币',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商表';

