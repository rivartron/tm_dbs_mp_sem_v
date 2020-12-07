create view listCities as
select nameCity
from Cities;

create view listBuses as
select idBus,
    reg_number_bus,
    odometer_read,
    typeName,
    seatsCount,
    mileage,
    avg_speed,
    ACtype
from Buses
    natural inner join BusTypes;

create view listPayments as
select idPayment,
	amountPayment,
	idPaymentDetails,
    statusPayment,
    methodPayment,
    idUser,
    timestampPayment 
from PaymentDetails 
	natural inner join Payments;