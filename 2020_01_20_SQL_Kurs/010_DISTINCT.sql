-- DISTINCT

USE Northwind


-- wie bekomme ich eine Liste von allen L�ndern, in die wir liefern?

SELECT Country
FROM Customers
ORDER BY Country
-- bringt nix, ich bekomme alle Customers, also L�nder doppelt und dreifach

-- L�sung:
SELECT DISTINCT Country
FROM Customers
-- 21 Treffer, jedes Land kommt nur noch 1x vor


SELECT DISTINCT Country, CustomerID
FROM Customers
-- bringt nix, weil dann wieder alle Customers ausgegeben werden!


-- Liste von allen St�dten, wo wir Kunden haben?
SELECT DISTINCT City
FROM Customers
-- 69 St�dte



SELECT DISTINCT City, Country
FROM Customers
-- 69 Treffer; Country wieder mehrfach, weil es mehrere St�dte pro Land gibt

-- Liste von allen L�ndern, in denen wir Angestellte (Employees) haben
SELECT DISTINCT Country
FROM Employees
-- UK, USA


-- �berpr�fen:
SELECT *
FROM Employees
-- passt