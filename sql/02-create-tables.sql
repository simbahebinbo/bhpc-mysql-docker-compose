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

