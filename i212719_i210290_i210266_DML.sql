USE Hisab_Kitab;
select *from Administrator;

-- Populating User table
INSERT INTO Users (user_id, email, access_level, responsibilities, task, user_type) VALUES 
(1, 'john.doe@example.com', 'admin', 'project management', 'overseeing project execution', 'internal'),
(2, 'jane.doe@example.com', 'manager', 'team management', 'supervising team performance', 'internal'),
(3, 'james.smith@example.com', 'duser_ideveloper', 'software development', 'coding and testing', 'internal'),
(4, 'jessica.jones@example.com', 'stakeholder', 'project review', 'reviewing project status and progress', 'external');


-- Populating Non_Developer table
INSERT INTO Non_Developer (ndev_id, user_id, department, company_name, stakeholder_type, organisation, ndev_flag) VALUES
(1, 4, 'Finance', 'ABC Corp', 'Investor', 'Investment firm', true),
(2, 4, 'Sales', 'DEF Corp', 'Investor', 'Investment firm', true),
(3, 4, 'Marketing', 'XYZ Corp', 'Client', 'Retail chain', false);

INSERT INTO Phone_Number_User (user_id, user_phone_number)
VALUES
    (1, '555-1234'),
    (2, '555-5678'),
    (3, '555-9012'),
    (4, '555-3456'),
    (5, '555-7890');
    
    -- Populating the Team Member table
INSERT INTO Team_Member (team_id, user_id, supervisor_id, member_age, member_name, member_join_date, salary, member_rank)
VALUES
  (1, 1, 2, 30, 'John Doe', '2022-01-01', 50000, 'Developer'),
  (1, 2, 2, 28, 'Jane Smith', '2022-01-01', 45000, 'Designer'),
  (2, 3, 4, 32, 'Mark Johnson', '2022-01-01', 55000, 'Developer'),
  (2, 4, 4, 29, 'Emily Brown', '2022-01-01', 48000, 'Designer');
    
    -- Populating the Issue table
INSERT INTO Issue (issue_id, issue_title, issue_priority, state, issue_property, team_id, issue_type, issue_flag)
VALUES
  (1, 'Design website UI/UX', 'high', 'to do', 'website', 1, 'feature', 0),
  (2, 'Implement website functionality', 'high', 'to do', 'website', 2, 'feature', 0);

-- Populating the Sprint table
INSERT INTO Sprint (sprint_id, issue_id, Sprint_start_date, Sprint_end_date, completed_task, scope, burndown_chart, goal, retrospective)
VALUES 
  (1, 1, '2022-01-01', '2022-01-14', 5, 'Develop website UI/UX', 'https://burndown_chart.com/sprint1', 'Launch website', 'Discuss lessons learned and improvements for next sprint'),
  (2, 2, '2022-01-15', '2022-01-28', 6, 'Implement back-end functionality', 'https://burndown_chart.com/sprint2', 'Finish website features', 'Discuss lessons learned and improvements for next sprint');



-- Populating the Phone_Number_Team_Member table
INSERT INTO Phone_Number_Team_Member (team_id, member_phone_number)
VALUES
  (1, '555-1234'),
  (1, '555-5678'),
  (2, '555-9012'),
  (2, '555-3456');

  -- pop
  INSERT INTO Project (project_id,ndev_id, team_id, supervisor_id, admin_id, issue_id, sprint_id, project_name, project_start_date, project_end_date, project_status, description, project_priority, overall_cost, est_budget, dependency_ratio) 
  VALUES
(1,1, 1, 1, 1, 1, 1, 'Project A', '2022-01-01', '2022-12-31', 'In Progress', 'This is the description of Project A', 'High', 50000, 100000, 0.5),
(2,2, 2, 2, 2, 2, 2, 'Project B', '2023-01-01', '2023-12-31', 'Not Started', 'This is the description of Project B', 'Medium', 25000, 50000, 0.3),
(3,3, 2, 3, 3, 2, 2, 'Project C', '2024-01-01', '2024-12-31', 'Completed', 'This is the description of Project C', 'Low', 10000, 20000, 0.2);

-- Populating the Version table
INSERT INTO Version (version_id, project_id, version_release_date, version_start_date, version_end_date, duration)
VALUES
  (1, 1, '2022-01-15', '2022-01-01', '2022-01-14', 14),
  (2, 2, '2022-02-15', '2022-01-15', '2022-02-14', 31);



-- populating administrator tablle 
INSERT INTO Administrator (admin_id, user_id, project_id, team_id, permission, access_level, report_generation, workflow_editor)
VALUES 
(1, 1, 1, 1, 'all', 'full', 1, 1),
(2, 2, 2, 2, 'limited', 'partial', 0, 1),
(3, 3, 3, 2, 'all', 'full', 1, 0);

-- Populating the Board table
INSERT INTO Board (board_id, project_id, admin_id, issue_id, last_modified_board, created_date_board, board_visibility, board_current_status, board_filters, Board_flag)
VALUES
  (1, 1, 1, 1, '2022-01-14 23:59:59', '2022-01-01 00:00:00', 'public', 'active', 'priority, status', 0),
  (2, 2, 3, 2, '2022-01-28 23:59:59', '2022-01-15 00:00:00', 'private', 'active', 'status', 0);

-- --Populating the Workflow table
INSERT INTO Workflow (workflow_id,admin_id, sprint_id, issue_id, artefacts, workflow_name, workflow_status)
VALUES 
  (1,1, 1, 1, 'Design Document', 'Design Workflow', 'Completed'),
  (2,1, 1, 2, 'Test Plan', 'Test Workflow', 'In Progress'),
  (3,2, 2, 2, 'Requirement Document', 'Requirement Workflow', 'Pending');
  
INSERT INTO User_Account (account_id, user_id, user_name, registration_id, last_login, acc_status, security_settings) VALUES
(1, 1, 'john_smith', 'reg_1234', '2022-05-08 12:00:00', 'active', 'high'),
(2, 2, 'jane_doe', 'reg_5678', '2022-05-08 13:00:00', 'active', 'medium'),
(3, 3, 'bob_johnson', 'reg_9101', '2022-05-08 14:00:00', 'inactive', 'low');


INSERT INTO Managing_responsibilities (admin_id, account_id, supervisor_id, assigning_role, user_groups, access_control, permission)
VALUES 
(1, 1, 2, 'Team Lead', 'Engineering', 'Full Access', 'Owner'),
(2, 2, 3, 'Manager', 'Sales', 'Limited Access', 'Read-only'),
(3, 3, 1, 'Administrator', 'IT', 'Full Access', 'Owner');
