SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `tez` DEFAULT CHARACTER SET latin1 ;
USE `tez` ;

-- -----------------------------------------------------
-- Table `tez`.`bolumler`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bolumler` (
  `bolum_ad` VARCHAR(512) NOT NULL  ,
  `f_ad` VARCHAR(512) NOT NULL ,
  PRIMARY KEY (`f_ad`,`bolum_ad`) );


-- -----------------------------------------------------
-- Table `tez`.`dersler`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`dersler` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `ad` VARCHAR(100) NULL DEFAULT NULL ,
  `ders_kodu` VARCHAR(100) NULL DEFAULT NULL ,
   `bolumler_f_ad` VARCHAR(500) NOT NULL ,
  `bolumler_bolum_ad` VARCHAR(500) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_dersler_bolumler1` (`bolumler_f_ad` ASC, `bolumler_bolum_ad` ASC) ,
  UNIQUE INDEX `ders_kodu_UNIQUE` (`ders_kodu` ASC) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`sinavlar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`sinavlar` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tarih` DATE NULL DEFAULT NULL ,
  `basla_zaman` TIME NULL DEFAULT NULL ,
  `bit_zaman` TIME NULL DEFAULT NULL ,
  `aciklama` VARCHAR(1000) NULL DEFAULT NULL ,
  `dersler_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_sinavlar_dersler1` (`dersler_id` ASC)  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`degerlendirme`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`degerlendirme` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `not_aralik1` INT(11) NULL DEFAULT NULL ,
  `not_aralik2` INT(11) NULL DEFAULT NULL ,
   `harf` VARCHAR(10) NULL DEFAULT NULL ,
  `sinavlar_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_degerlendirme_sinavlar1` (`sinavlar_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`kullanicilar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`kullanicilar` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `sifre` VARCHAR(30) NULL DEFAULT NULL ,
  `aktif` TINYINT(1) NULL DEFAULT '0' ,
  `onay` TINYINT(1) NULL DEFAULT '0' ,
  `email` VARCHAR(100) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`statu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`statu` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `statu_ad` VARCHAR(20) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `statu_ad_UNIQUE` (`statu_ad` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`kullanici_bilgi`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`kullanici_bilgi` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL ,
  `ad` VARCHAR(20) NULL DEFAULT NULL ,
  `soyad` VARCHAR(20) NULL DEFAULT NULL ,
  `uyelik_tarih` DATE NULL ,
  `kullanicilar_id` INT NOT NULL ,
  `statu_id` INT(11) NOT NULL ,
  `bolumler_f_ad` VARCHAR(500) NOT NULL ,
  `bolumler_bolum_ad` VARCHAR(500) NOT NULL ,
  INDEX `fk_kullanici_bilgi_kullanicilar1` (`kullanicilar_id` ASC) ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_kullanici_bilgi_statu1` (`statu_id` ASC) ,
  INDEX `fk_kullanici_bilgi_bolumler1` (`bolumler_f_ad` ASC, `bolumler_bolum_ad` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`sorular`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`sorular` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `soru_metin` VARCHAR(5000) NULL DEFAULT NULL ,
  `sinavlar_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_sorular_sinavlar1` (`sinavlar_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`siklar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`siklar` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `dogru_mu` TINYINT(1) NULL DEFAULT NULL ,
  `sik_metin` VARCHAR(5000) NULL DEFAULT NULL ,
  `sorular_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_siklar_sorular1` (`sorular_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`ogrenci_sinav_soru`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`ogrenci_sinav_soru` (
  `sinavlar_id` INT(11) NOT NULL ,
  `sorular_id` INT(11) NOT NULL ,
  `siklar_id` INT(11) NOT NULL ,
  `kullanicilar_id` INT NOT NULL ,
  PRIMARY KEY (`sinavlar_id`, `sorular_id`,  `kullanicilar_id`) ,
  INDEX `fk_ogrenci_sinav_soru_sinavlar1` (`sinavlar_id` ASC) ,
  INDEX `fk_ogrenci_sinav_soru_sorular1` (`sorular_id` ASC) ,
  INDEX `fk_ogrenci_sinav_soru_kullanicilar1` (`kullanicilar_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`sinav_sonuc`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`sinav_sonuc` (
   `dogru_sayi` INT(11) NULL DEFAULT NULL ,
  `yanlis_sayi` INT(11) NULL DEFAULT NULL ,
  `bos_sayi` INT(11) NULL DEFAULT NULL ,
  `puan` INT(11) NULL DEFAULT NULL ,
  `harf` VARCHAR(10) NULL DEFAULT NULL ,
   `sinavlar_id` INT(11) NOT NULL ,
  `kullanicilar_id` INT NOT NULL ,
  PRIMARY KEY (`sinavlar_id`,`kullanicilar_id`) ,
  INDEX `fk_sinav_sonuc_sinavlar1` (`sinavlar_id` ASC) ,
  INDEX `fk_sinav_sonuc_kullanicilar1` (`kullanicilar_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`uyelik_istek`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`uyelik_istek` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(100) NULL DEFAULT NULL ,
  `sifre` VARCHAR(30) NULL DEFAULT NULL ,
  `ad` VARCHAR(50) NULL DEFAULT NULL ,
  `soyad` VARCHAR(50) NULL DEFAULT NULL ,
  `statu_id` INT(11) NOT NULL ,
  `bolumler_f_ad` VARCHAR(500) NOT NULL ,
  `bolumler_bolum_ad` VARCHAR(500) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_uyelik_istek_statu1` (`statu_id` ASC) ,
  INDEX `fk_uyelik_istek_bolumler1` (`bolumler_f_ad` ASC, `bolumler_bolum_ad` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`dersler_has_kullanicilar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`dersler_has_kullanicilar` (
  `dersler_id` INT(11) NOT NULL ,
  `kullanicilar_id` INT NOT NULL ,
  PRIMARY KEY (`dersler_id`, `kullanicilar_id`) ,
  INDEX `fk_dersler_has_kullanicilar_kullanicilar1` (`kullanicilar_id` ASC) ,
  INDEX `fk_dersler_has_kullanicilar_dersler1` (`dersler_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tez`.`kullanicilar_has_sinavlar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tez`.`kullanicilar_has_sinavlar` (
  `kullanicilar_id` INT NOT NULL ,
  `sinavlar_id` INT(11) NOT NULL ,
  `bas_zaman` DATETIME NULL ,
  `bit_zaman` DATETIME NULL ,
  PRIMARY KEY (`kullanicilar_id`, `sinavlar_id`) ,
  INDEX `fk_kullanicilar_has_sinavlar1_sinavlar1` (`sinavlar_id` ASC) ,
  INDEX `fk_kullanicilar_has_sinavlar1_kullanicilar1` (`kullanicilar_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into statu (`statu_ad`) values ('Ogrenci');
insert into statu (`statu_ad`) values ('O. Gorevlisi');

INSERT INTO `tez`.`bolumler` (`bolum_ad`, `f_ad`) VALUES ('Bil. Ogrt', 'TEF');
INSERT INTO `tez`.`bolumler` (`bolum_ad`, `f_ad`) VALUES ('Sinif Ogrt.', 'Egitim');
INSERT INTO `tez`.`bolumler` (`bolum_ad`, `f_ad`) VALUES ('Ing Ogrt.', 'Egitim');
