create database E_health
use E_health

create table Personi(
person_id int not null Primary Key,
emri varchar (30),
mbiemri varchar (40),
gjinia varchar(15),
qyteti varchar (30),
rruga varchar (50),
numri int,
zip_kodi int
);

create table PersoniNr_tel(
nr_telefonit varchar(30),
person_id int ,
Foreign Key (person_id) references Personi(person_id)
on delete cascade on update cascade
);

create table Doctor(
person_id int  Primary Key
references Personi(person_id)
);

create table MoterMedicionale(
person_id int  Primary Key
references Personi(person_id)
);

create table Gjirollogaria_Bankare(
gjirollogari_id int not null Primary Key,
emri_bankes varchar (50),
data_hapjes date,
numri_kotos int,
tipi_kontos varchar (40),
pershkrimi_bilancit int
);

create table KompaniaSigurimit(
kompani_id int not null Primary Key,
emri_kompanise varchar (40),
qyteti varchar (30),
rruga varchar (50),
numri int,
zip_kodi int
);

create table KompaniaSigNr_tel(
nr_telefonit varchar(30), 
kompani_id int,
Foreign Key(kompani_id) references KompaniaSigurimit(kompani_id)
on delete cascade on update cascade
);

create table Plani_Sigurimit(
plani_id int not null Primary Key,
emri_planit varchar (50),
pershkrimi text,
Anetaret_Premium int,
kompani_id int ,
Foreign Key (kompani_id) references KompaniaSigurimit(kompani_id)
on delete cascade on update cascade
);

create table Pacienti(
pacient_id int not null Primary Key,
nr_personal int ,
profesioni varchar (50),
pozita varchar (50),
emri_kompanise_ku_punon varchar (50),
nr_tel_kompanise varchar (30),
gjendja_sigurimit varchar(50),
plani_id int ,
gjirollogari_id int ,
Foreign Key (nr_personal) references Personi(person_id),
Foreign Key (plani_id) references Plani_Sigurimit(plani_id),
Foreign Key (gjirollogari_id) references Gjirollogaria_Bankare(gjirollogari_id)
on delete cascade on update cascade
);


create table Kerkesat(
kerkesat_id int not null Primary Key,
bilanci int,
kompani_id int ,
gjirollogari_id int ,
Foreign Key (kompani_id) references KompaniaSigurimit(kompani_id),
Foreign Key (gjirollogari_id) references Gjirollogaria_Bankare(gjirollogari_id)
on delete cascade on update cascade
);

create table Vizita_Doktori(
vizit_id int not null Primary Key,
data_vizites date,
pacient_id int ,
kerkesat_id int ,
Foreign Key (pacient_id) references Pacienti(pacient_id),
Foreign Key (kerkesat_id) references Kerkesat(kerkesat_id)
on delete cascade on update cascade
);


create table Trajtimi(
trajtimi_id int not null Primary Key,
diagnoza text,
koha_e_trajtimit varchar (50),
simptomat text,
vizit_id int ,
Foreign Key (vizit_id) references Vizita_Doktori(vizit_id)
on delete cascade on update cascade
);

create table Farmaci(
farmaci_id int not null Primary Key,
emri_farmacise varchar (40),
qyteti varchar (30),
rruga varchar (50),
numri int,
zip_kodi int
);

create table FarmaciNr_tel(
nr_telefonit varchar (30),
farmaci_id int ,
Foreign Key (farmaci_id) references Farmaci(farmaci_id)
on delete cascade on update cascade
);

create table Receta(
receta_id int not null Primary Key,
menyra_perdorimit varchar (100),
rimbushja_e_dozes varchar (40),
farmaci_id int ,
trajtimi_id int ,
Foreign Key (farmaci_id) references Farmaci(farmaci_id),
Foreign Key (trajtimi_id) references Trajtimi(trajtimi_id)
on delete cascade on update cascade
);

create table Medikamente(
medikamenti_id int not null Primary Key,
emri_medikamentit varchar (50),
);

create table Permbane(
sasia varchar(50),
receta_id int ,
medikamenti_id int ,
Foreign Key (receta_id) references Receta(receta_id),
Foreign Key (medikamenti_id) references Medikamente(medikamenti_id),
constraint Permbane_id Primary Key (receta_id, medikamenti_id) 
);


create table Mbane(
farmaci_id int ,
medikamenti_id int ,
cmimi_per_njesi varchar(30),
gjendja_e_stokut varchar(30),
Foreign Key (farmaci_id) references Farmaci(farmaci_id),
Foreign Key (medikamenti_id) references Medikamente(medikamenti_id),
constraint mbane_id Primary Key(farmaci_id,medikamenti_id)
);


create table SherbimiKerkesave(
kodi_sherbimit int not null,
emri_sherbimit varchar (100),
pagesa_pacientit varchar(50),
pagesa_sigurimit varchar(50),
kerkesat_id int Foreign Key references Kerkesat(kerkesat_id)
constraint SherbimiKerkesave_id Primary Key (kodi_sherbimit,kerkesat_id)
);

create table Ofruesi_Kujdesit(
ofruesi_id int not null Primary Key,
mjeku_vleresues varchar (50),
kontrata_me_spital text
);

create table Perfshine(
plani_id int ,
ofruesi_id int ,
Foreign Key (plani_id) references Plani_Sigurimit(plani_id),
Foreign Key (ofruesi_id) references Ofruesi_Kujdesit(ofruesi_id),
constraint Perfshine_id Primary Key (plani_id, ofruesi_id) 
);

create table Orari_Ofruesit(
ofruesi_id int Primary Key
references Ofruesi_Kujdesit(ofruesi_id),
koha_e_fillimit time,
emri_pacientit varchar (40)
);

create table Gjuha_Ofruesit(
ofruesi_id int Primary Key
references Ofruesi_Kujdesit(ofruesi_id),
gjuha varchar (30)
);

-----Insertimi me te dhena

