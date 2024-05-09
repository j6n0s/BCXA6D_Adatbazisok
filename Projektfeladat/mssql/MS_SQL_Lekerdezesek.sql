-- 1. lekérdezés --
SELECT k.kor_nev, sum(p.pont_ertek) as 'osszespont'
from Pont p JOIN Szereples sz ON p.szereples_id = sz.szereples_id
			JOIN Versenyzok v on v.versenyzo_id = sz.versenyzo_id
            JOIN Kor k on k.kor_id = sz.kor_id
where v.nev LIKE 'Megan Taylor'
GROUP by k.kor_nev
order BY sum(p.pont_ertek) desc


-- 2. lekérdezés --
SELECT 	kor_nev,
		ROUND(avg(teljes), 2)
FROM (SELECT	k.kor_nev,
		--sz.kategoria,
        sz.versenyzo_id,
        sum(p.pont_ertek) AS "teljes"
FROM Szereples sz JOIN Kor k ON k.kor_id = sz.kor_id
				  JOIN Pont p On sz.szereples_id = p.szereples_id
 GROUP BY k.kor_nev, sz.versenyzo_id  ) AS subquery
 GROUP BY kor_nev
 Order BY avg(teljes) DESC
 
 
 -- 3. lekérdezés --
 SELECT k.kor_nev, v.nem, COUNT(*)
 From Szereples sz JOIN Versenyzok v ON sz.versenyzo_id = v.versenyzo_id
 JOIN Kor k ON k.kor_id = sz.kor_id
 GROUP by k.kor_nev,k.kor_id, v.nem
 ORDER by k.kor_id
 
 
 --4. lekérdezés --
 SELECT 
 	CASE
    WHEN eletkor BETWEEN 18 and 26 THEN 'Fiatal'
    WHEN eletkor BETWEEN 26 and 50 THEN 'Középkorú'
    ELSE 'Idős'
    END as 'korcsoportok',
    COUNT(versenyzo_id)
 from Versenyzok
 GROUP by (CASE
    WHEN eletkor BETWEEN 18 and 26 THEN 'Fiatal'
    WHEN eletkor BETWEEN 26 and 50 THEN 'Középkorú'
    ELSE 'Idős'
    END)
       
       
-- 5. lekérdezés --
SELECT iif(grouping_id(zs.zsuri_nev)=1,'Összesen',cast(zs.zsuri_nev  as nvarchar(100))), 
		iif(grouping_id(k.kor_nev)=1 and grouping_id(zs.zsuri_nev)<>1,'Részösszeg',cast(k.kor_nev as nvarchar(100))),
        sum(p.pont_ertek)
From Zsuri zs JOIN Pont p ON p.zsuri_id = zs.zsuri_id
JOIN Szereples sz on sz.szereples_id = p.szereples_id
JOIN Kor k ON k.kor_id = sz.kor_id
GROUP by rollup(zs.zsuri_nev,k.kor_nev)


-- 6. lekérdezés --
Select 
	nev,pont,
    lag(nev,1,'') over(order by pont) as 'Eggyel rosszabb helyezés',
    lead(nev,1,'') over(order by pont) as 'Eggyel jobb helyezés'
From
(SELECT	distinct v.nev,
		SUM(p.pont_ertek) OVER(PARTITION By v.nev) as 'pont'
FROM Szereples sz JOIN Pont p ON sz.szereples_id = p.szereples_id
				  JOIN Versenyzok v ON sz.versenyzo_id = v.versenyzo_id
                  JOIN Kor k ON sz.kor_id = k.kor_id
WHERE k.kor_nev = 'Elodönto'
) AS subquery