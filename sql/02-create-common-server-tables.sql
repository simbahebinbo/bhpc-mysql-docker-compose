-- Create database
CREATE DATABASE IF NOT EXISTS `common_server` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `common_server`;

-- tb_rate_limiter
CREATE TABLE IF NOT EXISTS `tb_rate_limiter` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `sender_type` INT(11) DEFAULT NULL,
  `biz_type` VARCHAR(255) DEFAULT NULL,
  `limiter_key` VARCHAR(255) DEFAULT NULL,
  `limiter_value` INT(11) DEFAULT NULL,
  `interval_seconds` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_broker_info
CREATE TABLE IF NOT EXISTS `tb_broker_info` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `org_name` VARCHAR(255) DEFAULT NULL,
  `sign_name` VARCHAR(255) DEFAULT NULL,
  `languages` VARCHAR(255) DEFAULT NULL,
  `env` VARCHAR(255) DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sp_info
CREATE TABLE IF NOT EXISTS `tb_sp_info` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `notice_type` VARCHAR(255) DEFAULT NULL,
  `msg_type` VARCHAR(255) DEFAULT NULL,
  `position` INT(11) DEFAULT NULL,
  `weight` INT(11) DEFAULT NULL,
  `access_key_id` VARCHAR(255) DEFAULT NULL,
  `secret_key` VARCHAR(255) DEFAULT NULL,
  `config_info` TEXT,
  `request_url` VARCHAR(255) DEFAULT NULL,
  `env` VARCHAR(255) DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  `support_whole` INT(11) DEFAULT NULL,
  `app_id` VARCHAR(255) DEFAULT NULL,
  `can_sync_sms_tmpl` INT(11) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_email_delivery_record