/* .....Inserti (shtimi) i te dhenave ne tabelen Personi.............. */
insert into Personi values(1,'Driton','Sopa','Mashkull','Prizren',' Shkembi',12,20000);
insert into Personi values(2,'Bekim','Hyeni','Mashkull','Ferizaj',' Arbrit',15,70000);
insert into Personi values(3,'Antigona','Raci','Femer','Prizren','Dielli',17,20000);
insert into Personi values(4,'Altin','Hoxha','Mashkull','Gjakove','UQK',13,50000);
insert into Personi values(5,'Kushtrim','Hoxha','Mashkull','Ferizaj','UQK',19,70000);
insert into Personi values(6,'Visar','Dema','Mashkull','Peje','Arbrit',25,100000);
insert into Personi values(7,'Lenonora','Peci','Femer','Mitrovice','Shkembi',36,40010);
insert into Personi values(8,'Besiana','Gashi','Femer','Prishtine','Dielli',42,100000);
insert into Personi values(9,'Alketa','Jakupi','Femer','Mitrovice','Tirana',121,40010);
insert into Personi values(10,'Edita','Syla','Femer','Gjilan','Elbansani',118,60000);
insert into Personi values(11,'Burim','Gashi','Mashkull','Lipjan','Dielli', 95,14000);
insert into Personi values(12,'Agon', 'Buja','Mashkull', 'Ferizaj','Hena', 75,70000);
insert into Personi values(13,'Albulena','Hamiti','Femer','Rahovec','Justinian', 56,21000);
insert into Personi values(14,'Kim','Gashi','Mashkull','Peje','Kombi', 11,30000);
insert into Personi values(15,'Flori','Kollari','Mashkull', 'Prishtine', 'Bajram Kelmendi',75,100000);
insert into Personi values(16,'Enver','Berisha','Mashkull', 'Prishtine', 'rruga B', 55,100000);
insert into Personi values(17,'Yll','Sopa','Mashkull', 'Gjakove','28 nentori', 64,50000);
insert into Personi values(18,'Florent','Kollari', 'Mashkull', 'Prishtine','Dardania', 77,100000);
insert into Personi values(19,'Ron','Krasniqi','Mashkull', 'Rahovec','17 shkurti', 90,21000);
insert into Personi values(20, 'Egzon','Haziri', 'Mashkull', 'Prishtine','17 shkurti', 78,100000);
insert into Personi values(21, 'Enis','Sllamniku', 'Mashkull', 'Fushe Kosove','17 shkurti', 78,12000);
insert into Personi values(22, 'Gramos','Seferi', 'Mashkull', 'Vushtrri','Jetoni ', 78,42000);
insert into Personi values(23, 'Rilind','Salihu', 'Mashkull', 'Therand','Nena Terez', 78,23000);
insert into Personi values(24, 'Fesim','Uka', 'Mashkull', 'Mitrovice','Shaban Polluzha', 78,40010);
insert into Personi values(25, 'Bleon','Uka', 'Femer', 'Prishtine','28 nentori', 78,100000);
insert into Personi values(26, 'Kaltrin','Zeneli', 'Femer', 'Prishtine','Dardania', 78,100000);
insert into Personi values(27, 'Argjend','Selani', 'Mashkull', 'Lipjan','Zambaku', 78,14000);
insert into Personi values(28, 'Leone','Haziri', 'Femer', 'Peje','Rugova', 78,30000);
insert into Personi values(29, 'Medine','Rrahmani', 'Femer', 'Ferizaj','17 shkurti', 78,70000);
insert into Personi values(30, 'Fatbardhe','Zogjani', 'Femer', 'Prishtine','Garibaldi', 78,100000);
insert into Personi values(31, 'Edone','Hyseni', 'Femer', 'Prishtine','Germia', 16,100000);


/* .....Inserti (shtimi) i te dhenave ne tabelen PersoniNr_tel.............. */
insert into PersoniNr_tel values('049100100',1);
insert into PersoniNr_tel values('049200200',2);
insert into PersoniNr_tel values('049300300',3);
insert into PersoniNr_tel values('049400400',4);
insert into PersoniNr_tel values('04950050',5);
insert into PersoniNr_tel values('049600600',6);
insert into PersoniNr_tel values('049700700',7);
insert into PersoniNr_tel values('049800800',8);
insert into PersoniNr_tel values('049900900',9);
insert into PersoniNr_tel values('049110110',10);
insert into PersoniNr_tel values('049120120',11);
insert into PersoniNr_tel values('049130130',12);
insert into PersoniNr_tel values('049140140',13);
insert into PersoniNr_tel values('049150150',14);
insert into PersoniNr_tel values('049160160',15);
insert into PersoniNr_tel values('049170170',16);
insert into PersoniNr_tel values('049180180',17);
insert into PersoniNr_tel values('049190190',18);
insert into PersoniNr_tel values('049210210',19);
insert into PersoniNr_tel values('049220220',20);
insert into PersoniNr_tel values('049230230',21);
insert into PersoniNr_tel values('049240240',22);
insert into PersoniNr_tel values('049256010',23);
insert into PersoniNr_tel values('049260260',24);
insert into PersoniNr_tel values('049270270',25);
insert into PersoniNr_tel values('049280280',26);
insert into PersoniNr_tel values('049290290',27);
insert into PersoniNr_tel values('049330330',28);
insert into PersoniNr_tel values('049340340',29);
insert into PersoniNr_tel values('049350350',30);
insert into PersoniNr_tel values('049360370',31);


/* .....Inserti (shtimi) i te dhenave ne tabelen Doctor.............. */
insert into Doctor values(11);
insert into Doctor values(12);
insert into Doctor values(13);
insert into Doctor values(14);
insert into Doctor values(15);
insert into Doctor values(16);
insert into Doctor values(17);
insert into Doctor values(18);
insert into Doctor values(19);
insert into Doctor values(20);


/* .....Inserti (shtimi) i te dhenave ne tabelen MoterMedicionale.............. */
insert into MoterMedicionale values(21);
insert into MoterMedicionale values(22);
insert into MoterMedicionale values(23);
insert into MoterMedicionale values(24);
insert into MoterMedicionale values(25);
insert into MoterMedicionale values(26);
insert into MoterMedicionale values(27);
insert into MoterMedicionale values(28);
insert into MoterMedicionale values(29);
insert into MoterMedicionale values(30);
insert into MoterMedicionale values(31);


/* .....Inserti (shtimi) i te dhenave ne tabelen Gjirollogaria_Bankare.............. */
insert into Gjirollogaria_Bankare  values(1000,'Rafaisen Bank','12/5/2018',1111,'e kursimeve',200);
insert into Gjirollogaria_Bankare  values(2000,'Procredit Bank','02/28/2018',2222,'rrjedhese',450);
insert into Gjirollogaria_Bankare  values(3000,'TEB','11/7/2018',3333,'aktuale',300);
insert into Gjirollogaria_Bankare  values(4000,'NLB Bank','8/25/2018',4444,'e kursimeve',230);
insert into Gjirollogaria_Bankare  values(5000,'BKT','11/12/2017',5555,'rrjedhese',40);
insert into Gjirollogaria_Bankare  values(6000,'Raifaisen Bank','1/11/2018',6666,'aktuale',50);
insert into Gjirollogaria_Bankare  values(7000,'Procredit Bank','3/8/2018',7777,'e kursimeve',2000);
insert into Gjirollogaria_Bankare  values(8000,'TEB','10/7/2018',8888,'aktuale',1000);
insert into Gjirollogaria_Bankare  values(9000,'NLB Bank','02/25/2018',9999,'e kursimeve',80);
insert into Gjirollogaria_Bankare  values(1100,'BKT','4/5/2018',1234,'rrjedhese',150);
insert into Gjirollogaria_Bankare  values(1200,'Procredit Bank','5/5/2018',5678,'e kursimve',650);
insert into Gjirollogaria_Bankare  values(1300,'Rafaisen Bank','12/5/2018',1111,'e kursimeve',200);
insert into Gjirollogaria_Bankare  values(1400,'Procredit Bank','02/28/2018',2222,'rrjedhese',450);
insert into Gjirollogaria_Bankare  values(1500,'TEB','11/7/2018',3333,'aktuale',300);
insert into Gjirollogaria_Bankare  values(1600,'NLB Bank','8/25/2018',4444,'e kursimeve',230);
insert into Gjirollogaria_Bankare  values(1700,'BKT','11/12/2017',5555,'rrjedhese',40);
insert into Gjirollogaria_Bankare  values(1800,'Raifaisen Bank','1/11/2018',6666,'aktuale',50);
insert into Gjirollogaria_Bankare  values(1900,'Procredit Bank','3/8/2018',7777,'e kursimeve',2000);
insert into Gjirollogaria_Bankare  values(2100,'TEB','10/7/2018',8888,'aktuale',1000);
insert into Gjirollogaria_Bankare  values(2200,'NLB Bank','02/25/2018',9999,'e kursimeve',80);
insert into Gjirollogaria_Bankare  values(2300,'BKT','4/5/2018',1234,'rrjedhese',150);
insert into Gjirollogaria_Bankare  values(2400,'Procredit Bank','5/5/2018',5678,'e kursimve',650);
insert into Gjirollogaria_Bankare  values(2500,'Rafaisen Bank','12/5/2018',1111,'e kursimeve',200);
insert into Gjirollogaria_Bankare  values(2600,'Procredit Bank','02/28/2018',2222,'rrjedhese',450);
insert into Gjirollogaria_Bankare  values(2700,'TEB','11/7/2018',3333,'aktuale',300);
insert into Gjirollogaria_Bankare  values(2800,'NLB Bank','8/25/2018',4444,'e kursimeve',230);



