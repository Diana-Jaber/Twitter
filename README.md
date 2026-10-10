# Twitter Project

## Description

This is a simple database project about Twitter, made with MySQL.
I created it to practice SQL, tables, relationships, and stored procedures.

## Database Tables

### users
- user_id
- email
- password_user (stored as an MD5 hash)
- registration_date (date and time)

### profiles
- profile_id
- user_id (foreign key from users)
- username
- bio

### Tweets
- tweet_id
- user_id (foreign key from users)
- content
- tweet_date

### Follows
- follower_id (foreign key from users)
- following_id (foreign key from users)
- follow_date

### Likes
- user_id (foreign key from users)
- tweet_id (foreign key from Tweets)
- like_date

## Database Relationships

- **users & profiles (1:1):** Each user has one profile.
- **users & Tweets (1:N):** A user can write many tweets.
- **users & users (N:M):** Connected using the `Follows` table.
- **users & Tweets (N:M):** Connected using the `Likes` table.

## Database Diagram

<img width="537" height="357" alt="twitter diagram" src="https://github.com/user-attachments/assets/579612f2-0fe9-45ab-a600-5fcd2dd9628e" />
## Stored Procedures

- `create_account`: adds a new user and creates a profile for them.
- `user_follow`: adds a follow between two users using their usernames.

Examples:
sql
call create_account('noor@gmail.com', md5('Noor111'), 'Noor', 'Math Student');
call user_follow('Lina', 'Omar'); -- Omar follows Lina

## What I Did in This Project

- Created the database and the tables.
- Inserted sample data for users, profiles, Tweets, Follows, and Likes.
- Stored passwords as MD5 hashes (not plain text).
- Used JOIN to show usernames with emails.
- Counted the number of tweets for one user.
- Created the `create_account` stored procedure.
- Created the `user_follow` stored procedure.
- Added comments to explain the SQL commands.

## How to Run

1. Open MySQL Workbench.
2. Open the SQL file (`twitter project.sql`).
3. Click the lightning icon to run it.
4. Check the results in the output panel.

## Technologies





- SQL
- MySQL Workbench
