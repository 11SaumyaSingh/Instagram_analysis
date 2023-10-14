SELECT * FROM ig_clone.users;
-- 1. ques - 1. find the 5 oldest users of the Instagram from the database 

-- In user table the id is the primary key
describe users;
select username, created_at  
from users 
order by created_at limit 5;


-- 2 ques Find the users who have never posted a single photo on Instagram 
select * from photos, users;

select * from users u left join photos p on p.user_id = u.id
where p.image_url is null 
order by u.username;

-- 3. ques Identify the winner of the contest and provide their details to the team 
select * from likes,photos,users;

select likes.photo_id, users.username, count(likes.user_id) as no_of_likes
from likes inner join photos on likes.photo_id = photos.id 
inner join users on photos.user_id = users.id group by 
likes.photo_id, users.username order by  no_of_likes desc;


-- 4 Identify and suggest the top 5 most commonly used hashtags on thr platform

select t.tag_name, count(p.photo_id) as ht 
from photo_tags p inner join tags t on t.id=p.tag_id 
group by t.tag_name order by ht desc;


-- 5 what day of thr week do most user register on? please provide the time when to post the ad campaign ?

-- 6 Provide how many times average user posts on Instagram. Also provide the total no of photos on instagram/ total no of users. 
select * from photos, users;
with base as(
select u.id as userid, count(p.id) as photoid 
from users u left join photos p on p.user_id = u.id 
group by u.id)
select sum(photoid) as totalphotos, count(userid) as total_users, 
sum(photoid)/count(userid) as photoperuser 
from base;


-- 7 Provide data on users  who have liked every single photo on the site (since any normal 
-- user would not be able to do this)
 select * from users, likes;
 with base as(
 select u.username, count(l.photo_id) as likess from likes l 
 inner join  users u on u.id = l.user_id 
 group by u.username) 
 select username, likess from base where likess = (select count(*) from photos ) order by username;


