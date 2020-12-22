CREATE TABLE travel_management_schema.Admins (
    idAdmin INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(16) UNIQUE NOT NULL,
    passwordHash VARCHAR(72) NOT NULL,
    nameAdmin VARCHAR(60) NOT NULL,
    PRIMARY KEY (idAdmin)    
);
CREATE TABLE travel_management_schema.Users (
    idUser INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    passwordHash VARCHAR(72) NOT NULL,
    nameUser VARCHAR(60) NOT NULL,
    age INT NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    addressUser VARCHAR(60) NOT NULL,
    PRIMARY KEY (idUser),
    CHECK (age > 18 and age < 110)
);
CREATE TABLE travel_management_schema.Drivers (
    idDriver INT NOT NULL AUTO_INCREMENT,
    nameDriver VARCHAR(60) NOT NULL,
    age INT NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    addressDriver VARCHAR(60) NOT NULL,
    city VARCHAR(20) NOT NULL,
    license_number VARCHAR(15) UNIQUE NOT NULL,
    aadhaar_number VARCHAR(12) UNIQUE NOT NULL,
    experience ENUM('lvl1', 'lvl2', 'lvl3') NOT NULL,
    PRIMARY KEY (idDriver)
);
CREATE TABLE travel_management_schema.BusTypes (
    idType INT NOT NULL AUTO_INCREMENT,
    typeName VARCHAR(10) NOT NULL,
    seatsCount INT NOT NULL,
    mileage INT NOT NULL,
    avg_speed INT NOT NULL,
    ACtype ENUM('AC', 'non-AC') NOT NULL,
    cost_AC INT,
    cost_nonAC INT NOT NULL,
    PRIMARY KEY (idType)
);
CREATE TABLE travel_management_schema.Buses (
    idBus INT NOT NULL AUTO_INCREMENT,
    reg_number_bus VARCHAR(10) UNIQUE NOT NULL,
    idType INT NOT NULL,
    odometer_read INT NOT NULL,
    PRIMARY KEY (idBus),
    FOREIGN KEY (idType) REFERENCES BusTypes(idType)
);
CREATE TABLE travel_management_schema.Cities (
    idCity INT NOT NULL AUTO_INCREMENT,
    nameCity VARCHAR(20) NOT NULL,
    PRIMARY KEY (idCity)
);
CREATE TABLE travel_management_schema.Routes (
    idRoute INT NOT NULL AUTO_INCREMENT,
    distanceRoute INT NOT NULL,
    descriptionRoute VARCHAR(30) NOT NULL,
    PRIMARY KEY (idRoute)
);
CREATE TABLE travel_management_schema.Stops (
    idStop INT NOT NULL AUTO_INCREMENT,
    idCity INT NOT NULL,
    idRoute INT NOT NULL,
    stopNumber INT NOT NULL,
    distanceFromSource INT NOT NULL,
    PRIMARY KEY (idStop),
    FOREIGN KEY (idCity) REFERENCES Cities (idCity),
    FOREIGN KEY (idRoute) REFERENCES Routes (idRoute),
    CHECK(distanceFromSource > 0 OR stopNumber = 1),
    CHECK(stopNumber >= 0)
);
CREATE TABLE travel_management_schema.Journey (
    idJourney INT NOT NULL AUTO_INCREMENT,
    startCity VARCHAR(20) NOT NULL,
    destCity VARCHAR(20) NOT NULL,
    JourneyDate DATE NOT NULL,
    DepartureTime TIME(0) NOT NULL,
    idBus INT NOT NULL,
    idRoute INT NOT NULL,
    idDriver INT NOT NULL,
    idAdmin INT NOT NULL,
    PRIMARY KEY (idJourney),
    FOREIGN KEY (idRoute) REFERENCES Routes (idRoute),
    FOREIGN KEY (idDriver) REFERENCES Drivers (idDriver),
    FOREIGN KEY (idBus) REFERENCES Buses (idBus),
    FOREIGN KEY (idAdmin) REFERENCES Admins (idAdmin)
);
CREATE TABLE travel_management_schema.PaymentDetails (
    idPaymentDetails INT NOT NULL AUTO_INCREMENT,
    statusPayment ENUM('PAID', 'FAILED', 'REVERSED') NOT NULL,
    methodPayment ENUM(
        'Internet Banking',
        'UPI',
        'DEBIT/CREDIT CARD',
        'E-WALLET',
        'CASH'
    ) NOT NULL,
    idUser INT NOT NULL,
    PRIMARY KEY (idPaymentDetails),
    FOREIGN KEY (idUser) REFERENCES Users (idUser)
);
CREATE TABLE travel_management_schema.Payments (
    idPayment INT NOT NULL AUTO_INCREMENT,
    timestampPayment TIMESTAMP NOT NULL,
    amountPayment INT NOT NULL,
    idPaymentDetails INT NOT NULL,
    PRIMARY KEY (idPayment),
    FOREIGN KEY (idPaymentDetails) REFERENCES PaymentDetails (idPaymentDetails)
);
CREATE TABLE travel_management_schema.Bookings (
    idBooking INT NOT NULL AUTO_INCREMENT,
    passengers INT NOT NULL,
    fareTotal INT NOT NULL,
    statusBooking ENUM('Confirmed', 'Not-Confirmed', 'Cancelled') NOT NULL,
    timestampBooking TIMESTAMP NOT NULL,
    idPayment INT NOT NULL,
    idUser INT NOT NULL,
    PRIMARY KEY (idBooking),
    FOREIGN KEY (idPayment) REFERENCES Payments (idPayment),
    FOREIGN KEY (idUser) REFERENCES Users (idUser)
);
CREATE TABLE travel_management_schema.Passengers (
    idPassenger INT NOT NULL AUTO_INCREMENT,
    namePassenger VARCHAR(60) NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    fromCity VARCHAR(20) NOT NULL,
    toCity VARCHAR(20) NOT NULL,
    ACtype ENUM('AC', 'non-AC') NOT NULL,
    farePassenger INT NOT NULL,
    aadhaar_number VARCHAR(12) NOT NULL,
    idBooking INT NOT NULL,
    idJourney INT NOT NULL,
    PRIMARY KEY (idPassenger),
    FOREIGN KEY (idBooking) REFERENCES Bookings (idBooking),
    FOREIGN KEY (idJourney) REFERENCES Journey (idJourney)
);
