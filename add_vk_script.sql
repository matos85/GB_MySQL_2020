-- education wall posts добавляются в качестве таблиц. Назначение отображать образование , стену постов, и и сами посты из групп соответсвенно

use vk;

DROP TABLE IF EXISTS education;
CREATE TABLE education (
	user_id SERIAL PRIMARY KEY, -- ключем будет ID пользовтеля
    educational_institution VARCHAR(100) COMMENT 'учебное заведение',
    training_start_date VARCHAR(100) COMMENT 'дата начала обучения',  
    specialty VARCHAR(100) COMMENT 'дата начала обучения',
    
    is_deleted bit default 0,
    -- INDEX users_educational_institution_idx(educational_institution), -- индексируем образовательные учреждения
    INDEX users_educational_institution_idx(educational_institution)
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
	id SERIAL PRIMARY KEY, 
	community_id BIGINT UNSIGNED NOT null,
    posts_name VARCHAR(30)  COMMENT 'имя поста', 
    posts_text VARCHAR(100) COMMENT 'содержимое поста'
	-- FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE cascade
);

DROP TABLE IF EXISTS wall;
CREATE TABLE wall (
	id SERIAL PRIMARY KEY, 
    user_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL
 	-- FOREIGN KEY (post_id) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE `education` ADD CONSTRAINT educ_user_id
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE `posts` ADD CONSTRAINT communiti_post_id
FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE `wall` ADD CONSTRAINT wall_posts_id
FOREIGN KEY (post_id) REFERENCES posts(id) ON UPDATE CASCADE ON DELETE cascade;