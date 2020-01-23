-- Wildcards nur beim LIKE

-- % steht f�r beliebig viele unbekannte Zeichen (0 - ?)

-- suche Kunde, wo in der ID 'ALF' vorkommt

USE Northwind

SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE 'ALF%'

-- m�gliche Treffer sind:
-- ALF
-- ALFXXXXXXXXX
-- ALFINE
-- ALFKI (tats�chlich in DB)

-- alle Kunden, die mit MI aufh�ren
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '%MI'


-- alle Kunden, die KI im Namen haben
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%KI%'

-- m�gliche Treffer:
-- Kiste...
-- Alfreds FutterKIste (gibts in NW DB)
-- WolsKI  Zajazd (gibts auch in NW DB)
-- xxxxx yyyyy zzzzKI



-- alle, wo Firmenname mit D beginnt?
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE 'D%'

-- wo im Firmennamen D vorkommt?
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%D%'


-- 7) Gib alle Produkte aus, deren Name mit Coffee endet.
SELECT	  ProductID
		, ProductName
	--  , ...
FROM Products
WHERE ProductName LIKE '%coffee'
-- 1


-- 8) Gib alle Produkte aus, deren Name mit 'L' beginnt.

SELECT	  ProductID
		, ProductName
	--  , ...
FROM Products
WHERE ProductName LIKE 'L%'
-- 5


-- 9) Gib alle Produkte aus, die 'ost' im Namen haben.

SELECT	  ProductID
		, ProductName
	--  , ...
FROM Products
WHERE ProductName LIKE '%ost%'
-- 7


--10) Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 St�ck vorr�tig sind und deren St�ckpreis unter 100 liegt. Ordne das Ergebnis absteigend vom h�chsten zum niedrigsten St�ckpreis.

SELECT	  ProductID
		, ProductName
		, SupplierID
		, UnitsInStock
		, UnitPrice
	--  , ...
FROM Products
WHERE SupplierID IN(5, 10, 15)
	AND UnitsInStock > 10
	AND UnitPrice < 100
ORDER BY UnitPrice DESC


-- alle Kontaktpersonen, die ein d im Namen haben und mit e enden
SELECT	  CustomerID
		, CompanyName
		, ContactName
	--  , ...
FROM Customers
WHERE ContactName LIKE '%d%e'


-- alle, die mit a beginnen, irgendwo ein f haben und in Deutschland sind
SELECT	  CustomerID
		, CompanyName
		, Country
	--  , ...
FROM Customers
WHERE CompanyName LIKE 'a%f%' AND Country = 'Germany'

-- m�gliche Treffer
-- AF
-- AxxxxxxxxxxxFxxxxxx xxxxxxxx
-- Axxxxxxxxx xxxxxxF
-- ALFKI
-- Alfreds Futterkiste


-- Bestellungen: alle von Angestellten 1, 3, 5, von Kunden, die mit r beginnen und deren Frachtkosten gr��er als 100 sind
SELECT	  OrderID
		, EmployeeID
		, CustomerID
		, Freight
	--  , ...
FROM Orders
WHERE EmployeeID IN(1, 3, 5) 
	AND CustomerId LIKE 'r%'
	AND Freight > 100

-- 6



--**************************************************************
-- Eckige Klammern

SELECT 'Leonard Hlavin' AS [vollst�ndiger Name]

SELECT *
FROM [Order Details]


-- eckige Klammern im LIKE
-- [] steht f�r einen Wertebereich


-- CustomerID beginnt mit a, b oder c
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[a-c]%'
-- 16

-- oder:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[abc]%'
--16


-- nur die, die mit A oder C beginnen
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[ac]%'


-- Prozentzeichen im Namen
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '%[%]%'
-- 0 (gibt keine Kunden mit % im Namen)

-- was w�re, wenn wir das so schreiben w�rden?
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '%%%'
-- bringt nix: alle Kunden (91)


-- Suche Hochkomma im Namen
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%''%' -- ACHTUNG: NICHT '%'%', NICHT '%[']%'
-- 6

-- alle, die mit a-c (a, b oder c) oder e-g (e, f oder g) enden
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'
-- 22

-- oder:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%[abcefg]'
-- 22

-- oder:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]'
-- 22

-- nein: 
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%[a,b,c,e,f,g]' -- dann w�rden wir auch nach denen suchen, die mit Komma aufh�ren!


-- ************************************ ESCAPE CHARACTER ****************

SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!' -- sucht nach dem Zeichen nach dem Escape-Character



SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '''' -- das w�rde nur nach einem Hochkomma suchen (kein Ergebnis in NW)



-- alle CompanyNames, die mit a oder c beginnen und mit einem m oder e enden
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '[ac]%[me]'
-- 2

-- Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.
SELECT	  ProductID
		, ProductName
	--  , ...
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'
-- 8

-- unsere CustomerID besteht aus 5 Buchstaben (ALFKI)
-- CMXY5 ... wie k�nnte ich die falschen Eintr�ge finden? (die, wo die CustomerID nicht aus 5 Buchstaben besteht)


-- die, die aus 5 Buchstaben bestehen:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[a-z][a-z][a-z][a-z][a-z]'


SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE REPLICATE('[a-z]', 5)
-- 91


-- die, wo Fehler drin ist (die, wo die CustomerID nicht aus 5 Buchstaben besteht)
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID NOT LIKE REPLICATE('[a-z]', 5)
-- 0 Treffer (keine falschen IDs in dieser Tabelle)


--SELECT *
--FROM Tabelle
--WHERE Pin NOT LIKE REPLICATE('[0-9]', 5)

SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[^a-c]%' -- alle, die NICHT mit a, b oder c beginnen
-- 75

-- oder:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID NOT LIKE '[a-c]%'
-- 75

-- oder:
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CustomerID LIKE '[d-z]%'
-- 75

-- Wildcards
-- * im SELECT (nicht sch�n!!) steht f�r alle Spalten aus der gew�hlten Tabelle
-- % steht f�r beliebig viele unbekannte Zeichen (0 - ?)
-- [] steht f�r genau 1 Zeichen aus einem bestimmten Wertebereich (z.B. a-c)
-- _ (Unterstrich) steht f�r genau 1 unbekanntes Zeichen

-- zweites Zeichen unbekannt

SELECT *
FROM Customers
WHERE CustomerID LIKE 'A_FKI'
-- ALFKI


-- alle Kunden (CompanyName), die mit d-f beginnen, der letzte Buchstabe ist ein l und der drittletzte ein d
SELECT	  CustomerID
		, CompanyName
	--  , ...
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

-- m�gliche Treffer
-- edel
-- fdel
-- ddal
-- dxxxxxxxxxxxxxdxl
-- Ernst HanDeL (in NW DB 1 Treffer)


/*

	Wildcards Microsoft-Dokumentation:

	https://docs.microsoft.com/en-us/sql/t-sql/language-elements/like-transact-sql?view=sql-server-ver15#using-wildcard-characters-as-literals


	w3schools- �bersicht:
	
	https://www.w3schools.com/sql/sql_wildcards.asp

*/