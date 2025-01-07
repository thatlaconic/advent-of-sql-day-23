# [🎄 The Case of the Missing Reindeer ID Tags 🦌](https://adventofsql.com/challenges/23)

## Description
At Santa's Workshop, each reindeer is assigned a sequential ID number for the annual Christmas Eve flight preparation. Mrs. Claus maintains a database table called 'sequence_table' where these ID tags are recorded. One snowy morning, while doing the pre-flight checks, she notices that some ID tags appear to be missing!

The ID sequence should be perfectly consecutive, as the tags were originally created in order (1,2,3...), but after a particularly chaotic practice flight through a snowstorm, some of the tags fell off.

You need to find the missing tags.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-23/blob/main/advent_of_sql_day_23.sql)

+ Find the missing tags
+ Assume the first and last tags are in the database
+ Group them in islands, a group starts as the first missing element and finishes as the last missing element. A group is a sequential number of missing values.

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**

```sql
SELECT *
FROM sequence_table ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-23/blob/main/saq.PNG)


### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-23/blob/main/advent_answer_day23.sql)

**input**
```sql

WITH RECURSIVE seq AS (
		SELECT MIN(id) AS current_id, MAX(id) as end_id
		FROM sequence_table
		UNION ALL
		SELECT current_id + 1, end_id
		FROM seq
		WHERE current_id < end_id
		),
seq2 AS (SELECT current_id, current_id - ROW_NUMBER() OVER() AS for_group
		FROM seq
		WHERE current_id NOT IN (SELECT id FROM sequence_table))
SELECT string_agg(current_id ::TEXT, ',') AS missing_numbers
FROM seq2
GROUP BY for_group
;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-23/blob/main/d23.PNG)

