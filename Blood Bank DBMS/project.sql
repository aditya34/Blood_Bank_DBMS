-- CREATE Tables

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema foo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema foo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `foo` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema sys
-- -----------------------------------------------------
USE `foo` ;

-- -----------------------------------------------------
-- Table `foo`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Person` (
  `Person_ID` INT NOT NULL,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Gender` CHAR(2) NULL,
  PRIMARY KEY (`Person_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Donor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Donor` (
  `Contact_Number` VARCHAR(45) NOT NULL,
  `Blood_Type` CHAR(8) NOT NULL,
  `Quantity_Donated` INT(6) NOT NULL,
  `Date_Donated` DATE NOT NULL,
  `Notification_Flag` VARCHAR(4) NOT NULL,
  `Emergency_Contact_Name` VARCHAR(45) NOT NULL,
  `Emergency_Contact_Number` VARCHAR(15) NOT NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Contact_Number`, `Person_ID`),
  UNIQUE INDEX `Contact_Number_UNIQUE` (`Contact_Number` ASC),
  INDEX `fk_Donor_Person1_idx` (`Person_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Location` (
  `Pincode` INT NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pincode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Hospital` (
  `Hospital_ID` INT NOT NULL AUTO_INCREMENT,
  `Hospital_Name` VARCHAR(45) NOT NULL,
  `Amount_Ordered` INT NULL,
  `Date_Ordered` DATE NOT NULL,
  `Pincode` INT NOT NULL,
  PRIMARY KEY (`Hospital_ID`),
  INDEX `fk_Hospital_Location1_idx` (`Pincode` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Doctor` (
  `Doctor_ID` INT NOT NULL AUTO_INCREMENT,
  `Specialization` VARCHAR(45) NOT NULL,
  `Hospital_ID` INT NOT NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_ID`, `Person_ID`),
  INDEX `fk_Doctor_Hospital1_idx` (`Hospital_ID` ASC),
  INDEX `fk_Doctor_Person1_idx` (`Person_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Recipient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Recipient` (
  `Contact_Number` VARCHAR(45) NOT NULL,
  `Blood_Type` CHAR(8) NOT NULL,
  `Quantity_Recieved` INT NOT NULL,
  `Date_Recieved` DATE NOT NULL,
  `Emergency_Contact_Name` VARCHAR(45) NOT NULL,
  `Emergency_Contact_Number` VARCHAR(15) NOT NULL,
  `Doctor_ID` INT NOT NULL,
  `Hospital_ID` INT NOT NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Contact_Number`, `Person_ID`),
  INDEX `fk_Recipient_Doctor1_idx` (`Doctor_ID` ASC),
  INDEX `fk_Recipient_Hospital1_idx` (`Hospital_ID` ASC),
  UNIQUE INDEX `Contact_Number_UNIQUE` (`Contact_Number` ASC),
  INDEX `fk_Recipient_Person1_idx` (`Person_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Campaign` (
  `Campaign_ID` INT NOT NULL,
  `Amount_Collected` INT NOT NULL,
  `No_of_Donors` INT NULL,
  `Pincode` INT NOT NULL,
  INDEX `Campaign_ID` (`Campaign_ID` ASC),
  INDEX `fk_Campaign_Location1_idx` (`Pincode` ASC),
  PRIMARY KEY (`Campaign_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Blood Bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Blood Bank` (
  `BloodBank_ID` INT NOT NULL,
  `BloodBank_Name` VARCHAR(45) NOT NULL,
  `Amount_Stored` INT NOT NULL,
  `Threshold` INT NOT NULL,
  `Pincode` INT NOT NULL,
  PRIMARY KEY (`BloodBank_ID`),
  INDEX `fk_Blood Bank_Location1_idx` (`Pincode` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Donation Campaign Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Donation Campaign Manager` (
  `Manager_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Contact_Number` VARCHAR(45) NOT NULL,
  `Campaign_ID` INT NOT NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Manager_ID`, `Person_ID`),
  INDEX `fk_Donation Campaign Manager_Campaign1_idx` (`Campaign_ID` ASC),
  INDEX `fk_Donation Campaign Manager_Person1_idx` (`Person_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Insurance` (
  `Insurance_ID` VARCHAR(45) NOT NULL,
  `Validity` DATE NOT NULL,
  `Insurance_Company` VARCHAR(45) NOT NULL,
  `Start_Date` DATE NOT NULL,
  PRIMARY KEY (`Insurance_ID`),
  UNIQUE INDEX `Insurance_ID_UNIQUE` (`Insurance_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Confidential_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Confidential_Details` (
  `SSN` VARCHAR(18) NOT NULL,
  `Medical_History` VARCHAR(1000) NOT NULL,
  `DOB` DATE NULL,
  `Person_ID` INT NOT NULL,
  `Insurance_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SSN`, `Person_ID`),
  INDEX `fk_Confidential_Details_Person1_idx` (`Person_ID` ASC),
  INDEX `fk_Confidential_Details_Insurance1_idx` (`Insurance_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Donor_Campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Donor_Campaign` (
  `Contact_Number` VARCHAR(45) NOT NULL,
  `Campaign_ID` INT NOT NULL,
  INDEX `fk_Donor_has_Campaign_Campaign1_idx` (`Campaign_ID` ASC),
  PRIMARY KEY (`Contact_Number`, `Campaign_ID`),
  UNIQUE INDEX `Contact_Number_UNIQUE` (`Contact_Number` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Campaign_Blood Bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Campaign_Blood Bank` (
  `Campaign_ID` INT NOT NULL,
  `BloodBank_ID` INT NOT NULL,
  INDEX `fk_Campaign_has_Blood Bank1_Blood Bank1_idx` (`BloodBank_ID` ASC),
  INDEX `fk_Campaign_has_Blood Bank1_Campaign1_idx` (`Campaign_ID` ASC),
  PRIMARY KEY (`Campaign_ID`, `BloodBank_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foo`.`Blood Bank_Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foo`.`Blood Bank_Hospital` (
  `BloodBank_ID` INT NOT NULL,
  `Hospital_ID` INT NOT NULL,
  `Amount_Ordered` INT NULL,
  `Date_Ordered` DATE NULL,
  INDEX `fk_Blood Bank_has_Hospital_Hospital1_idx` (`Hospital_ID` ASC),
  INDEX `fk_Blood Bank_has_Hospital_Blood Bank1_idx` (`BloodBank_ID` ASC),
  PRIMARY KEY (`BloodBank_ID`, `Hospital_ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'script'

-- end attached script 'script'





-- INSERT Into tables

INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('1', 'Srishti ', 'Bhandari', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('2', 'Pranali', 'Bhosale', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('3', 'Aditya', 'Apte', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('4', 'Akash', 'Manghani', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('5', 'Rahul', 'Kunju', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('6', 'Rohan', 'Bholla', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('7', 'Ronak', 'Shah', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('8', 'Simran', 'Narang', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('9', 'Carlie', 'Casper', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('10', 'Shahrukh', 'Khan', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('11', 'Ruby', 'Patel', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('12', 'Amogh', 'Garg', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('13', 'Kunal', 'Mehta', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('14', 'Rohit', 'Singh', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('15', 'Jennifer', 'Aniston', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('16', 'Rachel ', 'Greene', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('17', 'Monica', 'Geller', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('18', 'Joey', 'Tribbiani', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('19', 'Chandler', 'Bing', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('20', 'Bob', 'Joshi', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('21', 'Nelson', 'Mandela', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('22', 'Kevin', 'Hart', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('23', 'Wayne', 'Rooney', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('24', 'Juan', 'Mata', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('25', 'Ranveer', 'Singhania', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('26', 'Nugyen', 'Do', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('27', 'Fang', 'Shu', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('28', 'Diana', 'Cleves', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('29', 'Saad', 'Abdullah', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('30', 'Jason', 'Marks', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('31', 'John', 'Mayer', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('32', 'Alexis', 'Price', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('33', 'Jon', 'Snow', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('34', 'Christina', 'Yang', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('35', 'Meredith', 'Grey', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('36', 'Alex', 'Karev', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('37', 'Barney', 'Stinson', 'M');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('38', 'Lily', 'Hempden', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('39', 'Julia', 'Baker', 'F');
INSERT INTO `foo`.`person` (`Person_ID`, `First_Name`, `Last_Name`, `Gender`) VALUES ('40', 'Mitch', 'Brown', 'M');


INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8578009840', 'B+', '450', '2017-01-09', 'Y', 'George O\'Malley', '6171234567', '1');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8571234567', 'B-', '225', '2018-02-27', 'N', 'Joe Olson', '6172345678', '2');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8572345679', 'A+', '450', '2017-01-09', 'N', 'Liam Hemsworth', '6173456789', '3');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8573456789', 'O+', '900', '2018-02-27', 'Y', 'Miley Cyrus', '6174567890', '4');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8574567890', 'B-', '225', '2018-02-27', 'Y', 'Lola Stuart', '6175678900', '5');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8575678910', 'AB+', '450', '2017-01-09', 'N', 'Lilian Black', '6176789875', '6');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8576789100', 'B+', '900', '2018-02-27', 'N', 'Harry Potter', '6177890975', '7');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8577898790', 'A-', '225', '2019-03-20', 'N', 'Henry Mickelson', '6178909763', '8');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8578977654', 'AB-', '450', '2018-02-27', 'Y', 'Scott Alan', '6179988765', '9');
INSERT INTO `foo`.`DONOR` (`Contact_Number`, `Blood_Type`, `Quantity_Donated`, `Date_Donated`, `Notification_Flag`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Person_ID`) VALUES ('8579987608', 'A+', '900', '2017-01-09', 'N', 'Charlie Sheen', '6175429607', '10');


INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8571231234', 'O+', '450', '2018-05-03', 'Pawan Chawla', '6179998888', '001', '0001', '11');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8579879876', 'AB-', '225', '2017-03-20', 'Vivek Katikar', '6172225555', '002', '0002', '12');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8574564567', 'B+', '900', '2018-09-11', 'Khushboo Biyani', '8576622233', '003', '0003', '13');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('6171231234', 'A+', '225', '2018-10-06', 'Shreya Khodolikar', '8571113333', '004', '0004', '14');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8575674567', 'B-', '225', '2017-10-21', 'Bhagya Kaprini', '6177775555', '005', '0005', '15');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8570987098', 'O+', '900', '2017-04-30', 'Tarun Sharma', '8571230986', '006', '0006', '16');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('6172569234', 'AB+', '225', '2019-02-28', 'Priyanka Gandhi', '6173344556', '007', '0007', '17');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('6172345890', 'AB-', '225', '2018-12-12', 'Reva Shalgar', '6172134578', '008', '0008', '18');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('8578123109', 'A+', '450', '2018-11-09', 'Shubham Munot', '8571123457', '009', '0009', '19');
INSERT INTO `foo`.`Recipient` (`Contact_Number`, `Blood_Type`, `Quantity_Recieved`, `Date_Recieved`, `Emergency_Contact_Name`, `Emergency_Contact_Number`, `Doctor_ID`, `Hospital_ID`, `Person_ID`) VALUES ('6178945123', 'A-', '225', '2017-11-16', 'Karim Parwani', '8572213456', '010', '0010', '20');
INSERT INTO `foo`.`Recipient` (`Blood_Type`, `Emergency_Contact_Name`) VALUES ('O-', 'Aishwarya Jagtap');


INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('001', 'Cardiologist', '0001', '21');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('002', 'Neurologist', '0002', '22');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('003', 'Gynecologist', '0003', '23');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('004', 'Neurologist', '0004', '24');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('005', 'Cardiologist', '0005', '25');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('006', 'Gynecologist', '0006', '26');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('007', 'Gynecologist', '0007', '27');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('008', 'Cardiologist', '0008', '28');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('009', 'Neurologist', '0009', '29');
INSERT INTO `foo`.`doctor` (`Doctor_ID`, `Specialization`, `Hospital_ID`, `Person_ID`) VALUES ('010', 'Neurologist', '0010', '30');


INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00001', 'ABC', '7164097389', '100', '31');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00002', 'PQR', '7162579202', '101', '32');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00003', 'LMN', '7169034675', '102', '33');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00004', 'EFG', '7162346546', '103', '34');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00005', 'STU', '7168494064', '104', '35');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00006', 'IJK', '7169899307', '105', '36');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00007', 'OPQ', '7168849033', '106', '37');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00008', 'AAA', '7163489088', '107', '38');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00009', 'BBB', '7162254309', '108', '39');
INSERT INTO `foo`.`Donation Campaign Manager` (`Manager_ID`, `Name`, `Contact_Number`, `Campaign_ID`, `Person_ID`) VALUES ('00010', 'CCC', '7165573890', '109', '40');


INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('900', 'Beth Israel ', '18000', '10000', '02120');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('901', 'Partners Care', '18000', '10000', '02210');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('902', 'New England Baptist ', '9000', '5000', '02217');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('903', 'Pacific Blood Center ', '12000', '9000', '02110');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('904', 'Life South Blood Center', '7000', '6000', '02281');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('905', 'Fenway Health', '18000', '8000', '02218');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('906', 'Community Blood Service', '8000', '6000', '02298');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('907', 'Heartland Blood Center', '15000', '8000', '02187');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('908', 'Bloodworks Northwest ', '9000', '5000', '02189');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('909', 'Carter Blood Case', '12000', '9000', '02177');
INSERT INTO `foo`.`Blood Bank` (`BloodBank_ID`, `BloodBank_Name`, `Amount_Stored`, `Threshold`, `Pincode`) VALUES ('910', 'Mass General Hospital', '18000', '14000', '02145');


INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('1', 'Mayo Clinic ', '7985', '2019-01-09', '02219');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('2', 'Fenway Health', '18000', '2019-04-01', '02876');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('3', 'Beth israel', '18000', '2019-03-03', '02215');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('4', 'New England Hospital', '7650', '2019-02-18', '02116');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('5', 'Grace Hospital', '15000', '2019-07=02', '02187');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('6', 'Boston Childrens Hospital', '5640', '2019-01-08', '02115');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('7', 'Boston Medical center ', '7000', '2019-02-10', '02198');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('8', 'Tufts Medical Center', '8700', '2019-03-26', '02198');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('9', 'Faulkner Hospital', '6790', '2019-01-08', '02198');
INSERT INTO `foo`.`Hospital` (`Hospital_ID`, `Hospital_Name`, `Amount_Ordered`, `Date_Ordered`, `Pincode`) VALUES ('10', 'Massachusetts General Hospital', '5400', '2019-04-16', '02110');


INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('900', '1', '7985', '2019-01-09');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('901', '2', '18000', '2019-04-01');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('902', '3', '18000', '2019-03-03');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('903', '4', '7650', '2019-02-18');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('904', '5', '15000', '2019-07-02');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('905', '6', '5640', '2019-01-08');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('906', '7', '7000', '2019-02-10');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('907', '8', '8700', '2019-03-26');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('908', '9', '6790', '2019-01-08');
INSERT INTO `foo`.`Blood Bank_Hospital` (`BloodBank_ID`, `Hospital_ID`, `Amount_Ordered`, `Date_Ordered`) VALUES ('909', '10', '5420', '2019-04-16');


UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'A' WHERE (`Manager_ID` = '1') and (`Person_ID` = '31');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'B' WHERE (`Manager_ID` = '2') and (`Person_ID` = '32');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'C' WHERE (`Manager_ID` = '3') and (`Person_ID` = '33');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'D' WHERE (`Manager_ID` = '4') and (`Person_ID` = '34');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'E' WHERE (`Manager_ID` = '5') and (`Person_ID` = '35');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'F' WHERE (`Manager_ID` = '6') and (`Person_ID` = '36');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'G' WHERE (`Manager_ID` = '7') and (`Person_ID` = '37');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'H' WHERE (`Manager_ID` = '8') and (`Person_ID` = '38');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'I' WHERE (`Manager_ID` = '9') and (`Person_ID` = '39');
UPDATE `foo`.`Donation Campaign Manager` SET `Name` = 'J' WHERE (`Manager_ID` = '10') and (`Person_ID` = '40');


INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('100', '8000', '45', '02219');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('101', '10000', '60', '02216');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('102', '6900', '40', '02215');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('103', '8900', '45', '02210');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('104', '8790', '48', '02218');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('105', '11000', '55', '02213');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('106', '12000', '70', '02212');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('107', '8790', '35', '02211');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('108', '10900', '60', '02221');
INSERT INTO `foo`.`Campaign` (`Campaign_ID`, `Amount_Collected`, `No_of_Donors`, `Pincode`) VALUES ('109', '9870', '40', '02229');


INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('02115', 'Boston', 'MA', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('10001', 'NYC', 'NY', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('07302', 'Jersey', 'NJ', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('98190', 'Seattle', 'WA', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('19019', 'Philadelphia', 'Pennsylvania', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('94118', 'San Fransisco', 'California', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('92111', 'San Diego', 'California', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('75212', 'Dallas', 'Texas', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('85202', 'Tempe', 'Arizona', 'US');
INSERT INTO `foo`.`Location` (`Pincode`, `City`, `State`, `Country`) VALUES ('60614', 'Chicago', 'Illinois', 'US');


INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1801', '2019-01-01', 'Blue Cross Blue Shield');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1802', '2019-01-15', 'All State Insurance');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1803', '2019-02-01', 'Religare Insurance');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1804', '2019-02-15', 'Blue Cross Blue Shield');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1805', '2019-03-01', 'Blue Cross Blue Shield');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1806', '2019-03-15', 'American Life Insurance');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1807', '2019-04-01', 'American Life insurance');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1808', '2019-04-15', 'All State Insurance');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1809', '2019-05-01', 'Religare Insurance ');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`) VALUES ('NU1810', '2019-05-15', 'Blue Cross Blue Shield');


UPDATE `foo`.`Blood Bank` SET `Pincode` = '02115' WHERE (`BloodBank_ID` = '905');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '07302' WHERE (`BloodBank_ID` = '900');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '10001' WHERE (`BloodBank_ID` = '902');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '19019' WHERE (`BloodBank_ID` = '901');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '60614' WHERE (`BloodBank_ID` = '903');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '85202' WHERE (`BloodBank_ID` = '906');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '92111' WHERE (`BloodBank_ID` = '907');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '94118' WHERE (`BloodBank_ID` = '908');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '98190' WHERE (`BloodBank_ID` = '909');
UPDATE `foo`.`Blood Bank` SET `Pincode` = '75212' WHERE (`BloodBank_ID` = '910');


UPDATE `foo`.`Location` SET `Pincode` = '02115' WHERE (`Pincode` = '2115');
UPDATE `foo`.`Location` SET `Pincode` = '07302' WHERE (`Pincode` = '7302');


INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('100', '900');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('101', '901');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('102', '902');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('103', '903');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('104', '904');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('105', '905');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('106', '906');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('107', '907');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('108', '908');
INSERT INTO `foo`.`Campaign_Blood Bank` (`Campaign_ID`, `BloodBank_ID`) VALUES ('109', '909');

UPDATE `foo`.`campaign` SET `Pincode` = '2115' WHERE (`Campaign_ID` = '100');
UPDATE `foo`.`campaign` SET `Pincode` = '7302' WHERE (`Campaign_ID` = '101');
UPDATE `foo`.`campaign` SET `Pincode` = '10001' WHERE (`Campaign_ID` = '102');
UPDATE `foo`.`campaign` SET `Pincode` = '19019' WHERE (`Campaign_ID` = '103');
UPDATE `foo`.`campaign` SET `Pincode` = '60614' WHERE (`Campaign_ID` = '104');
UPDATE `foo`.`campaign` SET `Pincode` = '75212' WHERE (`Campaign_ID` = '105');
UPDATE `foo`.`campaign` SET `Pincode` = '85202' WHERE (`Campaign_ID` = '106');
UPDATE `foo`.`campaign` SET `Pincode` = '92111' WHERE (`Campaign_ID` = '107');
UPDATE `foo`.`campaign` SET `Pincode` = '94118' WHERE (`Campaign_ID` = '108');
UPDATE `foo`.`campaign` SET `Pincode` = '98190' WHERE (`Campaign_ID` = '109');


INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201801', '2019-01-01', 'Blue Cross Blue Shield', '2018-01-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201802', '2019-01-15', 'Religare', '2018-01-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201803', '2019-02-01', 'American Family Insurance', '2018-02-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201804', '2019-02-15', 'All State Insurance', '2018-02-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201805', '2019-03-01', 'Religare', '2018-03-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201806', '2019-03-15', 'Blue Cross Blue Shield', '2018-03-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201807', '2019-04-01', 'All State Insurance', '2018-04-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201808', '2019-04-15', 'Religare', '2018-04-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201809', '2019-05-01', 'Blue Cross Blue Shied ', '2018-05-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201810', '2019-05-15', 'All State Insurance', '2018-05-15');


INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8571234567', '100');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8572345679', '101');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8573456789', '102');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8574567890', '103');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8575678910', '104');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8576789100', '105');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8577898790', '106');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8578009840', '107');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8578977654', '108');
INSERT INTO `foo`.`Donor_Campaign` (`Contact_Number`, `Campaign_ID`) VALUES ('8579987608', '109');


INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1234', 'Leg Fracture at age 6', '1990-01-01', '1', 'NU201801');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1235', 'Tonsils Operation', '1991-02-02', '2', 'NU201802');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1236', 'Alergic to oflaxazcin', '1993-03-03', '3', 'NU201803');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1237', 'Acid Reflux', '1994-04-04', '4', 'NU201804');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1238', 'Appendicitis', '1995-05-05', '5', 'NU201805');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-12-1239', 'Arm Fracture ', '1980-01-01', '6', 'NU201806');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1232', 'Skin Allergy ', '1981-01-01', '7', 'NU201807');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1233', 'Tonsils Operation', '1982-02-02', '8', 'NU201808');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1251', 'PTSD', '1982-03-03', '9', 'NU201809');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1262', 'Allergic to ethanol', '1983-04-05', '10', 'NU201810');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1279', 'Diabeties', '1986-08-07', '11', 'NU201811');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1285', 'No serious illness', '1997-01-09', '12', 'NU201812');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1299', 'Gluten Allergy', '1981-02-09', '13', 'NU201813');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-1231', 'Chest Pain ', '1964-02-09', '14', 'NU201814');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-0980', 'Obesity', '2966-09-06', '15', 'NU201815');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-9870', 'No serious illness', '1979-09-07', '16', 'NU201816');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-21-8769', 'Ulcers', '1969-09-19', '17', 'NU201817');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-23-0980', 'HIV', '1992-03-10', '18', 'NU201818');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-09-0897', 'Migranes', '1980-09-16', '19', 'NU201819');
INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-09-0983', 'PCOD', '1995-12-10', '20', 'NU201820');


INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201811', '2019-06-01', 'Religare Insurance', '2018-06-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201812', '2019-06-15', 'All State Insurance', '2018-06-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201813', '2019-07-01', 'Blue Cross Blue Shield', '2018-07-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201814', '2019-08-15', 'All State Insurance', '2018-07-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201815', '2019-08-01', 'All State Insurance', '2018-08-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201816', '2019-09-01', 'Blue Cross Blue Shield', '2018-08-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201817', '2019-09-15', 'Religare Insurance', '2018-09-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201818', '2019-10-01', 'Blue Cross Blue Shield ', '2018-09-15');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201819', '2019-10-15', 'All State Insurance', '2018-10-01');
INSERT INTO `foo`.`Insurance` (`Insurance_ID`, `Validity`, `Insurance_Company`, `Start_Date`) VALUES ('NU201820', '2019-11-01', 'Religare Insurance', '2018-10-15');
UPDATE `foo`.`Insurance` SET `Insurance_Company` = 'Blue Cross Blue Shield ' WHERE (`Insurance_ID` = 'NU201809');
UPDATE `foo`.`Insurance` SET `Insurance_Company` = 'Religare Insurance' WHERE (`Insurance_ID` = 'NU201802');
UPDATE `foo`.`Insurance` SET `Insurance_Company` = 'Religare Insurance' WHERE (`Insurance_ID` = 'NU201805');
UPDATE `foo`.`Insurance` SET `Insurance_Company` = 'Religare Insurance' WHERE (`Insurance_ID` = 'NU201808');

