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