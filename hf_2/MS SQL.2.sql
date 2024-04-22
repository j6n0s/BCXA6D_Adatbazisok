SELECT * FROM Vendeg

CREATE user felhasznalo_proba_547 without login
grant SELECT ON Vendeg to felhasznalo_proba_547
execute As user = 'felhasznalo_proba_547'
SELECT * FROM Vendeg
revert
SELECT * FROM Vendeg