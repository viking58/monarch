-- ============================================
-- MySQL Database Backup for CMS Pages
-- id: INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
-- Timestamps: INT UNSIGNED (Unix Timestamp)
-- ============================================

CREATE DATABASE IF NOT EXISTS cms_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE cms_db;

-- Drop existing table if needed
DROP TABLE IF EXISTS pages;

-- Create pages table
CREATE TABLE pages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  status ENUM('draft', 'published') NOT NULL DEFAULT 'draft',
  seo_title VARCHAR(255) NULL,
  seo_description TEXT NULL,
  seo_keywords TEXT NULL,
  og_image_url TEXT NULL,
  canonical_url TEXT NULL,
  robots_index BOOLEAN NOT NULL DEFAULT TRUE,
  robots_follow BOOLEAN NOT NULL DEFAULT TRUE,
  content JSON NOT NULL,
  created_at INT UNSIGNED NOT NULL DEFAULT (UNIX_TIMESTAMP()),
  updated_at INT UNSIGNED NOT NULL DEFAULT (UNIX_TIMESTAMP())
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for faster lookups
CREATE INDEX idx_pages_slug ON pages (slug);
CREATE INDEX idx_pages_status ON pages (status);
CREATE INDEX idx_pages_updated_at ON pages (updated_at DESC);

-- Auto-update updated_at on row change using a trigger
DELIMITER //
CREATE TRIGGER pages_before_update
BEFORE UPDATE ON pages
FOR EACH ROW
BEGIN
  SET NEW.updated_at = UNIX_TIMESTAMP();
END//
DELIMITER ;
