CREATE DATABASE group_28;

CREATE TABLE department(
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    dept_description TEXT
);

CREATE TABLE role(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    role_description TEXT
);

CREATE TABLE address(
    add_id SERIAL PRIMARY KEY,
    add_line_1 VARCHAR(50) NOT NULL,
    add_line_2 VARCHAR(50),
    add_city VARCHAR(30) NOT NULL,
    add_postcode VARCHAR(8) NOT NULL
);

CREATE TABLE emergency_contact(
    emer_id SERIAL PRIMARY KEY,
    add_id INT NOT NULL,
    emer_first_name VARCHAR(50) NOT NULL,
    emer_mid_name VARCHAR(50),
    emer_last_name VARCHAR(50) NOT NULL,
    emer_email VARCHAR(150) NOT NULL UNIQUE,
    emer_phone_number VARCHAR(15) NOT NULL UNIQUE,
    FOREIGN KEY (add_id) REFERENCES address(add_id)
);

CREATE TABLE staff(
    staff_id SERIAL PRIMARY KEY,
    dept_id INT NOT NULL,
    role_id INT NOT NULL,
    emer_id INT,
    add_id INT NOT NULL,
    staff_head BOOLEAN NOT NULL DEFAULT FALSE,
    staff_title VARCHAR(10) NOT NULL,
    staff_first_name VARCHAR(50) NOT NULL,
    staff_mid_name VARCHAR(50),
    staff_last_name VARCHAR(50) NOT NULL,
    staff_email VARCHAR(150) NOT NULL UNIQUE,
    staff_phone_number VARCHAR(15) NOT NULL UNIQUE,
    staff_date_of_birth DATE NOT NULL,
    staff_qualifications VARCHAR(150),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (emer_id) REFERENCES emergency_contact(emer_id),
    FOREIGN KEY (add_id) REFERENCES address(add_id)
);

