insert Kor 
(
  kor_id, kor_nev, datum, helyszin
)

SELECT 1, 'Első forduló (1. csoport)', '2024-05-01', 'Budapest'
UNION ALL
SELECT 2, 'Első forduló (2. csoport)', '2024-05-02', 'Budapest'
UNION ALL
SELECT 3, 'Második forduló', '2024-05-07', 'Debrecen'
UNION ALL
SELECT 4, 'Harmadik forduló', '2024-05-14', 'Szeged'
UNION ALL
SELECT 5, 'Elődöntő', '2024-05-20', 'Pécs'
UNION ALL
SELECT 6, 'Döntő', '2024-05-29', 'Győr';