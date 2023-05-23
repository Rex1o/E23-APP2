CREATE OR REPLACE function
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
    SELECT dates.number, loc.numero_local, loc.pav_id, res.commentaire
    FROM local AS loc
        CROSS JOIN (
    SELECT * from generate_series(
            _debut,_fin,
            INTERVAL '15 minutes'
        ) AS number) AS dates
    FULL OUTER JOIN reservation res on res.pav_id = loc.pav_id
                            and loc.numero_local = res.numero_local
                            and dates.number >= res.debut
                            and dates.number <= res.fin
    WHERE loc.cat_id = _categorie
    ORDER BY  dates.number, res.numero_local;
END$$;

SELECT * FROM TABLEAU(make_timestamp(2023, 5, 23, 8, 30, 0),make_timestamp(2023, 5, 23, 14, 30, 0),7);
