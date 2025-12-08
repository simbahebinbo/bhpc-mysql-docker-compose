-- ============================================
-- Broker Server Database Schema
-- ============================================
-- 数据库: broker

USE broker;

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

-- ============================================
-- 8. tb_kyc_level - KYC等级表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_kyc_level (
  level_id INT(11) NOT NULL COMMENT '等级ID',
  level_name VARCHAR(255) COMMENT '等级名称',
  precondition VARCHAR(500) COMMENT '前置条件',
  memo VARCHAR(500) COMMENT '备注',
  display_level VARCHAR(255) COMMENT '显示等级',
  status INT(11) COMMENT '状态 1-启用 2-禁用',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (level_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='KYC等级表';

-- ============================================
-- 9. tb_kyc_level_config - KYC等级配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_kyc_level_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  country_id BIGINT(20) NOT NULL COMMENT '国家ID',
  kyc_level INT(11) NOT NULL COMMENT 'KYC等级',
  allow_otc INT(11) COMMENT '是否允许OTC',
  face_compare INT(11) COMMENT '是否人脸比对',
  otc_daily_limit DECIMAL(20,8) COMMENT 'OTC每日限额',
  otc_limit_currency VARCHAR(50) COMMENT 'OTC限额币种',
  withdraw_daily_limit DECIMAL(20,8) COMMENT '提现每日限额',
  withdraw_limit_token VARCHAR(50) COMMENT '提现限额代币',
  memo VARCHAR(500) COMMENT '备注',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_country_level (org_id, country_id, kyc_level),
  KEY idx_org_country (org_id, country_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='KYC等级配置表';

-- ============================================
-- 10. tb_broker_kyc_config - 券商KYC配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_broker_kyc_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  country_id BIGINT(20) NOT NULL COMMENT '国家ID',
  second_kyc_level INT(11) COMMENT '二级KYC等级',
  webank_app_id VARCHAR(255) COMMENT '微众App ID',
  webank_app_secret VARCHAR(255) COMMENT '微众App Secret',
  webank_android_license TEXT COMMENT '微众Android License（JSON格式）',
  webank_ios_license TEXT COMMENT '微众iOS License（JSON格式）',
  app_name VARCHAR(255) COMMENT '应用名称',
  company_name VARCHAR(255) COMMENT '公司名称',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_country (org_id, country_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商KYC配置表';

-- ============================================
-- 11. tb_card_type - 证件类型表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_card_type (
  type_id INT(11) NOT NULL COMMENT '证件类型ID',
  type_name VARCHAR(255) COMMENT '证件名称',
  status INT(11) COMMENT '状态',
  PRIMARY KEY (type_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='证件类型表';

-- ============================================
-- 12. tb_card_type_locale - 证件类型本地化表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_card_type_locale (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  card_type_id INT(11) NOT NULL COMMENT '证件类型ID',
  locale VARCHAR(50) NOT NULL COMMENT '语言',
  name VARCHAR(255) COMMENT '证件名称',
  PRIMARY KEY (id),
  KEY idx_card_type_locale (card_type_id, locale)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='证件类型本地化表';

-- ============================================
-- 13. tb_otc_third_party_chain - OTC第三方链配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_otc_third_party_chain (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  token_id VARCHAR(64) NOT NULL COMMENT '币种ID',
  chain_type VARCHAR(64) NOT NULL COMMENT '链类型',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_org_token (org_id, token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OTC第三方链配置表';

-- ============================================
-- 14. tb_otc_third_party - OTC第三方配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_otc_third_party (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  third_party_id BIGINT(20) NOT NULL COMMENT '第三方ID',
  third_party_name VARCHAR(255) COMMENT '第三方名称',
  end_point VARCHAR(500) COMMENT '端点地址',
  api_key VARCHAR(255) COMMENT 'API密钥',
  secret VARCHAR(255) COMMENT '密钥',
  bind_org_id BIGINT(20) COMMENT '绑定组织ID',
  bind_user_id BIGINT(20) COMMENT '绑定用户ID',
  bind_account_id BIGINT(20) COMMENT '绑定账户ID',
  control_type INT(11) COMMENT '控制类型',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  success_url VARCHAR(500) COMMENT '成功URL',
  failure_url VARCHAR(500) COMMENT '失败URL',
  cancel_url VARCHAR(500) COMMENT '取消URL',
  icon_url VARCHAR(500) COMMENT '图标URL',
  side INT(11) NOT NULL COMMENT '方向 1-买入 2-卖出',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_org_third_party_side (org_id, third_party_id, side)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OTC第三方配置表';

-- ============================================
-- 15. tb_otc_third_party_symbol - OTC第三方币对配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_otc_third_party_symbol (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  otc_symbol_id BIGINT(20) NOT NULL COMMENT 'OTC币对ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  third_party_id BIGINT(20) NOT NULL COMMENT '第三方ID',
  token_id VARCHAR(64) COMMENT '币种ID',
  currency_id VARCHAR(64) COMMENT '法币ID',
  payment_id BIGINT(20) COMMENT '支付方式ID',
  payment_type VARCHAR(64) COMMENT '支付类型',
  payment_name VARCHAR(255) COMMENT '支付名称',
  fee DECIMAL(20,8) COMMENT '手续费',
  min_amount DECIMAL(20,8) COMMENT '最小金额',
  max_amount DECIMAL(20,8) COMMENT '最大金额',
  side INT(11) NOT NULL COMMENT '方向 1-买入 2-卖出',
  status INT(11) COMMENT '状态',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_org_otc_symbol_third_party_side (org_id, otc_symbol_id, third_party_id, side)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OTC第三方币对配置表';

-- ============================================
-- 16. tb_symbol - 币对表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_symbol (
  id BIGINT(20) NOT NULL COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  exchange_id BIGINT(20) NOT NULL COMMENT '交易所ID',
  symbol_id VARCHAR(64) NOT NULL COMMENT '币对ID',
  symbol_name VARCHAR(255) COMMENT '币对名称',
  base_token_id VARCHAR(64) COMMENT '基础币种ID',
  base_token_name VARCHAR(255) COMMENT '基础币种名称',
  quote_token_id VARCHAR(64) COMMENT '计价币种ID',
  quote_token_name VARCHAR(255) COMMENT '计价币种名称',
  allow_trade INT(11) COMMENT '允许交易 币对管理 禁买+禁卖 取代允许交易字段',
  status INT(11) COMMENT '状态 是否启用',
  ban_sell_status INT(11) COMMENT '打新状态 0-关闭打新 1-开启打新',
  white_account_id_list TEXT COMMENT '白名单 逗号分隔',
  custom_order INT(11) COMMENT '自定义排序',
  index_show INT(11) COMMENT '首页显示',
  index_show_order INT(11) COMMENT '首页显示排序',
  need_preview_check INT(11) COMMENT '需要预览检查',
  open_time BIGINT(20) COMMENT '开盘时间',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  category INT(11) COMMENT '类别 1-主类别 2-创新类别 3-期权 4-期货',
  index_recommend_order INT(11) COMMENT '首页推荐排序',
  is_aggregate INT(11) COMMENT '是否聚合',
  show_status INT(11) COMMENT '前端显示状态 1-显示 0-隐藏',
  ban_buy_status INT(11) COMMENT '禁买状态 0-关闭禁买 1-开启禁买',
  allow_margin INT(11) COMMENT '允许杠杆 0-未开通杠杆 1-开通杠杆',
  filter_time BIGINT(20) COMMENT '过滤历史K线时间',
  filter_top_status INT(11) COMMENT 'topN涨幅榜展示状态 1-过滤 0-不过滤',
  label_id BIGINT(20) COMMENT '标签ID',
  hide_from_openapi INT(11) COMMENT '从OpenAPI隐藏',
  forbid_openapi_trade INT(11) COMMENT '禁止OpenAPI交易',
  allow_plan INT(11) COMMENT '是否允许计划委托 0-不允许 1-允许',
  extra_tag VARCHAR(255) COMMENT '额外标签',
  extra_config TEXT COMMENT '额外配置',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_exchange_symbol (exchange_id, symbol_id),
  KEY idx_org_symbol (org_id, symbol_id),
  KEY idx_org_status (org_id, status),
  KEY idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='币对表';

-- ============================================
-- 17. tb_admin_push_task - 推送任务基本信息表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_admin_push_task (
  task_id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  name VARCHAR(255) COMMENT '推送名称',
  push_category INT(11) COMMENT '推送类别 1-通知',
  range_type INT(11) COMMENT '推送范围类型',
  user_ids TEXT COMMENT '用户ID列表（可能是个大数据，注意排除）',
  cycle_type INT(11) COMMENT '计划执行类型 0-定时一次执行 1-周期性每天执行 2-周期性每周执行',
  cycle_day_of_week INT(11) COMMENT '每周几执行',
  first_action_time BIGINT(20) COMMENT '第一次预计执行时间',
  execute_time BIGINT(20) COMMENT '执行时间',
  status INT(11) COMMENT '状态 0-未执行 1-执行中 2-此轮任务执行完成 3-此task结束 4-取消',
  action_time BIGINT(20) COMMENT '可变动的执行时间，周期性的为下一次执行时间',
  expire_time BIGINT(20) COMMENT '失效时间',
  default_language VARCHAR(50) COMMENT '默认语言',
  remark VARCHAR(500) COMMENT '备注（用于正常取消，和非正常取消的备注）',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (task_id),
  KEY idx_org_id (org_id),
  KEY idx_status (status),
  KEY idx_action_time (action_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='推送任务基本信息表';

-- ============================================
-- 18. tb_broker_task_config - 券商任务配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_broker_task_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  exchange_id BIGINT(20) COMMENT '交易所ID',
  symbol_id VARCHAR(64) COMMENT '币对ID',
  token_id VARCHAR(64) COMMENT '币种ID',
  type INT(11) COMMENT '类型 1-币币定时开盘 2-...',
  action_time BIGINT(20) COMMENT '下次开始执行的时间',
  action_content TEXT COMMENT '执行任务描述 json格式',
  status INT(11) COMMENT '状态 0-失效 1-待执行任务 2-已执行完毕',
  daily_task INT(11) COMMENT '是否每天执行 1-每天执行 0-一次性任务',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  admin_user_name VARCHAR(255) COMMENT '管理员用户名',
  remark VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_status (status),
  KEY idx_action_time (action_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商任务配置表';

-- ============================================
-- 19. tb_withdraw_address - 提现地址表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_withdraw_address (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  user_id BIGINT(20) NOT NULL COMMENT '用户ID',
  token_id VARCHAR(64) NOT NULL COMMENT '币种ID',
  chain_type VARCHAR(64) COMMENT '链类型',
  token_name VARCHAR(255) COMMENT '币种名称',
  address VARCHAR(255) NOT NULL COMMENT '地址',
  address_ext VARCHAR(255) COMMENT '地址扩展',
  remark VARCHAR(500) COMMENT '备注',
  status INT(11) DEFAULT 0 COMMENT '状态 0-有效 其他-无效',
  request_num INT(11) DEFAULT 0 COMMENT '请求次数',
  success_num INT(11) DEFAULT 0 COMMENT '成功次数',
  created BIGINT(20) COMMENT '创建时间',
  updated BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_user_id (user_id),
  KEY idx_user_token (user_id, token_id),
  KEY idx_user_status (user_id, status),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提现地址表';

-- ============================================
-- 20. tb_trade_competition - 交易大赛配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_trade_competition (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  competition_code VARCHAR(255) NOT NULL COMMENT '比赛编码',
  symbol_id VARCHAR(64) COMMENT '币对ID',
  start_time DATETIME COMMENT '开始时间',
  end_time DATETIME COMMENT '结束时间',
  type INT(11) COMMENT '类型',
  status INT(11) COMMENT '状态 0-初始化 1-正在比赛 2-已经结束 3-已无效',
  effective_quantity INT(11) COMMENT '有效数量',
  receive_token_id VARCHAR(64) COMMENT '接收币种ID',
  receive_token_name VARCHAR(255) COMMENT '接收币种名称',
  receive_token_amount DECIMAL(20,8) COMMENT '接收币种数量',
  create_time DATETIME COMMENT '创建时间',
  update_time DATETIME COMMENT '更新时间',
  rank_types VARCHAR(255) COMMENT '排名类型',
  is_reverse INT(11) COMMENT '是否反向 0-普通单个合约比赛 1-正向组团比赛 2-反向组团比赛',
  PRIMARY KEY (id),
  UNIQUE KEY uk_org_competition_code (org_id, competition_code),
  KEY idx_org_id (org_id),
  KEY idx_status (status),
  KEY idx_start_end_time (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易大赛配置表';

-- ============================================
-- 21. tb_activity_experience_fund - 体验金活动表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_activity_experience_fund (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  type INT(11) COMMENT '类型 1-合约体验金',
  title VARCHAR(255) COMMENT '标题',
  description TEXT COMMENT '描述',
  broker_id BIGINT(20) COMMENT '券商ID',
  org_account_id BIGINT(20) COMMENT '机构账户ID',
  org_account_type INT(11) COMMENT '机构账户类型',
  token_id VARCHAR(64) COMMENT '空投币种ID',
  token_amount DECIMAL(20,8) COMMENT '空投币种的数量',
  redeem_type INT(11) COMMENT '赎回类型 0-不赎回 1-到期赎回',
  redeem_time BIGINT(20) COMMENT '赎回时间',
  redeem_amount DECIMAL(20,8) COMMENT '赎回币种的数量',
  deadline BIGINT(20) COMMENT '截止日期 过了这个日期无论收回多少都结束任务',
  user_count INT(11) COMMENT '发送的用户总数',
  transfer_asset_amount DECIMAL(20,8) COMMENT '发送token总数',
  status INT(11) COMMENT '状态 0-初始化未执行 1-赠送完毕 2-赠送失败 3-赎回成功终态',
  failed_reason VARCHAR(500) COMMENT '空投失败说明',
  admin_user_name VARCHAR(255) COMMENT '管理员用户名',
  created_at BIGINT(20) COMMENT '创建时间',
  updated_at BIGINT(20) COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_broker_id (broker_id),
  KEY idx_status (status),
  KEY idx_redeem_time (redeem_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='体验金活动表';

-- ============================================
-- 22. tb_data_push_config - 数据推送配置表
-- ============================================
CREATE TABLE IF NOT EXISTS tb_data_push_config (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  org_id BIGINT(20) NOT NULL COMMENT '组织ID',
  call_back_url VARCHAR(500) COMMENT '回调URL',
  `key` VARCHAR(255) COMMENT '配置键',
  `value` VARCHAR(500) COMMENT '配置值',
  status INT(11) COMMENT '状态 0-禁用 1-启用',
  encrypt INT(11) COMMENT '是否加密 0-不加密 1-加密',
  futures INT(11) COMMENT '是否开启期货推送 0-不开启 1-开启',
  futures_call_back_url VARCHAR(500) COMMENT '期货推送URL',
  retry_count INT(11) COMMENT '重试次数配置',
  otc_status INT(11) COMMENT 'OTC是否callback 0-不推送 1-推送',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据推送配置表';
