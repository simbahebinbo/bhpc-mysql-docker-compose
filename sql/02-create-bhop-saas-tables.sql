-- ============================================
-- Bhop SaaS Database Schema
-- ============================================
-- 数据库: bhop_saas
-- 用于 saas-admin 服务

USE bhop_saas;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. tb_broker - 券商表
-- ============================================
DROP TABLE IF EXISTS tb_broker;
CREATE TABLE tb_broker (
   id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'pk',
   broker_id bigint(20) NOT NULL COMMENT '券商id',
   instance_id bigint(20) NULL COMMENT '实例id',
   name varchar(100) DEFAULT NULL COMMENT '券商简称',
   company varchar(100) DEFAULT NULL COMMENT '券商全称/公司名',
   email varchar(100) DEFAULT NULL COMMENT '邮箱',
   phone varchar(100) DEFAULT NULL COMMENT '联系电话',
   host varchar(100) DEFAULT NULL COMMENT '券商域名',
   earnest_address varchar(500) DEFAULT NULL COMMENT '保证金地址',
   contact varchar(100) DEFAULT NULL COMMENT '联系人',
   basic_info varchar(100) DEFAULT NULL COMMENT '基础信息',
   remark varchar(500) DEFAULT NULL COMMENT '备注',
   api_domain varchar(255) DEFAULT NULL COMMENT 'API域名',
   is_bind tinyint(4) DEFAULT NULL COMMENT '是否绑定身份',
   enabled tinyint(4) DEFAULT NULL COMMENT '是否启用',
   register_option int(11) DEFAULT NULL COMMENT '注册选项',
   created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   KEY idx_broker_id (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商表';

-- ============================================
-- 2. tb_exchange_info - 交易所信息表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_info;
CREATE TABLE tb_exchange_info (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) NOT NULL DEFAULT '0' COMMENT '交易平台所使用的id',
  exchange_name varchar(255) DEFAULT NULL COMMENT '交易所简称',
  cluster_name varchar(255) DEFAULT NULL COMMENT '集群名称',
  company varchar(200) DEFAULT NULL COMMENT '公司名称',
  email varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  contact_name varchar(255) DEFAULT NULL COMMENT '联系人姓名',
  contact_telephone varchar(50) DEFAULT NULL COMMENT '联系人电话',
  pay_earnest tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否缴纳保证金',
  remark varchar(500) DEFAULT NULL COMMENT '备注信息',
  status tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态值',
  created_at bigint(20) NOT NULL COMMENT '用户注册时间',
  created_ip varchar(20) DEFAULT NULL COMMENT '用户注册IP',
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除: 1=删除 0=正常',
  updated_at bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易所信息表';

-- ============================================
-- 3. tb_exchange_instance - 交易所实例表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_instance;
CREATE TABLE tb_exchange_instance (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_name varchar(255) DEFAULT NULL COMMENT '交易所名称',
  exchange_id bigint(20) NOT NULL COMMENT '交易所id',
  cluster_name varchar(255) DEFAULT NULL COMMENT '集群名称',
  instance_name varchar(255) DEFAULT NULL COMMENT '实例名称',
  gateway_url varchar(255) DEFAULT NULL COMMENT '网关URL',
  admin_internal_api_url varchar(255) DEFAULT NULL COMMENT '管理内部API URL',
  admin_web_domain_pattern varchar(255) DEFAULT NULL COMMENT '管理Web域名模式',
  admin_web_protocal varchar(50) DEFAULT NULL COMMENT '管理Web协议',
  admin_web_port int(11) DEFAULT NULL COMMENT '管理Web端口',
  region varchar(100) DEFAULT NULL COMMENT '区域',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  created_at timestamp NULL DEFAULT NULL,
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除: 1=删除 0=正常',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易所实例表';

-- ============================================
-- 4. tb_exchange_instance_detail - 交易所实例详情表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_instance_detail;
CREATE TABLE tb_exchange_instance_detail (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  instance_id bigint(20) NOT NULL COMMENT '实例ID',
  exchange_id bigint(20) NOT NULL COMMENT '交易所ID',
  exchange_name varchar(255) DEFAULT NULL COMMENT '交易所名称',
  cluster_name varchar(255) DEFAULT NULL COMMENT '集群名称',
  instance_name varchar(255) DEFAULT NULL COMMENT '实例名称',
  gateway_url varchar(255) DEFAULT NULL COMMENT '网关URL',
  admin_web_url varchar(255) DEFAULT NULL COMMENT '管理Web URL',
  admin_internal_api_url varchar(255) DEFAULT NULL COMMENT '管理内部API URL',
  admin_web_domain varchar(255) DEFAULT NULL COMMENT '管理Web域名',
  status int(11) DEFAULT NULL COMMENT '状态：0-dns设置中 1-dns设置完成发送了邮件 2-邮件设置成功',
  forbid_access int(11) DEFAULT NULL COMMENT '禁止访问',
  created_at timestamp NULL DEFAULT NULL,
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除: 1=删除 0=正常',
  PRIMARY KEY (id),
  KEY idx_instance_id (instance_id),
  KEY idx_exchange_id (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易所实例详情表';

-- ============================================
-- 5. tb_broker_instance - 券商实例表
-- ============================================
DROP TABLE IF EXISTS tb_broker_instance;
CREATE TABLE tb_broker_instance (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  instance_name varchar(255) NOT NULL COMMENT '实例名称',
  admin_internal_api_url varchar(255) DEFAULT NULL COMMENT '管理内部API URL',
  admin_web_domain_pattern varchar(255) DEFAULT NULL COMMENT '管理Web域名模式',
  broker_web_domain_pattern varchar(255) DEFAULT NULL COMMENT '券商Web域名模式',
  admin_web_protocal varchar(50) DEFAULT NULL COMMENT '管理Web协议',
  admin_web_port int(11) DEFAULT NULL COMMENT '管理Web端口',
  region varchar(100) DEFAULT NULL COMMENT '区域',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  status int(11) DEFAULT NULL COMMENT '状态',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商实例表';

-- ============================================
-- 6. tb_broker_instance_detail - 券商实例详情表
-- ============================================
DROP TABLE IF EXISTS tb_broker_instance_detail;
CREATE TABLE tb_broker_instance_detail (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  instance_id bigint(20) NOT NULL COMMENT '实例ID',
  broker_id bigint(20) NOT NULL COMMENT '券商ID',
  broker_name varchar(255) DEFAULT NULL COMMENT '券商名称',
  broker_web_domain varchar(255) DEFAULT NULL COMMENT '券商Web域名',
  admin_web_url varchar(255) DEFAULT NULL COMMENT '管理Web URL',
  admin_internal_api_url varchar(255) DEFAULT NULL COMMENT '管理内部API URL',
  admin_web_domain varchar(255) DEFAULT NULL COMMENT '管理Web域名',
  status int(11) DEFAULT NULL COMMENT '状态：0-dns设置中 1-dns设置完成发送了邮件 2-邮件设置成功',
  frontend_customer int(11) DEFAULT NULL COMMENT '券商前端自定义',
  forbid_access int(11) DEFAULT NULL COMMENT '禁止访问',
  due_time bigint(20) DEFAULT NULL COMMENT '过期时间，0-代表未设置',
  created_at timestamp NULL DEFAULT NULL,
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除: 1=删除 0=正常',
  PRIMARY KEY (id),
  KEY idx_instance_id (instance_id),
  KEY idx_broker_id (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商实例详情表';

-- ============================================
-- 7. tb_exchange_op_record - 交易所操作记录表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_op_record;
CREATE TABLE tb_exchange_op_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  saas_exchange_id bigint(20) DEFAULT NULL COMMENT 'SaaS交易所ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  op_type tinyint(4) DEFAULT NULL COMMENT '操作类型',
  req_content varchar(500) DEFAULT NULL COMMENT '请求内容',
  res_content varchar(500) DEFAULT NULL COMMENT '响应内容',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  op_saas_admin_id bigint(20) DEFAULT NULL COMMENT '操作管理员ID',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易所操作记录表';

-- ============================================
-- 8. tb_exchange_saas_fee_rate - 交易所saas费率表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_saas_fee_rate;
CREATE TABLE tb_exchange_saas_fee_rate (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) NOT NULL DEFAULT '0' COMMENT '交易所id',
  fee_rate decimal(65,18) NOT NULL COMMENT 'Saas费率',
  action_time date NOT NULL COMMENT '生效时间',
  create_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  update_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-未删除 1-已删除',
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易所saas费率表';

-- ============================================
-- 9. tb_broker_saas_fee_rate - 券商saas费率表
-- ============================================
DROP TABLE IF EXISTS tb_broker_saas_fee_rate;
CREATE TABLE tb_broker_saas_fee_rate (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  broker_id bigint(20) NOT NULL DEFAULT '0' COMMENT '券商id',
  fee_rate decimal(65,18) NOT NULL COMMENT 'Saas费率',
  action_time date NOT NULL COMMENT '生效时间',
  create_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  update_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-未删除 1-已删除',
  PRIMARY KEY (id),
  KEY idx_broker_id (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商saas费率表';

-- ============================================
-- 10. tb_exchange_symbol - 交易所币对表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_symbol;
CREATE TABLE tb_exchange_symbol (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) NOT NULL COMMENT '币对所属交易所ID',
  symbol_id varchar(255) DEFAULT NULL COMMENT '币对ID',
  symbol_name varchar(255) NOT NULL COMMENT '币对名称',
  base_token_id varchar(255) NOT NULL COMMENT '基础币种ID',
  quote_token_id varchar(255) NOT NULL COMMENT '计价币种ID',
  symbol_alias varchar(255) DEFAULT NULL COMMENT '币对别名',
  category int(11) DEFAULT NULL COMMENT '分类',
  underlying_id varchar(255) DEFAULT NULL COMMENT '标的ID',
  status tinyint(4) DEFAULT NULL COMMENT '显示状态：0-不在交易所中显示，1-显示在交易所中',
  allow_trade tinyint(4) DEFAULT NULL COMMENT '允许交易',
  published tinyint(4) DEFAULT NULL COMMENT '是否发布',
  created_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_symbol_id (symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设置交易所可显示的币对';

-- ============================================
-- 11. tb_exchange_token - 交易所Token表
-- ============================================
DROP TABLE IF EXISTS tb_exchange_token;
CREATE TABLE tb_exchange_token (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  token_id varchar(255) NOT NULL COMMENT '不用数字',
  token_full_name varchar(255) NOT NULL COMMENT 'full name',
  min_precision tinyint(4) NOT NULL COMMENT '最小精度',
  token_detail varchar(500) DEFAULT NULL COMMENT 'token 详情',
  description varchar(2000) DEFAULT NULL COMMENT 'token 描述',
  status tinyint(4) DEFAULT NULL COMMENT '显示状态：0-不在交易所中显示，1-显示在交易所中',
  category int(11) DEFAULT NULL COMMENT '分类',
  icon varchar(255) DEFAULT NULL COMMENT 'token icon',
  fee_token_id varchar(255) DEFAULT NULL COMMENT '手续费TokenId',
  fee_token_name varchar(255) DEFAULT NULL COMMENT '手续费TokenName',
  created_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (id),
  UNIQUE KEY token_id_idx (token_id),
  KEY idx_exchange_id (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设置交易所可显示的token';

-- ============================================
-- 12. tb_token_apply_record - Token申请记录表
-- ============================================
DROP TABLE IF EXISTS tb_token_apply_record;
CREATE TABLE tb_token_apply_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  token_type int(11) DEFAULT NULL COMMENT 'Token类型',
  state int(11) DEFAULT NULL COMMENT '状态',
  token_id varchar(255) DEFAULT NULL COMMENT 'Token ID',
  token_name varchar(255) DEFAULT NULL COMMENT 'Token名称',
  token_full_name varchar(255) DEFAULT NULL COMMENT 'Token全名',
  fair_value decimal(65,18) DEFAULT NULL COMMENT '公允价值',
  icon_url varchar(500) DEFAULT NULL COMMENT '图标URL',
  contract_address varchar(255) DEFAULT NULL COMMENT '合约地址',
  introduction text COMMENT '介绍',
  min_depositing_amt decimal(65,18) DEFAULT NULL COMMENT '最小充值金额',
  min_withdrawing_amt decimal(65,18) DEFAULT NULL COMMENT '最小提现金额',
  broker_withdrawing_fee decimal(65,18) DEFAULT NULL COMMENT '券商提现手续费',
  max_withdrawing_amt decimal(65,18) DEFAULT NULL COMMENT '最大提现金额',
  reason varchar(1000) DEFAULT NULL COMMENT '原因',
  fee_token varchar(255) DEFAULT NULL COMMENT '手续费Token',
  platform_fee decimal(65,18) DEFAULT NULL COMMENT '平台手续费',
  need_tag int(11) DEFAULT NULL COMMENT '是否需要标签',
  confirm_count int(11) DEFAULT NULL COMMENT '确认数',
  can_withdraw_confirm_count int(11) DEFAULT NULL COMMENT '可提现确认数',
  min_precision int(11) DEFAULT NULL COMMENT '最小精度',
  explore_url varchar(500) DEFAULT NULL COMMENT '浏览器URL',
  max_quantity_supplied varchar(255) DEFAULT NULL COMMENT '最大发行量',
  current_turnover varchar(255) DEFAULT NULL COMMENT '当前流通量',
  official_website_url varchar(500) DEFAULT NULL COMMENT '官网URL',
  white_paper_url varchar(500) DEFAULT NULL COMMENT '白皮书URL',
  publish_time varchar(100) DEFAULT NULL COMMENT '发行时间',
  is_private_token int(11) DEFAULT NULL COMMENT '是否私有Token',
  is_baas int(11) DEFAULT NULL COMMENT '是否BaaS',
  is_aggregate int(11) DEFAULT NULL COMMENT '是否聚合',
  is_test int(11) DEFAULT NULL COMMENT '是否测试',
  is_mainstream int(11) DEFAULT NULL COMMENT '是否主流币',
  extra_tag text COMMENT '额外标签JSON',
  extra_config text COMMENT '额外配置JSON',
  chain_name varchar(255) DEFAULT NULL COMMENT '链名称',
  parent_token_id varchar(255) DEFAULT NULL COMMENT '父Token ID',
  chain_sequence int(11) DEFAULT NULL COMMENT '链序列',
  create_at timestamp NULL DEFAULT NULL,
  update_at timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_broker_id (broker_id),
  KEY idx_token_id (token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Token申请记录表';

-- ============================================
-- 13. tb_symbol_apply - 币对申请记录表
-- ============================================
DROP TABLE IF EXISTS tb_symbol_apply;
CREATE TABLE tb_symbol_apply (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  state int(11) DEFAULT NULL COMMENT '状态',
  symbol_id varchar(255) DEFAULT NULL COMMENT '币对ID',
  base_token_id varchar(255) DEFAULT NULL COMMENT '基础币种ID',
  quote_token_id varchar(255) DEFAULT NULL COMMENT '计价币种ID',
  min_price_precision decimal(65,18) DEFAULT NULL COMMENT '最小价格精度',
  base_precision decimal(65,18) DEFAULT NULL COMMENT '基础精度',
  min_trade_quantity decimal(65,18) DEFAULT NULL COMMENT '最小交易数量',
  quote_precision decimal(65,18) DEFAULT NULL COMMENT '计价精度',
  min_trade_amt decimal(65,18) DEFAULT NULL COMMENT '最小交易金额',
  merge_digit_depth varchar(255) DEFAULT NULL COMMENT '合并深度',
  reason varchar(1000) DEFAULT NULL COMMENT '原因',
  online_time bigint(20) DEFAULT NULL COMMENT '上线时间',
  create_at timestamp NULL DEFAULT NULL,
  update_at timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_broker_id (broker_id),
  KEY idx_symbol_id (symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='币对申请记录表';

-- ============================================
-- 14. tb_event_log - 事件日志表
-- ============================================
DROP TABLE IF EXISTS tb_event_log;
CREATE TABLE tb_event_log (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  cmd varchar(255) DEFAULT NULL COMMENT '命令',
  request_info varchar(2000) DEFAULT NULL COMMENT '请求信息',
  request_id bigint(20) DEFAULT NULL COMMENT '请求ID',
  status int(11) DEFAULT NULL COMMENT '状态',
  remark varchar(1000) DEFAULT NULL COMMENT '备注',
  created timestamp NULL DEFAULT NULL,
  updated timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_broker_id (broker_id),
  KEY idx_request_id (request_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='事件日志表';

-- ============================================
-- 15. tb_db_table_config - 数据库表配置表
-- ============================================
DROP TABLE IF EXISTS tb_db_table_config;
CREATE TABLE tb_db_table_config (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  db_name varchar(255) DEFAULT NULL COMMENT '数据库名',
  table_name varchar(255) DEFAULT NULL COMMENT '表名',
  table_indexs varchar(1000) DEFAULT NULL COMMENT '可以用于查询的索引列表每条索引的字段用逗号分隔，多条索引之间用分号分隔',
  PRIMARY KEY (id),
  KEY idx_db_table (db_name, table_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据库表配置表';

-- ============================================
-- 16. tb_trading_commission - 交易佣金表
-- ============================================
DROP TABLE IF EXISTS tb_trading_commission;
CREATE TABLE tb_trading_commission (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  trade_detail_id bigint(20) DEFAULT NULL COMMENT '交易详情ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  match_exchange_id bigint(20) DEFAULT NULL COMMENT '撮合交易所ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  symbol_id varchar(255) DEFAULT NULL COMMENT '币对ID',
  fee_token_id varchar(255) DEFAULT NULL COMMENT '手续费Token ID',
  side int(11) DEFAULT NULL COMMENT '方向',
  trading_amount decimal(65,18) DEFAULT NULL COMMENT '交易总额',
  match_time timestamp NULL DEFAULT NULL COMMENT '撮合时间',
  is_maker int(11) DEFAULT NULL COMMENT '是否Maker',
  total_fee decimal(65,18) DEFAULT NULL COMMENT '总手续费',
  sys_fee decimal(65,18) DEFAULT NULL COMMENT '系统手续费',
  exchange_fee decimal(65,18) DEFAULT NULL COMMENT '交易所手续费',
  broker_fee decimal(65,18) DEFAULT NULL COMMENT '券商手续费',
  exchange_saas_fee decimal(65,18) DEFAULT NULL COMMENT '交易所SaaS手续费',
  broker_saas_fee decimal(65,18) DEFAULT NULL COMMENT '券商SaaS手续费',
  match_exchange_fee decimal(65,18) DEFAULT NULL COMMENT '撮合交易所手续费',
  match_exchange_saas_fee decimal(65,18) DEFAULT NULL COMMENT '撮合交易所SaaS手续费',
  sys_fee_rate decimal(65,18) DEFAULT NULL COMMENT '系统手续费率',
  exchange_fee_rate decimal(65,18) DEFAULT NULL COMMENT '交易所手续费率',
  exchange_sass_fee_rate decimal(65,18) DEFAULT NULL COMMENT '交易所SaaS手续费率',
  match_exchange_saas_fee_rate decimal(65,18) DEFAULT NULL COMMENT '撮合交易所SaaS手续费率',
  match_exchange_fee_rate decimal(65,18) DEFAULT NULL COMMENT '撮合交易所手续费率',
  broker_sass_fee_rate decimal(65,18) DEFAULT NULL COMMENT '券商SaaS手续费率',
  status int(11) DEFAULT NULL COMMENT '计算步骤状态',
  sn bigint(20) DEFAULT NULL COMMENT '转帐sn,取批次内最大的id',
  clear_day varchar(20) DEFAULT NULL COMMENT '清算日',
  PRIMARY KEY (id),
  KEY idx_trade_detail_id (trade_detail_id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_broker_id (broker_id),
  KEY idx_clear_day (clear_day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易佣金表';

-- ============================================
-- 17. tb_org_contract - 机构合约表
-- ============================================
DROP TABLE IF EXISTS tb_org_contract;
CREATE TABLE tb_org_contract (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  contract_id bigint(20) DEFAULT NULL COMMENT '合约ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  apply_org_id bigint(20) DEFAULT NULL COMMENT '合作状态变更的发起机构id，用来判断下次状态变更时是否有权限操作',
  broker_status int(11) DEFAULT NULL COMMENT '券商状态',
  exchange_status int(11) DEFAULT NULL COMMENT '交易所状态',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_broker_id (broker_id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_contract_id (contract_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机构合约表';

-- ============================================
-- 18. tb_org_contract_detail - 机构合约详情表
-- ============================================
DROP TABLE IF EXISTS tb_org_contract_detail;
CREATE TABLE tb_org_contract_detail (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  org_type int(11) DEFAULT NULL COMMENT '机构类型',
  contract_id bigint(20) DEFAULT NULL COMMENT '合约ID',
  contract_org_name varchar(255) DEFAULT NULL COMMENT '合作的机构名称',
  company_name varchar(255) DEFAULT NULL COMMENT '公司名称',
  phone varchar(100) DEFAULT NULL COMMENT '电话',
  email varchar(255) DEFAULT NULL COMMENT '邮箱',
  contact varchar(255) DEFAULT NULL COMMENT '联系人',
  remark varchar(1000) DEFAULT NULL COMMENT '备注',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_contract_id (contract_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机构合约详情表';

-- ============================================
-- 19. tb_verify_flow_history - 审核流程历史表
-- ============================================
DROP TABLE IF EXISTS tb_verify_flow_history;
CREATE TABLE tb_verify_flow_history (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  biz_record_id bigint(20) DEFAULT NULL COMMENT '业务记录ID',
  verify_status int(11) DEFAULT NULL COMMENT '审核状态（1-通过 2-拒绝）',
  review_comments varchar(2000) DEFAULT NULL COMMENT '审核意见',
  admin_user_id bigint(20) DEFAULT NULL COMMENT '管理员用户ID',
  admin_user_name varchar(255) DEFAULT NULL COMMENT '管理员用户名',
  verify_time bigint(20) DEFAULT NULL COMMENT '审核时间',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_biz_record_id (biz_record_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审核流程历史表';

-- ============================================
-- 20. tb_verify_flow_config - 审核流程配置表
-- ============================================
DROP TABLE IF EXISTS tb_verify_flow_config;
CREATE TABLE tb_verify_flow_config (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  biz_type int(11) DEFAULT NULL COMMENT '业务类型',
  level int(11) DEFAULT NULL COMMENT '审核等级',
  verify_user_ids varchar(500) DEFAULT NULL COMMENT '审批人 uid用,分隔',
  can_close int(11) DEFAULT NULL COMMENT '可以关闭',
  can_change int(11) DEFAULT NULL COMMENT '可以变更',
  status int(11) DEFAULT NULL COMMENT '状态',
  admin_user_id bigint(20) DEFAULT NULL COMMENT '管理员用户ID',
  admin_user_name varchar(255) DEFAULT NULL COMMENT '管理员用户名',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_biz_type (biz_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审核流程配置表';

-- ============================================
-- 21. tb_verify_biz_record - 审核业务记录表
-- ============================================
DROP TABLE IF EXISTS tb_verify_biz_record;
CREATE TABLE tb_verify_biz_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  biz_type int(11) DEFAULT NULL COMMENT '业务类型',
  title varchar(500) DEFAULT NULL COMMENT '标题',
  description varchar(2000) DEFAULT NULL COMMENT '描述',
  verify_content text COMMENT '审核内容 用json表示，一般会有其它表来表示自己的业务',
  status int(11) DEFAULT NULL COMMENT '状态 0.初始化 1.审核中 2.结束-通过 3.结束-拒绝',
  current_verify_level int(11) DEFAULT NULL COMMENT '当前审核等级',
  admin_user_id bigint(20) DEFAULT NULL COMMENT '管理员用户ID',
  admin_user_name varchar(255) DEFAULT NULL COMMENT '管理员用户名',
  verify_user_ids varchar(500) DEFAULT NULL COMMENT '审批人 uid用,分隔',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_biz_type (biz_type),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审核业务记录表';

-- ============================================
-- 22. tb_symbol_match_transfer - 币对撮合转移表
-- ============================================
DROP TABLE IF EXISTS tb_symbol_match_transfer;
CREATE TABLE tb_symbol_match_transfer (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  source_exchange_id bigint(20) DEFAULT NULL COMMENT '源交易所ID',
  source_broker_id bigint(20) DEFAULT NULL COMMENT '源券商ID',
  source_broker_name varchar(255) DEFAULT NULL COMMENT '源券商名称',
  match_exchange_id bigint(20) DEFAULT NULL COMMENT '撮合交易所ID',
  match_broker_id bigint(20) DEFAULT NULL COMMENT '撮合券商ID',
  match_exchange_name varchar(255) DEFAULT NULL COMMENT '撮合交易所名称',
  match_broker_name varchar(255) DEFAULT NULL COMMENT '撮合券商名称',
  symbol_id varchar(255) DEFAULT NULL COMMENT '币对ID',
  category int(11) DEFAULT NULL COMMENT '分类',
  remark varchar(1000) DEFAULT NULL COMMENT '备注',
  enable int(11) DEFAULT NULL COMMENT '是否启用',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_source_exchange_id (source_exchange_id),
  KEY idx_match_exchange_id (match_exchange_id),
  KEY idx_symbol_id (symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='币对撮合转移表';

-- ============================================
-- 23. tb_sms_sign - 短信签名表
-- ============================================
DROP TABLE IF EXISTS tb_sms_sign;
CREATE TABLE tb_sms_sign (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  org_name varchar(255) DEFAULT NULL COMMENT '机构名称',
  sign varchar(255) DEFAULT NULL COMMENT '签名',
  language varchar(50) DEFAULT NULL COMMENT '语言',
  deleted tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除: 1=删除 0=正常',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信签名表';

-- ============================================
-- 24. tb_saas_transfer_record - SaaS转账记录表
-- ============================================
DROP TABLE IF EXISTS tb_saas_transfer_record;
CREATE TABLE tb_saas_transfer_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  biz_record_id bigint(20) DEFAULT NULL COMMENT '业务记录ID',
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  target_org_id bigint(20) DEFAULT NULL COMMENT '目标机构ID',
  target_account_id bigint(20) DEFAULT NULL COMMENT '目标账户ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'Token ID',
  amount decimal(65,18) DEFAULT NULL COMMENT '金额',
  status int(11) DEFAULT NULL COMMENT '状态：0-初始化 1-锁定余额 2-转出成功 3-拒绝解锁余额 4-失败解锁余额',
  lock_id bigint(20) DEFAULT NULL COMMENT '锁定ID',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_biz_record_id (biz_record_id),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SaaS转账记录表';

-- ============================================
-- 25. tb_deposit_receipt_apply_record - 充值凭证申请记录表
-- ============================================
DROP TABLE IF EXISTS tb_deposit_receipt_apply_record;
CREATE TABLE tb_deposit_receipt_apply_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  org_id bigint(20) DEFAULT NULL COMMENT '机构ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'Token ID',
  order_id bigint(20) DEFAULT NULL COMMENT '订单ID',
  created bigint(20) DEFAULT NULL COMMENT '创建时间',
  updated bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值凭证申请记录表';

-- ============================================
-- 26. tb_contract_apply_record - 合约申请记录表
-- ============================================
DROP TABLE IF EXISTS tb_contract_apply_record;
CREATE TABLE tb_contract_apply_record (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  symbol_id varchar(255) DEFAULT NULL COMMENT '币对ID',
  symbol_name varchar(255) DEFAULT NULL COMMENT '币对名称',
  base_token_id varchar(255) DEFAULT NULL COMMENT '基础币种ID',
  symbol_name_locale_json text COMMENT '币对名称多语言JSON',
  risk_limit_json text COMMENT '风险限额JSON',
  quote_token_id varchar(255) DEFAULT NULL COMMENT '计价币种ID',
  underlying_id varchar(255) DEFAULT NULL COMMENT '标的id',
  display_underlying_id varchar(255) DEFAULT NULL COMMENT '展示用的标的id',
  exchange_id bigint(20) DEFAULT NULL COMMENT '申请的交易所id',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  state int(11) DEFAULT NULL COMMENT '期货审核状态值 0 申请中 1 通过 2 拒绝',
  min_trade_quantity decimal(65,18) DEFAULT NULL COMMENT '单次交易最小交易base的数量',
  min_trade_amt decimal(65,18) DEFAULT NULL COMMENT '最小交易额',
  min_price_precision decimal(65,18) DEFAULT NULL COMMENT '每次价格变动，最小的变动单位',
  digit_merge_list varchar(255) DEFAULT NULL COMMENT '深度合并。格式：0.01,0.0001,0.000001',
  base_precision decimal(65,18) DEFAULT NULL COMMENT '基础精度',
  quote_precision decimal(65,18) DEFAULT NULL COMMENT '计价精度',
  display_token varchar(255) DEFAULT NULL COMMENT '显示用的估价token',
  currency varchar(255) DEFAULT NULL COMMENT '计价单位(token_id)',
  currency_display varchar(255) DEFAULT NULL COMMENT '显示价格单位',
  contract_multiplier decimal(65,18) DEFAULT NULL COMMENT '合约乘数',
  limit_down_in_trading_hours decimal(65,18) DEFAULT NULL COMMENT '交易时段内下跌限价',
  limit_up_in_trading_hours decimal(65,18) DEFAULT NULL COMMENT '交易时段内上涨限价',
  limit_down_out_trading_hours decimal(65,18) DEFAULT NULL COMMENT '交易时段外下跌限价',
  limit_up_out_trading_hours decimal(65,18) DEFAULT NULL COMMENT '交易时段外上涨限价',
  max_leverage decimal(65,18) DEFAULT NULL COMMENT '最大杠杆',
  leverage_range varchar(255) DEFAULT NULL COMMENT '杠杆范围',
  over_price_range varchar(255) DEFAULT NULL COMMENT '超价浮动范围',
  market_price_range varchar(255) DEFAULT NULL COMMENT '市价浮动范围',
  is_perpetual_swap int(11) DEFAULT NULL COMMENT '是否永续合约',
  index_token varchar(255) DEFAULT NULL COMMENT '指数名称',
  display_index_token varchar(255) DEFAULT NULL COMMENT '用于页面显示指数价格(正向=index_token,反则反之)',
  funding_lower_bound decimal(65,18) DEFAULT NULL COMMENT '永续合约资金费率下限',
  funding_upper_bound decimal(65,18) DEFAULT NULL COMMENT '永续合约资金费率上限',
  funding_interest decimal(65,18) DEFAULT NULL COMMENT '永续合约两币种借贷利率之和',
  is_reverse int(11) DEFAULT NULL COMMENT '是否反向',
  margin_precision decimal(65,18) DEFAULT NULL COMMENT '用户修改保证金的最小精度',
  created_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  updated_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_broker_id (broker_id),
  KEY idx_symbol_id (symbol_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='合约申请记录表';

SET FOREIGN_KEY_CHECKS = 1;



