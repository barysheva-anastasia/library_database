--- самый активный читатель
SELECT TOP(1) WITH TIES
READER.last_name, READER.first_name, COUNT(*) AS number_of_books
FROM READER JOIN DEAL ON READER.reader_id = DEAL.reader_id
WHERE DEAL.day_x_date >= DEAL.returning_date
GROUP BY READER.last_name, READER.first_name
ORDER BY number_of_books DESC