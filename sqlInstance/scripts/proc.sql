CREATE OR REPLACE function
    TABLEAU(
    _debut TIMESTAMP,
    _fin TIMESTAMP,
    _categorie INT)
    RETURNS TABLE
            (
                _temps        timestamp,
                _numero_local int,
                _pav_id       char(3),
                _commentaire  varchar
            )
    LANGUAGE plpgsql
AS
$$
DECLARE
    _interval  INTERVAL;
    _rowAmount INT;
BEGIN
    _interval := _fin - _debut;
    _rowAmount := (SELECT TRUNC(EXTRACT(EPOCH FROM _interval::INTERVAL) / 60) / 15);
    RETURN QUERY
        SELECT dates.number,
               loc.numero_local,
               loc.pav_id,
               CASE
                   WHEN res.commentaire is null THEN
                       (
                           --Verification Local parent
                           SELECT parent.commentaire
                           FROM reservation as parent
                                    INNER JOIN
                                (SELECT local.id_local_parent, local.id_pav_parent
                                 FROM local
                                 WHERE local.pav_id = loc.pav_id
                                   AND local.numero_local = loc.numero_local) as local_voulue
                                ON parent.numero_local = local_voulue.id_local_parent
                                    AND parent.pav_id = local_voulue.id_pav_parent
                                    and dates.number >= parent.debut
                                    and dates.number <= parent.fin
                           UNION ALL
                           SELECT 'enfant réservé'
                           FROM reservation as enfants
                                    INNER JOIN
                                (SELECT local.numero_local, local.pav_id
                                 FROM local
                                 WHERE local.id_pav_parent = loc.pav_id
                                   AND local.id_local_parent = loc.numero_local) as local_voulue
                                ON enfants.numero_local = local_voulue.numero_local
                                    AND enfants.pav_id = local_voulue.pav_id
                                    AND dates.number >= enfants.debut
                                    AND dates.number <= enfants.fin
                                LIMIT 1
                           )
                   ELSE res.commentaire
                   END as commentaire
        FROM local AS loc
                 CROSS JOIN (SELECT *
                             from generate_series(
                                          _debut, _fin,
                                          INTERVAL '15 minutes'
                                      ) AS number) AS dates
                 FULL OUTER JOIN reservation res
                                 on res.pav_id = loc.pav_id
                                     and loc.numero_local = res.numero_local
                                     and dates.number >= res.debut
                                     and dates.number <= res.fin
        WHERE loc.cat_id = _categorie
        ORDER BY dates.number, res.numero_local;
END
$$;

SELECT *
FROM TABLEAU(make_timestamp(2023, 5, 23, 8, 30, 0), make_timestamp(2023, 5, 23, 14, 30, 0), 1);
