/*

����� 1: 
���:�� ���������� �������
�������� �� ��� ���������-���������������� ������� ������� ����������� � ������� ������ �� �������� � ����� �������������
� ����� ���������� ����� ������� ���� ������� � ����� ����������� ���������� � ��������� ���� ������� � ����������� ������������� �� ��������� � �������.

*/

DROP DATABASE IF exists health;
CREATE DATABASE health;
USE health;

-- ���������� �������
DROP TABLE IF EXISTS `Event_usefulness`;
CREATE TABLE `Event_usefulness`(
	`Id_event_usefulness` SERIAL PRIMARY KEY,
	`Event_usefulness`  VARCHAR(200)  UNIQUE COMMENT '���������� �������'	
);

INSERT INTO `Event_usefulness` values
('1','�������'),
('2','������');

-- ������������
DROP TABLE IF exists `Users`;
CREATE TABLE `Users`(
	`Id_user`  SERIAL PRIMARY KEY,
	`Surname`  VARCHAR(50) null COMMENT '�������', 
	`Name`  VARCHAR(50) NULL,
	`Middle_name`  VARCHAR(50) null COMMENT '��������', 
	`birthday` DATE,
	`Height`  INTEGER null COMMENT '����', 
	`Weight`  INTEGER null COMMENT '���',
	INDEX users_Surname_Name_idx(Surname, Name)
);

INSERT INTO `Users` values
('1','������','����','��������','2000-12-10','177','90'),
('2','������','����','��������','1978-02-01','177','80'),
('3','�������','����','��������','1988-12-05','167','90'),
('4','����������','��������','���������','1989-12-03','172','85'),
('5','���������','������','��������','1978-12-10','173','89'),
('6','��������','����','����������','1978-06-11','172','77'),
('7','������','������','���������','1998-12-06','170','90'),
('8','������','������','������������','1968-11-11','187','90'),
('9','������','����','��������','1987-10-15','180','100'),
('10','������','����','��������','1990-11-09','160','85');

-- ���� �������
DROP TABLE IF exists `Type_events`;
CREATE TABLE `Type_events`(
	`Id_tip_event`  SERIAL PRIMARY KEY,
	`Type_event`  VARCHAR(100)  UNIQUE	
);

INSERT INTO `Type_events` values
('1','����� ������ ����'),
('2','������������ ������ � ����'),
('3','����������� ��������'),
('4','�������� �� 5 ��'),
('5','������� ��� 3 ����'),
('6','������ (����)'),
('7','������ (�� �����)'),
('8','�������� � �����'),
('9','������������� ��������'),
('10','��������� � ����������'),
('11','�����'),
('12','���������� � ����� ����'),
('13','��� 4 ����'),
('14','��� 8 �����'),
('15','��� 13 �����'),
('16','������ ��-�� ������ ������'),
('17','������ ��-�� ��������'),
('18','�������� (�� ���������� ������)'),
('19','����� �������� (�� ����������)'),
('20','����� �������� (�� �� ����������)');

-- ��� ������������
DROP TABLE IF exists `Type_health`;
CREATE TABLE `Type_health` (
	`Id_type_health`  SERIAL PRIMARY KEY,
	`Type_health`  VARCHAR(50) null COMMENT '��� ������������' -- ��������� ��������. �����, ������, ����� ������ � �.�.
);

INSERT INTO `Type_health` values
('1','���������'),
('2','������'),
('3','�������'),
('4','�����������'),
('5','��� ���� ���� ������'),
('6','����� ��� �������'),
('7','����� �����'),
('8','��� ����� ��� ������'),
('9','����� �������'),
('10','���� �����');

-- �������
DROP TABLE IF exists `Events`;
CREATE TABLE `Events`(
	`ID_events`  SERIAL PRIMARY KEY,
	`ID_users`  BIGINT UNSIGNED NOT NULL,
	`Id_event_usefulness`  BIGINT UNSIGNED NOT NULL,
	 `Id_tip_event`  BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (ID_users) REFERENCES Users(Id_user) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_tip_event) REFERENCES Type_events(Id_tip_event) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_event_usefulness) REFERENCES Event_usefulness(Id_event_usefulness) ON UPDATE CASCADE ON DELETE cascade
);

INSERT INTO `Events` values
('1','1','1','11'),
('2','2','2','12'),
('3','3','1','13'),
('4','4','2','14'),
('5','5','1','15'),
('6','6','2','16'),
('7','7','1','17'),
('8','8','2','18'),
('9','9','1','19'),
('10','10','2','20');

