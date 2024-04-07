CREATE DATABASE Hisab_Kitab;

USE Hisab_Kitab;


CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    email VARCHAR(255),
    access_level VARCHAR(50),
    responsibilities VARCHAR(255),
    task VARCHAR(255),
    user_type VARCHAR(50)
);

CREATE TABLE Phone_Number_User (
    user_id INT PRIMARY KEY,
    user_phone_number VARCHAR(20)
);

CREATE TABLE Non_Developer (

    ndev_id INT PRIMARY KEY,
    user_id INT,
    department VARCHAR(255),
    company_name VARCHAR(255),
    stakeholder_type VARCHAR(50),
    organisation VARCHAR(255),
    ndev_flag TINYINT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE User_Account (
    account_id INT PRIMARY KEY,
    user_id INT,
    user_name VARCHAR(255),

    registration_id VARCHAR(255),
    last_login TIMESTAMP,
    acc_status VARCHAR(50),
    security_settings VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Team_Member (
  team_id INT NOT NULL,
  user_id INT NOT NULL,
  supervisor_id INT,
  member_age INT,
  member_name VARCHAR(255),
  member_join_date DATE,
  salary DECIMAL(10,2),
  member_rank VARCHAR(255),
  PRIMARY KEY (team_id, user_id)
);

CREATE TABLE Issue (
  issue_id INT NOT NULL,
  issue_title VARCHAR(255),
  issue_priority VARCHAR(20),
  state VARCHAR(20),
  issue_property VARCHAR(255),
  team_id INT,
  issue_type VARCHAR(20),
  issue_flag INT,
  PRIMARY KEY (issue_id),
  FOREIGN KEY (team_id) REFERENCES Team_Member(team_id)
);

CREATE TABLE Sprint (
    sprint_id INT PRIMARY KEY,
    issue_id INT,
    sprint_start_date TIMESTAMP,
    sprint_end_date TIMESTAMP,
    completed_task INT,
    scope VARCHAR(255),
    burndown_chart VARCHAR(255),
    goal VARCHAR(255),
    retrospective TEXT,
    FOREIGN KEY (issue_id) REFERENCES Issue(issue_id)
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    ndev_id INT,
    team_id INT,
    supervisor_id INT,
    admin_id INT,
    issue_id INT,
    sprint_id INT,
    project_name VARCHAR(255),
    project_start_date TIMESTAMP,
    project_end_date TIMESTAMP,
    project_status VARCHAR(50),
    description TEXT,
    project_priority VARCHAR(50),
    overall_cost DECIMAL(10, 2),
    est_budget DECIMAL(10, 2),
    dependency_ratio DECIMAL(10, 2),
    FOREIGN KEY (ndev_id) REFERENCES Non_Developer(ndev_id),
	FOREIGN KEY (team_id) REFERENCES Team_Member(team_id),
	-- FOREIGN KEY (supervisor_id) REFERENCES Team_Member(supervisor_id), 
    FOREIGN KEY (issue_id) REFERENCES Issue(issue_id),
    FOREIGN KEY (sprint_id) REFERENCES Sprint(sprint_id)
);

CREATE TABLE Administrator (
    admin_id INT PRIMARY KEY,
    user_id INT,
    project_id INT,
    team_id INT,
    permission VARCHAR(255),
    access_level VARCHAR(50),
    report_generation TINYINT,
    workflow_editor TINYINT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id),
    FOREIGN KEY (team_id) REFERENCES Team_Member(team_id)
);

CREATE TABLE Managing_responsibilities (
    admin_id INT,
    account_id INT,
    supervisor_id int,
    assigning_role VARCHAR(50),
    user_groups VARCHAR(255),
    access_control VARCHAR(255),
    permission VARCHAR(255),
    PRIMARY KEY (admin_id, account_id, supervisor_id),
    FOREIGN KEY (admin_id) REFERENCES Administrator(admin_id),
    FOREIGN KEY (account_id) REFERENCES User_Account(account_id)
    -- FOREIGN KEY (supervisor_id) REFERENCES Team_Member(user_id)

);


CREATE TABLE Phone_Number_Team_Member (
  team_id INT NOT NULL,
  member_phone_number VARCHAR(20),
  PRIMARY KEY (team_id, member_phone_number),
  FOREIGN KEY (team_id) REFERENCES Team_Member(team_id)
);

CREATE TABLE Version (
  version_id INT NOT NULL,
  project_id INT NOT NULL,
  version_release_date DATE,
  version_start_date DATE,
  version_end_date DATE,
  duration INT,
  PRIMARY KEY (version_id),
  FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

CREATE TABLE Board (
  board_id INT NOT NULL,
  project_id INT NOT NULL,
  admin_id INT,
  issue_id INT,
  last_modified_board DATETIME,
  created_date_board DATETIME,
  board_visibility VARCHAR(20),
  board_current_status VARCHAR(20),
  board_filters VARCHAR(255),
  board_flag INT,
  PRIMARY KEY (board_id),
  FOREIGN KEY (project_id) REFERENCES Project(project_id),
  FOREIGN KEY (admin_id) REFERENCES Administrator(admin_id),
  FOREIGN KEY (issue_id) REFERENCES Issue(issue_id)
);

CREATE TABLE Workflow (
  workflow_id INT NOT NULL,
  admin_id INT NOT NULL,
  sprint_id INT NOT NULL,
  issue_id INT NOT NULL,
  artefacts VARCHAR(255),
  workflow_name VARCHAR(255),
  workflow_status VARCHAR(20),
  PRIMARY KEY (workflow_id),
  FOREIGN KEY (admin_id) REFERENCES Administrator(admin_id),
  FOREIGN KEY (sprint_id) REFERENCES Sprint(sprint_id),
  FOREIGN KEY (issue_id) REFERENCES Issue(issue_id)
);