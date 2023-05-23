CREATE function
    TABLEAU(
    _debut TIMESTAMP,
     _fin TIMESTAMP,
     _categorie INT)
    RETURNS TABLE
        (
            _temps timestamp,
            _numero_local int,
            _pav_id char(3),
            _commentaire varchar
        )
LANGUAGE plpgsql
AS $$
DECLARE
    _interval INTERVAL;
    _rowAmount INT;
BEGIN
    _interval := _fin - _debut;
    _rowAmount :=  (SELECT TRUNC(EXTRACT(EPOCH FROM _interval::INTERVAL)/60) / 15);
RETURN QUERY
    SELECT dates.number, loc.numero_local, loc.pav_id,
           (
           SELECT res.commentaire
           FROM reservation as res
              WHERE dates.number >= res.debut AND dates.number <= res.fin
               ) commentaire
    FROM local AS loc
        CROSS JOIN (
    SELECT * from generate_series(
            _debut,_fin,
            INTERVAL '15 minutes'
        ) AS number) AS dates
    WHERE loc.cat_id = _categorie;
END$$;

SELECT *
FROM local
         Cross join (SELECT generate_series(0, 6)) as locals
WHERE local.cat_id = 6;

SELECT * FROM TABLEAU(make_timestamp(1997,6,4,14,55,0),make_timestamp(1997,6,4,18,55,0),6);
