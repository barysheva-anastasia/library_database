--- ������� ���� ���������, ������� ����� ��������� ����� �� ������ ���� ��� �����
DELETE READER FROM READER 
	INNER JOIN DEAL ON READER.reader_id = DEAL.deal_id
WHERE ((SELECT TOP(1) DATEDIFF(year, DEAL.lending_date, GETDATE()) ORDER BY DATEDIFF(year, DEAL.lending_date, GETDATE())) > 1)
