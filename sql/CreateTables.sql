CREATE TABLE `travel_management_schema`.`Users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(72) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `age` INT NOT NULL,
  `mobile_number` VARCHAR(15) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idUser`));

CREATE TABLE `travel_management_schema`.`Drivers` (
  `idDriver` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `age` INT NOT NULL,
  `mobile_number` VARCHAR(15) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `license_number` VARCHAR(15) NOT NULL,
  `aadhaar_number` VARCHAR(12) NOT NULL,
  `experience` ENUM('lvl1', 'lvl2', 'lvl3') NOT NULL,
  PRIMARY KEY (`idDriver`));

CREATE TABLE `travel_management_schema`.`BusTypes` (
`idType` INT NOT NULL AUTO_INCREMENT,
`typeName` VARCHAR(10) NOT NULL,
`seatsCount` INT NOT NULL,
`mileage` INT NOT NULL,
`avg_speed` INT NOT NULL,
`ACtype` ENUM('AC', 'non-AC') NOT NULL,
`cost_AC` INT,
`cost_non-AC` INT NOT NULL,
PRIMARY KEY (`idType`));

CREATE TABLE `travel_management_schema`.`Buses` (
  `idBus` INT NOT NULL AUTO_INCREMENT,
  `reg_number` VARCHAR(10) NOT NULL,
  `idType` INT NOT NULL,
  `odometer_read` INT NOT NULL,
  PRIMARY KEY (`idBus`),
  FOREIGN KEY (`idType`) REFERENCES `BusTypes`(`idType`));

CREATE TABLE `travel_management_schema`.`Cities` (
  `idCity` INT NOT NULL AUTO_INCREMENT,
  `cityName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCity`));

CREATE TABLE `travel_management_schema`.`Routes` (
  `idRoute` INT NOT NULL AUTO_INCREMENT,
  `distance` INT NOT NULL,
  `description` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idRoute`));

CREATE TABLE `travel_management_schema`.`Stops` (
  `idStop` INT NOT NULL AUTO_INCREMENT,
  `idCity` INT NOT NULL,
  `idRoute` INT NOT NULL,
  `stop_number` INT NOT NULL,
  PRIMARY KEY (`idStop`),
  FOREIGN KEY (`idCity`) REFERENCES `Cities`(`idCity`),
  FOREIGN KEY (`idRoute`) REFERENCES `Routes`(`idRoute`));

CREATE TABLE `travel_management_schema`.`Journey` (
  `idJourney` INT NOT NULL AUTO_INCREMENT,
  `StartCity` VARCHAR(20) NOT NULL,
  `DestCity` VARCHAR(20) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `idBus` INT NOT NULL,
  `idRoute` INT NOT NULL,
  `idDriver` INT NOT NULL,
  PRIMARY KEY (`idJourney`),
  FOREIGN KEY (`idRoute`) REFERENCES `Routes`(`idRoute`),
  FOREIGN KEY (`idDriver`) REFERENCES `Drivers`(`idDriver`),
  FOREIGN KEY (`idBus`) REFERENCES `Buses`(`idBus`));

CREATE TABLE `travel_management_schema`.`PaymentDetails` (
  `idPaymentDetails` INT NOT NULL AUTO_INCREMENT,
  `status` ENUM('PAID', 'FAILED', 'REVERSED') NOT NULL,
  `method` ENUM('Internet Banking', 'UPI', 'DEBIT/CREDIT CARD', 'E-WALLET', 'CASH') NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idPaymentDetails`),
  FOREIGN KEY (`idUser`) REFERENCES `Users`(`idUser`));

CREATE TABLE `travel_management_schema`.`Payments` (
  `idPayment` INT NOT NULL AUTO_INCREMENT,
  `timestamp` TIMESTAMP NOT NULL,
  `amount` INT NOT NULL,
  `idPaymentDetails` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  FOREIGN KEY (`idPaymentDetails`) REFERENCES `PaymentDetails`(`idPaymentDetails`));
  
CREATE TABLE `travel_management_schema`.`Bookings` (
  `idBooking` INT NOT NULL AUTO_INCREMENT,
  `passengers` INT NOT NULL,
  `fareTotal` INT NOT NULL,
  `status` ENUM('Confirmed', 'Not-Confirmed', 'Cancelled') NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `idPayment` INT NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idBooking`),
  FOREIGN KEY (`idPayment`) REFERENCES `Payments`(`idPayment`),
  FOREIGN KEY (`idUser`) REFERENCES `Users`(`idUser`));
  
CREATE TABLE `travel_management_schema`.`Passengers` (
  `idPassenger` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `age` INT NOT NULL,
  `gender` ENUM('Male', 'Female') NOT NULL,
  `fromCity` VARCHAR(20) NOT NULL,
  `toCity` VARCHAR(20) NOT NULL,
  `ACtype` ENUM('AC', 'non-AC') NOT NULL,
  `fare` INT NOT NULL,
  `aadhaar_number` VARCHAR(12) NOT NULL,
  `idBooking` INT NOT NULL,
  `idJourney` INT NOT NULL,
  PRIMARY KEY (`idPassenger`),
  FOREIGN KEY (`idBooking`) REFERENCES `Bookings`(`idBooking`),
  FOREIGN KEY (`idJourney`) REFERENCES `Journey`(`idJourney`));
  