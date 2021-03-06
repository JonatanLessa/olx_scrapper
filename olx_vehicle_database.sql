-- MySQL Script generated by MySQL Workbench
-- Mon Apr 18 12:05:40 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DW_olx_vehicle_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DW_olx_vehicle_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DW_olx_vehicle_database` DEFAULT CHARACTER SET utf8 ;
USE `DW_olx_vehicle_database` ;

-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`DM_VEICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`DM_VEICULO` (
  `ID_VEICULO` INT NOT NULL AUTO_INCREMENT,
  `MARCA` VARCHAR(255) NULL,
  `MODELO` VARCHAR(255) NULL,
  `ANO` INT NULL,
  `POTENCIA` INT NULL,
  `KM` INT NULL,
  PRIMARY KEY (`ID_VEICULO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`DM_ANUNCIANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`DM_ANUNCIANTE` (
  `ID_ANUNCIANTE` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(255) NULL,
  `TIPO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_ANUNCIANTE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`DM_TEMPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`DM_TEMPO` (
  `ID_TEMPO` INT NOT NULL AUTO_INCREMENT,
  `ANO` INT NULL,
  `MES` INT NULL,
  `DIA` INT NULL,
  `HORA` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_TEMPO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`DM_LOCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`DM_LOCAL` (
  `ID_LOCAL` INT NOT NULL AUTO_INCREMENT,
  `ESTADO` VARCHAR(45) NULL,
  `CIDADE` VARCHAR(45) NULL,
  `BAIRRO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_LOCAL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`DM_FATO_ANUNCIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`DM_FATO_ANUNCIOS` (
  `VEICULO_ID_VEICULO` INT NOT NULL,
  `ANUNCIANTE_ID_ANUNCIANTE` INT NOT NULL,
  `LOCAL_ID_LOCAL` INT NOT NULL,
  `TEMPO_ID_TEMPO` INT NOT NULL,
  `PRECO` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (`VEICULO_ID_VEICULO`, `ANUNCIANTE_ID_ANUNCIANTE`, `LOCAL_ID_LOCAL`, `TEMPO_ID_TEMPO`),
  INDEX `fk_ANUNCIOS_VEICULO_idx` (`VEICULO_ID_VEICULO` ASC) VISIBLE,
  INDEX `fk_ANUNCIOS_ANUNCIANTE1_idx` (`ANUNCIANTE_ID_ANUNCIANTE` ASC) VISIBLE,
  INDEX `fk_ANUNCIOS_LOCAL1_idx` (`LOCAL_ID_LOCAL` ASC) VISIBLE,
  INDEX `fk_ANUNCIOS_TEMPO1_idx` (`TEMPO_ID_TEMPO` ASC) VISIBLE,
  CONSTRAINT `fk_ANUNCIOS_VEICULO`
    FOREIGN KEY (`VEICULO_ID_VEICULO`)
    REFERENCES `DW_olx_vehicle_database`.`DM_VEICULO` (`ID_VEICULO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ANUNCIOS_ANUNCIANTE1`
    FOREIGN KEY (`ANUNCIANTE_ID_ANUNCIANTE`)
    REFERENCES `DW_olx_vehicle_database`.`DM_ANUNCIANTE` (`ID_ANUNCIANTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ANUNCIOS_LOCAL1`
    FOREIGN KEY (`LOCAL_ID_LOCAL`)
    REFERENCES `DW_olx_vehicle_database`.`DM_LOCAL` (`ID_LOCAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ANUNCIOS_TEMPO1`
    FOREIGN KEY (`TEMPO_ID_TEMPO`)
    REFERENCES `DW_olx_vehicle_database`.`DM_TEMPO` (`ID_TEMPO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_olx_vehicle_database`.`TMP_ETL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_olx_vehicle_database`.`TMP_ETL` (
  `ID_TMP_ETL` INT NOT NULL AUTO_INCREMENT,
  `MARCA` VARCHAR(255) NULL,
  `MODELO` VARCHAR(255) NULL,
  `ANO_VEICULO` INT NULL,
  `POTENCIA` INT NULL,
  `KM` INT NULL,
  `NOME_ANUNCIANTE` VARCHAR(255) NULL,
  `TIPO_ANUNCIANTE` VARCHAR(45) NULL,
  `ESTADO` VARCHAR(45) NULL,
  `CIDADE` VARCHAR(45) NULL,
  `BAIRRO` VARCHAR(45) NULL,
  `ANO` INT NULL,
  `MES` INT NULL,
  `DIA` INT NULL,
  `HORA` VARCHAR(45) NULL,
  `PRECO` DECIMAL(15,2) NULL,
  PRIMARY KEY (`ID_TMP_ETL`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
