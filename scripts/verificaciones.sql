-- ==========================================
-- VERIFICACIÓN DE TABLAS MIGRADAS
-- Base: pdb_employees
-- ==========================================


-- Conteo de registros por tabla

SELECT 'employees' AS tabla, COUNT(*) AS registros
FROM employees.employees;

SELECT 'departments' AS tabla, COUNT(*) AS registros
FROM employees.departments;

SELECT 'dept_emp' AS tabla, COUNT(*) AS registros
FROM employees.dept_emp;

SELECT 'dept_manager' AS tabla, COUNT(*) AS registros
FROM employees.dept_manager;

SELECT 'salaries' AS tabla, COUNT(*) AS registros
FROM employees.salaries;

SELECT 'titles' AS tabla, COUNT(*) AS registros
FROM employees.titles;



-- ==========================================
-- VERIFICACIÓN DE VISTAS
-- ==========================================

SELECT *
FROM employees.current_dept_emp
LIMIT 5;


SELECT *
FROM employees.dept_emp_latest_date
LIMIT 5;



-- ==========================================
-- VERIFICACIÓN DE INTEGRIDAD REFERENCIAL
-- Buscar empleados sin referencia
-- ==========================================

SELECT COUNT(*) AS empleados_sin_departamento
FROM employees.employees e
LEFT JOIN employees.dept_emp de
ON e.emp_no = de.emp_no
WHERE de.emp_no IS NULL;



-- Buscar departamentos sin empleados

SELECT COUNT(*) AS departamentos_sin_empleados
FROM employees.departments d
LEFT JOIN employees.dept_emp de
ON d.dept_no = de.dept_no
WHERE de.dept_no IS NULL;