-- TABLE LEVEL CHECK CONSTRAINTS

ALTER TABLE donor
ADD CHECK (Blood_Type IN (‘A+’,'B+','AB+',‘AB-‘,‘A-‘,‘B-‘,‘O+’));


ALTER TABLE person
ADD CHECK (Gender IN (‘F’,'M'));

-- NON-CLUSTERED INDEX

CREATE INDEX IX_ID_Flag ON Donor(Notification_Flag, Person_ID);


-- Add columns based on functions 

ALTER TABLE `Blood Bank`
ADD COLUMN amount_required INT 
GENERATED ALWAYS AS (Threshold - Amount_Stored) STORED;


UPDATE `foo`.`Hospital` SET `Pincode` = '2115' WHERE (`Hospital_ID` = '1');
UPDATE `foo`.`Hospital` SET `Pincode` = '7302' WHERE (`Hospital_ID` = '2');
UPDATE `foo`.`Hospital` SET `Pincode` = '10001' WHERE (`Hospital_ID` = '3');
UPDATE `foo`.`Hospital` SET `Pincode` = '19019' WHERE (`Hospital_ID` = '4');
UPDATE `foo`.`Hospital` SET `Pincode` = '60614' WHERE (`Hospital_ID` = '5');
UPDATE `foo`.`Hospital` SET `Pincode` = '75212' WHERE (`Hospital_ID` = '6');
UPDATE `foo`.`Hospital` SET `Pincode` = '85202' WHERE (`Hospital_ID` = '7');
UPDATE `foo`.`Hospital` SET `Pincode` = '92111' WHERE (`Hospital_ID` = '8');
UPDATE `foo`.`Hospital` SET `Pincode` = '94118' WHERE (`Hospital_ID` = '9');
UPDATE `foo`.`Hospital` SET `Pincode` = '98190' WHERE (`Hospital_ID` = '10');




