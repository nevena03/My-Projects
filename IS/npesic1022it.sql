-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`frizer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`frizer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`frizer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(25) NOT NULL,
  `prezime` VARCHAR(25) NOT NULL,
  `kontakt` CHAR(10) NOT NULL,
  `radno_vreme` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `kontakt_UNIQUE` (`kontakt` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`klijenti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`klijenti` ;

CREATE TABLE IF NOT EXISTS `mydb`.`klijenti` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(25) NOT NULL,
  `prezime` VARCHAR(25) NOT NULL,
  `kontakt` CHAR(10) NOT NULL,
  `adresa` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `kontakt_UNIQUE` (`kontakt` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_termina` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_termina_UNIQUE` (`status_termina` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nacin_placanja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`nacin_placanja` ;

CREATE TABLE IF NOT EXISTS `mydb`.`nacin_placanja` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nacin_placanja` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nacin_placanja_UNIQUE` (`nacin_placanja` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`racun`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`racun` ;

CREATE TABLE IF NOT EXISTS `mydb`.`racun` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum_izdavanja` DATE NOT NULL,
  `nacin_placanja_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_racun_nacin_placanja1_idx` (`nacin_placanja_id` ASC) ,
  CONSTRAINT `fk_racun_nacin_placanja1`
    FOREIGN KEY (`nacin_placanja_id`)
    REFERENCES `mydb`.`nacin_placanja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`termini`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`termini` ;

CREATE TABLE IF NOT EXISTS `mydb`.`termini` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `vreme` VARCHAR(10) NOT NULL,
  `status_id` INT NOT NULL,
  `frizer_id` INT NOT NULL,
  `klijenti_id` INT NOT NULL,
  `racun_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_termini_status_idx` (`status_id` ASC) ,
  INDEX `fk_termini_frizer1_idx` (`frizer_id` ASC) ,
  INDEX `fk_termini_klijenti1_idx` (`klijenti_id` ASC) ,
  INDEX `fk_termini_racun1_idx` (`racun_id` ASC) ,
  CONSTRAINT `fk_termini_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `mydb`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_termini_frizer1`
    FOREIGN KEY (`frizer_id`)
    REFERENCES `mydb`.`frizer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_termini_klijenti1`
    FOREIGN KEY (`klijenti_id`)
    REFERENCES `mydb`.`klijenti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_termini_racun1`
    FOREIGN KEY (`racun_id`)
    REFERENCES `mydb`.`racun` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usluge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usluge` ;

CREATE TABLE IF NOT EXISTS `mydb`.`usluge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(25) NOT NULL,
  `cena` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `usluge_UNIQUE` (`naziv` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stavka_racuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`stavka_racuna` ;

CREATE TABLE IF NOT EXISTS `mydb`.`stavka_racuna` (
  `usluge_id` INT NOT NULL,
  `racun_id` INT NOT NULL,
  `cena` FLOAT NOT NULL,
  INDEX `fk_stavka_racuna_usluge1_idx` (`usluge_id` ASC) ,
  PRIMARY KEY (`racun_id`, `usluge_id`),
  CONSTRAINT `fk_stavka_racuna_usluge1`
    FOREIGN KEY (`usluge_id`)
    REFERENCES `mydb`.`usluge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stavka_racuna_racun1`
    FOREIGN KEY (`racun_id`)
    REFERENCES `mydb`.`racun` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`zalihe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`zalihe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`zalihe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv_proizvoda` VARCHAR(25) NOT NULL,
  `namena_proizvoda` VARCHAR(15) NOT NULL,
  `kolicina_zaliha` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `naziv_proizvoda_UNIQUE` (`naziv_proizvoda` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`koriscen_materijal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`koriscen_materijal` ;

CREATE TABLE IF NOT EXISTS `mydb`.`koriscen_materijal` (
  `zalihe_id` INT NOT NULL,
  `usluge_id` INT NOT NULL,
  INDEX `fk_koriscen_materijal_zalihe1_idx` (`zalihe_id` ASC) ,
  INDEX `fk_koriscen_materijal_usluge1_idx` (`usluge_id` ASC) ,
  PRIMARY KEY (`zalihe_id`, `usluge_id`),
  CONSTRAINT `fk_koriscen_materijal_zalihe1`
    FOREIGN KEY (`zalihe_id`)
    REFERENCES `mydb`.`zalihe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_koriscen_materijal_usluge1`
    FOREIGN KEY (`usluge_id`)
    REFERENCES `mydb`.`usluge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`frizer`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`frizer` (`id`, `ime`, `prezime`, `kontakt`, `radno_vreme`) VALUES (1, 'Snezana', 'Arandjelovic', '0637528362', '08:00-13:00');
INSERT INTO `mydb`.`frizer` (`id`, `ime`, `prezime`, `kontakt`, `radno_vreme`) VALUES (2, 'Jelena', 'Pesic', '0654852310', '13:00-18:00');
INSERT INTO `mydb`.`frizer` (`id`, `ime`, `prezime`, `kontakt`, `radno_vreme`) VALUES (3, 'Milena', 'Gajic', '0613712887', '08:00-13:00');
INSERT INTO `mydb`.`frizer` (`id`, `ime`, `prezime`, `kontakt`, `radno_vreme`) VALUES (4, 'Jelica', 'Mladenovic', '0643125778', '13:00-18:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`klijenti`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (1, 'Filip', 'Milutinovic', '0645145578', 'Sremskog fronta,12,Smederevska Palanka');
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (2, 'Nevena', 'Pesic', '0655864856', 'Cara Dusana,43,Selevac');
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (3, 'Mina', 'Maricic', '0637810165', 'Vladimira Matijevica,12,Beograd');
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (4, 'Jovana', 'Lazic', '0613712880', 'Maksima Gorkog,14,Novi Sad');
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (5, 'Andreja', 'Isailovic', '0651223367', 'Admirala Vukovica,5,Beograd');
INSERT INTO `mydb`.`klijenti` (`id`, `ime`, `prezime`, `kontakt`, `adresa`) VALUES (6, 'Nikola', 'Andric', '0663769288', 'Avalska,18,Smederevska Palanka');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`status`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`status` (`id`, `status_termina`) VALUES (1, 'Zakazan');
INSERT INTO `mydb`.`status` (`id`, `status_termina`) VALUES (2, 'Zavrsen');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`nacin_placanja`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`nacin_placanja` (`id`, `nacin_placanja`) VALUES (1, 'Gotovina');
INSERT INTO `mydb`.`nacin_placanja` (`id`, `nacin_placanja`) VALUES (2, 'Kartica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`racun`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (1, '2023-11-10', 1);
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (2, '2023-12-13', 2);
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (3, '2023-11-14', 1);
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (4, '2023-11-15', 2);
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (5, '2023-12-16', 1);
INSERT INTO `mydb`.`racun` (`id`, `datum_izdavanja`, `nacin_placanja_id`) VALUES (6, '2023-11-17', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`termini`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (3, '2023-11-10', '13:00', 2, 2, 5, 1);
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (4, '2023-12-13', '09:30', 1, 4, 1, 2);
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (5, '2023-11-14', '11:00', 2, 3, 4, 3);
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (6, '2023-11-15', '12:30', 1, 1, 3, 4);
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (7, '2023-12-16', '14:30', 1, 2, 2, 5);
INSERT INTO `mydb`.`termini` (`id`, `datum`, `vreme`, `status_id`, `frizer_id`, `klijenti_id`, `racun_id`) VALUES (8, '2023-11-17', '17:15', 2, 4, 6, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`usluge`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`usluge` (`id`, `naziv`, `cena`) VALUES (1, 'Sisanje', 400);
INSERT INTO `mydb`.`usluge` (`id`, `naziv`, `cena`) VALUES (2, 'Feniranje', 600);
INSERT INTO `mydb`.`usluge` (`id`, `naziv`, `cena`) VALUES (3, 'Pranje_kose', 500);
INSERT INTO `mydb`.`usluge` (`id`, `naziv`, `cena`) VALUES (4, 'Farbanje', 800);
INSERT INTO `mydb`.`usluge` (`id`, `naziv`, `cena`) VALUES (5, 'Stiflizovanje_frizure', 1000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`stavka_racuna`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (1, 1, 400);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (1, 6, 400);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (2, 4, 600);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (2, 5, 600);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (3, 1, 500);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (3, 2, 500);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (3, 5, 500);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (4, 2, 800);
INSERT INTO `mydb`.`stavka_racuna` (`usluge_id`, `racun_id`, `cena`) VALUES (5, 3, 1000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`zalihe`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (1, 'Syoss boja za kosu 3-1 Dark brown', 'Farba za kosu', 10);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (2, 'Syoss boja za kosu 4-1 Middle brown', 'Farba za kosu', 15);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (3, 'Syoss boja za kosu 13-5 Platinum Lightener', 'Farba za kosu', 10);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (4, 'Makaze CHIROFORM LINE 787 - 5\"', 'Sisanje', 10);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (5, 'Philips Masinica za sisanje', 'Sisanje', 5);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (6, 'Cesalj karbonski', 'Sisanje', 20);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (8, 'Sampon bez sulfata za hidrataciju kose', 'Pranje kose', 15);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (9, 'Natural beauty oporavljajuci balzam za kosu', 'Pranje kose', 12);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (10, 'Remington Presa za kosu', 'Stilizovanje frizure', 5);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (11, 'Remington Figaro za kosu', 'Stilizovanje frizure', 4);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (12, 'Cetka za feniranje Nano Technology', 'Feniranje', 5);
INSERT INTO `mydb`.`zalihe` (`id`, `naziv_proizvoda`, `namena_proizvoda`, `kolicina_zaliha`) VALUES (13, 'Beurer Fen HC50', 'Feniranje', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`koriscen_materijal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (13, 2);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (6, 1);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (4, 1);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (11, 5);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (10, 5);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (12, 2);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (9, 3);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (8, 3);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (3, 4);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (1, 4);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (2, 4);
INSERT INTO `mydb`.`koriscen_materijal` (`zalihe_id`, `usluge_id`) VALUES (5, 1);

COMMIT;