/* .....Inserti (shtimi) i te dhenave ne tabelen KompaniaSigurimit.............. */
insert into KompaniaSigurimit values(100,'Euro Sig','Prizren',' Teuta',120,20000);
insert into KompaniaSigurimit values(101,'Sigal','Prishtine',' Ali Podrimja',36,100000);
insert into KompaniaSigurimit values(102,'Siguria','Prishtine','Garibaldi',58,100000);
insert into KompaniaSigurimit values(103,'Henner','Ferizaj',' Arberi',49,70000);
insert into KompaniaSigurimit values(104,'Sig Cos','Mitrovice',' UQK',69,40010);
insert into KompaniaSigurimit values(105,'Sig Group','Gjilan',' Dielli',78,60000);
insert into KompaniaSigurimit values(106,'Scardan','Gjakove',' Nena Tereze',62,50000);
insert into KompaniaSigurimit values(107,'Sigma','Ferizaj',' 28 nentori',25,70000);
insert into KompaniaSigurimit values(108,'Prisig','Mitrovice',' Kombi',14,40010);
insert into KompaniaSigurimit values(109,'Elsig','Prizren',' Dardania',36,20000);


/* .....Inserti (shtimi) i te dhenave ne tabelen KompaniaSigNr_tel.............. */
insert into KompaniaSigNr_tel values('049111111',100);
insert into KompaniaSigNr_tel values('049222222',101);
insert into KompaniaSigNr_tel values('049333333',102);
insert into KompaniaSigNr_tel values('049444444',103);
insert into KompaniaSigNr_tel values('049555555',104);
insert into KompaniaSigNr_tel values('049666666',105);
insert into KompaniaSigNr_tel values('049777777',106);
insert into KompaniaSigNr_tel values('049888888',107);
insert into KompaniaSigNr_tel values('049999999',108);
insert into KompaniaSigNr_tel values('045111111',109);
insert into KompaniaSigNr_tel values('045222222',100);
insert into KompaniaSigNr_tel values('045333333',101);
insert into KompaniaSigNr_tel values('045444444',102);
insert into KompaniaSigNr_tel values('045555555',103);
insert into KompaniaSigNr_tel values('045666666',104);
insert into KompaniaSigNr_tel values('045777777',105);
insert into KompaniaSigNr_tel values('045888888',106);
insert into KompaniaSigNr_tel values('045999999',107);
insert into KompaniaSigNr_tel values('044111111',108);
insert into KompaniaSigNr_tel values('044222222',109);
insert into KompaniaSigNr_tel values('044333333',100);
insert into KompaniaSigNr_tel values('044444444',101);
insert into KompaniaSigNr_tel values('044555555',102);
insert into KompaniaSigNr_tel values('044666666',103);
insert into KompaniaSigNr_tel values('044777777',104);
insert into KompaniaSigNr_tel values('044888888',105);