-- ������ ����� ����
DROP TABLE IF exists `IMT`;
CREATE TABLE `IMT` (
	`Id_IMT`  SERIAL PRIMARY KEY,
	`IMT`  FLOAT NULL,
	`Id_user`  BIGINT UNSIGNED NOT NULL,
	`calculation_date` DATETIME,
	
	FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON UPDATE CASCADE ON DELETE cascade
);

INSERT INTO `IMT` values
('1','0','1', '2021-01-08 11:46:31'),
('2','0','2', NOW()),
('3','0','3', NOW()),
('4','0','4', NOW()),
('5','0','5', NOW()),
('6','0','6', NOW()),
('7','0','7', NOW()),
('8','0','8', NOW()),
('9','0','9', NOW()),
('10','0','1', NOW()),
('11','0','10', NOW());

-- ����������� ������������
DROP TABLE IF exists `Medical_recommendations`;
CREATE TABLE `Medical_recommendations`(
	`Id_med_recomend`  SERIAL PRIMARY KEY,
	`Medical_recommendations`  VARCHAR(900) null
);

-- ����� ����� �� ����(����� �����������) �� ���������. ��� ������ ���� ����� ����� ������� ���������� ������ ������������
INSERT INTO `Medical_recommendations` values
('1','��� ����� ��� �����. ����� ��� � ��� �� ������ ������������ ��� ������. ����� ��������� ����� ���������� � �������� ������� � �������� ��� ����������� ��������.'),
('2','��������� ����������. ����������� ������, ����� � ��������� �� ���� ������ �������� ��������� 1:1:4.'),
('3','������������� ������. ���� � �� �� �������� �� ����� � ��� ������ � ������� ��������� ������ ����������� �����������. '),
('4','����� ����. ��� �� �������������, ����� �� �������� ���, ���� ���� ����.'),
('5','�������� �������� �����. ��� �������� �������� �������, ��� ��� �������� ���������� ��� ����� ���� ������ �������.'),
('6','�������� ������� � ���������. � ��������� ��������� ���������� ���� � ��� ���-�� �������. '),
('7','������ ������. ���������� ����� � ������� � ��� ���� ������� ������� ����. ������� �������� �����������. '),
('8','����� ������ �������������� ���������. � ��� ���� ������� ��������, ������� �������������� �������� � ������� ���� � ���������. '),
('9','����� ������ ���� ������. �� ������ ���������� ������ ���������, � ���������, �������� �����. '),
('10','���� ������ ��������� ���������. �� ����� ������� �������� ������� �������, ��� ������ � ��������� ��������� ������, � ����� ���������� ��� ������� ������ � ������� ������ ��������. '),
('11','���� ���� ������������. ������� ����� �� ������ ������������� ���������� ��� ����� � �������� ������ ���, �� � �������� ������ ������ � ������������� ������.'),
('12','��������� ���� � ������� �������� ������. �������� �������� �������� �� ���� �� ����, ��� �������, � ������������ ������� ��� �� ������ ����� ��������� ����� �����.'),
('13','�� ����� 600 � ������� � ������ � ����. �����, ������ � ����� �������� ��������, ������� ��� � ������ ��������� �������.'),
('14','����������� ���� ������� ��� � ������. � ������ ���� � ��������, ������ ��� ����� � ����� ����������� ������ ������ �����-3, ������� ������� � ������������� ������ � �������.'),
('15','�������� � ������ �������� ��������. �������� ����� ������� ����� �������� �� ��������� ������, � �������� �2 � �� �������. '),
('16','����� ����� ����������� �������. ������� ������� ���� �������� ������ ����������� � ���, ��� ��� �������� � �������. '),
('17','������ ���: ������� ������� ��� ���������� ��������. ��� �������������, ����� �������� �������� � ����� ������ �������, ��� ��� ���������.'),
('18','��������� ���� ��� ������. ������, ���� �� � ��� ������ ���, �����, ��������� ���.  ����  �������� �� 18,5 �� 25, ������, ������� ���� � ��� ���.'),
('19','���������� ������� ������� �� ������ ������ �����. ���������� �������, ����������� ��� ���������, ������� �� ����, ��������� �� �������.'),
('20','�������� ������� � ��� ������ � ��������. ����� �������� ����� � ����� �������. '),
('21','�� ����� ���� ���������� ������� ���������� � �����, ������� ����� �������� ������ ����������� ����������.'),
('22','��� � ���� �� ������ �������� ��������� �� ������� ������ � �������� � ����������� ������ ������ �� �������.'),
('23','����������� ������ ������� ���������� ����������� � ��������� �������������� ������������ ��������-���������� ������� � �������� ������������������ ���������. '),
('24','��� ��������� ����� �� �������� ��������� � ��������� ����� ���������� ��������, ����������� ���������� ����� ��������� ��������. '),
('25','� �� �����, ����� ������� ����, ������� ������� �������� ������� ���������� ��� � ������.'),
('26','��� ���������� �������� � �������� ������������ ������� �������� ����������� �����������������.'),
('27','���������� � ������� ������ �����������.'),
('28','���������� � ������ ����� ������� � ���, ��� � ��� ������������ ��������.'),
('29','������� ��� ����� � ��������� ��������� � ������, ��� ��� �������� ��������� �� ��������'),
('30','������������ �������� ���� �������� �� ��� ����� ����, ����� �� �������� � �������� � ������������� ����������� ��������.'),
('31','���������� ���� ������������ ������������ �������� ������, �������� �� ��� ���������� �������� � ������� ������ � ���������: ��������, ���������.'),
('32','���������� ������� ��������. ����� �������, ��� �������, ��������� � ��������� ���������� �������, ������� ���������� ������������ �������� ���������.'),
('33','������������� ����������� �����. �������� �������� ��������� �������� �����, �� ������� ������� ���������� ������.'),
('34','���������� ���������������� ������. ��� ������������ ����������� ������� � ������� ���������� ������� ��������� ��������, ������� �� �������� ������������� � ��������� ��������.'),
('35','������� ��������-���������� �������'),
('36','�������� � ����������� ���������'),
('37','��� ��������������� ����������� ������� �� �������� ��� �������� ������� �������� �������� ����������� ����������'),
('38','���������� � ���������� �����;'),
('39','���������� �������������� ����� ��������'),
('40','������������� ����������� �� �������� �������');

