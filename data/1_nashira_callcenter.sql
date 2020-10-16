-- MySQL Script generated by MySQL Workbench
-- Tue Jun 16 20:23:40 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nashira_callcenter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nashira_callcenter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nashira_callcenter` DEFAULT CHARACTER SET utf8 ;
USE `nashira_callcenter` ;

-- -----------------------------------------------------
-- Table `nashira_callcenter`.`authorities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`authorities` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`authorities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `alias` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`users` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `username` VARCHAR(60) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  `image` VARCHAR(150) NULL,
  `authorities_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_users_authorities1_idx` (`authorities_id` ASC),
  CONSTRAINT `fk_users_authorities1`
    FOREIGN KEY (`authorities_id`)
    REFERENCES `nashira_callcenter`.`authorities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`actions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`actions` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`actions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `action_date` DATETIME NOT NULL,
  `host` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`login_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`login_history` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`login_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `session_id` VARCHAR(50) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NULL,
  `host` VARCHAR(45) NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_login_history_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_login_history_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `nashira_callcenter`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`breaks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`breaks` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`breaks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `break_type` VARCHAR(45) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NULL,
  `host` VARCHAR(45) NOT NULL,
  `duration` INT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_breaks_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_breaks_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `nashira_callcenter`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`licenses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`licenses` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`licenses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `max_date` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0,
  `activation_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`database`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`database` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`database` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `success_goal` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`client_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`client_info` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`client_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `database_id` INT NOT NULL,
  `identification_number` VARCHAR(20) NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_info_database1_idx` (`database_id` ASC),
  CONSTRAINT `fk_client_info_database1`
    FOREIGN KEY (`database_id`)
    REFERENCES `nashira_callcenter`.`database` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`status` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`substatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`substatus` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`substatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `management_enabler` TINYINT NOT NULL,
  `recall_enabler` TINYINT NOT NULL,
  `manageable` TINYINT NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_substatus_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_substatus_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `nashira_callcenter`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`call_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`call_info` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`call_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attempts` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `start_date` DATETIME NULL,
  `agent_name` VARCHAR(45) NULL,
  `scheduling_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `observation` LONGTEXT NULL,
  `client_info_id` INT NOT NULL,
  `substatus_id` INT NOT NULL,
  `substatus_detail` VARCHAR(45) NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_call_info_client_info1_idx` (`client_info_id` ASC),
  INDEX `fk_call_info_substatus1_idx` (`substatus_id` ASC),
  INDEX `fk_call_info_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_call_info_client_info1`
    FOREIGN KEY (`client_info_id`)
    REFERENCES `nashira_callcenter`.`client_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_call_info_substatus1`
    FOREIGN KEY (`substatus_id`)
    REFERENCES `nashira_callcenter`.`substatus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_call_info_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `nashira_callcenter`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`client_phones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`client_phones` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`client_phones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `telephone_number` VARCHAR(45) NOT NULL,
  `telephone_status` VARCHAR(45) NULL,
  `call_attempts` INT NOT NULL DEFAULT 0,
  `callable` TINYINT NOT NULL,
  `client_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_phones_client_info1_idx` (`client_info_id` ASC),
  CONSTRAINT `fk_client_phones_client_info1`
    FOREIGN KEY (`client_info_id`)
    REFERENCES `nashira_callcenter`.`client_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`call_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`call_history` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`call_history` (
  `id` INT NOT NULL,
  `attempt` INT NOT NULL DEFAULT 1,
  `status` VARCHAR(45) NOT NULL,
  `substatus` VARCHAR(45) NULL,
  `substatus_detail` VARCHAR(45) NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `duration_time` VARCHAR(45) NOT NULL,
  `agent_name` VARCHAR(45) NOT NULL,
  `host` VARCHAR(45) NOT NULL,
  `client_info_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_call_history_client_info1_idx` (`client_info_id` ASC),
  CONSTRAINT `fk_call_history_client_info1`
    FOREIGN KEY (`client_info_id`)
    REFERENCES `nashira_callcenter`.`client_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`substatus_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`substatus_detail` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`substatus_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `substatus_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_substatus_detail_substatus1_idx` (`substatus_id` ASC),
  CONSTRAINT `fk_substatus_detail_substatus1`
    FOREIGN KEY (`substatus_id`)
    REFERENCES `nashira_callcenter`.`substatus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`users_authorities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`users_authorities` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`users_authorities` (
  `users_id` INT NOT NULL,
  `authorities_id` INT NOT NULL,
  INDEX `fk_users_authorities_users1_idx` (`users_id` ASC),
  INDEX `fk_users_authorities_authorities1_idx` (`authorities_id` ASC),
  UNIQUE INDEX `unique_users_authorities` (`users_id` ASC, `authorities_id` ASC),
  CONSTRAINT `fk_users_authorities_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `nashira_callcenter`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_authorities_authorities1`
    FOREIGN KEY (`authorities_id`)
    REFERENCES `nashira_callcenter`.`authorities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`configurations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`configurations` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`configurations` (
  `id` INT NOT NULL,
  `max_users_number` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`provinces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`provinces` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`provinces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nashira_callcenter`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nashira_callcenter`.`cities` ;

CREATE TABLE IF NOT EXISTS `nashira_callcenter`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0,
  `provinces_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cities_provinces1_idx` (`provinces_id` ASC),
  CONSTRAINT `fk_cities_provinces1`
    FOREIGN KEY (`provinces_id`)
    REFERENCES `nashira_callcenter`.`provinces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
