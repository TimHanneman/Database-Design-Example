create table person(
	SSN integer PRIMARY KEY,
	name varchar(64) NOT NULL UNIQUE,
	age integer,
	address varchar(255));

create table company(
	company varchar(255) PRIMARY KEY,
	phone_num varchar(13) NOT NULL);

create table pharmacy(
	store varchar(255) PRIMARY KEY,
	addr varchar(255) NOT NULL,
	phone_num varchar(13));

create table doctor(
	D_SSN integer PRIMARY KEY,
	specialty varchar(64) NOT NULL,
	years_XP integer);

create table patient(
	P_SSN integer,
	D_SSN integer,
	PRIMARY KEY (P_SSN, D_SSN),
	FOREIGN KEY (P_SSN) REFERENCES person(SSN),
	FOREIGN KEY (D_SSN) REFERENCES doctor(D_SSN));

create table drug(
	trade_name varchar(64) PRIMARY KEY,
	formula varchar(255) NOT NULL,
	company varchar(255) NOT NULL,
	FOREIGN KEY (company) REFERENCES company(company)
	on delete cascade);

create table prescription(
	P_SSN integer,
	trade_name varchar(64),
	D_SSN integer,
	date_prescribed date,
	quantity numeric(8,4) NOT NULL,
	PRIMARY KEY (P_SSN, trade_name, D_SSN, date_prescribed),
	FOREIGN KEY (P_SSN) REFERENCES patient(P_SSN),
	FOREIGN KEY (trade_name) REFERENCES drug(trade_name),
	FOREIGN KEY (D_SSN) REFERENCES doctor(D_SSN));

create table inventory(
	store varchar(255),
	trade_name varchar(64),
	price numeric(10,2) NOT NULL,
	PRIMARY KEY (store, trade_name),
	FOREIGN KEY (store) REFERENCES pharmacy(store),
	FOREIGN KEY (trade_name) REFERENCES drug(trade_name));

create table contract(
	company varchar(255),
	store varchar(255),
	start date NOT NULL,
	expire date NOT NULL,
	contract_text varchar(255) NOT NULL,
	supervisor_SSN integer,
	PRIMARY KEY (company, store),
	FOREIGN KEY (company) REFERENCES company(company),
	FOREIGN KEY (store) REFERENCES pharmacy(store),
	FOREIGN KEY (supervisor_SSN) REFERENCES person(SSN));


-- Test Data
-- For this to work you must run each section sequentially, no guarantees for running it all at once.

insert into company values('Generic', '800-000-0000');
insert into company values('1','Ramesh');
insert into company values('biotext','831-555-4555');
insert into company values('Gilead Sciences','191-666-5555');
insert into company values('Acura Pharmaceuticals US Inc.','555-555-5555');
insert into company values('Merck','010-111-0001');



update Company 
set Company = 'Nicolas Flamel', phone_num = 'owl'
where Company = 1



insert into person values(123456789,  'John Doe', 89, 'Bilbury Street. NY, United States');
insert into person values(246824681, 'Smith', 55, 'Broadway, NV, United States');
insert into person values(000000623, 'Al-Zahrawi', 45, 'El-Zahra, Andalusia, Spain');
insert into person values(000000157, 'Galen of Pergamum', 32, 'Pergamum, Rome');
insert into person values(000000023, 'Gaius Plinius Secundus', 40,'Rome, Italy');


insert into person values(123666321, 'Donald', 50, '101010 Old Place, Washington DC, United States');
insert into person values(201900009, 'Anthony Fauci', 79, '101010 Old Place, Washington DC, United States');
insert into person values(318573900, 'Mary Jane', 20, '56 Main Street, Texas, United States');
insert into person values(392765882, 'Jane Doe', 76, '92 2nd Street, California, United States');
insert into person values(385768892, 'Maria Zuniga', 30, '4545 Intergarison, California, United States');


insert into doctor values(246824681,'General',12);
insert into doctor values(000000623,'Naturalist',20);
insert into doctor values(000000157,'Surgeon',6);
insert into doctor values(000000023,'Surgeon',52);
insert into doctor values(201900009,'Infection',40);


