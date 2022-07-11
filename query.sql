-- ------ Query su singola tabella
-- 
-- ```
-- 1- Selezionare tutte le software house americane (3)

--SELECT * FROM software_houses WHERE country = 'United States';

-- 2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)

-- SELECT * FROM players WHERE city = 'Rogahnland';

-- 3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)

-- SELECT * FROM players WHERE name LIKE '%a';

-- 4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

-- SELECT * FROM reviews WHERE player_id = 800;

-- 5- Contare quanti tornei ci sono stati nell'anno 2015 (9)

-- SELECT COUNT(*) AS  tournaments FROM tournaments WHERE year = 2015;

-- 6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

-- SELECT * FROM awards WHERE description LIKE '%facere%';

-- 7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)

-- SELECT DISTINCT videogame_id as videogame_id FROM category_videogame WHERE category_id = 2 OR category_id = 6;

-- 8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

-- SELECT * FROM reviews WHERE rating >= 2 AND rating <= 4;

-- 9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)

-- SELECT * FROM videogames WHERE release_date > '31/12/2019' AND release_date < '01/01/2021'

-- 10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da 5 stelle, mostrandoli una sola volta (443)

-- SELECT DISTINCT reviews.videogame_id as videogame_id FROM reviews WHERE reviews.rating >= 5;
-- *********** BONUS ***********
-- 
-- 11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)

-- SELECT COUNT(videogame_id) AS review_number,AVG(rating) AS avg_rating FROM reviews WHERE videogame_id = 412; 

-- 12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)

-- SELECT COUNT(software_house_id) FROM videogames WHERE software_house_id = 1 AND release_date > '31/12/2017' AND release_date < '01/01/2019';



-- ```
-- 



