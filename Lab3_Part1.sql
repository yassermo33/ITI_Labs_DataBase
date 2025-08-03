create database hospital
use hospital
create table nurse(number int primary key ,name  varchar ,address varchar)

create table word(id int primary key , name varchar ,number_nurse int
foreign key(number_nurse)  references nurse(number ))

create table patient(id int primary key ,BD date , name varchar , id_word int
foreign key(id_word)  references word(id)
)

create table consultant(id int primary key ,name varchar ,id_patient int
foreign key(id_patient)  references patient(id))

create table drug(code int primary key ,brand varchar )

create table patient_condultant(id_patient int,id_consltant int
primary key(id_patient,id_consltant)
foreign key (id_patient)references patient(id),
foreign key (id_consltant)references consultant(id))

create table patient_drug(time time   ,data int,dosag varchar,number_nurse int,
code_drug int,id_patient int
primary key (id_patient,code_drug,time)
foreign key (number_nurse) references nurse(number),
foreign key (code_drug) references drug(code),
foreign key (id_patient) references patient(id))

create table brand(name varchar,code_drug int
primary key (name,code_drug)
foreign key (code_drug) references drug(code))