insert into patient values(123456789,246824681);
insert into patient values(318573900,000000623);
insert into patient values(246824681,000000623);
insert into patient values(385768892,000000157);
insert into patient values(392765882,000000023);
insert into patient values(246824681,000000023);
insert into patient values(000000623,000000023);
insert into patient values(201900009,000000023);
insert into patient values(123666321,201900009);




insert into pharmacy values('PopRocks', '22 Street Oakland, California, United States', '555-456-7899');
insert into pharmacy values('Green Dispensary', '420 Roseville, California, United States', '800-420-0420');
insert into pharmacy values('Bertoulis', ' 20 Main Street, California, United States', '831-567-0011');
insert into pharmacy values('Rite Aid', ' 47th Street, NY, United States', '899-454-4545');



insert into drug values('Remdesivir', 'C_27H_35N_6O_8P', 'Gilead Sciences');
insert into drug values('Anti_Malaria', 'hydroxychloroquine', 'Generic');
insert into drug values('Nexafed', 'pseudoephedrine', 'Acura Pharmaceuticals US Inc.');
insert into drug values('Glucophage', 'Metformin', 'Merck');
insert into drug values('Micrylium', 'Ethanol, Chlorhexidine Gluconate', 'biotext');
insert into drug values('Elixir Of Life', 'Philosophers Stone', 'Nicolas Flamel');
insert into drug values('Marijuana', 'Cannabis', 'Generic');




insert into contract values( 'Nicolas Flamel', 'Bertoulis', '1400-12-31','2020-12-31', 'Nicolas Flamel shall provide medicine','000000623');
insert into contract values( 'biotext', 'Rite Aid', '2014-12-31','2025-12-31', ' Biotext shall provide disinfectant','123666321');
insert into contract values( 'Gilead Sciences', 'Bertoulis','2021-12-31','2028-12-31', ' Gilead Sciences shall fight COVID-19','201900009');
insert into contract values( 'Acura Pharmaceuticals US Inc.', 'PopRocks', '2030-12-31','2040-12-31', ' Acura Pharmaceuticals shall provide Nexafed','246824681');
insert into contract values( 'Merck', 'Rite Aid', '2015-12-31','2020-6-30', ' Merck shall provide Metformin','246824681');
insert into contract values( 'Generic', 'Rite Aid','2019-12-31','2021-5-31', ' Generic shall provide hydroxychloroquine','246824681');
insert into contract values( 'Generic', 'Green Dispensary', '2018-12-31','2020-12-31', ' Generic shall provide weed','246824681');

insert into inventory values('Bertoulis','Elixir Of Life',9999999.98);
insert into inventory values('Rite Aid','Micrylium',10.99);
insert into inventory values('Bertoulis','Remdesivir', 568455.00);
insert into inventory values('PopRocks','Nexafed', 50.56);
insert into inventory values('Rite Aid','Glucophage',99);
insert into inventory values('Rite Aid','Anti_Malaria',16);
insert into inventory values('Green Dispensary','Marijuana',30.25);
insert into inventory values('PopRocks','Marijuana',420);


insert into prescription values(123456789,'Remdesivir',246824681,'2014-01-30', 2.5000);
insert into prescription values(123456789,'Glucophage',246824681,'2015-01-30', 2.5000);
insert into prescription values(318573900,'Anti_Malaria',000000623,'2015-01-30',3);
insert into prescription values(385768892,'Nexafed',000000157,'2016-01-30',0.05);
insert into prescription values(385768892,'Nexafed',246824681,'2016-01-30',0.05);
insert into prescription values(385768892,'Nexafed',000000623,'2016-01-30',0.05);
insert into prescription values(385768892,'Nexafed',000000023,'2016-01-30',0.05);
insert into prescription values(385768892,'Nexafed',201900009,'2016-01-30',0.05);
insert into prescription values(392765882,'Glucophage',000000023,'2018-01-30',50);
insert into prescription values(123666321,'Micrylium',201900009,'2020-04-30',1);
insert into prescription values(123666321,'Glucophage',201900009,'2020-04-30',1);