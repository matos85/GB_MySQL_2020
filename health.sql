/*

Пункт 1: 
Имя:БД полезности события
Создание БД для аналитико-рекомендательной системы которая накапливала и хранила данные по событиям в жизни пользователям
а также информацию после анализа этих событий с целью определения полезности и вредности этих событий с последующей рекомендацией об отношении к событию.

*/

DROP DATABASE IF exists health;
CREATE DATABASE health;
USE health;

-- полезность события
DROP TABLE IF EXISTS `Event_usefulness`;
CREATE TABLE `Event_usefulness`(
	`Id_event_usefulness` SERIAL PRIMARY KEY,
	`Event_usefulness`  VARCHAR(200)  UNIQUE COMMENT 'Полезность события'	
);

INSERT INTO `Event_usefulness` values
('1','Полезно'),
('2','Вредно');

-- пользователи
DROP TABLE IF exists `Users`;
CREATE TABLE `Users`(
	`Id_user`  SERIAL PRIMARY KEY,
	`Surname`  VARCHAR(50) null COMMENT 'Фамилия', 
	`Name`  VARCHAR(50) NULL,
	`Middle_name`  VARCHAR(50) null COMMENT 'Отчество', 
	`birthday` DATE,
	`Height`  INTEGER null COMMENT 'Рост', 
	`Weight`  INTEGER null COMMENT 'Вес',
	INDEX users_Surname_Name_idx(Surname, Name)
);

INSERT INTO `Users` values
('1','Иванов','Иван','Иванович','2000-12-10','177','90'),
('2','Петров','Петр','Петрович','1978-02-01','177','80'),
('3','Сидоров','Сидр','Иванович','1988-12-05','167','90'),
('4','Сперидонов','Сперидон','Михалович','1989-12-03','172','85'),
('5','Владленин','Маклай','Иванович','1978-12-10','173','89'),
('6','Примаков','Иван','Игнатьевич','1978-06-11','172','77'),
('7','Коржев','Максим','Андреевич','1998-12-06','170','90'),
('8','Земцев','Кирилл','Сперидонович','1968-11-11','187','90'),
('9','Иванов','Илья','Иванович','1987-10-15','180','100'),
('10','Пакияо','Мени','Иванович','1990-11-09','160','85');

-- Типы событий
DROP TABLE IF exists `Type_events`;
CREATE TABLE `Type_events`(
	`Id_tip_event`  SERIAL PRIMARY KEY,
	`Type_event`  VARCHAR(100)  UNIQUE	
);

INSERT INTO `Type_events` values
('1','Прием жирной пищи'),
('2','Употребление зелени в пищу'),
('3','Употреблеие алкоголя'),
('4','Пробежка на 5 км'),
('5','Дневной сон 3 часа'),
('6','Работа (сидя)'),
('7','Работа (на ногах)'),
('8','Прогулка в парке'),
('9','Прослушивание концерта'),
('10','Киносеанс в кинотеатре'),
('11','Танцы'),
('12','Тренировка в спорт зале'),
('13','Сон 4 часа'),
('14','Сон 8 часов'),
('15','Сон 13 часов'),
('16','Стресс из-за потери работы'),
('17','Стресс из-за экзамена'),
('18','Операция (на внутреннем органе)'),
('19','Прием лекарств (по назначению)'),
('20','Прием лекарств (не по назначению)');

-- Тиы самочувствий
DROP TABLE IF exists `Type_health`;
CREATE TABLE `Type_health` (
	`Id_type_health`  SERIAL PRIMARY KEY,
	`Type_health`  VARCHAR(50) null COMMENT 'Тип самочувствия' -- состояние здоровья. Плохо, Хорошо, Очень хорошо и т.д.
);

INSERT INTO `Type_health` values
('1','Нормально'),
('2','Хорошо'),
('3','Отлично'),
('4','Великолепно'),
('5','Нет слов одни эмоции'),
('6','Плохо мне кажется'),
('7','Очень плохо'),
('8','Так плохо что умираю'),
('9','Болен кажется'),
('10','Душа болит');

-- События
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

-- Индекс массы тела
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

-- Медицинские рекомендации
DROP TABLE IF exists `Medical_recommendations`;
CREATE TABLE `Medical_recommendations`(
	`Id_med_recomend`  SERIAL PRIMARY KEY,
	`Medical_recommendations`  VARCHAR(900) null
);

