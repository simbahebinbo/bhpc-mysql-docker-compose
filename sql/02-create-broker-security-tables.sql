-- ============================================
-- Broker Security Database Schema
-- ============================================
-- 数据库: broker_security
-- 用于 security 服务

USE broker_security;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. tb_user - 用户表
-- ============================================
DROP TABLE IF EXISTS tb_user;
CREATE TABLE tb_user (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increase',
  org_id bigint(20) NOT NULL COMMENT 'broker id',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  password varchar(100) NOT NULL COMMENT 'password',
  trade_password varchar(100) NOT NULL DEFAULT '' COMMENT 'trade password',
  snow varchar(100) NOT NULL COMMENT 'snow',
  trade_snow varchar(100) NOT NULL DEFAULT '' COMMENT 'trade password snow',
  ga_key varchar(16) NOT NULL DEFAULT '' COMMENT 'GA Key',
  user_status int(4) NOT NULL DEFAULT '0' COMMENT 'user status',
  api_level int(4) NOT NULL DEFAULT '0' COMMENT 'api level',
  ip varchar(50) DEFAULT NULL COMMENT 'ip',
  created bigint(20) NOT NULL,
  updated bigint(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY SECURITY_USER_UNIQUE (org_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='security user';

-- ============================================
-- 2. tb_user_pwd_change_log - 用户密码变更记录表
-- ============================================
DROP TABLE IF EXISTS tb_user_pwd_change_log;
CREATE TABLE tb_user_pwd_change_log (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increase',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  change_type int(4) DEFAULT '0' COMMENT 'password change type，1 find password 2 update password',
  old_password varchar(100) NOT NULL COMMENT 'old password',
  old_snow varchar(100) NOT NULL COMMENT 'old snow',
  new_password varchar(100) NOT NULL COMMENT 'new password',
  new_snow varchar(100) NOT NULL COMMENT 'new snow',
  created bigint(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user password change log';

-- ============================================
-- 3. tb_api_key - 用户ApiKey表
-- ============================================
DROP TABLE IF EXISTS tb_api_key;
CREATE TABLE tb_api_key (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increase',
  org_id bigint(20) NOT NULL COMMENT 'org id',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  account_id bigint(20) NOT NULL COMMENT 'account id',
  account_type int(4) DEFAULT '0' COMMENT 'account type',
  account_index int(4) DEFAULT '0' COMMENT 'account index',
  account_name varchar(100) DEFAULT NULL COMMENT 'account name',
  api_key varchar(200) NOT NULL COMMENT 'api_key',
  secret_key varchar(100) NOT NULL COMMENT 'secret_key',
  key_snow varchar(100) DEFAULT NULL COMMENT 'key snow',
  tag varchar(100) NOT NULL DEFAULT '' COMMENT 'remark or tag',
  ip_white_list varchar(100) NOT NULL DEFAULT '' COMMENT 'ip white list',
  type int(4) NOT NULL DEFAULT '0' COMMENT 'api key type',
  level int(4) NOT NULL DEFAULT '0' COMMENT 'api key level',
  special_permission int(4) NOT NULL DEFAULT '0' COMMENT 'special permission',
  create_for_user int(4) NOT NULL DEFAULT '0' COMMENT 'create for user',
  status int(4) NOT NULL DEFAULT '0' COMMENT 'available status: 0 no 1 yes',
  created bigint(20) NOT NULL,
  updated bigint(20) NOT NULL,
  secret_key_seen_times_by_org int(11) NOT NULL DEFAULT '0' COMMENT 'secret key seen times by org',
  PRIMARY KEY (id),
  UNIQUE KEY API_KEY_UNIQUE (api_key),
  KEY idx_org_user (org_id, user_id),
  KEY idx_account (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user api key';

-- ============================================
-- 4. tb_api_key_log - 用户ApiKey流水表
-- ============================================
DROP TABLE IF EXISTS tb_api_key_log;
CREATE TABLE tb_api_key_log (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increase',
  org_id bigint(20) NOT NULL COMMENT 'org id',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  account_id bigint(20) NOT NULL COMMENT 'account id',
  account_type int(4) DEFAULT '0' COMMENT 'account type',
  account_index int(4) DEFAULT '0' COMMENT 'account index',
  account_name varchar(100) DEFAULT NULL COMMENT 'account name',
  api_key varchar(200) NOT NULL COMMENT 'api_key',
  secret_key varchar(100) NOT NULL COMMENT 'secret_key',
  key_snow varchar(100) DEFAULT NULL COMMENT 'key snow',
  tag varchar(100) NOT NULL DEFAULT '' COMMENT 'api key',
  ip_white_list varchar(100) NOT NULL DEFAULT '' COMMENT 'ip white list',
  type int(4) NOT NULL DEFAULT '0' COMMENT 'api key type',
  level int(4) NOT NULL DEFAULT '0' COMMENT 'api key level',
  special_permission int(4) NOT NULL DEFAULT '0' COMMENT 'special permission',
  create_for_user int(4) NOT NULL DEFAULT '0' COMMENT 'create for user',
  status int(4) NOT NULL DEFAULT '0' COMMENT 'available status: 0 no 1 yes',
  created bigint(20) NOT NULL,
  updated bigint(20) NOT NULL,
  secret_key_seen_times_by_org int(11) NOT NULL DEFAULT '0' COMMENT 'secret key seen times by org',
  PRIMARY KEY (id),
  KEY idx_user_id (user_id),
  KEY idx_account_id (account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user api key log';

-- ============================================
-- 5. tb_verify_code_log - 验证码表
-- ============================================
DROP TABLE IF EXISTS tb_verify_code_log;
CREATE TABLE tb_verify_code_log (
  id bigint(20) NOT NULL COMMENT 'id',
  org_id bigint(20) NOT NULL COMMENT 'broker id',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  receiver varchar(200) NOT NULL COMMENT 'mobile or email',
  type int(4) NOT NULL DEFAULT '0' COMMENT 'verification code type',
  code varchar(10) NOT NULL COMMENT 'verification code',
  content text NOT NULL COMMENT 'sms content or email content',
  created bigint(20) NOT NULL,
  PRIMARY KEY (id),
  KEY idx_receiver (receiver),
  KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='verification code log';

-- ============================================
-- 6. tb_user_bind_ga_check - 用户绑定GA验证表
-- ============================================
DROP TABLE IF EXISTS tb_user_bind_ga_check;
CREATE TABLE tb_user_bind_ga_check (
  id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increase',
  org_id bigint(20) NOT NULL COMMENT 'broker id',
  user_id bigint(20) NOT NULL COMMENT 'user id',
  ga_key varchar(16) NOT NULL COMMENT 'GA Key',
  expired bigint(20) NOT NULL COMMENT 'expired time',
  created bigint(20) NOT NULL,
  PRIMARY KEY (id),
  KEY idx_org_user (org_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user bind ga check';

SET FOREIGN_KEY_CHECKS = 1;

