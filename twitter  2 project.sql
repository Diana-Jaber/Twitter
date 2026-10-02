 
 drop  database if exists twitter;
 create database twitter;
 use twitter;
  
-- إنشاء جدول المستخدمين وإضافة بيانات المستخدمين
 create table users(
 
user_id int auto_increment  primary key,
email varchar(50)  not null unique,
password_user  binary(64) not null,
registration_date date

);
INSERT INTO users (email, Password_user, registration_date)
VALUES
('diana@gmail.com', MD5('Diana123'), '2025-01-15'),
('sara@gmail.com', MD5('Sara456'), '2025-03-20'),
('ahmad@gmail.com', MD5('Ahmad789'), '2025-06-10'),
('lina@gmail.com', MD5('Lina321'), '2025-08-25'),
('omar@gmail.com', MD5('Omar654'), '2026-02-12');

select*from users;

  create table profiles(
 profile_id  int auto_increment primary key,
 user_id int not null unique,
 username varchar(50),
 bio text,
 foreign key(user_id) REFERENCES Users(user_id)
 
 );
 -- إنشاء جدول الملفات الشخصية وإضافة بيانات الملفات الشخصية

 INSERT INTO Profiles (user_id, username, bio) VALUES
(1, 'Diana', 'Data Science Student'),
(2, 'Ahmad', 'Computer Science Student'),
(3, 'Sara', 'AI Student'),
(4, 'Omar', 'Technology Lover'),
(5, 'Lina', 'Data Analyst');

select *from profiles;
  SELECT 
    p.username,u.email, p.bio 
FROM users u
JOIN profiles p ON u.user_id = p.user_id;
-- إنشاء جدول التغريدات وإضافة بيانات التغريدات
CREATE TABLE Tweets (
    tweet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    tweet_date datetime,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) 
);
INSERT INTO tweets (user_id, content, tweet_date)
VALUES
(1, 'Hello everyone, this is my first tweet!', '2026-10-01'),
(1, 'Learning SQL is interesting', '2026-10-02'),
(1, 'Today I learned about JOIN', '2026-10-02'),
(2, 'Welcome to my Twitter account', '2026-10-01'),
(2, 'I love programming', '2026-10-02'),
(3, 'Artificial Intelligence is the future', '2026-10-01'),
(3, 'Working on my AI project', '2026-10-02'),
(4, 'Technology makes life easier', '2026-10-01'),
(5, 'Data analysis is amazing', '2026-10-02');
--  جدول المتابعة (Follows) بين الuser_user
CREATE TABLE Follows (
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    follow_date datetime,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id),
    FOREIGN KEY (following_id) REFERENCES Users(user_id) 
);
INSERT INTO Follows (follower_id, following_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 3),
(3, 1),
(4, 2),
(5, 1);
--   جدول الإعجابات (Likes) بين ال user_tweet
CREATE TABLE Likes (
    user_id INT NOT NULL,
    tweet_id INT NOT NULL,
    like_date datetime,
    PRIMARY KEY (user_id, tweet_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ,
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id) 
);
INSERT INTO Likes (user_id, tweet_id)
VALUES
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(4, 7),
(5, 8);
-- عرض عدد التغريدات لمستخدم واحد فقط
select  profiles.username , COUNT(tweets.tweet_id) AS NumberOfTweets
FROM Profiles
 left join  tweets
ON Profiles.user_id = tweets.user_id
WHERE Profiles.username = 'Diana'
group by profiles.username;

-- إنشاء Procedure باسم createAccount لإضافة بيانات المستخدم والملف الشخصي

delimiter //
create procedure create_Account(
  in user_id int,
 in user_name varchar(50),
 in email_hash varchar(255),
 in password_hash binary(64),
 in bio text
)
begin
 declare new_user_id int; 
insert into users (email_hash,password_hash)values(email_hash,password_hash);
  set new_user_id = last_insert_id();
  insert into profiles (user_id,username,bio) values(new_user_id,user_name,bio);

end //
-- إنشاء Procedure باسم User_Follow لإضافة متابعة بين مستخدمين

delimiter //
create procedure user_follow(
 in following_name varchar(50),
 in follower_name varchar(50)
)
begin
declare follower_id int;
declare following_id int;

select user_id 
 into follower_id
from profiles   
where  username=follower_name;

select user_id 
 into following_id
from profiles   
where  username=following_name;

insert into follows (follower_id,following_id) values(follower_id,following_id);


end//