-- VIEWS

CREATE VIEW east_city_view AS
SELECT loc.City, campmgr.Name, bank.BloodBank_Name, hosp.Hospital_Name, camp.pincode
FROM Location loc, `Donation Campaign Manager`campmgr, `Blood Bank` bank, Hospital hosp, Campaign camp
where camp.campaign_ID = campmgr.campaign_ID
and loc.pincode =  camp.pincode
and bank. Pincode= loc. Pincode
and hosp.Pincode = loc.pincode
and loc.City in ('NYC','Jersey', 'Boston', 'Philadelphia');


CREATE VIEW west_city_view AS
SELECT loc.City, campmgr.Name, bank.BloodBank_Name, hosp.Hospital_Name, camp.pincode
FROM Location loc, `Donation Campaign Manager`campmgr, `Blood Bank` bank, Hospital hosp, Campaign camp
where camp.campaign_ID = campmgr.campaign_ID
and loc.pincode =  camp.pincode
and bank. Pincode= loc. Pincode
and hosp.Pincode = loc.pincode
and loc.City in ('Tempe','San Diego', 'San Fransisco', 'Seattle'); 

CREATE VIEW central_city_view AS
SELECT loc.City, campmgr.Name, bank.BloodBank_Name, hosp.Hospital_Name, camp.pincode
FROM Location loc, `Donation Campaign Manager`campmgr, `Blood Bank` bank, Hospital hosp, Campaign camp
where camp.campaign_ID = campmgr.campaign_ID
and loc.pincode =  camp.pincode
and bank. Pincode= loc. Pincode
and hosp.Pincode = loc.pincode
and loc.City in ('Dallas','Chicago');

