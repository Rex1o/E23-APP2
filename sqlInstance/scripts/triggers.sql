-- Fonction de log
CREATE FUNCTION trigger_log_insert()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS $$
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
AS $$
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
AS $$
BEGIN
    INSERT INTO LogReservation(res_id, action, time)
    VALUES (OLD.res_id, 'delete', now());

    RETURN NEW;
END
$$;

--Fonction de vérification de la disponnibilité
CREATE FUNCTION trigger_insertion_reservation()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS $$
BEGIN
    IF (SELECT 1
        FROM reservation as res
        WHERE res.numero_local = new.numero_local
        AND res.pav_id = new.pav_id
        AND (new.debut >= res.debut AND new.debut < res.fin
        OR new.fin > res.debut AND new.fin <= res.fin)) THEN
            RAISE EXCEPTION 'Le local est déja réservé dans cette plage horaire';
        END IF;
    RETURN NEW;
END
$$;



-- Log creation de reservation
CREATE TRIGGER log_creation_insert
AFTER INSERT ON Reservation
FOR EACH ROW
EXECUTE PROCEDURE trigger_log_insert();

CREATE TRIGGER log_creation_modifie
AFTER UPDATE ON Reservation
FOR EACH ROW
EXECUTE PROCEDURE trigger_log_modifie();

CREATE TRIGGER log_creation_delete
AFTER DELETE ON Reservation
FOR EACH ROW
EXECUTE PROCEDURE trigger_log_delete();


CREATE TRIGGER verification_insertion_reservation
    BEFORE INSERT ON Reservation
    FOR EACH ROW
EXECUTE PROCEDURE trigger_insertion_reservation();