CREATE TABLE course(
    course_id SERIAL PRIMARY KEY,
    dept_id INT NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE subject(
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    subject_description TEXT
);

CREATE TABLE course_subject(
   course_id INT NOT NULL,
   subject_id INT NOT NULL,
   PRIMARY KEY (course_id, subject_id),
   FOREIGN KEY (course_id) REFERENCES course(course_id),
   FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

CREATE TABLE session(
    session_id SERIAL PRIMARY KEY,
    subject_id INT NOT NULL,
    session_date DATE NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

CREATE TABLE student(
    stu_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    emer_id INT,
    add_id INT NOT NULL,
    stu_first_name VARCHAR(50) NOT NULL,
    stu_mid_name VARCHAR(50),
    stu_last_name VARCHAR(50) NOT NULL,
    stu_email VARCHAR(150) NOT NULL UNIQUE,
    stu_phone_number VARCHAR(15) NOT NULL UNIQUE,
    stu_date_of_birth DATE NOT NULL,
    stu_enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    stu_academic_level VARCHAR(2) NOT NULL,
    stu_international BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (emer_id) REFERENCES emergency_contact(emer_id),
    FOREIGN KEY (add_id) REFERENCES address(add_id)
);


CREATE TABLE timetable(
    timetable_id SERIAL PRIMARY KEY,
    subject_id INT NOT NULL,
    staff_id INT NOT NULL,
    timetable_date DATE NOT NULL DEFAULT CURRENT_DATE,
    timetable_start_time TIME NOT NULL DEFAULT CURRENT_TIME,
    timetable_end_time TIME NOT NULL DEFAULT CURRENT_TIME,
    timetable_building_name VARCHAR(30) NOT NULL,
    timetable_room_number VARCHAR(6) NOT NULL,
    timetable_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT valid_timetable_start_time CHECK (timetable_start_time BETWEEN '09:00:00' AND '17:00:00')
);

CREATE TABLE timetable_staff(
    timetable_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (timetable_id, staff_id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE timetable_session(
    timetable_id INT NOT NULL,
    session_id INT NOT NULL,
    PRIMARY KEY (timetable_id, session_id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id),
    FOREIGN KEY (session_id) REFERENCES session(session_id)
);

CREATE TABLE timetable_student(
    timetable_id INT NOT NULL,
    stu_id INT NOT NULL,
    PRIMARY KEY (timetable_id, stu_id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id),
    FOREIGN KEY (stu_id) REFERENCES student(stu_id)
);

INSERT INTO department (dept_name, dept_description) VALUES
('Computer Science Department', 'Department focused on teaching and research in computer science'),
('Mathematics Department', 'Department dedicated to mathematics education and research'),
('Physics Department', 'Department that explores the principles and laws governing the physical world'),
('Literature Department', 'Department for the study and appreciation of literary works');

INSERT INTO role (role_name, role_description) VALUES
('Administrator', 'User with full system access'),
('Instructor', 'User who teaches courses'),
('Student', 'User enrolled in courses'),
('Researcher', 'User conducting academic research'),
('Guest', 'Temporary user with limited access privileges');

INSERT INTO address (add_line_1, add_line_2, add_city, add_postcode) VALUES
('1 Street Name', NULL, 'Portsmouth', 'PO1 1AA'),
('2 Street Name', NULL, 'Portsmouth', 'PO1 2BB'),
('3 Street Name', NULL, 'Portsmouth', 'PO1 3CC'),
('4 Street Name', NULL, 'Portsmouth', 'PO1 4DD'),
('5 Street Name', NULL, 'Portsmouth', 'PO1 5EE'),
('6 Street Name', NULL, 'Portsmouth', 'PO1 6FF'),
('7 Street Name', NULL, 'Portsmouth', 'PO1 7GG'),
('8 Street Name', NULL, 'Portsmouth', 'PO1 8HH'),
('9 Street Name', NULL, 'Portsmouth', 'PO1 9II'),
('10 Street Name', NULL, 'Portsmouth', 'PO1 1JJ'),
('11 Street Name', NULL, 'Portsmouth', 'PO1 2KK'),
('12 Street Name', NULL, 'Portsmouth', 'PO1 3LL'),
('13 Street Name', NULL, 'Portsmouth', 'PO1 4MM'),
('14 Street Name', NULL, 'Portsmouth', 'PO1 5NN'),
('15 Street Name', NULL, 'Portsmouth', 'PO1 6OO'),
('16 Street Name', NULL, 'Portsmouth', 'PO1 7PP'),
('17 Street Name', NULL, 'Portsmouth', 'PO1 8QQ'),
('18 Street Name', NULL, 'Portsmouth', 'PO1 9RR'),
('19 Street Name', NULL, 'Portsmouth', 'PO1 1SS'),
('20 Street Name', NULL, 'Portsmouth', 'PO1 2TT'),
('21 Street Name', NULL, 'Portsmouth', 'PO1 3UU'),
('22 Street Name', NULL, 'Portsmouth', 'PO1 4VV'),
('23 Street Name', NULL, 'Portsmouth', 'PO1 5WW'),
('24 Street Name', NULL, 'Portsmouth', 'PO1 6XX'),
('25 Street Name', NULL, 'Portsmouth', 'PO1 7YY');


INSERT INTO emergency_contact (add_id, emer_first_name, emer_mid_name, emer_last_name, emer_email, emer_phone_number) VALUES
(1, 'John', 'A.', 'Doe', 'john.doe@example.com', '555-0101'),
(2, 'Jane', 'B.', 'Smith', 'jane.smith@example.com', '555-0202'),
(3, 'Jim', 'C.', 'Brown', 'jim.brown@example.com', '555-0303'),
(4, 'Jill', 'D.', 'Davis', 'jill.davis@example.com', '555-0404'),
(5, 'Jack', 'E.', 'Wilson', 'jack.wilson@example.com', '555-0505'),
(6, 'Jenny', 'F.', 'Taylor', 'jenny.taylor@example.com', '555-0606'),
(7, 'Joan', 'G.', 'Anderson', 'joan.anderson@example.com', '555-0707'),
(8, 'Jeff', 'H.', 'Thomas', 'jeff.thomas@example.com', '555-0808'),
(9, 'Julia', 'I.', 'Jackson', 'julia.jackson@example.com', '555-0909'),
(10, 'Jacob', 'J.', 'White', 'jacob.white@example.com', '555-1010'),
(11, 'Jasmine', 'K.', 'Harris', 'jasmine.harris@example.com', '555-1111'),
(12, 'Jeremy', 'L.', 'Martin', 'jeremy.martin@example.com', '555-1212'),
(13, 'Jessica', 'M.', 'Garcia', 'jessica.garcia@example.com', '555-1313'),
(14, 'Jose', 'N.', 'Clark', 'jose.clark@example.com', '555-1414'),
(15, 'Jade', 'O.', 'Rodriguez', 'jade.rodriguez@example.com', '555-1515'),
(16, 'Jordan', 'P.', 'Lewis', 'jordan.lewis@example.com', '555-1616'),
(17, 'Julie', 'Q.', 'Walker', 'julie.walker@example.com', '555-1717'),
(18, 'Joel', 'R.', 'Hall', 'joel.hall@example.com', '555-1818'),
(19, 'Jocelyn', 'S.', 'Allen', 'jocelyn.allen@example.com', '555-1919'),
(20, 'Jonas', 'T.', 'Young', 'jonas.young@example.com', '555-2020'),
(21, 'Joyce', 'U.', 'Hernandez', 'joyce.hernandez@example.com', '555-2121'),
(22, 'Jean', 'V.', 'King', 'jean.king@example.com', '555-2222'),
(23, 'Jared', 'W.', 'Wright', 'jared.wright@example.com', '555-2323');

INSERT INTO staff (dept_id, role_id, emer_id, add_id, staff_title, staff_first_name, staff_mid_name, staff_last_name, staff_email, staff_phone_number, staff_date_of_birth, staff_qualifications
) VALUES
(1, 1, 1, 1, 'Dr.', 'Alice', 'B.', 'Johnson', 'alice.johnson@example.com', '555-3232', '1975-04-12', 'PhD in Computer Science'),
(2, 2, 2, 2, 'Mr.', 'Bob', 'C.', 'Smith', 'bob.smith@example.com', '555-4545', '1988-05-23', 'MSc in Mathematics'),
(3, 3, 3, 3, 'Ms.', 'Carol', 'D.', 'Evans', 'carol.evans@example.com', '555-5656', '1990-06-14', 'BSc in Physics'),
(4, 4, 4, 4, 'Prof.', 'David', 'E.', 'Williams', 'david.williams@example.com', '555-6767', '1982-07-25', 'MA in Literature'),
(1, 5, 5, 5, 'Mrs.', 'Eve', 'F.', 'Brown', 'eve.brown@example.com', '555-7878', '1979-08-06', 'MBA'),
(2, 1, 6, 6, 'Dr.', 'Frank', 'G.', 'Moore', 'frank.moore@example.com', '555-8989', '1973-09-17', 'PhD in Economics'),
(3, 2, 7, 7, 'Mr.', 'Grace', 'H.', 'Lee', 'grace.lee@example.com', '555-9090', '1985-10-28', 'MS in Engineering'),
(4, 3, 8, 8, 'Ms.', 'Henry', 'I.', 'Garcia', 'henry.garcia@example.com', '555-1010', '1992-11-09', 'BS in Biology'),
(1, 4, 9, 9, 'Prof.', 'Ivy', 'J.', 'Martinez', 'ivy.martinez@example.com', '555-1212', '1980-12-20', 'MA in History'),
(2, 5, 10, 10, 'Mrs.', 'Jack', 'K.', 'Davis', 'jack.davis@example.com', '555-1313', '1976-01-31', 'MFA');

INSERT INTO course (dept_id, course_name, course_description) VALUES
(1, 'Computer Science', 'Study of algorithmic processes and computational machines'),
(2, 'Mathematics', 'Abstract study of numbers, quantity, structure, space, models, and change'),
(3, 'Physics', 'The natural science that studies matter, its motion and behavior through space and time'),
(4, 'Literature', 'The art of written works, focusing on the study of books and writings');

INSERT INTO subject (subject_name, subject_description) VALUES
('Algebra', 'Study of mathematical symbols and rules for manipulating these symbols'),
('Biology', 'Natural science concerned with the study of life and living organisms'),
('Chemistry', 'Science of atoms and molecules, and how they interact'),
('Economics', 'Social science that studies the production, distribution, and consumption of goods and services'),
('Geography', 'Study of places and the relationships between people and their environments'),
('History', 'Study of past events, particularly in human affairs'),
('Philosophy', 'Study of general and fundamental questions about existence, knowledge, values, reason, mind, and language'),
('Political Science', 'Study of politics and government, and the analysis of political activity and behavior'),
('Psychology', 'Science of behavior and mind, including conscious and unconscious phenomena'),
('Sociology', 'Study of society, patterns of social relationships, social interaction, and culture');


INSERT INTO course_subject (course_id, subject_id) VALUES
(1, 1), -- Computer Science course with Algebra
(1, 2), -- Computer Science course with Biology
(2, 1), -- Mathematics course with Algebra
(2, 3), -- Mathematics course with Chemistry
(3, 2), -- Physics course with Biology
(3, 3), -- Physics course with Chemistry
(4, 4), -- Literature course with Economics
(4, 6); -- Literature course with History

INSERT INTO student (course_id, emer_id, add_id, stu_first_name, stu_mid_name, stu_last_name, stu_email, stu_phone_number, stu_date_of_birth, stu_academic_level, stu_international) VALUES
(1, 1, 1, 'John', 'A', 'Smith', 'john.smith@example.com', '555-0101', '2001-01-01', 'UG', FALSE),
(2, 2, 2, 'Emily', 'B', 'Jones', 'emily.jones@example.com', '555-0102', '2002-02-02', 'UG', FALSE),
(3, 3, 3, 'William', 'C', 'Brown', 'william.brown@example.com', '555-0103', '2003-03-03', 'UG', FALSE),
(4, 4, 4, 'Olivia', 'D', 'Davis', 'olivia.davis@example.com', '555-0104', '2004-04-04', 'UG', FALSE),
(1, 5, 5, 'James', 'E', 'Miller', 'james.miller@example.com', '555-0105', '2005-05-05', 'UG', FALSE),
(2, 6, 6, 'Sophia', 'F', 'Wilson', 'sophia.wilson@example.com', '555-0106', '2006-06-06', 'UG', FALSE),
(3, 7, 7, 'Michael', 'G', 'Moore', 'michael.moore@example.com', '555-0107', '2007-07-07', 'UG', FALSE),
(4, 8, 8, 'Isabella', 'H', 'Taylor', 'isabella.taylor@example.com', '555-0108', '2008-08-08', 'UG', FALSE),
(1, 1, 9, 'Alexander', 'I', 'Anderson', 'alexander.anderson@example.com', '555-0109', '2001-09-09', 'PG', TRUE),
(2, 2, 10, 'Mia', 'J', 'Thomas', 'mia.thomas@example.com', '555-0110', '2002-10-10', 'PG', TRUE),
(3, 3, 11, 'Ethan', 'K', 'Jackson', 'ethan.jackson@example.com', '555-0111', '2003-11-11', 'PG', TRUE),
(4, 4, 12, 'Ava', 'L', 'White', 'ava.white@example.com', '555-0112', '2004-12-12', 'PG', TRUE),
(1, 5, 13, 'Daniel', 'M', 'Harris', 'daniel.harris@example.com', '555-0113', '2005-01-13', 'PG', TRUE),
(2, 6, 14, 'Grace', 'N', 'Martin', 'grace.martin@example.com', '555-0114', '2006-02-14', 'PG', TRUE),
(3, 7, 15, 'Matthew', 'O', 'Garcia', 'matthew.garcia@example.com', '555-0115', '2007-03-15', 'PG', TRUE),
(4, 8, 16, 'Lily', 'P', 'Clark', 'lily.clark@example.com', '555-0116', '2008-04-16', 'PG', TRUE),
(1, 1, 17, 'Jackson', 'Q', 'Rodriguez', 'jackson.rodriguez@example.com', '555-0117', '2001-05-17', 'UG', FALSE),
(2, 2, 18, 'Ella', 'R', 'Lewis', 'ella.lewis@example.com', '555-0118', '2002-06-18', 'UG', FALSE),
(3, 3, 19, 'Oliver', 'S', 'Lee', 'oliver.lee@example.com', '555-0119', '2003-07-19', 'UG', FALSE),
(4, 4, 20, 'Zoe', 'T', 'Walker', 'zoe.walker@example.com', '555-0120', '2004-08-20', 'UG', FALSE);

INSERT INTO session (subject_id, session_date) VALUES
(1, '2024-02-15'),
(2, '2024-02-16'),
(3, '2024-02-17'),
(4, '2024-02-18'),
(5, '2024-02-19'),
(6, '2024-02-20'),
(7, '2024-02-21'),
(8, '2024-02-22'),
(9, '2024-02-23'),
(10, '2024-02-24');

INSERT INTO timetable (subject_id, staff_id, timetable_date, timetable_start_time, timetable_end_time, timetable_building_name, timetable_room_number, timetable_code) VALUES
(1, 1, '2024-02-15', '09:00:00', '09:00:00', 'Main Building', 'Room 1', 'CS101'),
(2, 2, '2024-02-16', '09:00:00', '10:00:00', 'Science Hall', 'Room 2', 'MATH201'),
(3, 3, '2024-02-17', '10:00:00', '11:00:00', 'Physics Center', 'Room 3', 'PHYS301'),
(4, 4, '2024-02-18', '11:00:00', '12:00:00', 'Arts Building', 'Room 4', 'LIT401'),
(5, 5, '2024-02-19', '12:00:00', '13:00:00', 'Main Building', 'Room 1', 'CS102'),
(6, 6, '2024-02-20', '13:00:00', '14:00:00', 'Science Hall', 'Room 2', 'MATH202'),
(7, 7, '2024-02-21', '14:00:00', '15:00:00', 'Physics Center', 'Room 3', 'PHYS302'),
(8, 8, '2024-02-22', '15:00:00', '16:00:00', 'Arts Building', 'Room 4', 'LIT402'),
(9, 9, '2024-02-23', '16:00:00', '17:00:00', 'Main Building', 'Room 1', 'CS103'),
(10, 10, '2024-02-24', '17:00:00', '18:00:00', 'Science Hall', 'Room 2', 'MATH203');

INSERT INTO timetable_staff (timetable_id, staff_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO timetable_session (timetable_id, session_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO timetable_student (timetable_id, stu_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);



-- Query 1: Fetch the list of courses along with their respective departments
SELECT course.course_name, department.dept_name 
FROM course
JOIN department 
ON course.dept_id = department.dept_id;

-- Query 2: Count the number of students enrolled in each course
SELECT course_id, COUNT(*) as student_count 
FROM student
GROUP BY course_id;

-- Query 3: List sessions and the number of staff members assigned to each session
SELECT session.session_id, COUNT(staff_session.staff_id) as staff_count 
FROM session
LEFT JOIN staff_session ON session.session_id = staff_session.session_id
GROUP BY session.session_id;

-- Query 4: Get all students with emergency contact details
SELECT student.stu_first_name, student.stu_last_name, emergency_contact.emer_first_name, emergency_contact.emer_last_name 
FROM student
JOIN emergency_contact ON student.emer_id = emergency_contact.emer_id;

-- View for courses and their respective departments
CREATE VIEW view_course_departments AS
SELECT course.course_name, department.dept_name 
FROM course
JOIN department ON course.dept_id = department.dept_id;

-- View for the number of students enrolled in each course
CREATE VIEW view_course_student_count AS
SELECT course_id, COUNT(*) as student_count 
FROM student
GROUP BY course_id;

-- View for sessions and the number of staff members assigned to each
CREATE VIEW view_session_staff_count AS
SELECT session.session_id, COUNT(staff_session.staff_id) as staff_count 
FROM session
LEFT JOIN staff_session ON session.session_id = staff_session.session_id
GROUP BY session.session_id;

-- View for all students with emergency contact details
CREATE VIEW view_student_emergency_contacts AS
SELECT student.stu_first_name, student.stu_last_name, emergency_contact.emer_first_name, emergency_contact.emer_last_name 
FROM student
JOIN emergency_contact ON student.emer_id = emergency_contact.emer_id;