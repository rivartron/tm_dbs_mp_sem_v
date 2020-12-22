delimiter //

create procedure userPayments (userId int) begin
	select * from listPayments 
	where idUser=userId;
end //

create procedure getPassengerRoute (sCity varchar(20), dCity varchar(20)) begin
select S.idRoute as idRoute,
    S.idCity as idSource,
    S.stopNumber as stopSource,
    D.idCity as idDest,
    D.stopNumber as stopDest
from (
        select *
        from Stops natural
            inner join (
                select idCity
                from Cities
                where nameCity = sCity
            ) as SC
    ) as S
    inner join (
        select *
        from Stops natural
            inner join (
                select idCity
                from Cities
                where nameCity = dCity
            ) as DC
    ) as D on S.idRoute = D.idRoute
where S.stopNumber < D.stopNumber;
end //

create procedure getJourneyRoute (sCity varchar(20), dCity varchar(20)) begin
select S.idRoute as idRoute,
    S.idStop as idSource,
    D.idStop as idDest
from (
        select *
        from Stops natural
            inner join (
                select idCity
                from Cities
                where nameCity = sCity
            ) as SC
    ) as S
    inner join (
        select *
        from Stops natural
            inner join (
                select idCity
                from Cities
                where nameCity = dCity
            ) as DC
    ) as D on S.idRoute = D.idRoute
where S.stopNumber < D.stopNumber;
end //

create procedure findBuses (Jdate date, busType varchar(20)) begin
	select * from listBuses natural inner join (
	select idBus 
	from listBuses 
	where typeName = busType and idBus not in (
		select idBus 
		from Journey 
		where JourneyDate = Jdate
		)
	) as Available
where listBuses.idBus = Available.idBus;
end //

create procedure planJourney(cityS varchar(20), cityD varchar(20), jdate date, bus int, route int, driver int, planner int, dtime time(0)) begin
	insert into Journey (startCity,destCity,JourneyDate,idBus,idRoute,idDriver,idAdmin,DepartureTime)
    values (cityS, cityD, jdate, bus, route, driver, planner, dtime);
end //

create procedure newUser (emailId varchar(255), passwordString varchar(72), nameIn varchar(60), ageIn int, mobileIn varchar(15), addressIn varchar(60)) begin
    insert into Users (email,passwordHash,nameUser,age,mobile_number,addressUser) values (emailId, passwordString, nameIn, ageIn, mobileIn, addressIn);
end //

create procedure addBus (reg_number varchar(10), idType int, odometervalue int) begin
	insert into Buses (reg_number_bus,idType,odometer_read) values (reg_number, idType, odometervalue);
end //

create procedure addCity (cityName varchar(20)) begin
	insert into Cities (nameCity) values (cityName);
end //

create procedure addRoute (totalDist int, descript varchar(30)) begin
	insert into Routes (distanceRoute,descriptionRoute) values (totalDist, descript);
end //

create procedure addDriver (nameIn varchar(60), age int, mobileIn varchar(15), addressIn varchar(60), city varchar(20), licenseNum varchar(15), aadhaarNo char(12), experience char(4)) begin
	insert into Drivers (nameDriver,age,mobile_number,addressDriver,city,license_number,aadhaar_number,experience) values (nameIn, age, mobileIn, addressIn, city, licenseNum, aadhaarNo, experience);
end //

create procedure newBooking (userId int) begin
	insert into PaymentDetails (statusPayment, methodPayment, idUser)
    values ("FAILED", "CASH", userId);
    
    set @idPayDetail = last_insert_id();
    
    insert into Payments (timestampPayment, amountPayment, idPaymentDetails)
    values (now(), 0, @idPayDetail);
    
    set @idPayment = last_insert_id();
    
    insert into Bookings (passengers, fareTotal, statusBooking, timestampBooking, idPayment, idUser)
    values (0, 0, "Not-Confirmed", now(), @idPayment, userId);
    
    set @idBooking = last_insert_id();
    
    select userId, @idBooking, @idPayment, @idPayDetail;
end //

create procedure addPassenger (bookingId int, journeyId int, namePass varchar(60), agePass int, genPass varchar(6), aadhaarNo varchar(12), sourceCity varchar(20), destCity varchar(20), acPref varchar(6)) begin
	
    set @routeId = (select idRoute from Journey where idJourney=journeyId);
    
    set @busType = (select idType from Buses where idBus=(select Journey.idBus from Journey where idJourney=journeyId));
    set @acfare = (select cost_AC from BusTypes where idType=@busType);
    set @nonacfare = (select cost_nonAC from BusTypes where idType=@busType);
    
    set @distance = (select distanceFromSource from Stops where idRoute=@routeId and Stops.idCity=(select Cities.idCity from Cities where nameCity=sourceCity)) - (select distanceFromSource from Stops where idRoute=@routeId and idCity=(select Cities.idCity from Cities where nameCity=destCity));
    
    if acPref = "AC" then
		set @fare = @acfare;
	else
		set @fare = @nonacfare;
	end if;
    
    insert into Passengers (namePassenger, age, gender, fromCity, toCity, ACtype, farePassenger, aadhaar_number, idBooking, idJourney)
    values (namePass, agePass, genPass, sourceCity, destCity, acPref, @fare, aadhaarNo, bookingId, journeyId);
    
    update Bookings set passengers = passengers + 1, fareTotal = fareTotal + @fare, timestampBooking = now()
    where idBooking = bookingId;
    
end //

create procedure updatePayment (bookingId int) begin
	update Payments set timestampPayment = now(), amountPayment = (select fareTotal from Bookings where idBooking = bookingId)
    where idPayment = (select Bookings.idPayment from Bookings where idBooking = bookingId);
end //

create procedure paymentSuccess (paymentId int, payMethod varchar(16)) begin
	update Payments set timestampPayment = now()
    where idPayment = paymentId;
    update PaymentDetails set statusPayment = "PAID", methodPayment = payMethod
    where idPaymentDetails = (select Payments.idPaymentDetails from Payments where idPayment = paymentId);
end //

create procedure paymentReversed (paymentId int, payMethod varchar(16)) begin
	update Payments set timestampPayment = now()
    where idPayment = paymentId;
	update PaymentDetails set statusPayment = "REVERSED", methodPayment = payMethod
    where idPaymentDetails = (select Payments.idPaymentDetails from Payments where idPayment = paymentId);
end //

create procedure paymentFailed (paymentId int, payMethod varchar(16)) begin
	update Payments set timestampPayment = now()
    where idPayment = paymentId;
	update PaymentDetails set statusPayment = "FAILED", methodPayment = payMethod
    where idPaymentDetails = (select Payments.idPaymentDetails from Payments where idPayment = paymentId);
end //

delimiter ;