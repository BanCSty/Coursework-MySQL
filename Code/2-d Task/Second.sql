﻿/* Создание базы данных «Детский садик» */
drop database if exists Ivanov;
create database Ivanov;

/* Открытие базы данных */
Use Ivanov;

/* Очистка БД от всех таблиц */
drop table if exists `Дети`;
drop table if exists `Группы`;
drop table if exists `Персонал`;

/* 1. Создание таблиц и связей между ними */
create table `Персонал` (
	`Табельный №` INT not null primary key,
	`ФИО работника` varchar(30) not null,
	`Должность` varchar(20) not null,
	`Оклад` INT not null
);

create table `Группы` (
	`№ группы` char(1) not null primary key,
	`Название группы` varchar(20) not null,
	`Табельный №` INT not null,
	foreign key (`Табельный №`) references `Персонал`(`Табельный №`) on update cascade on delete restrict
);

create table `Дети` (
	`№ порядковый` int not null primary key,
	`ФИО ребенка` varchar(30) not null,
	`Дата рождения` date not null,
	`№ группы` char(1) not null ,
	foreign key (`№ группы`) references `Группы`(`№ группы`) on update cascade on delete restrict
);

/* 2. Заполнение таблиц данными */
insert into `Персонал` (`Табельный №`, `ФИО работника`, `Должность`, `Оклад`)
	values 	(102, "Фролова Н.Г.", "Воспитатель", 27000),
		(108, "Самохина В.П.", "Ст.воспитатель", 32000),
		(107, "Самохвалова И.В.", "Воспитатель", 27000),
		(110, "Фирсова М.В.", "Воспитатель", 27000),
		(120, "Фурманов Н.И.", "Зав. детским садиком", 52000);

insert into `Группы`(`№ группы`, `Название группы`, `Табельный №`)
	values  ("М","Младшая",102),
		("П","Подготовительная",108),
		("С","Средняя",107),
		("Я","Ясельная",110);

insert into `Дети` (`№ порядковый`, `ФИО ребенка`, `Дата рождения`,`№ группы`)
	values  (1001,"Петров Артем","2017-12-23","М"),
		(1002,"Фролов Антон","2018-06-30","М"),
		(1003,"Федорова Ирина","2015-09-12","П"),
	        (1004,"Иванов Алеша","2016-10-30","С"),
		(1005,"Сидорова Наташа","2016-02-27","С"),
		(1006,"Семенова Маша","2019-03-15","Я");

select A.`№ порядковый`, A.`ФИО ребенка`, A.`Дата рождения`, A.`№ группы`, B.`Название группы`,C.`Табельный №`,
	 C.`ФИО работника`, C.`Должность`, C.`Оклад`
from (`Дети` as A inner join `Группы` as B on A.`№ группы`=B.`№ группы`) right join `Персонал` as C on B.`Табельный №`=C.`Табельный №`
Order by A.`№ порядковый`;
 