-- факты взяты на угад(почти произвольно) из интернета. Для боевой базы нужно очень большое количестов данных рекомендаций
INSERT INTO `Medical_recommendations` values
('1','Еда нужна для жизни. Любая еда – это не просто удовольствие или ритуал. Любое съеденное блюдо поставляет в организм энергию и вещества для поддержания здоровья.'),
('2','Питайтесь полноценно. Соотношение белков, жиров и углеводов за день должно примерно равняться 1:1:4.'),
('3','Разнообразьте рацион. Одни и те же продукты на столе – это скучно и чревато недобором важных питательных компонентов. '),
('4','Ешьте чаще. Как ни парадоксально, чтобы не набирать вес, надо есть чаще.'),
('5','Углеводы жизненно важны. Это основной источник энергии, так как организм использует для своих нужд именно глюкозу.'),
('6','Углеводы простые и медленные. В понимании обывателя углеводная пища — это что-то сладкое. '),
('7','Меньше сахара. Избыточный сахар в питании – еще одна причина лишнего веса. Читайте этикетки внимательно. '),
('8','Ешьте больше цельнозерновых продуктов. В них есть сложные углеводы, которые перевариваются медленно и снижают тягу к сладостям. '),
('9','Белки должны быть всегда. Из белков образуются клетки организма, в частности, мышечная ткань. '),
('10','Жиры нельзя полностью исключать. Из жиров состоят оболочки нервных волокон, они входят в структуру клеточной стенки, а также необходимы для деления клеток и синтеза важных гормонов. '),
('11','Жиры надо ограничивать. Избыток жиров не только откладывается организмом про запас и образует лишний вес, но и нарушает работу печени и поджелудочной железы.'),
('12','Сократить жиры в питании довольно просто. Нежирные молочные продукты на вкус не хуже, чем цельные, а калорийность рациона при их помощи можно сократить почти вдвое.'),
('13','Не менее 600 г фруктов и овощей в день. Овощи, фрукты и ягоды содержат витамины, которых нет в других продуктах питания.'),
('14','Потребляйте рыбу минимум раз в неделю. В жирной рыбе – скумбрии, сельди или семге — много незаменимых жирных кислот Омега-3, которые борются с заболеваниями сердца и сосудов.'),
('15','Включите в рацион молочные продукты. Суточную норму кальция можно получить из полулитра молока, а витамина В2 – из стакана. '),
('16','Учите детей правильному питанию. Причины лишнего веса взрослых обычно заключаются в том, как они питались в детстве. '),
('17','Лишний вес: избыток питания или недостаток движения. Вес увеличивается, когда организм получает с пищей больше энергии, чем ему требуется.'),
('18','Проверить свой вес просто. Понять, есть ли у вас лишний вес, можно, рассчитав ИМТ.  Если  значение от 18,5 до 25, значит, лишнего веса у вас нет.'),
('19','Количество калорий зависит от вашего образа жизни. Количество энергии, необходимой для организма, зависит от того, насколько вы активны.'),
('20','Здоровое питание – это просто и недорого. Самые полезные крупы – самые дешевые. '),
('21','Во время бега повышается уровень эндорфинов в крови, поэтому после пробежек всегда поднимается настроение.'),
('22','Бег – один из лучших способов отвлечься от сложной задачи и отыскать в подсознании легкий способ ее решения.'),
('23','Специальный эффект беговой тренировки заключается в повышении функциональных возможностей сердечно-сосудистой системы и аэробной производительности организма. '),
('24','Бег считается одним из наиболее доступных и несложных видов физической культуры, оказывающий полезность всему организму человека. '),
('25','В то время, когда человек спит, намного быстрее проходит процесс заживления ран и ожогов.'),
('26','При регулярном недосыпе у человека удивительным образом начинает подрываться работоспособность.'),
('27','Бессонница – причина многих заболеваний.'),
('28','Просыпания в раннее время говорят о том, что у вас гормональные проблемы.'),
('29','Дневной сон может с легкостью перерасти в ночной, так как организм реагирует на биоритмы'),
('30','Танцевальные движения дают нагрузку на все мышцы тела, делая их упругими и сильными и разрабатывают подвижность суставов.'),
('31','Тренировка мышц способствует формированию красивой осанки, особенно на это обращается внимание в бальных танцах и испанских: фламенко, пасодобль.'),
('32','Повышается уровень инсулина. Такой углевод, как глюкоза, выступает в организме источником энергии, которая активирует протекторные свойства организма.'),
('33','Непроизвольно сокращаются мышцы. Судороги способны разрушать мышечную ткань, из которой состоят внутренние органы.'),
('34','Нарушается функционирование клеток. Под воздействием регулярного стресса в клетках происходит процесс выработки токсинов, которые со временем накапливаются и отравляют организм.'),
('35','Болезни сердечно-сосудистой системы'),
('36','Проблемы с сексуальным здоровьем'),
('37','При кратковременном воздействии стресса на организм его защитные системы начинают работать максимально эффективно'),
('38','Тахикардия и панические атаки;'),
('39','Ускоренное восстановление после операции'),
('40','Положительное воздействие на иммунную систему');

-- персональные рекомендации
DROP TABLE IF exists `Personal_recommendations`;
CREATE TABLE `Personal_recommendations`(
	`Id_personal_recommendations`  SERIAL PRIMARY KEY,
	`Personal_recommendations`  VARCHAR(200) NULL,
	`Id_med_recomend`  BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (Id_med_recomend) REFERENCES Medical_recommendations(Id_med_recomend) ON UPDATE CASCADE ON DELETE cascade	 
);