-- ------ Query con group by
-- 
-- ```
-- 1- Contare quante software house ci sono per ogni paese (3)

-- SELECT COUNT(name) FROM software_houses GROUP BY country;

-- 2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)

-- SELECT COUNT(reviews.id) as n_reviews FROM reviews GROUP BY videogame_id;

-- 3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)

-- SELECT COUNT(videogame_id) FROM pegi_label_videogame GROUP BY pegi_label_id;

-- 4- Mostrare il numero di videogiochi rilasciati ogni anno (11)

-- SELECT COUNT(id) FROM videogames GROUP BY YEAR(release_date) ;

-- 5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)

-- SELECT COUNT(videogame_id) AS n_videogiochi FROM device_videogame GROUP BY device_id;

-- 6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)

-- SELECT AVG(rating) as media_gioco FROM reviews GROUP BY videogame_id ORDER BY media_gioco; 


-- ```
-- 
-- ------ Query con join
-- 
-- ```
-- 1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)

-- SELECT players.nickname FROM players INNER JOIN reviews ON reviews.player_id = players.id GROUP BY players.nickname;

-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)

-- SELECT DISTINCT videogames.name FROM videogames LEFT JOIN tournament_videogame ON tournament_videogame.videogame_id = videogames.id LEFT JOIN  tournaments ON tournaments.id = tournament_videogame.tournament_id WHERE tournaments.year >'2015' AND tournaments.year < '2017';

-- 3- Mostrare le categorie di ogni videogioco
-- SELECT v.id AS videogame_id, v.name AS videogame_name, v.release_date, c.id AS category_id, c.name AS category_name (1718)

-- SELECT videogames.id AS videogame_id, videogames.name AS videogame_name, videogames.release_date, categories.id AS category_id, categories.name AS category_name FROM videogames LEFT JOIN category_videogame ON category_videogame.videogame_id = videogames.id LEFT JOIN categories ON categories.id = category_videogame.category_id

-- 
-- 4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)

-- SELECT DISTINCT software_houses.name as softwareHouse_name FROM software_houses LEFT JOIN videogames ON videogames.software_house_id = software_houses.id WHERE videogames.release_date > '31/12/2020';

-- 5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)

-- SELECT software_houses.name AS sh_name, awards.name AS rewards_name FROM software_houses INNER JOIN videogames ON videogames.software_house_id = software_houses.id INNER JOIN award_videogame ON award_videogame.videogame_id = videogames.id INNER JOIN awards ON awards.id = award_videogame.award_id ; 

-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)

-- SELECT DISTINCT categories.name AS cat_name , pegi_labels.name AS pegi_name, videogames.name FROM videogames LEFT JOIN category_videogame ON category_videogame.videogame_id = videogames.id LEFT JOIN categories ON categories.id = category_videogame.category_id LEFT JOIN pegi_label_videogame ON pegi_label_videogame.videogame_id = category_videogame.videogame_id LEFT JOIN pegi_labels ON pegi_labels.id = pegi_label_videogame.pegi_label_id LEFT JOIN reviews ON reviews.videogame_id = videogames.id WHERE reviews.rating = 4 OR  reviews.rating = 5

-- 7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)

-- SELECT DISTINCT v.id AS videogame_id, v.name AS videogame_name, v.release_date FROM videogames v INNER JOIN tournament_videogame tv ON v.id = tv.videogame_id INNER JOIN tournaments t ON tv.tournament_id = t.id INNER JOIN player_tournament pt ON t.id = pt.tournament_id INNER JOIN players p ON pt.player_id = p.id WHERE p.name LIKE 'S%'

-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)

-- SELECT t.city FROM tournaments t INNER JOIN tournament_videogame tv ON t.id = tv.tournament_id INNER JOIN videogames v ON tv.videogame_id = v.id INNER JOIN award_videogame av ON v.id = av.videogame_id INNER JOIN awards a ON av.award_id = a.id WHERE a.name = 'Gioco dell''anno' AND av.year = 2018

-- 9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)

-- SELECT p.id AS player_id, p.name AS player_name, p.lastname AS player_lastname, p.nickname AS player_nickname, p.city AS player_city FROM players p INNER JOIN player_tournament pt ON p.id = pt.player_id INNER JOIN tournaments t ON pt.tournament_id = t.id INNER JOIN tournament_videogame tv ON t.id = tv.tournament_id INNER JOIN videogames v ON tv.videogame_id = v.id INNER JOIN award_videogame av ON v.id = av.videogame_id INNER JOIN awards a ON av.award_id = a.id WHERE a.name = 'Gioco più atteso' AND av.year = 2018 AND t.year = 2019
-- *********** BONUS ***********
-- 
-- 10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)

-- SELECT TOP 1 sh.id AS software_house_id, sh.name AS software_house_name, sh.tax_id, sh.city, sh.country, V.id AS videogame_id, V.name AS videogame_name, V.overview, V.release_date FROM software_houses sh INNER JOIN videogames v ON sh.id = v.software_house_id ORDER BY v.release_date 

-- 11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)

-- SELECT TOP 1 v.id AS videogame_id, v.name, v.release_date, COUNT(*) AS total_reviews FROM videogames v INNER JOIN reviews r ON v.id = r.videogame_id GROUP BY v.id, v.name, v.release_date ORDER BY total_reviews DESC

-- 12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)

-- SELECT TOP 1 sh.id AS software_house_id, sh.name AS software_house_name, sh.tax_id, sh.city, sh.country, COUNT(*) AS total_awards FROM software_houses sh INNER JOIN videogames v ON sh.id = v.software_house_id INNER JOIN award_videogame av ON v.id = av.videogame_id WHERE av.year = 2015 OR av.year = 2016 GROUP BY sh.id, software_house_id, sh.name, sh.tax_id, sh.city, sh.country ORDER BY total_awards DESC 

-- 13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)

-- SELECT DISTINCT c.id AS category_id, c.name AS category_name FROM videogames v INNER JOIN reviews r ON v.id = r.videogame_id INNER JOIN category_videogame cv ON v.id = cv.videogame_id INNER JOIN categories c ON cv.category_id = c.id GROUP BY v.id, c.id, c.name HAVING AVG(r.rating) < 1.5
-- ```