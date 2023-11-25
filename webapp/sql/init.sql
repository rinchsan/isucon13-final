TRUNCATE TABLE themes;
TRUNCATE TABLE icons;
TRUNCATE TABLE reservation_slots;
TRUNCATE TABLE tags;
TRUNCATE TABLE livestreams;
TRUNCATE TABLE users;

-- NGワード
DROP TABLE ng_words;
CREATE TABLE `ng_words` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `livestream_id` bigint NOT NULL,
  `word` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ng_words_word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=14358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ライブ配信に対するライブコメント
DROP TABLE IF EXISTS livecomments;
CREATE TABLE `livecomments` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `comment` VARCHAR(255) NOT NULL,
  `tip` BIGINT NOT NULL DEFAULT 0,
  `created_at` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信
DROP TABLE IF EXISTS livestreams;
CREATE TABLE `livestreams` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` text NOT NULL,
  `playlist_url` VARCHAR(255) NOT NULL,
  `thumbnail_url` VARCHAR(255) NOT NULL,
  `start_at` BIGINT NOT NULL,
  `end_at` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信に対するリアクション
DROP TABLE IF EXISTS reactions;
CREATE TABLE `reactions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  -- :innocent:, :tada:, etc...
  `emoji_name` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信とタグの中間テーブル
DROP TABLE IF EXISTS livestream_tags;
CREATE TABLE `livestream_tags` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `livestream_id` BIGINT NOT NULL,
  `tag_id` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- プロフィール画像
DROP TABLE IF EXISTS icons;
CREATE TABLE `icons` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `image` LONGBLOB NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ユーザごとのカスタムテーマ
DROP TABLE IF EXISTS themes;
CREATE TABLE `themes` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `dark_mode` BOOLEAN NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信視聴履歴
DROP TABLE IF EXISTS livestream_viewers_history;
CREATE TABLE `livestream_viewers_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `created_at` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ユーザからのライブコメントのスパム報告
DROP TABLE IF EXISTS livecomment_reports;
CREATE TABLE `livecomment_reports` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `livecomment_id` BIGINT NOT NULL,
  `created_at` BIGINT NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

ALTER TABLE `themes` auto_increment = 1;
ALTER TABLE `icons` auto_increment = 1;
ALTER TABLE `reservation_slots` auto_increment = 1;
ALTER TABLE `livestream_tags` auto_increment = 1;
ALTER TABLE `livestream_viewers_history` auto_increment = 1;
ALTER TABLE `livecomment_reports` auto_increment = 1;
ALTER TABLE `ng_words` auto_increment = 1;
ALTER TABLE `reactions` auto_increment = 1;
ALTER TABLE `tags` auto_increment = 1;
ALTER TABLE `livecomments` auto_increment = 1;
ALTER TABLE `livestreams` auto_increment = 1;
ALTER TABLE `users` auto_increment = 1;

alter table `livestream_tags` add index idx_01(livestream_id);
alter table `reactions` add index idx_01(livestream_id);
alter table `livecomments` add index idx_01(livestream_id, created_at DESC);
alter table `icons` add index idx_01(user_id);
alter table `themes` add index idx_01(user_id);
alter table `livestreams` add index idx_01(user_id);
alter table `livestream_viewers_history` add index idx_01(livestream_id);
alter table `livecomment_reports` add index idx_01(livestream_id);
ALTER TABLE `ng_words` ADD INDEX `idx_ng_words_livestream_id_user_id_created_at`(`livestream_id`,`user_id`,`created_at` DESC);