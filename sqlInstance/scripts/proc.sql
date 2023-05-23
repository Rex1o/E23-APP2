CREATE FUNCTION
    TABLEAU(
    _debut TIMESTAMP,
     _fin TIMESTAMP,
     _categorie INT)
    RETURNS TABLE(
        numero_local INT,
        pav_id CHAR(3),
        res_id INT
    )
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Value: %', ;
    hello := div(_fin - _debut)
--     SELECT *
--     FROM Reservation as res
--     INNER JOIN local AS loc
--     ON res.numero_local = loc.numero_local
--     AND res.pav_id = loc.pav_id
--     WHERE loc.cat_id = _categorie
--     AND (
--         (res.debut >= _debut AND res.debut <= _fin)
--     OR
--         (res.fin >= _debut AND res.fin <= _fin));



END$$;

SELECT make_timestamp(1997,6,4,14,55,0);

SELECT * FROM TABLEAU(make_timestamp(1997,6,4,14,55,0),make_timestamp(1997,6,4,18,55,0),3);