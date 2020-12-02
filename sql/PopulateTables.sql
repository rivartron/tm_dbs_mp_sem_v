#Administrators

insert into `travel_management_schema`.Admins values (11,"govinds","fakePass1#","Govind Shinde");
insert into `travel_management_schema`.Admins values (null,"sumity","fakePass2#","Sumit Yelikar");
insert into `travel_management_schema`.Admins values (null,"varadv","fakePass3#","Varad Vaishnav");

#BusTypes

insert into `travel_management_schema`.BusTypes values (1001,"AC-Coach",42,8,85,'AC',15,12);
insert into `travel_management_schema`.BusTypes values (NULL,"Coach",42,10,85,'non-AC',null,12);
insert into `travel_management_schema`.BusTypes values (NULL,"AC-Sleeper",30,8,95,'AC',55,45);
insert into `travel_management_schema`.BusTypes values (NULL,"Sleeper",30,10,95,'non-AC',null,45);

#Buses

insert into `travel_management_schema`.Buses values (101,"MH20K3782",1003,0);
insert into `travel_management_schema`.Buses values (null,"MH20K3588",1001,0);
insert into `travel_management_schema`.Buses values (null,"MH20K3529",1001,0);
insert into `travel_management_schema`.Buses values (null,"MH20K5682",1001,0);
insert into `travel_management_schema`.Buses values (null,"MH20K8984",1001,0);
insert into `travel_management_schema`.Buses values (null,"MH20K5086",1003,0);
insert into `travel_management_schema`.Buses values (null,"MH20K2003",1002,0);
insert into `travel_management_schema`.Buses values (null,"MH20K1782",1004,0);

#Users

insert into `travel_management_schema`.Users values (10001,"user1@fakemail.com","userPass1$","User Name1",21,"9876543210","Not Known 888263");
insert into `travel_management_schema`.Users values (null,"user2@fakemail.com","userPass2$","User Name2",22,"9876543211","Not Known 888263");
insert into `travel_management_schema`.Users values (null,"user3@fakemail.com","userPass3$","User Name3",23,"9876543212","Not Known 888263");
insert into `travel_management_schema`.Users values (null,"user4@fakemail.com","userPass4$","User Name4",24,"9876543213","Not Known 888263");
insert into `travel_management_schema`.Users values (null,"user5@fakemail.com","userPass5$","User Name5",25,"9876543214","Not Known 888263");

#Drivers

insert into `travel_management_schema`.Drivers values (2001,"Driver Name1",31,"9786543220","Shaitan Galli Khatra Mehel 453234","Bhootnagar","MH202019876547","123456789101",'lvl2');
insert into `travel_management_schema`.Drivers values (null,"Driver Name2",36,"9784569223","Shaitan Galli Khatra Mehel 453234","Bhootnagar","MH202019876547","123456789101",'lvl3');
insert into `travel_management_schema`.Drivers values (null,"Driver Name3",27,"9783512237","Shaitan Galli Khatra Mehel 453234","Bhootnagar","MH202019876547","123456789101",'lvl1');
insert into `travel_management_schema`.Drivers values (null,"Driver Name4",29,"9785547220","Shaitan Galli Khatra Mehel 453234","Bhootnagar","MH202019876547","123456789101",'lvl2');

#Cities

insert into `travel_management_schema`.Cities values (301,"City1");
insert into `travel_management_schema`.Cities values (null,"City2");
insert into `travel_management_schema`.Cities values (null,"City3");
insert into `travel_management_schema`.Cities values (null,"City4");

#Routes

insert into `travel_management_schema`.Routes values (201,259,"City1-City2-City4-City3");
insert into `travel_management_schema`.Routes values (null,259,"City3-City4-City2-City1");

#Stops

insert into `travel_management_schema`.Stops values (501,301,201,1);
insert into `travel_management_schema`.Stops values (null,302,201,2);
insert into `travel_management_schema`.Stops values (null,303,201,4);
insert into `travel_management_schema`.Stops values (null,304,201,3);
insert into `travel_management_schema`.Stops values (null,303,202,1);
insert into `travel_management_schema`.Stops values (null,304,202,2);
insert into `travel_management_schema`.Stops values (null,302,202,3);
insert into `travel_management_schema`.Stops values (null,301,202,4);
