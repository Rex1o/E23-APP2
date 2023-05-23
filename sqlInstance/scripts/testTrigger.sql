INSERT INTO reservation(debut, fin, commentaire, cip, numero_local, pav_id)
VALUES (now(), now(), 'lol', 'eigy7463', 3, 'A9');

UPDATE reservation SET commentaire = 'fini' WHERE commentaire = 'lol';

DELETE FROM reservation WHERE commentaire = 'fini';