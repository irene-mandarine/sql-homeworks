ALTER TABLE locations
ADD department_amount INTEGER DEFAULT 0;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location';

CREATE OR REPLACE TRIGGER hr_migration.plus_department_amount
AFTER INSERT
ON hr_migration.departments
FOR EACH ROW
BEGIN
UPDATE hr_migration.locations
	SET locations.department_amount = (locations.department_amount + 1)
		WHERE locations.location_id = :new.location_id;
END;

CREATE OR REPLACE TRIGGER hr_migration.minus_department_amount
AFTER INSERT
ON hr_migration.departments
FOR EACH ROW
BEGIN
UPDATE hr_migration.locations
	SET locations.department_amount = (locations.department_amount + 1)
		WHERE locations.location_id = :new.location_id;
END;


