-- ** Database generated with pgModeler (PostgreSQL Database Modeler).
-- ** pgModeler version: 1.2.3
-- ** PostgreSQL version: 18.0
-- ** Project Site: pgmodeler.io
-- ** Model Author: ---

-- ** Database creation must be performed outside a multi lined SQL file. 
-- ** These commands were put in this file only as a convenience.

-- object: pdb_employees | type: DATABASE --
-- DROP DATABASE IF EXISTS pdb_employees;
CREATE DATABASE pdb_employees
	ENCODING = 'UTF8'
	LC_COLLATE = 'en_US.utf8'
	LC_CTYPE = 'en_US.utf8'
	TABLESPACE = pg_default
	OWNER = dorian;
-- ddl-end --


SET check_function_bodies = false;
-- ddl-end --

-- object: employees | type: SCHEMA --
-- DROP SCHEMA IF EXISTS employees CASCADE;
CREATE SCHEMA employees;
-- ddl-end --
ALTER SCHEMA employees OWNER TO dorian;
-- ddl-end --

SET search_path TO pg_catalog,public,employees;
-- ddl-end --

-- object: employees.departments | type: TABLE --
-- DROP TABLE IF EXISTS employees.departments CASCADE;
CREATE TABLE employees.departments (
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	dept_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT idx_16390_primary PRIMARY KEY (dept_no)
);
-- ddl-end --
ALTER TABLE employees.departments OWNER TO dorian;
-- ddl-end --

-- object: employees.dept_emp | type: TABLE --
-- DROP TABLE IF EXISTS employees.dept_emp CASCADE;
CREATE TABLE employees.dept_emp (
	emp_no bigint NOT NULL,
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	CONSTRAINT idx_16395_primary PRIMARY KEY (emp_no,dept_no)
);
-- ddl-end --
ALTER TABLE employees.dept_emp OWNER TO dorian;
-- ddl-end --

-- object: employees.dept_manager | type: TABLE --
-- DROP TABLE IF EXISTS employees.dept_manager CASCADE;
CREATE TABLE employees.dept_manager (
	emp_no bigint NOT NULL,
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	CONSTRAINT idx_16402_primary PRIMARY KEY (emp_no,dept_no)
);
-- ddl-end --
ALTER TABLE employees.dept_manager OWNER TO dorian;
-- ddl-end --

-- object: employees.employees | type: TABLE --
-- DROP TABLE IF EXISTS employees.employees CASCADE;
CREATE TABLE employees.employees (
	emp_no bigint NOT NULL,
	birth_date date NOT NULL,
	first_name character varying(14) COLLATE pg_catalog."default" NOT NULL,
	last_name character varying(16) COLLATE pg_catalog."default" NOT NULL,
	gender text COLLATE pg_catalog."default" NOT NULL,
	hire_date date NOT NULL,
	CONSTRAINT idx_16409_primary PRIMARY KEY (emp_no)
);
-- ddl-end --
ALTER TABLE employees.employees OWNER TO dorian;
-- ddl-end --

-- object: employees.salaries | type: TABLE --
-- DROP TABLE IF EXISTS employees.salaries CASCADE;
CREATE TABLE employees.salaries (
	emp_no bigint NOT NULL,
	salary bigint NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	CONSTRAINT idx_16420_primary PRIMARY KEY (emp_no,from_date)
);
-- ddl-end --
ALTER TABLE employees.salaries OWNER TO dorian;
-- ddl-end --

-- object: employees.titles | type: TABLE --
-- DROP TABLE IF EXISTS employees.titles CASCADE;
CREATE TABLE employees.titles (
	emp_no bigint NOT NULL,
	title character varying(50) COLLATE pg_catalog."default" NOT NULL,
	from_date date NOT NULL,
	to_date date,
	CONSTRAINT idx_16427_primary PRIMARY KEY (emp_no,title,from_date)
);
-- ddl-end --
ALTER TABLE employees.titles OWNER TO dorian;
-- ddl-end --