-- ������������ ������������
DROP TABLE IF exists `Personal_recommendations`;
CREATE TABLE `Personal_recommendations`(
	`Id_personal_recommendations`  SERIAL PRIMARY KEY,
	`Personal_recommendations`  VARCHAR(200) NULL,
	`Id_med_recomend`  BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (Id_med_recomend) REFERENCES Medical_recommendations(Id_med_recomend) ON UPDATE CASCADE ON DELETE cascade	 
);

INSERT INTO `Personal_recommendations` values
('1','������','1'),
('2','������','11'),
('3','������','21'),
('4','������','32'),
('5','������','2'),
('6','������','22'),
('7','������','33'),
('8','������','4'),
('9','������','5'),
('10','�����','6');

-- ������ ��������
DROP TABLE IF exists `Status_healths`;
CREATE TABLE `Status_healths` (
	`Id_status_healths` SERIAL PRIMARY KEY,
	`Status_healths`VARCHAR(50) null
);

INSERT INTO `Status_healths` values
('1','������'),
('2','�����');

-- ��������� �������� 
DROP TABLE IF exists `Status_health`;
CREATE TABLE `Status_health` (
	`Id_status_health` SERIAL PRIMARY KEY,
	`id_type_health` BIGINT UNSIGNED NOT NULL,
	`Id_user` BIGINT UNSIGNED NOT NULL,
	`Id_personal_recommendations`  BIGINT UNSIGNED NOT NULL,
	`Id_IMT` BIGINT UNSIGNED NOT NULL,
	`ID_events` BIGINT UNSIGNED NOT NULL,
	`Id_status_healths` BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (id_type_health) REFERENCES Type_health(Id_type_health) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_personal_recommendations) REFERENCES Personal_recommendations(Id_personal_recommendations) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_IMT) REFERENCES IMT(Id_IMT) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (ID_events) REFERENCES Events(ID_events) ON UPDATE CASCADE ON DELETE cascade,
	FOREIGN KEY (Id_status_healths) REFERENCES Status_healths(Id_status_healths) ON UPDATE CASCADE ON DELETE cascade
);

INSERT INTO `Status_health` values
('1','1','1','1','1','1','1'),
('2','2','2','1','1','1','2'),
('3','3','3','1','1','1','1'),
('4','4','4','1','1','1','1'),
('5','5','5','1','1','1','1'),
('6','6','6','1','1','1','2'),
('7','7','7','1','1','1','1'),
('8','8','8','1','1','1','1'),
('9','9','9','1','1','1','2'),
('10','10','10','1','1','1','1');  

