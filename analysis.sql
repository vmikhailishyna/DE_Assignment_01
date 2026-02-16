/* Who made more tweets during the Nintendo E3 2018 Conference*/
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

/*Most popular hashtags*/

SELECT hashtag_text,
       COUNT(*) AS count_hashtag,
       RANK() OVER(ORDER BY COUNT(*) DESC) as hashtag_rank
FROM tweet_hashtags
GROUP BY hashtag_text
LIMIT 10;

/*Time of users activity*/
SELECT created_at,
       COUNT(*) AS count_of_twits,
       RANK() OVER(ORDER BY COUNT(*) DESC) as time_rank
FROM NintendoTweets
GROUP BY created_at;

/*Most popular hashtags per users*/
SELECT
    nt.user_id,
    th.hashtag_text,
    COUNT(*) AS count_hashtag,
    RANK() OVER(PARTITION BY nt.user_id ORDER BY COUNT(*) DESC) as user_hashtag_rank
FROM NintendoTweets nt
JOIN tweet_hashtags th ON nt.id = th.id
GROUP BY nt.user_id, th.hashtag_text
ORDER BY ;
