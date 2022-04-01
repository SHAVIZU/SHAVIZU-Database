create database shavizu;

DROP TABLE IF EXISTS `tbl_shop_image`;
DROP TABLE IF EXISTS `tbl_inventory`;
DROP TABLE IF EXISTS `tbl_sell`;
DROP TABLE IF EXISTS `tbl_item_size`;
DROP TABLE IF EXISTS `tbl_item`;
DROP TABLE IF EXISTS `tbl_shop_information`;
DROP TABLE IF EXISTS `tbl_brand`;
DROP TABLE IF EXISTS `tbl_shop`;

CREATE TABLE `tbl_shop` (
	`id`	BIGINT	NOT NULL,
   	`user_id` VARCHAR(12) NOT NULL UNIQUE,
	`password`	CHAR(60)	NOT NULL,
    	`name` VARCHAR(45) NOT NULL,
	`created_at`	DATETIME	NOT NULL,
	`registration_number`	VARCHAR(12)	NOT NULL UNIQUE,
	`boss_name`	VARCHAR(10)	NOT NULL,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_shop_information` (
	`id`	BIGINT	NOT NULL,
	`telephone`	VARCHAR(11)	NOT NULL,
	`address`	VARCHAR(100)	NOT NULL,
	`opening_hours`	VARCHAR(200)	NOT NULL,
	`description`	VARCHAR(150)	NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `tbl_shop` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_brand` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL UNIQUE,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_item` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT,
	`name`	VARCHAR(50)	NOT NULL,
	`brand_id`	BIGINT	NOT NULL,
	`style_code`	VARCHAR(20)	NOT NULL UNIQUE,
	`category`	VARCHAR(10)	NOT NULL,
	`image_url`	VARCHAR(255)	NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`brand_id`) REFERENCES `tbl_brand` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_item_size` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT,
	`item_id`	BIGINT	NOT NULL,
	`size`	VARCHAR(10)	NOT NULL,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_sell` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT,
	`shop_id`	BIGINT	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`price`	INTEGER	NOT NULL,
	`discount_rate`	TINYINT	NULL,
	`discount_price`	INTEGER	NULL,
	`created_at`	DATETIME	NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`shop_id`) REFERENCES `tbl_shop` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_inventory` (
	`sell_id`	BIGINT	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`amount`	BIGINT	NOT NULL,
    PRIMARY KEY (`sell_id`, `item_id`),
    FOREIGN KEY (`sell_id`) REFERENCES `tbl_sell` (`id`),
    FOREIGN KEY (`item_id`) REFERENCES `tbl_item_size` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_shop_image` (
	`id`	BIGINT NOT NULL,
    	`shop_id` BIGINT NOT NULL,
	`image_url`	VARCHAR(255)	NOT NULL,
	`is_representative`	BIT	NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `tbl_shop` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `tbl_item_size` ADD UNIQUE (`item_id`, `size`);
ALTER TABLE `tbl_sell` ADD UNIQUE (`shop_id`, `item_id`);