/* .....Inserti (shtimi) i te dhenave ne tabelen Plani_Sigurimit.............. */
insert into Plani_Sigurimit values(1,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',30,100);
insert into Plani_Sigurimit values(2,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',1000,100);
insert into Plani_Sigurimit values(3,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',5000,102);
insert into Plani_Sigurimit values(4,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',2000,102);
insert into Plani_Sigurimit values(5,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',10,102);
insert into Plani_Sigurimit values(6,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',500,100);
insert into Plani_Sigurimit values(7,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',4000,100);
insert into Plani_Sigurimit values(8,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',1000,102);
insert into Plani_Sigurimit values(9,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',60,102); 
insert into Plani_Sigurimit values(10,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',200,102);
insert into Plani_Sigurimit values(11,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',8000,100);
insert into Plani_Sigurimit values(12,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',1500,100);
insert into Plani_Sigurimit values(13,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',15,100);
insert into Plani_Sigurimit values(14,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',750,103);
insert into Plani_Sigurimit values(15,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',56,103);
insert into Plani_Sigurimit values(16,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',350,103);
insert into Plani_Sigurimit values(17,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',630,103);
insert into Plani_Sigurimit values(18,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',93,102);
insert into Plani_Sigurimit values(19,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 80%',59,100);
insert into Plani_Sigurimit values(20,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 60%',47,100);
insert into Plani_Sigurimit values(21,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 50%',556,100);
insert into Plani_Sigurimit values(22,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 50%',3658,102);
insert into Plani_Sigurimit values(23,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 50%',66,100);
insert into Plani_Sigurimit values(24,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 50%',41,102);
insert into Plani_Sigurimit values(25,'Sigurim i Plote','sigurimi perfshin nje mbulim prej 50%',69,103);
insert into Plani_Sigurimit values(26,'Sigurim i Pjeseshem','sigurimi perfshin nje mbulim prej 50%',169,104);


/* .....Inserti (shtimi) i te dhenave ne tabelen Pacienti.............. */
insert into Pacienti values(1000,1,'Mesues','Cikli i ulet','Shkolla Fillore','049123456','ka sigurim',1,1000);
insert into Pacienti values(1001,2,'Programer','Product Designer','Microsoft','049234567','ka sigurim',2,2000);
insert into Pacienti values(1002,3,'Menaxher','Arketar','Viva Fresh','049345678','ka sigurim',26,3000);
insert into Pacienti values(1003,4,'Profesor','Cikli i larte','Shkolla Teknike','049456789','ka sigurim',26,4000);
insert into Pacienti values(1004,5,'Biolog','Praktikant','Lab','049567891','ka sigurim',1,5000);
insert into Pacienti values(1005,1,'Gazetar','Multimedia Gazetar','Klan Kosova','049678912','ka sigurim',2,6000);
insert into Pacienti values(1006,2,'Kuzhinier','Shef','Restaurant Gulf','049789123','ka sigurim',26,7000);
insert into Pacienti values(1007,3,'Pilot','Transportues i mallrave','Air Line','049891234','ka sigurim',1,8000);
insert into Pacienti values(1008,4,'Inxhinier','Civil Inxhinier','Alba Group','049912345','ka sigurim',2,9000);
insert into Pacienti values(1009,5,'Sportist','Sulmues','FC Prishtina','045123456','ka sigurim',26,1100);
insert into Pacienti values(1010,1,'Psikolog','cikli i larte','Shkolla e Mesme','045234567','ka sigurim',1,1200);
insert into Pacienti values(1011,2,'Kimist','cikli i larte','Shkolla e Mesme','045345678','ka sigurim',2,1300);
insert into Pacienti values(1012,3,'Matematikant','cikli i ulet','Shkolla Fillore','045456789','ka sigurim',26,1400);
insert into Pacienti values(1013,4,'Gjeograf','cikli i ulet','Shkolla Fillore','045567891','ka sigurim',1,1500);
insert into Pacienti values(1014,5,'Histroian','cikli i larte','Shkolla e Mesme','045678912','ka sigurim',2,1600);
insert into Pacienti values(1015,1,'Arkeolog','Arsimi i larte','Universitet','045789123','ka sigurim',26,1700);
insert into Pacienti values(1016,2,'Kengetar','Anetar i Band-it','','045891234','ka sigurim',1,1800);
insert into Pacienti values(1017,3,'Shpetimtar','','Garda Bregdetare','045912345','ka sigurim',2,1900);
insert into Pacienti values(1018,4,'Politikan','Deputet','Subjekti Politik','044123456','ka sigurim',26,2100);
insert into Pacienti values(1019,5,'Ushtare','kadet','FSK','044234567','ka sigurim',1,2200);
insert into Pacienti values(1020,1,'Astronaut','Udheheqes i Grupit','Stacioni Hapsirore','044345678','ka sigurim',2,2300);
insert into Pacienti values(1021,2,'Rrobaqepes','Dizajner','DEA','044456789','ka sigurim',26,2400);
insert into Pacienti values(1022,3,'Kontabilist','Kontabilist','Star Lab','044567891','ka sigurim',1,2500);
insert into Pacienti values(1023,4,'Shofer','Shofer','Taxi Im','044678912','ka sigurim',2,2600);
insert into Pacienti values(1024,5,'Kujdestar','cikli i larte','Shkolla e Mesme','044789123','ka sigurim',26,2700);
insert into Pacienti values(1025,1,'Polic','Toger','Shkolla e Policise','044891234','ka sigurim',1,2800);


/* .....Inserti (shtimi) i te dhenave ne tabelen Kerkesat.............. */
insert into Kerkesat values(12345,150,100,1000);
insert into Kerkesat values(23456,50,101,2000);
insert into Kerkesat values(34567,250,102,3000);
insert into Kerkesat values(45678,15,103,4000);
insert into Kerkesat values(56789,350,100,5000);
insert into Kerkesat values(67891,120,101,3000);
insert into Kerkesat values(78912,170,102,2000);
insert into Kerkesat values(89123,160,103,1000);
insert into Kerkesat values(91234,110,100,1000);
insert into Kerkesat values(11111,30,101,1000);
insert into Kerkesat values(22222,20,102,1000);
insert into Kerkesat values(33333,70,103,2000);
insert into Kerkesat values(44444,80,100,2000);
insert into Kerkesat values(55555,90,101,3000);
insert into Kerkesat values(66666,450,102,2000);
insert into Kerkesat values(77777,10,103,3000);
insert into Kerkesat values(88888,550,103,3000);
insert into Kerkesat values(99999,220,100,2000);
insert into Kerkesat values(11222,260,101,4000);
insert into Kerkesat values(22333,240,102,4000);
insert into Kerkesat values(33444,230,103,5000);
insert into Kerkesat values(44555,220,100,5000);
insert into Kerkesat values(55666,150,101,4000);
insert into Kerkesat values(66777,150,100,3000);
insert into Kerkesat values(77888,150,102,5000);
insert into Kerkesat values(88999,150,103,5000);


/* .....Inserti (shtimi) i te dhenave ne tabelen Vizita_Doktori.............. */
insert into Vizita_Doktori values(10,'2020-1-1',1000,12345);
insert into Vizita_Doktori values(11,'2021-2-2',1000,12345);
insert into Vizita_Doktori values(12,'2020-3-3',1002,34567);
insert into Vizita_Doktori values(13,'2020-4-4',1002,34567);
insert into Vizita_Doktori values(14,'2020-5-5',1004,56789);
insert into Vizita_Doktori values(15,'2021-6-6',1004,56789);
insert into Vizita_Doktori values(16,'2019-7-7',1006,78912);
insert into Vizita_Doktori values(17,'2020-8-8',1006,78912);
insert into Vizita_Doktori values(18,'2021-9-9',1009,91234);
insert into Vizita_Doktori values(19,'2021-10-10',1009,91234);
insert into Vizita_Doktori values(20,'2019-11-11',1010,22222);
insert into Vizita_Doktori values(21,'2018-12-12',1011,33333);
insert into Vizita_Doktori values(22,'2021-1-13',1009,44444);
insert into Vizita_Doktori values(23,'2020-2-14',1009,55555);
insert into Vizita_Doktori values(24,'2017-3-15',1000 ,66666);
insert into Vizita_Doktori values(25,'2019-4-16',1009,77777);
insert into Vizita_Doktori values(26,'2020-5-17',1006,88888);
insert into Vizita_Doktori values(27,'2021-6-18',1008,99999);
insert into Vizita_Doktori values(28,'2021-7-19',1009,11222);
insert into Vizita_Doktori values(29,'2020-8-20',1009,22333);
insert into Vizita_Doktori values(30,'2016-9-21',1004,33444);
insert into Vizita_Doktori values(31,'2015-10-22',1004,44555);
insert into Vizita_Doktori values(32,'2021-11-23',1010,55666);
insert into Vizita_Doktori values(33,'2017-12-24',1011,66777);
insert into Vizita_Doktori values(34,'2018-1-25',1011,77888);
insert into Vizita_Doktori values(35,'2019-2-26',1011,88999);



/* .....Inserti (shtimi) i te dhenave ne tabelen Trajtimi.............. */
insert into Trajtimi values(1,'Grip sezonal','1 jave','kollitje',10);
insert into Trajtimi values(2,'dështimi kongjestiv i zemrës','disa muaj','probleme me zemer',11);
insert into Trajtimi values(3,'Grip sezonal','2jave','dhimbje stomaku',12);
insert into Trajtimi values(4,'Pneomunia','2 muaj','dhimbje ne mushkeri',13);
insert into Trajtimi values(5,'Sëmundje kronike obstruktive pulmonare','1 vit','kollitje',14);
insert into Trajtimi values(6,'Infarkt akut të miokardit','1 muaj','dhimbje ne zemer',15);
insert into Trajtimi values(7,'Diarrhea','6 muaj','dhimbje barku',16);
insert into Trajtimi values(8,'Grip sezonal','3 jave','skuqje te fytit',17);
insert into Trajtimi values(9,'Virus','2 jave','kollitje',18);
insert into Trajtimi values(10,'Virus','2 jave','dhimbje koke',19);
insert into Trajtimi values(11,'Migren','','dhimbje e kokes',10);
insert into Trajtimi values(12,'Osteroartitis','5 muaj','dhimbje te nyjeve',11);
insert into Trajtimi values(13,'Grip sezonal','1 jave','kollitje',12);
insert into Trajtimi values(14,'dështimi kongjestiv i zemrës','disa muaj','probleme me zemer',13);
insert into Trajtimi values(15,'Grip sezonal','2jave','dhimbje stomaku',14);
insert into Trajtimi values(16,'Pneomunia','2 muaj','dhimbje ne mushkeri',15);
insert into Trajtimi values(17,'Sëmundje kronike obstruktive pulmonare','1 vit','kollitje',16);
insert into Trajtimi values(18,'Infarkt akut të miokardit','1 muaj','dhimbje ne zemer',17);
insert into Trajtimi values(19,'Diarrhea','6 muaj','dhimbje barku',18);
insert into Trajtimi values(20,'Grip sezonal','3 jave','skuqje te fytit',19);
insert into Trajtimi values(21,'Virus','2 jave','kollitje',10);
insert into Trajtimi values(22,'Migren','','dhimbje e kokes',11);
insert into Trajtimi values(23,'Osteroartitis','5 muaj','dhimbje te nyjeve',12);
insert into Trajtimi values(24,'Shtypje e larte e gjakut','2 dite','problem me zemer',13);
insert into Trajtimi values(25,'Grip sezonal','1 jave','kollitje',14);


/* .....Inserti (shtimi) i te dhenave ne tabelen Farmaci.............. */
insert into Farmaci values(1,'Pharmacy','Prishtine',' Teuta',12,100000);
insert into Farmaci values(2,'Barnatore Pentagon','Prishtine',' Garibaldi',19,100000);
insert into Farmaci values(3,'Barnatore Joni','Ferizaj','Jetoni',23,70000);
insert into Farmaci values(4,'Barnatore Tosi','Peje','Elbansani',59,30000);
insert into Farmaci values(5,'Barnatore Era','Mitrovice','Tirana',42,40000);
insert into Farmaci values(6,'Barnatore Dea','Gjilan',' Rugova',57,60000);
insert into Farmaci values(7,'Barnatore Melisa','Gjakove','Isa Boletini',68,100000);
insert into Farmaci values(8,'Barnatore Rexall','Mitrovice',' Arberit',47,100000);
insert into Farmaci values(9,'Barnatore Arberi','Prizren','Lidhja',15,20000);
insert into Farmaci values(10,'Pharmacy','Prizren',' Teuta',120,20000);
insert into Farmaci values(11,'Barnatore Joni','Peje','Kuvendi',15,30000);


/* .....Inserti (shtimi) i te dhenave ne tabelen FarmaciNr_tel.............. */
insert into FarmaciNr_tel values('049100100',1);
insert into FarmaciNr_tel values('049200100',2);
insert into FarmaciNr_tel values('049300300',3);
insert into FarmaciNr_tel values('049400400',4);
insert into FarmaciNr_tel values('049500500',5);
insert into FarmaciNr_tel values('049600600',6);
insert into FarmaciNr_tel values('049700700',7);
insert into FarmaciNr_tel values('049800800',8);
insert into FarmaciNr_tel values('049900900',9);
insert into FarmaciNr_tel values('049100200',10);
insert into FarmaciNr_tel values('045100300',11);
insert into FarmaciNr_tel values('045100400',1);
insert into FarmaciNr_tel values('045100500',2);
insert into FarmaciNr_tel values('045100600',3);
insert into FarmaciNr_tel values('045100700',4);
insert into FarmaciNr_tel values('045100800',5);
insert into FarmaciNr_tel values('045100900',6);
insert into FarmaciNr_tel values('045200100',7);
insert into FarmaciNr_tel values('045200200',8);
insert into FarmaciNr_tel values('045200300',9);
insert into FarmaciNr_tel values('044200400',10);
insert into FarmaciNr_tel values('044200500',11);
insert into FarmaciNr_tel values('044200600',1);
insert into FarmaciNr_tel values('044200700',2);
insert into FarmaciNr_tel values('044200800',3);
insert into FarmaciNr_tel values('044200900',4);


/* .....Inserti (shtimi) i te dhenave ne tabelen Receta.............. */
insert into Receta values(1,'1 here 1','pas nje jave',1,1);
insert into Receta values(2,'3 here 1','pas 5 diteve',2,2);
insert into Receta values(3,'pas ushqimit','pas 2 jave',3,3);
insert into Receta values(4,'para ushqimit','pas nje muaji',4,4);
insert into Receta values(5,'2 here 1','cdo 2 muaj',5,5);
insert into Receta values(6,'cdo 12 ore','pas 3 jave',1,6);
insert into Receta values(7,'1 here 1','pas nje jave',2,7);
insert into Receta values(8,'3 here 1','pas 5 diteve',3,8);
insert into Receta values(9,'pas ushqimit','pas 2 jave',4,9);
insert into Receta values(10,'para ushqimit','pas nje muaji',5,10);
insert into Receta values(11,'2 here 1','cdo 2 muaj',1,1);
insert into Receta values(12,'cdo 12 ore','pas 3 jave',2,2);
insert into Receta values(13,'1 here 1','pas nje jave',3,3);
insert into Receta values(14,'3 here 1','pas 5 diteve',4,4);
insert into Receta values(15,'pas ushqimit','pas 2 jave',5,5);
insert into Receta values(16,'para ushqimit','pas nje muaji',1,6);
insert into Receta values(17,'2 here 1','cdo 2 muaj',2,9);
insert into Receta values(18,'cdo 12 ore','pas 3 jave',3,8);
insert into Receta values(19,'1 here 1','pas nje jave',4,7);
insert into Receta values(20,'3 here 1','pas 5 diteve',5,6);
insert into Receta values(21,'pas ushqimit','pas 2 jave',1,5);
insert into Receta values(22,'para ushqimit','pas nje muaji',2,4);
insert into Receta values(23,'2 here 1','cdo 2 muaj',3,3);
insert into Receta values(24,'cdo 12 ore','pas 3 jave',4,2);
insert into Receta values(25,'1 here 1','pas nje jave',5,1);
insert into Receta values(26,'3 here 1','pas 5 diteve',1,1);


/* .....Inserti (shtimi) i te dhenave ne tabelen Medikamente.............. */
insert into Medikamente values(1,'Paracetamol');
insert into Medikamente values(2,'Kafetin');
insert into Medikamente values(3,'Brufen');
insert into Medikamente values(4,'Amoxicillin');
insert into Medikamente values(5,'Vitamin D');
insert into Medikamente values(6,'Vitamin C');
insert into Medikamente values(7,'Vitamin B');
insert into Medikamente values(8,'Oki');
insert into Medikamente values(9,'Bronko Balsamina');
insert into Medikamente values(10,'Ialoclan');


/* .....Inserti (shtimi) i te dhenave ne tabelen Permbane.............. */
insert into Permbane values('nje pako',1,1);
insert into Permbane values('dy pako',2,1);
insert into Permbane values('tri pako',3,1);
insert into Permbane values('nje pako',4,1);
insert into Permbane values('dy pako',5,2);
insert into Permbane values('tri pako',6,2);
insert into Permbane values('nje pako',7,2);
insert into Permbane values('dy pako',8,2);
insert into Permbane values('kater pako',9,3);
insert into Permbane values('nje pako',10,3);
insert into Permbane values('nje pako',1,3);
insert into Permbane values('5 cope',2,3);
insert into Permbane values('3 cope',3,2);
insert into Permbane values('nje pako',4,3);
insert into Permbane values('dy pako',5,4);
insert into Permbane values('tri pako',6,4);
insert into Permbane values('kater pako',7,4);
insert into Permbane values('2 cope',8,4);
insert into Permbane values('nje pako',9,4);
insert into Permbane values('nje pako',10,4);
insert into Permbane values('dy pako',1,5);
insert into Permbane values('dy pako',2,5);
insert into Permbane values('tre pako',3,5);
insert into Permbane values('nje pkao',4,5);
insert into Permbane values('nje pako',5,5);
insert into Permbane values('nje pako',6,5);


/* .....Inserti (shtimi) i te dhenave ne tabelen Mbane.............. */
insert into Mbane values(1,1,'1 Euro','ka ne stok');
insert into Mbane values(1,2,'2 Euro','ka ne stok');
insert into Mbane values(1,3,'3 Euro','ka ne stok');
insert into Mbane values(1,4,'5 Euro','ka ne stok');
insert into Mbane values(1,5,'7 Euro','nuk ka ne stok');
insert into Mbane values(2,1,'8 Euro','ka ne stok');
insert into Mbane values(2,2,'8 Euro','nuk ka ne stok');
insert into Mbane values(2,3,'7 Euro','ka ne stok');
insert into Mbane values(2,4,'6 Euro','nuk ka ne stok');
insert into Mbane values(2,5,'4 Euro','ka ne stok');
insert into Mbane values(3,1,'3 Euro','nuk ka ne stok');
insert into Mbane values(3,2,'5 Euro','ka ne stok');
insert into Mbane values(3,3,'2 Euro','nuk ka ne stok');
insert into Mbane values(3,4,'1 Euro','nuk ka ne stok');
insert into Mbane values(3,5,'1 Euro','ka ne stok');
insert into Mbane values(4,1,'5 Euro','ka ne stok');
insert into Mbane values(4,2,'6 Euro','nuk ka ne stok');
insert into Mbane values(4,3,'10 Euro','nuk ka ne stok');
insert into Mbane values(4,4,'12 Euro','ka ne stok');
insert into Mbane values(4,5,'15 Euro','ka ne stok');
insert into Mbane values(5,1,'7 Euro','nuk ka ne stok');
insert into Mbane values(5,2,'14 Euro','ka ne stok');
insert into Mbane values(5,3,'12 Euro','nuk ka ne stok');
insert into Mbane values(5,4,'11 Euro','ka ne stok');
insert into Mbane values(5,5,'28 Euro','nuk ka ne stok');


/* .....Inserti (shtimi) i te dhenave ne tabelen SherbimiKerkesave.............. */
insert into SherbimiKerkesave values(100,'kontroll mjeksore','5Euro','20Euro',12345);
insert into SherbimiKerkesave values(101,'kontroll mjeksore','15Euro','50Euro',23456);
insert into SherbimiKerkesave values(102,'kontroll mjeksore','25Euro','100Euro',34567);
insert into SherbimiKerkesave values(103,'kontroll mjeksore','11Euro','44Euro',45678);
insert into SherbimiKerkesave values(104,'kontroll mjeksore','50Euro','250Euro',56789);
insert into SherbimiKerkesave values(105,'kontroll mjeksore','5Euro','20Euro',67891);
insert into SherbimiKerkesave values(106,'kontroll mjeksore','10Euro','50Euro',78912);
insert into SherbimiKerkesave values(107,'Barera','13Euro','28Euro',89123);
insert into SherbimiKerkesave values(108,'Barera','15Euro','65Euro',91234);
insert into SherbimiKerkesave values(109,'Barera','27Euro','89Euro',12345);
insert into SherbimiKerkesave values(110,'Barera','12Euro','66Euro',23456);
insert into SherbimiKerkesave values(111,'Barera','5Euro','20Euro',34567);
insert into SherbimiKerkesave values(112,'Barera','7Euro','43Euro',45678);
insert into SherbimiKerkesave values(113,'kontroll mjeksore','5Euro','20Euro',56789);
insert into SherbimiKerkesave values(114,'kontroll mjeksore','15Euro','50Euro',67891);
insert into SherbimiKerkesave values(115,'kontroll mjeksore','25Euro','100Euro',78912);
insert into SherbimiKerkesave values(116,'kontroll mjeksore','11Euro','44Euro',89123);
insert into SherbimiKerkesave values(117,'kontroll mjeksore','50Euro','250Euro',91234);
insert into SherbimiKerkesave values(118,'kontroll mjeksore','5Euro','20Euro',12345);
insert into SherbimiKerkesave values(119,'kontroll mjeksore','10Euro','50Euro',23456);
insert into SherbimiKerkesave values(120,'Barera','13Euro','28Euro',34567);
insert into SherbimiKerkesave values(121,'Barera','15Euro','65Euro',45678);
insert into SherbimiKerkesave values(122,'Barera','27Euro','89Euro',56789);
insert into SherbimiKerkesave values(123,'Barera','12Euro','66Euro',67891);
insert into SherbimiKerkesave values(124,'Barera','5Euro','20Euro',78912);
insert into SherbimiKerkesave values(125,'Barera','7Euro','43Euro',89123);


/* .....Inserti (shtimi) i te dhenave ne tabelen Ofruesi_Kujdesit.............. */
insert into Ofruesi_Kujdesit values(10,'Dr.Agon Buja','ka marreveshje me klinike');
insert into Ofruesi_Kujdesit values(20,'Dr.Burim Gashi','ka marreveshje me ambulante');
insert into Ofruesi_Kujdesit values(30,'Dr.Albulena Hamiti','ka marreveshje me spital');
insert into Ofruesi_Kujdesit values(40,'Dr.Kim Gashi','ka marreveshje me ordinance');
insert into Ofruesi_Kujdesit values(50,'Dr.Flori Kollari','ka marreveshje me ambilante');
insert into Ofruesi_Kujdesit values(60,'Dr.Enver Berisha','ka marreveshje me klinike');
insert into Ofruesi_Kujdesit values(70,'Dr.Yll Sopa','ka marreveshje me klinike');
insert into Ofruesi_Kujdesit values(80,'Dr.Florent Kollari','ka marreveshje me spital');
insert into Ofruesi_Kujdesit values(90,'Dr.Ron Krasniqi','ka marreveshje me ordinance');
insert into Ofruesi_Kujdesit values(100,'Dr.Valdet Kollari','ka marreveshje me klinike');


/* .....Inserti (shtimi) i te dhenave ne tabelen Perfshine.............. */
insert into Perfshine values(1,10);
insert into Perfshine values(2,10);
insert into Perfshine values(3,10);
insert into Perfshine values(4,10);
insert into Perfshine values(5,10);
insert into Perfshine values(6,20);
insert into Perfshine values(7,20);
insert into Perfshine values(8,20);
insert into Perfshine values(9,20);
insert into Perfshine values(10,20);
insert into Perfshine values(1,30);
insert into Perfshine values(2,30);
insert into Perfshine values(3,30);
insert into Perfshine values(4,30);
insert into Perfshine values(5,30);
insert into Perfshine values(6,40);
insert into Perfshine values(7,40);
insert into Perfshine values(8,40);
insert into Perfshine values(9,40);
insert into Perfshine values(10,50);
insert into Perfshine values(1,50);
insert into Perfshine values(2,50);
insert into Perfshine values(3,50);
insert into Perfshine values(4,50);


/* .....Inserti (shtimi) i te dhenave ne tabelen Orari_Ofruesit.............. */
insert into Orari_Ofruesit values(10,'10:30','Driton');
insert into Orari_Ofruesit values(20,'10:30','Bekim');
insert into Orari_Ofruesit values(30,'10:00','Antigona');
insert into Orari_Ofruesit values(40,'10:30','Altin');
insert into Orari_Ofruesit values(50,'10:30','Kushtrim');
insert into Orari_Ofruesit values(60,'10:30','Visar');
insert into Orari_Ofruesit values(70,'10:30','Lenonora');
insert into Orari_Ofruesit values(80,'10:30','Besiana');
insert into Orari_Ofruesit values(90,'10:30','Alketa');
insert into Orari_Ofruesit values(100,'10:30','Edita');


/* .....Inserti (shtimi) i te dhenave ne tabelen Gjuha_Ofruesit.............. */
insert into Gjuha_Ofruesit values(10,'Gjuhe Shqipe');
insert into Gjuha_Ofruesit values(20,'Gjuhe Shqipe');
insert into Gjuha_Ofruesit values(30,'Gjuhe Shqipe');
insert into Gjuha_Ofruesit values(40,'English');
insert into Gjuha_Ofruesit values(50,'English');
insert into Gjuha_Ofruesit values(60,'Gjuhe Shqipe');
insert into Gjuha_Ofruesit values(70,'Français');
insert into Gjuha_Ofruesit values(80,'Gjuhe Shqipe');
insert into Gjuha_Ofruesit values(90,'Deutsch');
insert into Gjuha_Ofruesit values(100,'Gjuhe Shqipe');


/* Perditesimi i tabeles Personi*/

update Personi
set emri='Anisa', mbiemri='Hoxha', gjinia='Femer'
where person_id = 4

update Personi
set emri='Serafina', mbiemri='Gashi'
where person_id = 13

update Personi
set emri='Gresa', mbiemri='Veseli', gjinia='Femer', qyteti = 'Mitrovice', 
rruga ='Isa Boletini', numri = 15, zip_kodi = 40010
where person_id = 20

update Personi
set emri='Ledjana', mbiemri='Toplli', gjinia='Femer', qyteti = 'Ferizaj'
where person_id = 24

update Personi
set emri='Besmir', mbiemri='Tahiri', gjinia='Mashkull', qyteti = 'Gjakove'
where person_id = 10

/* Perditesimi i tabeles Gjirollogaria_Bankare*/

update Gjirollogaria_Bankare
set emri_bankes='Banka Ekonomike', data_hapjes='04/20/2015', numri_kotos = 9638
where gjirollogari_id = 2000

update Gjirollogaria_Bankare
set emri_bankes ='Banka Ekonomike', data_hapjes='05/25/2015'
where gjirollogari_id =6000 

update Gjirollogaria_Bankare
set  data_hapjes='04/20/2014', numri_kotos = 7788 
where gjirollogari_id = 2200

update Gjirollogaria_Bankare
set tipi_kontos = 'e kursimeve', pershkrimi_bilancit = 350
where gjirollogari_id = 2700

update Gjirollogaria_Bankare
set emri_bankes = 'Banka Ekonomike', numri_kotos = 1111, tipi_kontos = 'aktuale'
where gjirollogari_id = 5000

/* Perditesimi i tabeles KompaniaSigurimit dhe KompaniaSigNr_tel */

update KompaniaSigurimit
set qyteti='Paris', rruga = 'Napoleon'
where kompani_id = 103

update KompaniaSigurimit
set qyteti='Prsihtine', rruga = 'Dardania', zip_kodi = 100000
where kompani_id = 106

update KompaniaSigNr_tel
set nr_telefonit = '+38349666666'
where kompani_id = 105

update KompaniaSigNr_tel
set nr_telefonit = '+38349333333'
where kompani_id = 102

update KompaniaSigurimit
set qyteti = 'Therand', zip_kodi = 23000
where kompani_id = 101

/* Perditesimi i tabeles Trajtimi */

update Trajtimi
set diagnoza = 'Virus'
where trajtimi_id = 3

update Trajtimi
set diagnoza = 'Insomnia', koha_e_trajtimit = '', simptomat = 'pamundesi e gjumit'
where trajtimi_id = 16

update Trajtimi
set koha_e_trajtimit = '3 dite'
where trajtimi_id = 24

update Trajtimi
set simptomat = 'dhimbje stomaku dhe skuqje te fytit'
where trajtimi_id = 15

update Trajtimi
set koha_e_trajtimit = '5 muaj'
where trajtimi_id = 5


/* Fshirja e objekteve ne tabela*/

delete from MoterMedicionale
where person_id = 31

delete from Doctor
where person_id = 16

delete from  Pacienti
where pacient_id = 1017

delete from Personi
where person_id = 8

delete from  Plani_Sigurimit
where plani_id = 20

delete from Vizita_Doktori
where vizit_id = 27

delete from Trajtimi
where trajtimi_id = 19 

delete from Receta
where receta_id = 22

delete from Medikamente
where medikamenti_id = 8 

delete from Gjirollogaria_Bankare
where gjirollogari_id = 1400


/*Query te thjeshta te realizuara me vetem nje table*/
select emri,mbiemri,qyteti,gjinia
from Personi
where qyteti like 'Ferizaj' and gjinia = 'Femer'

select distinct emri_bankes from Gjirollogaria_Bankare

select MIN(bilanci) as BilanciMinimal, 
MAX(bilanci) as BilanciMaksimal, 
AVG(bilanci) as BilanciMesatar from Kerkesat

select * from Trajtimi
where trajtimi_id >= 9 and 
koha_e_trajtimit in('1 jave','2 jave','1 muaj') and
vizit_id between 14 and 20 


select * from  Personi
where rruga ='17 shkurti' and not mbiemri ='Sllamniku'



/*Query te thjeshta te realizuara me dy ose me shume tabela*/

/*Te gjendet emri i medikamentit, sasia dhe menyra e perdorimit */
select m.emri_medikamentit, p.sasia, r.menyra_perdorimit
from Medikamente m, Permbane p, Receta r
where m.medikamenti_id = p.medikamenti_id
and r.receta_id = p.receta_id

/*Te gjendet mjeku vlersues dhe gjuha */
select distinct  ok.mjeku_vleresues, gjo.gjuha
from Ofruesi_Kujdesit ok,  Gjuha_Ofruesit gjo
where gjo.gjuha = 'Gjuhe Shqipe'


/*Te gjendet id e vizites dhe data e vizites */
select distinct t.vizit_id, vz.data_vizites
from Trajtimi t, Vizita_Doktori vz
where vz.data_vizites = '2015-10-22'


/*Te gjendet emri i kompanise dhe anetaret premium */
select ks.emri_kompanise, ps.Anetaret_Premium
from KompaniaSigurimit ks , Plani_Sigurimit ps
where ks.kompani_id = ps.kompani_id
and ks.emri_kompanise like 'Sig Cos'


/*Te gjendet pagesa e pacientit, pagesa e sigurimit dhe emri i kompanise 'Henner' */
select shk.pagesa_pacientit, shk.pagesa_sigurimit, ks.emri_kompanise
from SherbimiKerkesave shk, Kerkesat k, KompaniaSigurimit ks
where shk.kerkesat_id = k.kerkesat_id
and ks.kompani_id = k.kompani_id
and ks.emri_kompanise like 'Henner'



/*Query te avancuara te realizuara me dy ose me shume tabela*/

/*Te gjenendet emerat e personave te cilat jane doktore (Inner Join)*/
select d.person_id, p.emri
from Doctor d inner join Personi p 
on d.person_id = p.person_id
order by d.person_id asc


/*Te gjenendet menyra e perdorimit dhe sasia e medikamenteve (Left Join)*/
select r.menyra_perdorimit, p.sasia
from Receta r left join  Permbane p 
on r.receta_id = p.receta_id


/*Te gjendet bilanci, shuma e pagese se sigurimit dhe shuma e pageses se pacientit (Right Join)*/
select k.bilanci, shk.pagesa_sigurimit, shk.pagesa_pacientit
from Kerkesat k right join SherbimiKerkesave shk 
on k.kerkesat_id = shk.kerkesat_id
order by k.bilanci desc


/*Te gjendet id, data e hapjes dhe emri i bankes si dhe numri personal (Full Outer Join)*/
select gjb.gjirollogari_id, gjb.data_hapjes, gjb.emri_bankes, p.nr_personal
from Gjirollogaria_Bankare gjb
full outer join Pacienti p 
on gjb.gjirollogari_id = p.gjirollogari_id 
order by p.nr_personal


/*Te gjendet emri i kompanise dhe numri i planve (Having)*/
select ks.emri_kompanise,
count(ps.plani_id) as NumriIPlaneve
from (Plani_Sigurimit ps inner join KompaniaSigurimit ks 
on ps.kompani_id = ks.kompani_id)
Group by emri_kompanise
having count(ps.plani_id) <= 10;



/*Subquery te thjeshta*/

 /*Te shfletohen atributet medikamenti me cmim me te lire */
 select * from Mbane 
 where cmimi_per_njesi = (select min(cmimi_per_njesi)
					      from Mbane);

 /*Te shfletohen anetaret premium mbi mesatare te planit te sigurimit  */
select * from Plani_Sigurimit
where Anetaret_Premium > (select avg(Anetaret_Premium)
						  from Plani_Sigurimit);

/*Te shfletohen atributet e Personit qe eshte pacient me profesion Mesues  */
select * from Personi
where person_id = (select nr_personal from Pacienti
					where profesioni = 'Mesues');

/*Te shfletohen atributet e gjirollogarise e cila ka bilanc ne sigurim 250 */
select * from Gjirollogaria_Bankare
where gjirollogari_id = (select k.gjirollogari_id
						 from Kerkesat k
						 where k.bilanci = 250);

/*Te shfletohen kerkesa me bilancin me te madhe */
select * from Kerkesat
where bilanci = (select max(bilanci)
				 from Kerkesat)
				 order by kerkesat_id; 

/*Subquery te avancuara*/

 /*Te shfletohen atributet medikamenti me cmim me te lire */
 select * from Personi 
 where person_id = (select  nr_personal
					from Pacienti 
					where profesioni = 'Programer');

/*Te shfletohen atributet kompanise se sigurimit qe ka numrin e anetareve premium 30 */
select * from KompaniaSigurimit
where kompani_id = (select kompani_id
					from Plani_Sigurimit
					where Anetaret_Premium = 30);

 
 /*Te shfletohen emri, mbiemri dhe id e personit qe kane vizitu doktorin */
 select p.emri, p.mbiemri, p.person_id 
 from Personi p
 where p.person_id in (select pa.nr_personal
					  from Pacienti pa
					  where pacient_id in (select vz.pacient_id
										  from Vizita_Doktori vz));

/*Te shfletohen atributet e Farmacise qe kane pranuar receteqe permbane menyren e perdorimit 1 here 1 */
select * from Farmaci
where farmaci_id in (select receta_id from Receta 
					where menyra_perdorimit = '1 here 1');

 /*Te shfletohen personat qe kane diagnozen Virus*/
 select * from Trajtimi
 where vizit_id in (select vz.vizit_id 
				   from Vizita_Doktori vz
				   where diagnoza like 'Virus');


/*Stored Procedure me parametra*/

/*Procedura per gjetjen e kompanive ne baze te kodit postar*/
create proc findKompanibykodipostar
@zip_kodi int
as
begin
select *
from KompaniaSigurimit
where zip_kodi = @zip_kodi
endexec findKompanibykodipostar @zip_kodi = 100000;/*Procedura per gjetjen e te dhenave te personit ne baze te emrit */
create proc findPersonbyName
@emri varchar (255)
as
begin
select * 
from Personi
where emri = @emri
end

exec findPersonbyName @emri = 'Anisa'


/*Procedura per gjetjen e id-se nga emri i medikamentit*/
create proc findIDbyname
@emri_medikamentit varchar(255)
as 
begin
select * 
from Medikamente
where emri_medikamentit = @emri_medikamentit
end

exec findIDbyname @emri_medikamentit = 'Paracetamol'


/*Procedura me kombinime te shprehjeve */

/*Procedura per gjetjen e emrit te kompanise se sigurimit ne baze te id-se cift apo tek*/
Create Procedure spcifttek
( 
@kompani_id  int  , 
@emri_kompanise varchar (40) = null)
as
begin
if(@kompani_id %2=0)
    begin
	set @emri_kompanise = (Select ks.emri_kompanise from KompaniaSigurimit ks where ks.kompani_id=@kompani_id)
	print 'Kompania me ID cift ka emrin : ' +(@emri_kompanise)
    end
else
    begin
	set @emri_kompanise = (Select ks.emri_kompanise from KompaniaSigurimit ks where ks.kompani_id=@kompani_id)
	print 'Kompania me ID tek ka emrin : ' +(@emri_kompanise)
    end
if(@kompani_id < 100 or @kompani_id > 109)
	begin
	print 'Nuk ka kompani me kete ID!'
	end
end

exec spcifttek  @kompani_id = 105

/*Procedura per shfletimin e personave sipas qytetit*/
 create proc spNrPersonavesipasqytetit
(
@qyteti varchar (40),
@person_id int = null)
as
begin
	if (@qyteti = 'Prishtine')
	begin
	set @person_id = (select count(*) from Personi p where p.qyteti = @qyteti)
	print 'Numri i personave te radhitur sipas qytetit P eshte: '+convert(varchar,@person_id)
	end
	else
	if (@qyteti = 'Mitrovice')
	begin
	set @person_id = (select count(*) from Personi p where p.qyteti = @qyteti)
	print 'Numri i personave te radhitur sipas qytetit M eshte: '+convert(varchar,@person_id)
	end
	else
	if (@qyteti = 'Ferizaj')
	begin
	set @person_id = (select count(*) from Personi p where p.qyteti = @qyteti)
	print 'Numri i personave te radhitur sipas qytetit F eshte: '+convert(varchar,@person_id)
	end
	else print 'Nuk ka Person me kete vend te lindjes: '+convert(varchar,@person_id)
end

exec spNrPersonavesipasqytetit @qyteti = 'Prishtine'


/*Procedura per filtrimin  e Gjinise*/
create proc FiltrimiiGjinise
( @gjinia as varchar(50) )
as
begin
select * from Personi
where gjinia =
(case when @gjinia IS NULL then 'Mashkull' else @gjinia end)
end

exec FiltrimiiGjinise @gjinia = null


/*View per gjetjen e personave qke jane te prishtines dhe qe rruga quhet Dardania*/
create view emriRrugesseQytetitPrishtine
as 
select * from Personi
where qyteti = 'prishtine'

select * 
from emriRrugesseQytetitPrishtine
where rruga = 'Dardania'

