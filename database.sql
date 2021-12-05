--DROP ALL CONSTRAINTS
ALTER TABLE projects
DROP CONSTRAINT IF EXISTS fk_projects_organisation;

ALTER TABLE projects 
DROP CONSTRAINT IF EXISTS fk_projects_manager;

ALTER TABLE documents 
DROP CONSTRAINT IF EXISTS fk_documents_project;

ALTER TABLE phases 
DROP CONSTRAINT IF EXISTS fk_phases_project;

ALTER TABLE deliverables 
DROP CONSTRAINT IF EXISTS fk_deliverables_phase;

ALTER TABLE employees 
DROP CONSTRAINT IF EXISTS fk_employees_profile;

ALTER TABLE project_employee 
DROP CONSTRAINT IF EXISTS fk_project_employees_project;

ALTER TABLE project_employee 
DROP CONSTRAINT IF EXISTS fk_project_employees_employee;

-- DROP ALL TABLES
DROP TABLE IF EXISTS project_employee;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS phases;
DROP TABLE IF EXISTS deliverables;
DROP TABLE IF EXISTS organisations;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS projects;


-- CREATING TABLES

CREATE TABLE IF NOT EXISTS projects (
    code BIGINT NOT NULL,
    name VARCHAR(100),
    description TEXT,
    amount FLOAT,
    start_date DATE,
    state BIGINT,
    organisation_code BIGINT,
    manager_code BIGINT,
    PRIMARY KEY (code)
);


CREATE TABLE  IF NOT EXISTS documents (
    id BIGINT,
    path VARCHAR(255),
    project_code BIGINT,
    PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS phases (
    code BIGINT,
    label VARCHAR(100),
    description TEXT,
    start_date DATE,
    end_date DATE,
    amount FLOAT,
    state BIGINT,
    is_invoiced BOOLEAN,
    is_payed BOOLEAN,
    project_code BIGINT,
    PRIMARY KEY (code)
);


CREATE TABLE IF NOT EXISTS deliverables (
    code BIGINT,
    label VARCHAR(255),
    description TEXT,
    dec_path VARCHAR(255),
    phase_code BIGINT,
    PRIMARY KEY (code)
);


CREATE TABLE IF NOT EXISTS organisations (
    code BIGINT,
    name VARCHAR(100),
    adress VARCHAR(255),
    phone VARCHAR(255),
    contact_name VARCHAR(100),
    contact_email VARCHAR(100),
    web_site_link VARCHAR(255),
    PRIMARY KEY (code)
);


CREATE TABLE IF NOT EXISTS employees (
    registration_number BIGINT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(255),
    email VARCHAR(100),
    login VARCHAR(255),
    password VARCHAR(255),
    profile_id BIGINT,
    PRIMARY KEY (registration_number)
);


CREATE TABLE IF NOT EXISTS profiles (
    id BIGINT,
    label VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS project_employee (
    project_code BIGINT,
    employee_code BIGINT,
    PRIMARY KEY (project_code, employee_code)
);

-- CREATE CONSTRAINTS
ALTER TABLE projects 
ADD CONSTRAINT fk_projects_organisation
FOREIGN KEY (organisation_code)
REFERENCES organisations(code);

ALTER TABLE projects 
ADD CONSTRAINT fk_projects_manager
FOREIGN KEY (manager_code)
REFERENCES employees(registration_number);

ALTER TABLE documents 
ADD CONSTRAINT fk_documents_project
FOREIGN KEY (project_code)
REFERENCES projects(code);

ALTER TABLE phases 
ADD CONSTRAINT fk_phases_project
FOREIGN KEY (project_code)
REFERENCES projects(code);

ALTER TABLE deliverables 
ADD CONSTRAINT fk_deliverables_phase
FOREIGN KEY (phase_code)
REFERENCES phases(code);

ALTER TABLE employees 
ADD CONSTRAINT fk_employees_profile
FOREIGN KEY (profile_id)
REFERENCES profiles(id);

ALTER TABLE project_employee 
ADD CONSTRAINT fk_project_employees_project
FOREIGN KEY (project_code)
REFERENCES projects(code);

ALTER TABLE project_employee 
ADD CONSTRAINT fk_project_employees_employee
FOREIGN KEY (employee_code)
REFERENCES employees(registration_number);