-- Stored procedures

Delimiter //
CREATE PROCEDURE GetDonorList_9 (IN blood char(3), OUT DonorNo INT)
BEGIN
select Count(*) AS DonorNo FROM Donor 
WHERE Blood_Type = blood;
END //
 

Delimiter //
CREATE PROCEDURE GetDocInfo_1 ( IN HospID INT, OUT DocFirstName VARCHAR(20), OUT DocLastName VARCHAR(20), OUT Spec VARCHAR (45))
BEGIN
SELECT p.First_Name AS DocFirstName, p.Last_Name AS DocLastName, d.Specialization As Spec
FROM Person p, Doctor d
WHERE d.Hospital_ID = HospID
AND p.person_ID = d.person_ID;
END//

call GetDocInfo_1('1', @DocFirstName,@DocLastName, @Spec)

Delimiter //
CREATE PROCEDURE OrganizeDrive 
(IN In_City VARCHAR(45), 
OUT Flag CHAR (1)
)
BEGIN 
SELECT
CASE 
WHEN Amount_Stored < Threshold  THEN "Y" 
ELSE "N"
END AS Flag
FROM `Blood Bank` b INNER JOIN Location l
ON b.Pincode = l.Pincode
AND l.City = In_City ;
END//

call OrganizeDrive('Jersey',@Flag)


-- TRIGGER 

Alter table Confidential_Details
add column Age INT; 

DELIMITER //
CREATE TRIGGER GetAge
BEFORE INSERT on Confidential_Details 
FOR EACH ROW
BEGIN
SET new.Age = TIMESTAMPDIFF(YEAR, new.DOB, CURDATE());
END; 
//

INSERT INTO `foo`.`Confidential_Details` (`SSN`, `Medical_History`, `DOB`, `Person_ID`, `Insurance_ID`) VALUES ('123-34-0163', 'No serious Illness', '1995-02-27', '20', 'NU201820');

DELIMITER //
CREATE TRIGGER GetValidity
BEFORE INSERT on Insurance
FOR EACH ROW
BEGIN
SET new.Validity_no_of_years = TIMESTAMPDIFF(YEAR, new.Validity, CURDATE());
END;
//
