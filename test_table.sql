CREATE DATABASE test
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE SEQUENCE IF NOT EXISTS public.employees_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.employees
(
    id integer NOT NULL DEFAULT nextval('employees_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    "position" text COLLATE pg_catalog."default" NOT NULL,
    office text COLLATE pg_catalog."default" NOT NULL,
    age integer NOT NULL,
    start_date timestamp with time zone,
    salary integer NOT NULL
);

ALTER SEQUENCE public.employees_id_seq
    OWNED BY public.employees.id;

ALTER SEQUENCE public.employees_id_seq
    OWNER TO postgres;


 -- Добавление комментария к таблице на Русском
COMMENT ON TABLE employees IS 'Основная таблица фактов. Содержит информацию о всех сотрудниках организации.';

COMMENT ON COLUMN employees.name IS        'Имя и фамилия сотрудника, указаны через пробел';
COMMENT ON COLUMN employees.position IS    'Должность сотрудника в компании';
COMMENT ON COLUMN employees.office IS      'В поле указывается называние города. Название города определяет местонахождении офиса. В каком городе находится офис, там и работает сотрудник. ';
COMMENT ON COLUMN employees.age IS         'Возраст сотрудника в компании. Всегда > 0. ';
COMMENT ON COLUMN employees.start_date IS  'Дата когда сотрудник начал работу в компании';
COMMENT ON COLUMN employees.salary IS      'Зарплата сотрудника за год. Всегда > 0. Указывается как число заработанных денег за год.';


 -- Добавление комментария к таблице English
COMMENT ON TABLE employees IS 'The main table of facts. It contains information about all employees of the organization.';

COMMENT ON COLUMN employees.name IS        'The employee first and last name are separated by a space';
COMMENT ON COLUMN employees.position IS    'Employee position in the company';
COMMENT ON COLUMN employees.office IS      'The name of the city is indicated in the field. The name of the city determines the location of the office. In which city the office is located, the employee works there. ';
COMMENT ON COLUMN employees.age IS         'The age of the employee in the company. Always > 0. ';
COMMENT ON COLUMN employees.start_date IS  'The date when the employee started working for the company';
COMMENT ON COLUMN employees.salary IS      'The employee salary for the year. Always > 0. It is indicated as the number of money earned per year.';


INSERT INTO public.employees (name, position, office, age, start_date, salary)
VALUES 
	( 'Arsendo Aristos', 'Chief Accountant', 'London', 32, '2009-10-09', 1200000 ),
	( 'Airi Satou', 'Accountant', 'Tokyo', 33, '2008-11-28', 162700 ),
	( 'Angelica Ramos', 'Chief Executive Officer (CEO)', 'London', 47, '2009-10-09', 1200000 ),
	( 'Ashton Cox', 'Junior Technical Author', 'San Francisco', 66, '2009-01-12', 86000 ),
	( 'Bradley Greer', 'Software Engineer', 'London', 41, '2012-10-13', 132000 ),
	( 'Brenden Wagner', 'Software Engineer', 'San Francisco', 28, '2011-06-07', 206850 ),
	( 'Brielle Williamson', 'Integration Specialist', 'New York', 61, '2012-12-02', 372000 ),
	( 'Bruno Nash', 'Software Engineer', 'London', 38, '2011-05-03', 163500 ),
	( 'Caesar Vance', 'Pre-Sales Support', 'New York', 21, '2011-12-12', 106450 ),
	( 'Cara Stevens', 'Sales Assistant', 'New York', 46, '2011-12-06', 145600 ),
	( 'Cedric Kelly', 'Senior JavaScript Developer', 'Edinburgh', 22, '2012-03-29', 433060 ),
	( 'Charde Marshall', 'Regional Director', 'San Francisco', 36, '2008-10-16', 470600 ),
	( 'Colleen Hurst', 'JavaScript Developer', 'San Francisco', 39, '2009-09-15', 205500 ),
	( 'Dai Rios', 'Personnel Lead', 'Edinburgh', 35, '2012-09-26', 217500 ),
	( 'Donna Snider', 'Customer Support', 'New York', 27, '2011-01-25', 112000 ),
	( 'Doris Wilder', 'Sales Assistant', 'Sydney', 23, '2010-09-20', 85600 ),
	( 'Finn Camacho', 'Support Engineer', 'San Francisco', 47, '2009-07-07', 87500 ),
	( 'Fiona Green', 'Chief Operating Officer (COO)', 'San Francisco', 48, '2010-03-11', 850000 ),
	( 'Garrett Winters', 'Accountant', 'Tokyo', 63, '2011-07-25', 170750 ),
	( 'Gavin Cortez', 'Team Leader', 'San Francisco', 22, '2008-10-26', 235500 ),
	( 'Gavin Joyce', 'Developer', 'Edinburgh', 42, '2010-12-22', 92575 ),
	( 'Gloria Little', 'Systems Administrator', 'New York', 59, '2009-04-10', 237500 ),
	( 'Haley Kennedy', 'Senior Marketing Designer', 'London', 43, '2012-12-18', 313500 ),
	( 'Hermione Butler', 'Regional Director', 'London', 47, '2011-03-21', 356250 ),
	( 'Herrod Chandler', 'Sales Assistant', 'San Francisco', 59, '2012-08-06', 137500 ),
	( 'Hope Fuentes', 'Secretary', 'San Francisco', 41, '2010-02-12', 109850 ),
	( 'Howard Hatfield', 'Office Manager', 'San Francisco', 51, '2008-12-16', 164500 ),
	( 'Jackson Bradshaw', 'Director', 'New York', 65, '2008-09-26', 645750 ),
	( 'Jena Gaines', 'Office Manager', 'London', '30', '2008-12-19', 90560 ),
	( 'Jenette Caldwell', 'Development Lead', 'New York', 31, '2011-09-03', 345000 ),
	( 'Jennifer Acosta', 'Junior JavaScript Developer', 'Edinburgh', 43, '2013-02-01', 75650 ),
	( 'Jennifer Chang', 'Regional Director', 'Singapore', 28, '2010-11-14', 357650 ),
	( 'Jonas Alexander', 'Developer', 'San Francisco', 31, '2010-07-14', 86500 ),
	( 'Lael Greer', 'Systems Administrator', 'London', 21, '2009-02-27', 103500 ),
	( 'Martena Mccray', 'Post-Sales support', 'Edinburgh', 46, '2011-03-09', 324050 ),
	( 'Michael Bruce', 'JavaScript Developer', 'Singapore', 27, '2011-06-27', 183000 ),
	( 'Michael Silva', 'Marketing Designer', 'London', 66, '2012-11-27', 198500 ),
	( 'Michelle House', 'Integration Specialist', 'Sydney', 37, '2011-06-02', 95400 ),
	( 'Olivia Liang', 'Support Engineer', 'Singapore', 64, '2011-02-03', 234500 ),
	( 'Paul Byrd', 'Chief Financial Officer (CFO)', 'New York', 64, '2010-06-09', 725000 ),
	( 'Prescott Bartlett', 'Technical Author', 'London', 27, '2011-05-07', 145000 ),
	( 'Quinn Flynn', 'Support Lead', 'Edinburgh', 22, '2013-03-03', 342000 ),
	( 'Rhona Davidson', 'Integration Specialist', 'Tokyo', 55, '2010-10-14', 327900 ),
	( 'Sakura Yamamoto', 'Support Engineer', 'Tokyo', 37, '2009-08-19', 139575 ),
	( 'Serge Baldwin', 'Data Coordinator', 'Singapore', 64, '2012-04-09', 138575 ),
	( 'Shad Decker', 'Regional Director', 'Edinburgh', 51, '2008-11-13', 183000 ),
	( 'Shou Itou', 'Regional Marketing', 'Tokyo', 20, '2011-08-14', 163000 ),
	( 'Sonya Frost', 'Software Engineer', 'Edinburgh', 23, '2008-12-13', 103600 ),
	( 'Suki Burks', 'Developer', 'London', 53, '2009-10-22', 114500 ),
	( 'Tatyana Fitzpatrick', 'Regional Director', 'London', 19, '2010-03-17', 385750 ),
	( 'Thor Walton', 'Developer', 'New York', 61, '2013-08-11', 98540 ),
	( 'Tiger Nixon', 'System Architect', 'Edinburgh', 64, '2011-04-25', 320800 ),
	( 'Timothy Mooney', 'Office Manager', 'London', 35, '2008-12-11', 136200 ),
	( 'Unity Butler', 'Marketing Designer', 'San Francisco', 47, '2009-12-09', 85675 ),
	( 'Vivian Harrell', 'Financial Controller', 'San Francisco', 62, '2009-02-14', 452500 ),
	( 'Yuri Berry', 'Chief Marketing Officer (CMO)', 'New York', 40, '2009-06-25', 675000 ),
	( 'Zenaida Frank', 'Software Engineer', 'New York', 63, '2010-01-04', 125250 ),
	( 'Zorita Serrano', 'Software Engineer', 'San Francisco', 56, '2012-06-01', 115000 )