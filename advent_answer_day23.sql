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