CREATE OR REPLACE TRIGGER insert_new_payment_trigger
    AFTER INSERT ON participation FOR EACH ROW
    EXECUTE FUNCTION insert_new_payment_status();