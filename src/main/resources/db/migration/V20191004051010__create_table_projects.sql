CREATE TABLE projects (
        project_id INTEGER PRIMARY KEY,
        project_description VARCHAR (255)
            CHECK (LENGTH(project_description)>10),
        project_investments INTEGER
            CHECK (project_investments>0),
        project_revenue NUMERIC(10, -3),
            CHECK (project_revenue>0),
        employee_id INTEGER
        );

CREATE TABLE hours (
        employee_id INTEGER,
        project_id INTEGER,
        hours_worked INTEGER,
        CONSTRAINT junction_pk PRIMARY KEY (employee_id, project_id),
                CONSTRAINT FK_employee_id
                    FOREIGN KEY (employee_id)
                    REFERENCES employees (employee_id),
                CONSTRAINT FK_project_id
                    FOREIGN KEY (project_id)
                    REFERENCES projects (project_id)
        );


