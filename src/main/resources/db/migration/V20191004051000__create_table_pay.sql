CREATE TABLE pay (
        employee_id INTEGER,
        card_number INTEGER PRIMARY KEY,
        salary INTEGER,
        commission_pct INTEGER,
        CONSTRAINT FK_pay_employee
            FOREIGN KEY (employee_id)
            REFERENCES employees(employee_id)
        );


--INSERT INTO pay (employee_id, salary, commission_pct)
--SELECT employee_id, salary, commission_pct FROM employees;
