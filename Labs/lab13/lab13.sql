.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet
  FROM students AS s
  WHERE color="blue" AND pet="dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song
  FROM students
  WHERE color="blue" AND pet="dog";


CREATE TABLE smallest_int_having AS
  SELECT time, smallest
  FROM students
  GROUP BY smallest HAVING COUNT(*)=1;


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color
  FROM students AS a, students AS b
  WHERE a.time < b.time AND a.pet=b.pet AND a.song=b.song;


CREATE TABLE sevens AS
  SELECT s.seven
  FROM students AS s, numbers AS n
  WHERE s.time=n.time AND n."7"="True" AND s.number=7;


CREATE TABLE average_prices AS
  SELECT category, AVG(MSRP) AS average_price
  FROM products
  GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT i.store AS store, p.name AS name, MIN(i.price) AS price
  FROM inventory AS i, products AS p
  WHERE i.item=p.name
  GROUP BY p.name;

CREATE TABLE help_shopping_list AS
  SELECT name AS name, MIN(MSRP/rating) AS best
  FROM products
  GROUP BY category;

CREATE TABLE shopping_list AS
  SELECT h.name, l.store AS store
  FROM help_shopping_list as h, lowest_prices as l
  WHERE h.name = l.name;


CREATE TABLE total_bandwidth AS
  SELECT SUM(s.Mbs)
  FROM shopping_list AS l, stores AS s
  WHERE l.store=s.store;

