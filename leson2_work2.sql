# в консоли в папке  C:\Program Files\MySQL Server 8.0\bin
mysqldump -u root -p examlpe > C:\1\examlpes.sql # создаем дамп
# ввод пароля

# база данных sample должна быть преворительно создана

mysqldump -u root -p sample < C:\1\examlpes.sql #разворачиваем в sample