CREATE TABLE IF NOT EXISTS `tb_email_delivery_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `message_id` VARCHAR(255) DEFAULT NULL,
  `delivery_status` VARCHAR(255) DEFAULT NULL,
  `content` TEXT,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `deliveried_at` TIMESTAMP NULL DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `biz_type` VARCHAR(255) DEFAULT NULL,
  `sp_id` INT(11) DEFAULT NULL,
  `req_order_id` VARCHAR(255) DEFAULT '',
  `code_feedback_time` TIMESTAMP NULL DEFAULT NULL,
  `code_feedback_result` INT(11) DEFAULT 0,
  `user_id` BIGINT(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_message_id` (`message_id`),
  KEY `idx_email` (`email`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sms_delivery_record
CREATE TABLE IF NOT EXISTS `tb_sms_delivery_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `region_name` VARCHAR(255) DEFAULT NULL,
  `nation_code` VARCHAR(255) DEFAULT NULL,
  `mobile` VARCHAR(255) DEFAULT NULL,
  `message_id` VARCHAR(255) DEFAULT NULL,
  `delivery_status` VARCHAR(255) DEFAULT NULL,
  `price` DECIMAL(18,8) DEFAULT NULL,
  `price_unit` VARCHAR(255) DEFAULT NULL,
  `content` TEXT,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `deliveried_at` TIMESTAMP NULL DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `biz_type` VARCHAR(255) DEFAULT NULL,
  `sp_id` INT(11) DEFAULT NULL,
  `count_num` INT(11) DEFAULT NULL,
  `req_order_id` VARCHAR(255) DEFAULT '',
  `code_feedback_time` TIMESTAMP NULL DEFAULT NULL,
  `code_feedback_result` INT(11) DEFAULT 0,
  `user_id` BIGINT(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_message_id` (`message_id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_app_push_record
CREATE TABLE IF NOT EXISTS `tb_app_push_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `push_channel` VARCHAR(255) DEFAULT NULL,
  `req_order_id` VARCHAR(255) DEFAULT '',
  `push_tokens` TEXT,
  `push_title` VARCHAR(255) DEFAULT NULL,
  `push_summary` VARCHAR(255) DEFAULT NULL,
  `push_content` TEXT,
  `push_url` VARCHAR(255) DEFAULT NULL,
  `push_url_type` INT(11) DEFAULT NULL,
  `push_url_data` VARCHAR(255) DEFAULT NULL,
  `custom_data` TEXT,
  `app_channel` VARCHAR(255) DEFAULT NULL,
  `message_id` VARCHAR(255) DEFAULT NULL,
  `biz_type` VARCHAR(255) DEFAULT NULL,
  `sp_id` INT(11) DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  `push_result` TEXT,
  PRIMARY KEY (`id`),
  KEY `idx_push_channel` (`push_channel`),
  KEY `idx_org_id` (`org_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_app_push_switch
CREATE TABLE IF NOT EXISTS `tb_app_push_switch` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `switch_type` VARCHAR(255) DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_email_template
CREATE TABLE IF NOT EXISTS `tb_email_template` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `template_content` TEXT,
  `language` VARCHAR(255) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_notice_tmpl
CREATE TABLE IF NOT EXISTS `tb_notice_tmpl` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `notice_type` VARCHAR(255) DEFAULT NULL,
  `business_type` VARCHAR(255) DEFAULT NULL,
  `language` VARCHAR(255) DEFAULT NULL,
  `template_content` TEXT,
  `email_subject` VARCHAR(255) DEFAULT NULL,
  `push_title` VARCHAR(255) DEFAULT NULL,
  `push_url` VARCHAR(255) DEFAULT NULL,
  `msg_type` VARCHAR(255) DEFAULT NULL,
  `whole` INT(11) DEFAULT NULL,
  `scenario` VARCHAR(255) DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_email_mx_info
CREATE TABLE IF NOT EXISTS `tb_email_mx_info` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `domain` VARCHAR(255) DEFAULT NULL,
  `mx_ip` VARCHAR(255) DEFAULT NULL,
  `mx_address` VARCHAR(255) DEFAULT NULL,
  `status` INT(11) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_domain` (`domain`),
  KEY `idx_mx_ip` (`mx_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_router_config
CREATE TABLE IF NOT EXISTS `tb_router_config` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `router_type` INT(11) DEFAULT NULL,
  `biz_type` INT(11) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `config` TEXT,
  `status` INT(11) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`org_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_user_anti_phishing_code
CREATE TABLE IF NOT EXISTS `tb_user_anti_phishing_code` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `user_id` BIGINT(20) DEFAULT NULL,
  `anti_phishing_code` VARCHAR(255) DEFAULT NULL,
  `salt` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_user` (`org_id`, `user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sp_account_info
CREATE TABLE IF NOT EXISTS `tb_sp_account_info` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sp_type` VARCHAR(255) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `default_channel` INT(11) DEFAULT NULL,
  `org_id` BIGINT(20) DEFAULT NULL,
  `org_alias` VARCHAR(255) DEFAULT NULL,
  `access_key_id` VARCHAR(255) DEFAULT NULL,
  `secret_key` VARCHAR(255) DEFAULT NULL,
  `extra_info` TEXT,
  `enable` INT(11) DEFAULT NULL,
  `request_url` VARCHAR(255) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_channel` (`channel`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sms_fee_statistics
CREATE TABLE IF NOT EXISTS `tb_sms_fee_statistics` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `channel` VARCHAR(255) DEFAULT NULL,
  `statistics_time` BIGINT(20) DEFAULT NULL,
  `price_unit` VARCHAR(255) DEFAULT NULL,
  `price` DECIMAL(18,8) DEFAULT NULL,
  `count` BIGINT(20) DEFAULT NULL,
  `last_record_id` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_channel_time` (`org_id`, `channel`, `statistics_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sms_tmpl_mapping
CREATE TABLE IF NOT EXISTS `tb_sms_tmpl_mapping` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `org_id` BIGINT(20) DEFAULT NULL,
  `source_channel` VARCHAR(255) DEFAULT NULL,
  `source_tmpl_id` VARCHAR(255) DEFAULT NULL,
  `target_channel` VARCHAR(255) DEFAULT NULL,
  `target_tmpl_id` VARCHAR(255) DEFAULT NULL,
  `tmpl_content` TEXT,
  `status` INT(11) DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tb_sms_tmpl_map
CREATE TABLE IF NOT EXISTS `tb_sms_tmpl_map` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `sp_id` INT(11) DEFAULT NULL,
  `sign_name` VARCHAR(255) DEFAULT NULL,
  `origin_tmpl_id` INT(11) DEFAULT NULL,
  `target_channel` VARCHAR(255) DEFAULT NULL,
  `target_tmpl_id` VARCHAR(255) DEFAULT NULL,
  `target_tmpl_content` TEXT,
  `target_tmpl_name` VARCHAR(255) DEFAULT NULL,
  `verify_status` INT(11) DEFAULT NULL,
  `remark` VARCHAR(255) DEFAULT NULL,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sp_id` (`sp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

