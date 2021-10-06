CREATE TABLE employment_logs (
        employment_log_id INTEGER PRIMARY KEY,
        first_name VARCHAR2(20),
        last_name VARCHAR2(25) NOT NULL,
        employment_action VARCHAR(5)
            CHECK (employment_action = 'HIRED' or employment_action = 'FIRED'),
        employment_status_updtd_tmstmp DATE NOT NULL
        );

CREATE SEQUENCE seq_id
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

ALTER TABLE employment_logs
    MODIFY employment_log_id DEFAULT seq_id.nextval;

CREATE OR REPLACE TRIGGER hr_migration.update_employment_log
BEFORE INSERT OR DELETE
ON hr_migration.employees
FOR EACH ROW
BEGIN
    IF INSERTING THEN
		insert_a_log(:new.first_name, :new.last_name, 'HIRED');
	ELSE
		insert_a_log(:old.first_name, :old.last_name, 'FIRED');
	END IF;
END;

CREATE OR REPLACE PROCEDURE hr.insert_a_log(first_name VARCHAR2, last_name VARCHAR2, employment_action VARCHAR)
AS
BEGIN
    INSERT INTO hr.employment_logs (first_name, last_name, employment_action, employment_status_updtd_tmstmp)
    VALUES (first_name, last_name, employment_action, current_date);
END;


