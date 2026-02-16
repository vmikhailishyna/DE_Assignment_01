# DE_Assignment_01
## Dataset Selection
Link on the dataset - https://www.kaggle.com/datasets/xvivancos/tweets-during-nintendo-e3-2018-conference

## Data Analysis Using Window Functions
Who made more tweets during the Nintendo E3 2018 Conference
```
WITH cte_count as (
    SELECT
    user_id,
    COUNT(*) as tweet_count,
    RANK() OVER(ORDER BY COUNT(*) DESC) as activity_rank
FROM NintendoTweets
GROUP BY user_id
HAVING user_id is not NULL
)
SELECT DISTINCT c.user_id,
       u.screen_name,
       c.tweet_count,
       c.activity_rank
FROM cte_count c
JOIN users u ON c.user_id = u.user_id
ORDER BY activity_rank ASC;
```
<img width="938" height="647" alt="image" src="https://github.com/user-attachments/assets/74e29f1d-2b9c-42f8-88bd-a533a4da1ef2" />

Most popular hashtags
```
SELECT hashtag_text,
       COUNT(*) AS count_hashtag,
       RANK() OVER(ORDER BY COUNT(*) DESC) as hashtag_rank
FROM tweet_hashtags
GROUP BY hashtag_text
LIMIT 10;
```
<img width="891" height="387" alt="image" src="https://github.com/user-attachments/assets/e0ae2806-fb91-4161-b3c8-2e5b1af21a52" />

Time of users activity

```
SELECT created_at,
       COUNT(*) AS count_of_twits,
       RANK() OVER(ORDER BY COUNT(*) DESC) as time_rank
FROM NintendoTweets
GROUP BY created_at;
```
<img width="836" height="147" alt="image" src="https://github.com/user-attachments/assets/c9a15fb7-26bf-4a8f-b76b-07a62883025a" />


Most popular hashtags per users

```
SELECT
    nt.user_id,
    th.hashtag_text,
    COUNT(*) AS count_hashtag,
    RANK() OVER(PARTITION BY nt.user_id ORDER BY COUNT(*) DESC) as user_hashtag_rank
FROM NintendoTweets nt
JOIN tweet_hashtags th ON nt.id = th.id
GROUP BY nt.user_id, th.hashtag_text;
```
<img width="1173" height="607" alt="image" src="https://github.com/user-attachments/assets/9465cb0a-99ec-4c7d-9b0b-0fb4c16c5e5f" />



## Additional Task
<img width="1348" height="692" alt="image" src="https://github.com/user-attachments/assets/751b315e-7466-4f0c-b0c9-8e133c3aa297" />


