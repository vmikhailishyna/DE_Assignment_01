CREATE TABLE raw_NintendoTweets AS
SELECT * FROM read_json_auto('NintendoTweets.json', union_by_name=true);

SELECT * FROM raw_NintendoTweets;

CREATE OR REPLACE TABLE NintendoTweets AS
       SELECT created_at,
              id,
              user.id as user_id,
              text,
              in_reply_to_status_id,
              in_reply_to_user_id,
              is_quote_status,
              quote_count,
              reply_count,
              retweet_count,
              favorite_count,
              lang
       FROM raw_NintendoTweets;

DESCRIBE NintendoTweets;

CREATE OR REPLACE TABLE users AS
    SELECT DISTINCT user.id as user_id,
           user.name as name,
           user.screen_name as screen_name,
           user.location as location,
           user.verified as verified,
           user.followers_count as followers_count,
           user.friends_count as friends_count,
           user.listed_count as listed_count,
           user.favorites_count as favorites_count,
           user.created_at as created_at,
           user.statuses_count as total_tweets
    FROM raw_NintendoTweets;

CREATE OR REPLACE TABLE tweet_hashtags AS
       SELECT
           id,
           unnest(entities.hashtags).text as hashtag_text
       FROM raw_NintendoTweets;