-- ���������� ������
DROP TABLE IF exists `contacts`;
CREATE TABLE `contacts`(
	`Id_contact_user`  SERIAL PRIMARY KEY,
	`Id_user` BIGINT UNSIGNED NOT NULL,
	`Telefon`  BIGINT, 
	`Email`  VARCHAR(50)  UNIQUE,
	`Adress`  VARCHAR(200) null,  
	
	FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON UPDATE CASCADE ON DELETE cascade	
);

INSERT INTO `contacts` values
('1','1','89189111234','��������111@mail.ru','298979, ��������� �������, ����� ����������, ��. ������, 42'),
('2','2','89189222345','��������@mail.ru','337576, ������������� �������, ����� �����, ���. �������, 95'),
('3','3','89189333456','��������@mail.su','029043, ���������� �������, ����� ��������, ������ �������������, 70'),
('4','4','89189444567','���������@mail.ru','975891, ���������� �������, ����� ������, ������� ����������, 15'),
('5','5','89189118901','��������@mailer.ru','172789, ����������� �������, ����� ������, ������ ����������, 64'),
('6','6','89189112311','����������@mail.ru','327184, ����������� �������, ����� ����, ���. ��������, 57'),
('7','7','89189110012','���������@mail.ru','557201, ���������� �������, ����� ٸ�����, ��. ����������, 68'),
('8','8','89189111994','������������@mail.ru','704627, ������������� �������, ����� ��������, ��. ��������, 79'),
('9','9','89189111299','��������@mail.ru','016780, ������������ �������, ����� �����, ����� ������, 17'),
('10','10','89189101234','��������@email.ru','854179, ����������� �������, ����� ��������, ������ �������, 47');


-- ------ ������������� ------------- --

-- ��� ������������
DROP view if exists `user_imt`;

create or replace view `user_imt` as
select Surname, Name, Middle_name, Height, Weight, IMT 
from users, imt 
where users.Id_user = imt.Id_user;

-- ������������ ���������� �������� � ������������ ���� �������� �� ��������� ��������� ��������.
-- ����� ��������� �� ������� ������ ������ � �����������������. ��������� �� �������� ������ - �������. ����� - ������. 
create or replace view `medical_recommendations_for_helth` as
select `Personal_recommendations`.Personal_recommendations, `medical_recommendations`.Medical_recommendations 
from `Personal_recommendations`, `medical_recommendations`
where `Personal_recommendations`.Id_med_recomend = `medical_recommendations`.Id_med_recomend;

-- ------ ������ ������������� ��������� �������� ------------- --

-- �������� �������������
DROP view if exists `user_contacts`;

create or replace  view `user_contacts` as
select Surname, Name, Middle_name, Telefon, Email, Adress 
from `users`, `contacts`
where `users`.Id_user in (
	select `contacts`.Id_user
	from `users`
	where `contacts`.Id_user = `users`.Id_user
);

-- ------ ������ ������������� � JOIN � ����������� ------------- --

-- ������� �������������
DROP view if exists `user_events`;

create or replace view `user_events` as
select `events`.ID_events, `users`.Surname, `users`.Name, `users`.Middle_name,  `event_usefulness`.Event_usefulness, `type_events`.Type_event
from users 
join events 
on `users`.Id_user = `events`.ID_users 
join event_usefulness
on `events`.Id_event_usefulness = `event_usefulness`.Id_event_usefulness 
join type_events
on `events`.Id_tip_event = `type_events`.Id_tip_event 
order by `events`.ID_events;


-- ------ �������� ��������� / �������� ------------- --

-- ��������� ���������� ������������
DROP PROCEDURE IF exists add_user;
delimiter //

CREATE PROCEDURE add_user(in I SERIAL, S VARCHAR(50), N VARCHAR(50), M VARCHAR(50), B DATE ,H INTEGER, W INTEGER)
begin
	INSERT INTO users values (I, S, N, M, B, H, W);
end 
//

call add_user('12','���������','������','��������','2022-10-10','187','99')//



-- ������ ������� ������� ����� ����
DROP TRIGGER IF EXISTS bmi_calculation;
DELIMITER //
//
CREATE TRIGGER `bmi_calculation` AFTER INSERT ON `users` FOR EACH ROW update IMT 
set imt = (select `users`.Weight / (`users`.Height * `users`.Height ) * 10000 from users)
where `imt`.IMT  = 0
//
DELIMITER ;

-- ������  �������� �������� �� �������. 
-- �������� �� ������� � ���� �� �������...
DELIMITER //
//
CREATE trigger `chek_user_age_befor_update` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN 
	IF new.birthday >= current_date()  then 
		signal  sqlstate  '45000' set message_text = '�������� ������! ���������� ��������. ����������� ������� ����!';
	END if ;
END
//
DELIMITER ;


