-- =====================================================
-- Migración de vistas MariaDB -> PostgreSQL
-- Base de datos: pdb_employees
-- Esquema: employees
-- =====================================================


-- =====================================================
-- Vista: current_dept_emp
-- Descripción:
-- Muestra los empleados que actualmente tienen una
-- asignación vigente dentro de un departamento.
-- =====================================================

CREATE OR REPLACE VIEW employees.current_dept_emp AS
SELECT
    de.emp_no,
    de.dept_no,
    de.from_date,
    de.to_date
FROM employees.dept_emp de
WHERE CURRENT_DATE BETWEEN de.from_date AND de.to_date;



-- =====================================================
-- Vista: dept_emp_latest_date
-- Descripción:
-- Obtiene la última fecha registrada de asignación
-- departamental para cada empleado.
-- =====================================================

CREATE OR REPLACE VIEW employees.dept_emp_latest_date AS
SELECT
    emp_no,
    MAX(from_date) AS from_date,
    MAX(to_date) AS to_date
FROM employees.dept_emp
GROUP BY emp_no;