-- object: idx_16402_dept_no | type: INDEX --
-- DROP INDEX IF EXISTS employees.idx_16402_dept_no CASCADE;
CREATE INDEX idx_16402_dept_no ON employees.dept_manager
USING btree
(
	dept_no pg_catalog.bpchar_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_16390_dept_name | type: INDEX --
-- DROP INDEX IF EXISTS employees.idx_16390_dept_name CASCADE;
CREATE UNIQUE INDEX idx_16390_dept_name ON employees.departments
USING btree
(
	dept_name pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_16395_dept_no | type: INDEX --
-- DROP INDEX IF EXISTS employees.idx_16395_dept_no CASCADE;
CREATE INDEX idx_16395_dept_no ON employees.dept_emp
USING btree
(
	dept_no pg_catalog.bpchar_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: employees.current_dept_emp | type: VIEW --
-- DROP VIEW IF EXISTS employees.current_dept_emp CASCADE;
CREATE OR REPLACE VIEW employees.current_dept_emp
AS 
SELECT emp_no,
    dept_no,
    from_date,
    to_date
   FROM dept_emp de
  WHERE ((CURRENT_DATE >= from_date) AND (CURRENT_DATE <= to_date));
-- ddl-end --
ALTER VIEW employees.current_dept_emp OWNER TO dorian;
-- ddl-end --

-- object: employees.dept_emp_latest_date | type: VIEW --
-- DROP VIEW IF EXISTS employees.dept_emp_latest_date CASCADE;
CREATE OR REPLACE VIEW employees.dept_emp_latest_date
AS 
SELECT emp_no,
    max(from_date) AS from_date,
    max(to_date) AS to_date
   FROM dept_emp
  GROUP BY emp_no;
-- ddl-end --
ALTER VIEW employees.dept_emp_latest_date OWNER TO dorian;
-- ddl-end --

-- object: dept_emp_ibfk_1 | type: CONSTRAINT --
-- ALTER TABLE employees.dept_emp DROP CONSTRAINT IF EXISTS dept_emp_ibfk_1 CASCADE;
ALTER TABLE employees.dept_emp ADD CONSTRAINT dept_emp_ibfk_1 FOREIGN KEY (emp_no)
REFERENCES employees.employees (emp_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

-- object: dept_emp_ibfk_2 | type: CONSTRAINT --
-- ALTER TABLE employees.dept_emp DROP CONSTRAINT IF EXISTS dept_emp_ibfk_2 CASCADE;
ALTER TABLE employees.dept_emp ADD CONSTRAINT dept_emp_ibfk_2 FOREIGN KEY (dept_no)
REFERENCES employees.departments (dept_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

-- object: dept_manager_ibfk_1 | type: CONSTRAINT --
-- ALTER TABLE employees.dept_manager DROP CONSTRAINT IF EXISTS dept_manager_ibfk_1 CASCADE;
ALTER TABLE employees.dept_manager ADD CONSTRAINT dept_manager_ibfk_1 FOREIGN KEY (emp_no)
REFERENCES employees.employees (emp_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

-- object: dept_manager_ibfk_2 | type: CONSTRAINT --
-- ALTER TABLE employees.dept_manager DROP CONSTRAINT IF EXISTS dept_manager_ibfk_2 CASCADE;
ALTER TABLE employees.dept_manager ADD CONSTRAINT dept_manager_ibfk_2 FOREIGN KEY (dept_no)
REFERENCES employees.departments (dept_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

-- object: salaries_ibfk_1 | type: CONSTRAINT --
-- ALTER TABLE employees.salaries DROP CONSTRAINT IF EXISTS salaries_ibfk_1 CASCADE;
ALTER TABLE employees.salaries ADD CONSTRAINT salaries_ibfk_1 FOREIGN KEY (emp_no)
REFERENCES employees.employees (emp_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

-- object: titles_ibfk_1 | type: CONSTRAINT --
-- ALTER TABLE employees.titles DROP CONSTRAINT IF EXISTS titles_ibfk_1 CASCADE;
ALTER TABLE employees.titles ADD CONSTRAINT titles_ibfk_1 FOREIGN KEY (emp_no)
REFERENCES employees.employees (emp_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --


