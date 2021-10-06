INSERT INTO regions VALUES
        ( 1
        , 'Europe'
        );

INSERT INTO countries VALUES
        ( 'IT'
        , 'Italy'
        , 1
        );

INSERT INTO locations VALUES
        ( 1000
        , '1297 Via Cola di Rie'
        , '00989'
        , 'Roma'
        , NULL
        , 'IT'
        );

INSERT INTO departments VALUES
        ( 250
        , 'Retail Sales'
        , NULL
        , 1000
        );

INSERT INTO jobs VALUES
        ( 'PU_MAN'
        , 'Purchasing Manager'
        , 8000
        , 15000
        );

INSERT INTO employees VALUES
        ( 102
        , 'Lex'
        , 'De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , TO_DATE('13-01-2001', 'dd-MM-yyyy')
        , 'PU_MAN'
        , 13000
        , NULL
        , NULL
        , 250
        );

INSERT INTO job_history VALUES
        ( 102
        , TO_DATE('13-01-2001', 'dd-MM-yyyy')
        , TO_DATE('15-02-2021', 'dd-MM-yyyy')
        , 'PU_MAN'
        , 250
        );