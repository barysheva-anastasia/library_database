--- увеличение допустимого времени хранения книги из-за карантина
UPDATE DEAL
SET DEAL.lending_date = '1-7-2020'
WHERE (DEAL.day_x_date > '17-03-2020' AND DEAL.lending_date < '01-07-2020')
