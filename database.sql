-- MySQL Script generated by MySQL Workbench
-- Mon Jul  1 08:33:28 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema e-lavanderia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e-lavanderia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e-lavanderia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `e-lavanderia` ;

-- -----------------------------------------------------
-- Table `e-lavanderia`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`user_role` (
  `id_user_role` TINYINT(6) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_user_role`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`users` (
  `id_users` INT(11) NOT NULL AUTO_INCREMENT,
  `id_user_role` TINYINT(6) NOT NULL,
  `type` TINYINT(6) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` INT(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` TINYINT(6) NULL DEFAULT NULL,
  `date_birth` DATE NOT NULL,
  `cpf` INT(11) NOT NULL,
  `cnpj` INT(11) NOT NULL,
  `address_fav` INT(11) NOT NULL,
  `card_fav` INT(11) NOT NULL,
  `branch_fav` TINYINT(6) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `update_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_users`, `email`, `card_fav`, `address_fav`, `cnpj`, `cpf`),
  INDEX `fk_users_user_role1_idx` (`id_user_role` ASC) VISIBLE,
  CONSTRAINT `fk_users_user_role1`
    FOREIGN KEY (`id_user_role`)
    REFERENCES `e-lavanderia`.`user_role` (`id_user_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`address` (
  `id_address` INT(11) NOT NULL,
  `id_client` INT(11) NULL DEFAULT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal_code` INT(8) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `address_num` INT(5) NOT NULL,
  `address_ref` VARCHAR(255) NULL DEFAULT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_address`),
  INDEX `fk_address_users1_idx` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_address_users1`
    FOREIGN KEY (`id_client`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`bank` (
  `id_bank` TINYINT(6) NOT NULL,
  `type` TINYINT(2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_bank`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`branch_office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`branch_office` (
  `id_branch_office` TINYINT(6) NOT NULL,
  `cnpj` INT(14) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `id_address` INT(11) NOT NULL,
  `max_range` INT(4) NOT NULL,
  PRIMARY KEY (`id_branch_office`, `cnpj`, `id_address`, `email`),
  INDEX `fk_branch_office_address1_idx` (`id_address` ASC) VISIBLE,
  CONSTRAINT `fk_branch_office_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `e-lavanderia`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`card` (
  `id_card` INT(11) NOT NULL AUTO_INCREMENT,
  `id_client` INT(11) NOT NULL,
  `cc_type` INT(3) NOT NULL,
  `id_bank` TINYINT(6) NOT NULL,
  `cc_number` INT(16) NOT NULL,
  `exp_date` DATE NOT NULL,
  `cc_name` VARCHAR(150) NOT NULL,
  `billing_address` INT(11) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_card`),
  INDEX `fk_card_bank_idx` (`id_bank` ASC) VISIBLE,
  INDEX `fk_card_address1_idx` (`billing_address` ASC) VISIBLE,
  CONSTRAINT `fk_card_bank`
    FOREIGN KEY (`id_bank`)
    REFERENCES `e-lavanderia`.`bank` (`id_bank`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_address1`
    FOREIGN KEY (`billing_address`)
    REFERENCES `e-lavanderia`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`cc_use`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`cc_use` (
  `id_cc_use` INT(11) NOT NULL,
  `id_cc` INT(11) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `inseted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_cc_use`),
  INDEX `fk_cc_use_card1_idx` (`id_cc` ASC) VISIBLE,
  CONSTRAINT `fk_cc_use_card1`
    FOREIGN KEY (`id_cc`)
    REFERENCES `e-lavanderia`.`card` (`id_card`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`check_use`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`check_use` (
  `id_check_use` INT(11) NOT NULL,
  `id_bank` TINYINT(6) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `check_number` INT(20) NOT NULL,
  `check_date` DATETIME NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_check_use`, `check_number`),
  INDEX `fk_cheque_use_bank1_idx` (`id_bank` ASC) VISIBLE,
  CONSTRAINT `fk_cheque_use_bank1`
    FOREIGN KEY (`id_bank`)
    REFERENCES `e-lavanderia`.`bank` (`id_bank`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`coupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`coupon` (
  `idcoupon` INT(11) NOT NULL AUTO_INCREMENT,
  `type` TINYINT(6) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `max_client` INT(11) NULL DEFAULT NULL,
  `max_uses` INT(11) NULL DEFAULT NULL,
  `uses` INT(11) NULL DEFAULT NULL,
  `active` ENUM('true,false') NULL DEFAULT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`idcoupon`, `code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`coupon_use`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`coupon_use` (
  `id_coupon_use` INT(11) NOT NULL AUTO_INCREMENT,
  `id_coupons` INT(11) NOT NULL,
  `id_client` INT(11) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_coupon_use`),
  INDEX `fk_coupon_use_coupon1_idx` (`id_coupons` ASC) VISIBLE,
  INDEX `fk_coupon_use_users1_idx` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_coupon_use_coupon1`
    FOREIGN KEY (`id_coupons`)
    REFERENCES `e-lavanderia`.`coupon` (`idcoupon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coupon_use_users1`
    FOREIGN KEY (`id_client`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`payment` (
  `id_payment` INT(11) NOT NULL AUTO_INCREMENT,
  `id_client` INT(10) NOT NULL,
  `id_coupon_use` INT(11) NOT NULL,
  `amount_pay` DOUBLE NOT NULL DEFAULT '0',
  `amount_total` DOUBLE NOT NULL DEFAULT '0',
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_payment`),
  INDEX `fk_payment_users1_idx` (`id_client` ASC) VISIBLE,
  INDEX `fk_payment_coupon_use1_idx` (`id_coupon_use` ASC) VISIBLE,
  CONSTRAINT `fk_payment_users1`
    FOREIGN KEY (`id_client`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_coupon_use1`
    FOREIGN KEY (`id_coupon_use`)
    REFERENCES `e-lavanderia`.`coupon_use` (`id_coupon_use`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`operations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`operations` (
  `id_operations` INT(11) NOT NULL,
  `type` TINYINT(6) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `operator` INT(11) NOT NULL,
  `id_payment` INT(11) NOT NULL,
  `id_cheque_use` INT(11) NOT NULL,
  `id_cc_use` INT(11) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_operations`, `id_cc_use`, `id_cheque_use`),
  INDEX `fk_operations_payment1_idx` (`id_payment` ASC) VISIBLE,
  INDEX `fk_operations_cheque_use1_idx` (`id_cheque_use` ASC) VISIBLE,
  INDEX `fk_operations_cc_use1_idx` (`id_cc_use` ASC) VISIBLE,
  CONSTRAINT `fk_operations_payment1`
    FOREIGN KEY (`id_payment`)
    REFERENCES `e-lavanderia`.`payment` (`id_payment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_operations_cheque_use1`
    FOREIGN KEY (`id_cheque_use`)
    REFERENCES `e-lavanderia`.`check_use` (`id_check_use`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_operations_cc_use1`
    FOREIGN KEY (`id_cc_use`)
    REFERENCES `e-lavanderia`.`cc_use` (`id_cc_use`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`shipping` (
  `id_shipping` INT NOT NULL AUTO_INCREMENT,
  `id_order` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `driver` VARCHAR(45) NOT NULL,
  `branch_office` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `receiver_name` VARCHAR(145) NULL,
  `receiver_cpf` INT NULL,
  `note` VARCHAR(255) NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_shipping`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`orders` (
  `id_orders` INT(11) NOT NULL,
  `id_client` INT(11) NOT NULL,
  `id_payment` INT(11) NOT NULL,
  `id_address` INT(11) NOT NULL,
  `id_branch_office` TINYINT(6) NOT NULL,
  `id_shipping_first` INT NOT NULL,
  `id_shipping_second` INT NOT NULL,
  `status` TINYINT(6) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_orders`, `id_payment`, `id_shipping_first`, `id_shipping_second`),
  INDEX `fk_orders_payment1_idx` (`id_payment` ASC) VISIBLE,
  INDEX `fk_orders_users1_idx` (`id_client` ASC) VISIBLE,
  INDEX `fk_orders_address1_idx` (`id_address` ASC) VISIBLE,
  INDEX `fk_orders_branch_office1_idx` (`id_branch_office` ASC) VISIBLE,
  INDEX `fk_orders_shipping1_idx` (`id_shipping_first` ASC) VISIBLE,
  INDEX `fk_orders_shipping2_idx` (`id_shipping_second` ASC) VISIBLE,
  CONSTRAINT `fk_orders_payment1`
    FOREIGN KEY (`id_payment`)
    REFERENCES `e-lavanderia`.`payment` (`id_payment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`id_client`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `e-lavanderia`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_branch_office1`
    FOREIGN KEY (`id_branch_office`)
    REFERENCES `e-lavanderia`.`branch_office` (`id_branch_office`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_shipping1`
    FOREIGN KEY (`id_shipping_first`)
    REFERENCES `e-lavanderia`.`shipping` (`id_shipping`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_shipping2`
    FOREIGN KEY (`id_shipping_second`)
    REFERENCES `e-lavanderia`.`shipping` (`id_shipping`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`session` (
  `id_session` INT(11) NOT NULL AUTO_INCREMENT,
  `id_user` INT(11) NOT NULL,
  `ip` INT(11) NOT NULL,
  `plataform` VARCHAR(45) NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_session`),
  INDEX `fk_session_users1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_session_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`clothes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`clothes` (
  `id_clothes` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_clothes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `id_clothes` INT NOT NULL,
  `amount` INT NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_content_clothes1_idx` (`id_clothes` ASC) VISIBLE,
  INDEX `fk_content_orders1_idx` (`id_order` ASC) VISIBLE,
  CONSTRAINT `fk_content_clothes1`
    FOREIGN KEY (`id_clothes`)
    REFERENCES `e-lavanderia`.`clothes` (`id_clothes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `e-lavanderia`.`orders` (`id_orders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-lavanderia`.`phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e-lavanderia`.`phones` (
  `id_phones` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NULL,
  `phone_number` INT NOT NULL,
  `inserted_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id_phones`),
  INDEX `fk_phones_users1_idx` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_phones_users1`
    FOREIGN KEY (`id_client`)
    REFERENCES `e-lavanderia`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
