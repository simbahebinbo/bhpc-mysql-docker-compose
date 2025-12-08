-- ============================================
-- Exchange OTC Database Schema
-- ============================================
-- 数据库: exchange_otc
-- 用于 exchange-otc 服务

USE exchange_otc;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. tb_otc_broker_ext - 券商扩展表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_ext;
CREATE TABLE tb_otc_broker_ext (
  broker_id bigint(20) NOT NULL COMMENT '券商ID',
  broker_name varchar(255) DEFAULT NULL COMMENT '券商名称',
  phone varchar(255) DEFAULT NULL COMMENT '电话',
  cancel_time int(11) DEFAULT NULL COMMENT '取消时间',
  appeal_time int(11) DEFAULT NULL COMMENT '申诉时间',
  create_at bigint(20) DEFAULT NULL COMMENT '创建时间',
  update_at bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商扩展表';

-- ============================================
-- 2. tb_otc_order - 订单表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order;
CREATE TABLE tb_otc_order (
  id bigint(20) NOT NULL COMMENT '订单ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商id',
  user_id bigint(20) DEFAULT NULL COMMENT '用户id',
  client_order_id bigint(20) DEFAULT NULL COMMENT '客户端id',
  side int(11) DEFAULT NULL COMMENT '订单类型 0-买入；1-卖出',
  item_id bigint(20) DEFAULT NULL COMMENT '商品id',
  account_id bigint(20) DEFAULT NULL COMMENT 'maker id',
  target_account_id bigint(20) DEFAULT NULL COMMENT 'taker id',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  token_name varchar(255) DEFAULT NULL COMMENT '币种名称',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  price decimal(36,18) DEFAULT NULL COMMENT '成交单价',
  quantity decimal(36,18) DEFAULT NULL COMMENT '成交数量',
  amount decimal(36,18) DEFAULT NULL COMMENT '订单金额',
  fee decimal(36,18) DEFAULT NULL COMMENT '手续费',
  pay_code varchar(255) DEFAULT NULL COMMENT '付款参考号',
  payment_type int(11) DEFAULT NULL COMMENT '付款方式',
  transfer_date datetime DEFAULT NULL COMMENT '转账日期',
  status int(11) DEFAULT NULL COMMENT '状态',
  appeal_account_id bigint(20) DEFAULT NULL COMMENT '申诉账户id',
  appeal_type int(11) DEFAULT NULL COMMENT '申诉类型',
  appeal_content varchar(1000) DEFAULT NULL COMMENT '申诉内容',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  freed int(11) DEFAULT NULL COMMENT '风险资金释放 0历史数据不处理 1:共享券商未释放 2:已释放 3:非共享券商未释放',
  risk_balance_type int(11) DEFAULT NULL COMMENT '0-默认，由系统确认 1-强制加入风险资金，2-强制成非风险资金',
  maker_fee decimal(36,18) DEFAULT NULL COMMENT 'maker fee',
  taker_fee decimal(36,18) DEFAULT NULL COMMENT 'taker fee',
  depth_share smallint(6) DEFAULT NULL COMMENT '共享深度标记，0=不共享，1=共享',
  match_org_id bigint(20) DEFAULT NULL COMMENT '成交方券商ID',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_account_id (account_id),
  KEY idx_target_account_id (target_account_id),
  KEY idx_item_id (item_id),
  KEY idx_status (status),
  KEY idx_create_date (create_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ============================================
-- 3. tb_otc_item - 商品/广告表
-- ============================================
DROP TABLE IF EXISTS tb_otc_item;
CREATE TABLE tb_otc_item (
  id bigint(20) NOT NULL COMMENT 'ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  user_id bigint(20) DEFAULT NULL COMMENT '用户ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  client_item_id bigint(20) DEFAULT NULL COMMENT '客户端id',
  side int(11) DEFAULT NULL COMMENT '广告类型 0.买入 1.卖出',
  recommend_level int(11) DEFAULT NULL COMMENT '推荐级别 0最高',
  price_type int(11) DEFAULT NULL COMMENT '定价类型 0-固定价格；1-浮动价格',
  price decimal(36,18) DEFAULT NULL COMMENT '单价',
  premium decimal(36,18) DEFAULT NULL COMMENT '溢价比例 -5 - 5',
  last_quantity decimal(36,18) DEFAULT NULL COMMENT '剩余数量',
  quantity decimal(36,18) DEFAULT NULL COMMENT '数量',
  frozen_quantity decimal(36,18) DEFAULT NULL COMMENT '冻结数量(未成交订单中数量)',
  executed_quantity decimal(36,18) DEFAULT NULL COMMENT '已成交数量',
  payment_period int(11) DEFAULT NULL COMMENT '付款期限',
  min_amount decimal(36,18) DEFAULT NULL COMMENT '单笔最小交易额（钱）',
  max_amount decimal(36,18) DEFAULT NULL COMMENT '单笔最大交易额（钱）',
  margin_amount decimal(36,18) DEFAULT NULL COMMENT '保证金(买)/手续费(卖)',
  remark varchar(1000) DEFAULT NULL COMMENT '交易说明',
  only_high_auth int(11) DEFAULT NULL COMMENT '只与高级认证交易： 0 否， 1是',
  auto_reply varchar(1000) DEFAULT NULL COMMENT '自动回复',
  status int(11) DEFAULT NULL COMMENT '状态',
  order_num int(11) DEFAULT NULL COMMENT '订单数量',
  finish_num int(11) DEFAULT NULL COMMENT '完成数量',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  fee decimal(36,18) DEFAULT NULL COMMENT '已收手续费',
  frozen_fee decimal(36,18) DEFAULT NULL COMMENT '冻结手续费',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_account_id (account_id),
  KEY idx_token_currency (token_id, currency_id),
  KEY idx_status (status),
  KEY idx_create_date (create_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品/广告表';

-- ============================================
-- 4. tb_otc_user_info - OTC用户信息表
-- ============================================
DROP TABLE IF EXISTS tb_otc_user_info;
CREATE TABLE tb_otc_user_info (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  account_id bigint(20) DEFAULT NULL COMMENT '账户id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商id',
  user_id bigint(20) DEFAULT NULL COMMENT '用户id',
  nick_name varchar(255) DEFAULT NULL COMMENT '用户昵称',
  status int(11) DEFAULT NULL COMMENT '用户状态',
  order_num int(11) DEFAULT NULL COMMENT '总单数',
  execute_num int(11) DEFAULT NULL COMMENT '成交单数',
  recent_order_num int(11) DEFAULT NULL COMMENT '最近下单数（每日统计）',
  recent_execute_num int(11) DEFAULT NULL COMMENT '最近成交单数（每日统计）',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  mobile varchar(255) DEFAULT NULL COMMENT '联系电话',
  email varchar(255) DEFAULT NULL COMMENT '邮箱',
  complete_rate_day30 decimal(36,18) DEFAULT NULL COMMENT '30天完成率',
  order_total_number_day30 int(11) DEFAULT NULL COMMENT '30天总订单数',
  order_finish_number_day30 int(11) DEFAULT NULL COMMENT '30天完成订单数',
  user_first_name varchar(255) DEFAULT NULL COMMENT '交易用户的KYC姓名',
  user_second_name varchar(255) DEFAULT NULL COMMENT '交易用户的KYC姓',
  PRIMARY KEY (id),
  UNIQUE KEY uk_account_id (account_id),
  KEY idx_org_id (org_id),
  KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OTC用户信息表';

-- ============================================
-- 5. tb_otc_payment_term - 付款方式表
-- ============================================
DROP TABLE IF EXISTS tb_otc_payment_term;
CREATE TABLE tb_otc_payment_term (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户id',
  real_name varchar(255) DEFAULT NULL COMMENT '姓名',
  payment_type int(11) DEFAULT NULL COMMENT '银行类别：0-商业银行;1-支付宝;2-微信',
  bank_code varchar(255) DEFAULT NULL COMMENT '银行编码',
  bank_name varchar(255) DEFAULT NULL COMMENT '银行名称',
  branch_name varchar(255) DEFAULT NULL COMMENT '分行名称',
  account_no varchar(255) DEFAULT NULL COMMENT '账户号',
  qrcode varchar(1000) DEFAULT NULL COMMENT '二维码',
  pay_message varchar(1000) DEFAULT NULL COMMENT '汇款信息 SWIFT、西联汇款 使用',
  first_name varchar(255) DEFAULT NULL COMMENT '名  仅Financial Payment用到',
  last_name varchar(255) DEFAULT NULL COMMENT '姓  仅Financial Payment用到',
  second_last_name varchar(255) DEFAULT NULL COMMENT '第二姓氏  仅Financial Payment用到',
  clabe varchar(255) DEFAULT NULL COMMENT 'CLABE号  仅Financial Payment用到',
  debit_card_number varchar(255) DEFAULT NULL COMMENT '借记卡  仅Financial Payment用到',
  mobile varchar(255) DEFAULT NULL COMMENT '手机号  仅Financial Payment用到',
  business_name varchar(255) DEFAULT NULL COMMENT '商户名称  仅Mercadopago用到',
  concept varchar(255) DEFAULT NULL COMMENT '描述  仅Mercadopago用到',
  status int(11) DEFAULT NULL COMMENT '状态 1 可用；0 待认证；-1 删除',
  visible int(11) DEFAULT NULL COMMENT '显示控制 0-显示；1-隐藏',
  create_date datetime DEFAULT NULL COMMENT '创建日期',
  update_date datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (id),
  KEY idx_account_id (account_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='付款方式表';

-- ============================================
-- 6. tb_otc_symbol - OTC交易对配置信息表
-- ============================================
DROP TABLE IF EXISTS tb_otc_symbol;
CREATE TABLE tb_otc_symbol (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所id',
  token_id varchar(255) DEFAULT NULL COMMENT 'token',
  currency_id varchar(255) DEFAULT NULL COMMENT '数字货币id',
  status int(11) DEFAULT NULL COMMENT '状态',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_token_currency (token_id, currency_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OTC交易对配置信息表';

-- ============================================
-- 7. tb_otc_order_ext - 订单扩展表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_ext;
CREATE TABLE tb_otc_order_ext (
  order_id bigint(20) NOT NULL COMMENT '订单ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商id',
  token_scale int(11) DEFAULT NULL COMMENT 'token精度',
  currency_scale int(11) DEFAULT NULL COMMENT '法币精度',
  currency_amount_scale int(11) DEFAULT NULL COMMENT '法币成交精度',
  is_business int(11) DEFAULT NULL COMMENT '是否是商家 0不是 1是',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单扩展表';

-- ============================================
-- 8. tb_otc_broker_symbol - 券商交易对配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_symbol;
CREATE TABLE tb_otc_broker_symbol (
  id int(11) NOT NULL COMMENT 'id',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'token币种',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  status int(11) DEFAULT NULL COMMENT '状态  1：可用   -1：不可用',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_token_currency (token_id, currency_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商交易对配置表';

-- ============================================
-- 9. tb_otc_broker_token - 券商Token配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_token;
CREATE TABLE tb_otc_broker_token (
  id bigint(20) NOT NULL COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'token币种',
  token_name varchar(255) DEFAULT NULL COMMENT 'token名字',
  min_quote decimal(36,18) DEFAULT NULL COMMENT '最小计价单位',
  max_quote decimal(36,18) DEFAULT NULL COMMENT '最大交易单位',
  scale int(11) DEFAULT NULL COMMENT '精度',
  status int(11) DEFAULT NULL COMMENT '状态  1：可用   -1：不可用',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  up_range decimal(36,18) DEFAULT NULL COMMENT '浮动范围最大值',
  down_range decimal(36,18) DEFAULT NULL COMMENT '浮动范围最小值',
  sequence int(11) DEFAULT NULL COMMENT '排序值',
  share_status int(11) DEFAULT NULL COMMENT '共享状态',
  PRIMARY KEY (id),
  KEY idx_org_id_token (org_id, token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商Token配置表';

-- ============================================
-- 10. tb_otc_broker_currency - 券商法币配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_currency;
CREATE TABLE tb_otc_broker_currency (
  id int(11) NOT NULL COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  code varchar(255) DEFAULT NULL COMMENT '法币代码',
  name varchar(255) DEFAULT NULL COMMENT '银行名称',
  language varchar(255) DEFAULT NULL COMMENT '多语言',
  min_quote decimal(36,18) DEFAULT NULL COMMENT '最小计价单位',
  max_quote decimal(36,18) DEFAULT NULL COMMENT '最大限额',
  scale int(11) DEFAULT NULL COMMENT '精度',
  status int(11) DEFAULT NULL COMMENT '状态  1：可用   -1：不可用',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  amount_scale int(11) DEFAULT NULL COMMENT '法币成交额精度',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商法币配置表';

-- ============================================
-- 11. tb_otc_order_finish - 订单完成表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_finish;
CREATE TABLE tb_otc_order_finish (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商id',
  client_order_id bigint(20) DEFAULT NULL COMMENT '客户端id',
  side int(11) DEFAULT NULL COMMENT '订单类型 0-买入；1-卖出',
  item_id bigint(20) DEFAULT NULL COMMENT '商品id',
  account_id bigint(20) DEFAULT NULL COMMENT 'maker id',
  nick_name varchar(255) DEFAULT NULL COMMENT 'maker 用户昵称',
  target_account_id bigint(20) DEFAULT NULL COMMENT 'taker id',
  target_nick_name varchar(255) DEFAULT NULL COMMENT 'taker 用户昵称',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  price decimal(36,18) DEFAULT NULL COMMENT '成交单价',
  quantity decimal(36,18) DEFAULT NULL COMMENT '成交数量',
  amount decimal(36,18) DEFAULT NULL COMMENT '订单金额',
  fee decimal(36,18) DEFAULT NULL COMMENT '手续费',
  pay_code varchar(255) DEFAULT NULL COMMENT '付款参考号',
  payment_type int(11) DEFAULT NULL COMMENT '付款方式',
  transfer_date datetime DEFAULT NULL COMMENT '转账日期',
  status int(11) DEFAULT NULL COMMENT '状态',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_account_id (account_id),
  KEY idx_create_date (create_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单完成表';

-- ============================================
-- 12. tb_otc_item_finish - 商品完成表
-- ============================================
DROP TABLE IF EXISTS tb_otc_item_finish;
CREATE TABLE tb_otc_item_finish (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  user_id bigint(20) DEFAULT NULL COMMENT '用户ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  client_item_id bigint(20) DEFAULT NULL COMMENT '客户端id',
  side int(11) DEFAULT NULL COMMENT '广告类型 0.买入 1.卖出',
  recommend_level int(11) DEFAULT NULL COMMENT '推荐级别 0最高',
  price_type int(11) DEFAULT NULL COMMENT '定价类型 1-固定价格；2-浮动价格',
  price decimal(36,18) DEFAULT NULL COMMENT '单价',
  premium decimal(36,18) DEFAULT NULL COMMENT '溢价比例 -5 - 5',
  last_quantity decimal(36,18) DEFAULT NULL COMMENT '剩余数量',
  quantity decimal(36,18) DEFAULT NULL COMMENT '数量',
  frozen_quantity decimal(36,18) DEFAULT NULL COMMENT '冻结数量(未成交订单中数量)',
  executed_quantity decimal(36,18) DEFAULT NULL COMMENT '已成交数量',
  payment_period int(11) DEFAULT NULL COMMENT '付款期限',
  min_amount decimal(36,18) DEFAULT NULL COMMENT '单笔最小交易额（钱）',
  max_amount decimal(36,18) DEFAULT NULL COMMENT '单笔最大交易额（钱）',
  margin_amount decimal(36,18) DEFAULT NULL COMMENT '保证金(买)/手续费(卖)',
  remark varchar(1000) DEFAULT NULL COMMENT '交易说明',
  only_high_auth int(11) DEFAULT NULL COMMENT '只与高级认证交易： 0 否， 1是',
  auto_reply varchar(1000) DEFAULT NULL COMMENT '自动回复',
  status int(11) DEFAULT NULL COMMENT '状态',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id),
  KEY idx_account_id (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品完成表';

-- ============================================
-- 13. tb_otc_balance_flow - 动账流水表
-- ============================================
DROP TABLE IF EXISTS tb_otc_balance_flow;
CREATE TABLE tb_otc_balance_flow (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  user_id bigint(20) DEFAULT NULL COMMENT '用户ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  amount decimal(36,18) DEFAULT NULL COMMENT '金额',
  flow_type int(11) DEFAULT NULL COMMENT '流水/业务类型',
  object_id bigint(20) DEFAULT NULL COMMENT '业务id',
  status int(11) DEFAULT NULL COMMENT '状态',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  fee decimal(36,18) DEFAULT NULL COMMENT '手续费',
  PRIMARY KEY (id),
  KEY idx_account_id (account_id),
  KEY idx_flow_type (flow_type),
  KEY idx_create_date (create_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动账流水表';

-- ============================================
-- 14. tb_otc_order_comment - 订单评价表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_comment;
CREATE TABLE tb_otc_order_comment (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  user_id bigint(20) DEFAULT NULL COMMENT '评价者用户id',
  account_id bigint(20) DEFAULT NULL COMMENT '评价者账户id',
  nick_name varchar(255) DEFAULT NULL COMMENT '评价者昵称',
  target_account_id bigint(20) DEFAULT NULL COMMENT '被评价者账户id',
  order_id bigint(20) DEFAULT NULL COMMENT '订单ID',
  side int(11) DEFAULT NULL COMMENT '评价方（1 买方，2 卖方）',
  type int(11) DEFAULT NULL COMMENT '评价类型 0-好评，1-差评',
  star int(11) DEFAULT NULL COMMENT '等级，[0,5]',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id),
  KEY idx_target_account_id (target_account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单评价表';

-- ============================================
-- 15. tb_otc_order_message - 订单消息（聊天记录）表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_message;
CREATE TABLE tb_otc_order_message (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  order_id bigint(20) DEFAULT NULL COMMENT '订单id',
  account_id bigint(20) DEFAULT NULL COMMENT '账户id，0表示系统发送',
  msg_type int(11) DEFAULT NULL COMMENT '消息类型',
  msg_code int(11) DEFAULT NULL COMMENT '消息编码',
  message varchar(2000) DEFAULT NULL COMMENT '消息内容',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id),
  KEY idx_create_date (create_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单消息（聊天记录）表';

-- ============================================
-- 16. tb_otc_order_pay_info - 订单付款信息表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_pay_info;
CREATE TABLE tb_otc_order_pay_info (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  order_id bigint(20) DEFAULT NULL COMMENT '订单id',
  real_name varchar(255) DEFAULT NULL COMMENT '姓名',
  payment_type int(11) DEFAULT NULL COMMENT '银行类别：0-商业银行;1-支付宝;2-微信',
  bank_code varchar(255) DEFAULT NULL COMMENT '银行编码',
  bank_name varchar(255) DEFAULT NULL COMMENT '银行名称',
  branch_name varchar(255) DEFAULT NULL COMMENT '分行名称',
  account_no varchar(255) DEFAULT NULL COMMENT '账户号',
  qrcode varchar(1000) DEFAULT NULL COMMENT '二维码',
  pay_message varchar(1000) DEFAULT NULL COMMENT '汇款信息 SWIFT、西联汇款 使用',
  first_name varchar(255) DEFAULT NULL COMMENT '名  仅Financial Payment用到',
  last_name varchar(255) DEFAULT NULL COMMENT '姓  仅Financial Payment用到',
  second_last_name varchar(255) DEFAULT NULL COMMENT '第二姓氏  仅Financial Payment用到',
  clabe varchar(255) DEFAULT NULL COMMENT 'CLABE号  仅Financial Payment用到',
  debit_card_number varchar(255) DEFAULT NULL COMMENT '借记卡  仅Financial Payment用到',
  mobile varchar(255) DEFAULT NULL COMMENT '手机号  仅Financial Payment用到',
  business_name varchar(255) DEFAULT NULL COMMENT '商户名称  仅Mercadopago用到',
  concept varchar(255) DEFAULT NULL COMMENT '描述  仅Mercadopago用到',
  created datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单付款信息表';

-- ============================================
-- 17. tb_otc_payment_items - 支付方式要素表
-- ============================================
DROP TABLE IF EXISTS tb_otc_payment_items;
CREATE TABLE tb_otc_payment_items (
  payment_type int(11) NOT NULL COMMENT '支付方式',
  payment_items varchar(2000) DEFAULT NULL COMMENT '支付方式要素项',
  language varchar(255) NOT NULL DEFAULT '' COMMENT '语言',
  PRIMARY KEY (payment_type, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付方式要素表';

-- ============================================
-- 18. tb_otc_bank - 银行表
-- ============================================
DROP TABLE IF EXISTS tb_otc_bank;
CREATE TABLE tb_otc_bank (
  id int(11) NOT NULL COMMENT 'id',
  code varchar(255) DEFAULT NULL COMMENT '银行代码',
  name varchar(255) DEFAULT NULL COMMENT '银行名称',
  language varchar(255) DEFAULT NULL COMMENT '多语言',
  status int(11) DEFAULT NULL COMMENT '状态  1：可用   -1：不可用',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='银行表';

-- ============================================
-- 19. tb_otc_statistic_data - 统计数据表
-- ============================================
DROP TABLE IF EXISTS tb_otc_statistic_data;
CREATE TABLE tb_otc_statistic_data (
  id int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  statistic_date varchar(255) DEFAULT NULL COMMENT '统计日期',
  type int(11) DEFAULT NULL COMMENT '类型',
  statistic_detail varchar(2000) DEFAULT NULL COMMENT '统计详情',
  amount decimal(36,18) DEFAULT NULL COMMENT '金额',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_org_id_date (org_id, statistic_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='统计数据表';

-- ============================================
-- 20. tb_otc_trade_fee_rate - 交易手续费率表
-- ============================================
DROP TABLE IF EXISTS tb_otc_trade_fee_rate;
CREATE TABLE tb_otc_trade_fee_rate (
  id int(11) NOT NULL COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'token币种',
  maker_buy_fee_rate decimal(36,18) DEFAULT NULL COMMENT 'maker fee rate',
  maker_sell_fee_rate decimal(36,18) DEFAULT NULL COMMENT 'trade fee rate',
  created_at datetime DEFAULT NULL COMMENT '创建时间',
  updated_at datetime DEFAULT NULL COMMENT '更新时间',
  deleted int(11) DEFAULT NULL COMMENT '0 未删除 1 已删除',
  PRIMARY KEY (id),
  KEY idx_org_id_token (org_id, token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易手续费率表';

-- ============================================
-- 21. tb_otc_message_config - 消息配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_message_config;
CREATE TABLE tb_otc_message_config (
  broker_id bigint(20) NOT NULL COMMENT '券商ID',
  PRIMARY KEY (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息配置表';

-- ============================================
-- 22. tb_otc_broker_payment_config - 券商支付配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_payment_config;
CREATE TABLE tb_otc_broker_payment_config (
  org_id bigint(20) NOT NULL COMMENT '券商ID',
  payment_config varchar(2000) DEFAULT NULL COMMENT '配置支持的支付方式',
  PRIMARY KEY (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商支付配置表';

-- ============================================
-- 23. tb_otc_broker_risk_balance_config - 券商风险资产配置表
-- ============================================
DROP TABLE IF EXISTS tb_otc_broker_risk_balance_config;
CREATE TABLE tb_otc_broker_risk_balance_config (
  id int(11) NOT NULL COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  status int(11) DEFAULT NULL COMMENT '状态: 1 有效 2 无效',
  hours int(11) DEFAULT NULL COMMENT '风险资产持续时间（小时）',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='券商风险资产配置表';

-- ============================================
-- 24. tb_otc_symbol_share - 交易对共享表
-- ============================================
DROP TABLE IF EXISTS tb_otc_symbol_share;
CREATE TABLE tb_otc_symbol_share (
  id int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  exchange_id bigint(20) DEFAULT NULL COMMENT '交易所ID',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  token_id varchar(255) DEFAULT NULL COMMENT 'token币种',
  currency_id varchar(255) DEFAULT NULL COMMENT '法币币种',
  status int(11) DEFAULT NULL COMMENT '状态  1：可用   -1：不可用',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_exchange_id (exchange_id),
  KEY idx_broker_id (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易对共享表';

-- ============================================
-- 25. tb_otc_order_depth_share - 订单共享深度信息表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_depth_share;
CREATE TABLE tb_otc_order_depth_share (
  order_id bigint(20) NOT NULL COMMENT '订单id',
  maker_exchange_id bigint(20) DEFAULT NULL COMMENT 'maker交易所ID',
  taker_org_id bigint(20) DEFAULT NULL COMMENT 'taker券商id',
  maker_org_id bigint(20) DEFAULT NULL COMMENT 'maker券商id',
  item_id bigint(20) DEFAULT NULL COMMENT '商品id',
  maker_account_id bigint(20) DEFAULT NULL COMMENT 'maker accountId',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  status int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (order_id),
  KEY idx_maker_org_id (maker_org_id),
  KEY idx_taker_org_id (taker_org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单共享深度信息表';

-- ============================================
-- 26. tb_otc_order_depth_share_appeal - 订单共享深度申诉表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_depth_share_appeal;
CREATE TABLE tb_otc_order_depth_share_appeal (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  order_id bigint(20) DEFAULT NULL COMMENT '订单id',
  broker_id bigint(20) DEFAULT NULL COMMENT '券商id',
  admin_id bigint(20) DEFAULT NULL COMMENT '操作人id',
  status smallint(6) DEFAULT NULL COMMENT '状态',
  comment varchar(1000) DEFAULT NULL COMMENT '备注',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id),
  KEY idx_broker_id (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单共享深度申诉表';

-- ============================================
-- 27. tb_otc_order_admin_canceled - 管理员取消订单表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_admin_canceled;
CREATE TABLE tb_otc_order_admin_canceled (
  order_id bigint(20) NOT NULL COMMENT '订单ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  target_account_id bigint(20) DEFAULT NULL COMMENT '目标账户ID',
  side int(11) DEFAULT NULL COMMENT '方向',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员取消订单表';

-- ============================================
-- 28. tb_otc_payment_term_history - 付款方式历史表
-- ============================================
DROP TABLE IF EXISTS tb_otc_payment_term_history;
CREATE TABLE tb_otc_payment_term_history (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户id',
  real_name varchar(255) DEFAULT NULL COMMENT '姓名',
  payment_type int(11) DEFAULT NULL COMMENT '银行类别：0-商业银行;1-支付宝;2-微信',
  bank_code varchar(255) DEFAULT NULL COMMENT '银行编码',
  bank_name varchar(255) DEFAULT NULL COMMENT '银行名称',
  branch_name varchar(255) DEFAULT NULL COMMENT '分行名称',
  account_no varchar(255) DEFAULT NULL COMMENT '账户号',
  qrcode varchar(1000) DEFAULT NULL COMMENT '二维码',
  pay_message varchar(1000) DEFAULT NULL COMMENT '汇款信息 SWIFT、西联汇款 使用',
  first_name varchar(255) DEFAULT NULL COMMENT '名  仅Financial Payment用到',
  last_name varchar(255) DEFAULT NULL COMMENT '姓  仅Financial Payment用到',
  second_last_name varchar(255) DEFAULT NULL COMMENT '第二姓氏  仅Financial Payment用到',
  clabe varchar(255) DEFAULT NULL COMMENT 'CLABE号  仅Financial Payment用到',
  debit_card_number varchar(255) DEFAULT NULL COMMENT '借记卡  仅Financial Payment用到',
  mobile varchar(255) DEFAULT NULL COMMENT '手机号  仅Financial Payment用到',
  business_name varchar(255) DEFAULT NULL COMMENT '商户名称  仅Mercadopago用到',
  concept varchar(255) DEFAULT NULL COMMENT '描述  仅Mercadopago用到',
  create_date datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (id),
  KEY idx_account_id (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='付款方式历史表';

-- ============================================
-- 29. tb_otc_depth_share_whitelist - 深度共享白名单表
-- ============================================
DROP TABLE IF EXISTS tb_otc_depth_share_whitelist;
CREATE TABLE tb_otc_depth_share_whitelist (
  broker_id bigint(20) NOT NULL COMMENT '券商ID',
  PRIMARY KEY (broker_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='深度共享白名单表';

-- ============================================
-- 30. tb_otc_depth_share_exchange - 深度共享交易所表
-- ============================================
DROP TABLE IF EXISTS tb_otc_depth_share_exchange;
CREATE TABLE tb_otc_depth_share_exchange (
  exchange_id bigint(20) NOT NULL COMMENT '交易所ID',
  status int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (exchange_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='深度共享交易所表';

-- ============================================
-- 31. tb_otc_share_limit - 共享限额表
-- ============================================
DROP TABLE IF EXISTS tb_otc_share_limit;
CREATE TABLE tb_otc_share_limit (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  org_id bigint(20) DEFAULT NULL COMMENT '券商ID',
  assure_org_id bigint(20) DEFAULT NULL COMMENT '担保券商ID',
  status int(11) DEFAULT NULL COMMENT '状态',
  token_id varchar(255) DEFAULT NULL COMMENT '币种',
  safe_amount decimal(36,18) DEFAULT NULL COMMENT '安全金额',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  warn_percent decimal(36,18) DEFAULT NULL COMMENT '警告百分比',
  PRIMARY KEY (id),
  KEY idx_org_id (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='共享限额表';

-- ============================================
-- 32. tb_otc_order_index - 订单索引表
-- ============================================
DROP TABLE IF EXISTS tb_otc_order_index;
CREATE TABLE tb_otc_order_index (
  id bigint(20) NOT NULL COMMENT 'id',
  order_id bigint(20) DEFAULT NULL COMMENT '订单ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  status smallint(6) DEFAULT NULL COMMENT '状态',
  create_date datetime DEFAULT NULL COMMENT '创建时间',
  update_date datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id),
  KEY idx_account_id (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单索引表';

-- ============================================
-- 33. tb_user_ext - 用户扩展表
-- ============================================
DROP TABLE IF EXISTS tb_user_ext;
CREATE TABLE tb_user_ext (
  user_id bigint(20) NOT NULL COMMENT '用户ID',
  account_id bigint(20) DEFAULT NULL COMMENT '账户ID',
  usdt_value_24hours_buy decimal(36,18) DEFAULT NULL COMMENT '24小时USDT买入价值',
  created_at datetime DEFAULT NULL COMMENT '创建时间',
  updated_at datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (user_id),
  KEY idx_account_id (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户扩展表';

SET FOREIGN_KEY_CHECKS = 1;