INSERT INTO `Personal_recommendations` values
('1','Здоров','1'),
('2','Здоров','11'),
('3','Здоров','21'),
('4','Здоров','32'),
('5','Здоров','2'),
('6','Здоров','22'),
('7','Здоров','33'),
('8','Здоров','4'),
('9','Здоров','5'),
('10','Болен','6');

-- Статус здоровья
DROP TABLE IF exists `Status_healths`;
CREATE TABLE `Status_healths` (
	`Id_status_healths` SERIAL PRIMARY KEY,
	`Status_healths`VARCHAR(50) null
);

INSERT INTO `Status_healths` values
('1','Здоров'),
('2','Болен');

-- Состояние здоровья 
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

-- Контактные данные
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
('1','1','89189111234','Иванович111@mail.ru','298979, Самарская область, город Домодедово, пл. Чехова, 42'),
('2','2','89189222345','Петрович@mail.ru','337576, Нижегородская область, город Истра, наб. Косиора, 95'),
('3','3','89189333456','Иванович@mail.su','029043, Смоленская область, город Лотошино, проезд Будапештсткая, 70'),
('4','4','89189444567','Михалович@mail.ru','975891, Пензенская область, город Шатура, бульвар Ломоносова, 15'),
('5','5','89189118901','Иванович@mailer.ru','172789, Ярославская область, город Москва, проезд Ломоносова, 64'),
('6','6','89189112311','Игнатьевич@mail.ru','327184, Кемеровская область, город Клин, пер. Ладыгина, 57'),
('7','7','89189110012','Андреевич@mail.ru','557201, Тамбовская область, город Щёлково, пл. Балканская, 68'),
('8','8','89189111994','Сперидонович@mail.ru','704627, Архангельская область, город Серпухов, ул. Ладыгина, 79'),
('9','9','89189111299','Иванович@mail.ru','016780, Свердловская область, город Чехов, шоссе Гоголя, 17'),
('10','10','89189101234','Иванович@email.ru','854179, Вологодская область, город Лотошино, проезд Сталина, 47');


-- ------ Представления ------------- --

-- ИМТ Пользователя
DROP view if exists `user_imt`;

create or replace view `user_imt` as
select Surname, Name, Middle_name, Height, Weight, IMT 
from users, imt 
where users.Id_user = imt.Id_user;

-- Рекомендации улучшающие здоровье и рекомендации чего избежать во избежание ухудщения здоровья.
-- Факты случайные не имеющие ничего общего с действительностью. Разделены по принцепы Здоров - полезно. Болен - вредно. 
create or replace view `medical_recommendations_for_helth` as
select `Personal_recommendations`.Personal_recommendations, `medical_recommendations`.Medical_recommendations 
from `Personal_recommendations`, `medical_recommendations`
where `Personal_recommendations`.Id_med_recomend = `medical_recommendations`.Id_med_recomend;

-- ------ Скрипт представления вложенным запросом ------------- --

-- Контакты пользователей
DROP view if exists `user_contacts`;

create or replace  view `user_contacts` as
select Surname, Name, Middle_name, Telefon, Email, Adress 
from `users`, `contacts`
where `users`.Id_user in (
	select `contacts`.Id_user
	from `users`
	where `contacts`.Id_user = `users`.Id_user
);

-- ------ Скрипт представления с JOIN с групировкой ------------- --

-- События пользователей
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


-- ------ Хранимые процедуры / Триггеры ------------- --

-- Процедура добавления пользователя
DROP PROCEDURE IF exists add_user;
delimiter //

CREATE PROCEDURE add_user(in I SERIAL, S VARCHAR(50), N VARCHAR(50), M VARCHAR(50), B DATE ,H INTEGER, W INTEGER)
begin
	INSERT INTO users values (I, S, N, M, B, H, W);
end 
//

call add_user('12','Иванченко','Иванко','Иванович','2022-10-10','187','99')//



-- тригер расчета индекса массы тела
DROP TRIGGER IF EXISTS bmi_calculation;
DELIMITER //
//
CREATE TRIGGER `bmi_calculation` AFTER INSERT ON `users` FOR EACH ROW update IMT 
set imt = (select `users`.Weight / (`users`.Height * `users`.Height ) * 10000 from users)
where `imt`.IMT  = 0
//
DELIMITER ;

-- Тригер  проверки возраста на будущее. 
-- фантазии не хватило у меня на тригеры...
DELIMITER //
//
CREATE trigger `chek_user_age_befor_update` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN 
	IF new.birthday >= current_date()  then 
		signal  sqlstate  '45000' set message_text = 'Сработал тригер! ОБновление отменено. Направильно указана дата!';
	END if ;
END
//
DELIMITER ;


