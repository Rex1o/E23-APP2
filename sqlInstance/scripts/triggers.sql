-- Fonction de log
CREATE FUNCTION trigger_log_insert()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    INSERT INTO LogReservation(res_id, action, time)
    VALUES (NEW.res_id, 'Creation', now());

    RETURN NEW;
END
$$;

-- Fonction de log
CREATE FUNCTION trigger_log_modifie()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    INSERT INTO LogReservation(res_id, action, time)
    VALUES (NEW.res_id, 'Modifie', now());

    RETURN NEW;
END
$$;

-- Fonction de log
CREATE FUNCTION trigger_log_delete()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    INSERT INTO LogReservation(res_id, action, time)
    VALUES (OLD.res_id, 'delete', now());

    RETURN NEW;
END
$$;

--Fonction de vérification de la disponnibilité
CREATE OR REPLACE FUNCTION trigger_insertion_reservation()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    --Verifier si le local actuelle a deja une reservation
    IF (SELECT 1
        FROM reservation as res
        WHERE res.numero_local = new.numero_local
          AND res.pav_id = new.pav_id
          AND (new.debut >= res.debut AND new.debut < res.fin
            OR new.fin > res.debut AND new.fin <= res.fin)) THEN
        RAISE EXCEPTION 'Le local est déja réservé dans cette plage horaire';
    END IF;

    --Verifier si le local parent est deja reserver
    IF (SELECT 1
        FROM reservation as res
                 INNER JOIN
             (SELECT local.id_local_parent, local.id_pav_parent
              FROM local
              WHERE local.pav_id = new.pav_id
                AND local.numero_local = new.numero_local) as local_voulue
             ON res.numero_local = local_voulue.id_local_parent
                 AND res.pav_id = local_voulue.id_pav_parent
                 AND (new.debut >= res.debut AND new.debut < res.fin
                     OR new.fin > res.debut AND new.fin <= res.fin))
    THEN
        RAISE EXCEPTION 'Le local parent est déja réservé dans cette plage horaire';
    END IF;
    --Verifier si un local enfant est déja réservé

    IF (SELECT 1
        FROM reservation as res
                 INNER JOIN
             (SELECT local.numero_local, local.pav_id
              FROM local
              WHERE local.id_pav_parent = new.pav_id
                AND local.id_local_parent = new.numero_local) as local_voulue
             ON res.numero_local = local_voulue.numero_local
                 AND res.pav_id = local_voulue.pav_id
                 AND (new.debut >= res.debut AND new.debut < res.fin
                     OR new.fin > res.debut AND new.fin <= res.fin))
    THEN
        RAISE EXCEPTION 'Un local enfant est déja réservé dans cette plage horaire';
    END IF;
    RETURN NEW;
END
$$;



-- Log creation de reservation
CREATE TRIGGER log_creation_insert
    AFTER INSERT
    ON Reservation
    FOR EACH ROW
EXECUTE PROCEDURE trigger_log_insert();

CREATE TRIGGER log_creation_modifie
    AFTER UPDATE
    ON Reservation
    FOR EACH ROW
EXECUTE PROCEDURE trigger_log_modifie();

CREATE TRIGGER log_creation_delete
    AFTER DELETE
    ON Reservation
    FOR EACH ROW
EXECUTE PROCEDURE trigger_log_delete();


CREATE TRIGGER verification_insertion_reservation
    BEFORE INSERT
    ON Reservation
    FOR EACH ROW
EXECUTE PROCEDURE trigger_insertion_reservation();