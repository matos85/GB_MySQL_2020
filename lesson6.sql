-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

SELECT users.id AS friend, COUNT(inc.from_user_id) + COUNT(inc.to_user_id) AS mess 
  FROM users
       LEFT JOIN messages AS inc 
	      ON users.id = inc.from_user_id
	     AND inc.to_user_id = 1
       LEFT JOIN messages AS outc
	      ON users.id = outc.to_user_id
	     AND outc.from_user_id = 1 
 GROUP BY friend
 ORDER BY mess DESC
 LIMIT 1;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT SUM(likes)
  FROM (SELECT profiles.user_id, profiles.birthday, COUNT(likes.to_subject_id) AS likes
	  FROM profiles
	       JOIN likes
		 ON likes.to_subject_id = profiles.user_id
	 GROUP BY profiles.user_id, profiles.birthday
	 ORDER BY profiles.birthday DESC
	 LIMIT 10) AS countlikes;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT sex
  FROM profiles
       JOIN likes
         ON likes.from_user_id = profiles.user_id
 GROUP BY sex
 ORDER BY COUNT(from_user_id) DESC
 LIMIT 1;