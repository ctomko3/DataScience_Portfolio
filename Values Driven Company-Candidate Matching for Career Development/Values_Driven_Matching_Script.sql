--Script to create database for Group Project

.echo ON

.mode list
.separator "  |  "

.output GroupProject_Alygn_DBcreate2_out.txt

.open Alygn2.db

PRAGMA foreign_keys = ON;

--Drop tables if exist

DROP TABLE IF EXISTS Candidate;
DROP TABLE IF EXISTS SoCulAttrib;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS CanSCALookup;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS CanLocLookup;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS CoLocLookup;
DROP TABLE IF EXISTS CoSCALookup;
DROP TABLE IF EXISTS Benefits;
DROP TABLE IF EXISTS CoBenLookup;
DROP TABLE IF EXISTS Position;
DROP TABLE IF EXISTS MoneyComp;

--Create tables with constraints

CREATE TABLE Candidate (
	can_id		CHAR(06),
	can_lname		VARCHAR(50) NOT NULL,
	can_fname		VARCHAR(50) NOT NULL,
	can_middle		VARCHAR (35),
	can_dob			DATE,
	can_gender		CHAR(1),
	can_email		CHAR(60),
	can_mphone		VARCHAR(30),
	can_hphone		VARCHAR(30),
	can_city		VARCHAR(35),
	can_state		CHAR(2),
	can_zip			CHAR(5),
	can_gradstatus	VARCHAR(15) NOT NULL,
	can_major		VARCHAR(50),
	can_minor		VARCHAR(50),
  CONSTRAINT candidate_can_id_pk PRIMARY KEY (can_id),
  CONSTRAINT candidate_can_mphone_chk CHECK (can_mphone NOT LIKE '%[^0-9+-.]%'),
  CONSTRAINT candidate_can_hphone_chk CHECK (can_hphone NOT LIKE '%[^0-9+-.]%'),
  CONSTRAINT candidate_can_gradstatus_chk CHECK (LOWER(can_gradstatus) IN ("freshman", "sophomore", "junior", "senior", "graduate", "alum"))
  );

CREATE TABLE SoCulAttrib (
	sca_id			CHAR(03),
	sca_name		VARCHAR(50) NOT NULL,
	sca_desc		VARCHAR(300),
  CONSTRAINT SoCulAttrib_sca_id_pk PRIMARY KEY (sca_id)
  );
  
CREATE TABLE Rating (
	rating_id		CHAR(03),
	rating_level	TINYINT NOT NULL,
	rating_desc		VARCHAR(100),
  CONSTRAINT rating_rating_id_pk PRIMARY KEY (rating_id),
  CONSTRAINT rating_rating_level_chk CHECK (rating_level >= 1 AND rating_level <= 10)
  );
  
CREATE TABLE CanSCALookup (
	cansca_lk_id	CHAR(03),
	can_id			CHAR(06) NOT NULL,
	sca_id			CHAR(03) NOT NULL,
	rating_id		CHAR(03),
  CONSTRAINT canscalookup_cansca_lk_id_pk PRIMARY KEY (cansca_lk_id),
  CONSTRAINT canscalookup_can_id_fk FOREIGN KEY (can_id) REFERENCES Candidate(can_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT canscalookup_sca_id_fk FOREIGN KEY (sca_id) REFERENCES SoCulAttrib(sca_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT canscalookup_uq UNIQUE (can_id, sca_id)
  );

CREATE TABLE Location (
	loc_id			CHAR(03),
	loc_region		VARCHAR(30) NOT NULL,
	loc_desc		VARCHAR(600),
  CONSTRAINT location_loc_id_pk PRIMARY KEY (loc_id)
  );

CREATE TABLE CanLocLookup (
	canloc_lk_id	CHAR(03),
	can_id			CHAR(06) NOT NULL,
	loc_id			CHAR(03) NOT NULL,
  CONSTRAINT canloclookup_canloc_lk_id_pk PRIMARY KEY (canloc_lk_id),
  CONSTRAINT canloclookup_can_id_fk FOREIGN KEY (can_id) REFERENCES Candidate(can_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT canloclookup_loc_id_fk FOREIGN KEY (loc_id) REFERENCES Location(loc_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT canloclookup_uq UNIQUE (can_id, loc_id)
  );

CREATE TABLE Company (
	co_id			CHAR(04),
	co_name			VARCHAR(50) NOT NULL,
	co_profile		VARCHAR(600),
	co_hq_city		VARCHAR (35),
	co_hq_state		CHAR(2),
	co_hq_zip		CHAR(5),
  CONSTRAINT company_co_id_pk PRIMARY KEY (co_id)
  );

CREATE TABLE CoLocLookup (
	coloc_lk_id		CHAR(03),
	co_id			CHAR(04) NOT NULL,
	loc_id			CHAR(03) NOT NULL,
  CONSTRAINT coloclookup_coloc_lk_id_pk PRIMARY KEY (coloc_lk_id),
  CONSTRAINT coloclookup_co_id_fk FOREIGN KEY (co_id) REFERENCES Company(co_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT coloclookup_loc_id_fk FOREIGN KEY (loc_id) REFERENCES Location(loc_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
  CONSTRAINT coloclookup_uq UNIQUE (co_id, loc_id)
  );

CREATE TABLE CoSCALookup (
	cosca_lk_id		CHAR(03),
	co_id			CHAR(04) NOT NULL,
	sca_id			CHAR(03) NOT NULL,
	rating_id		CHAR(03),
  CONSTRAINT coscalookup_cosca_lk_id_pk PRIMARY KEY (cosca_lk_id),
  CONSTRAINT coscalookup_co_id_fk FOREIGN KEY (co_id) REFERENCES Company(co_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT coscalookup_sca_id_fk FOREIGN KEY (sca_id) REFERENCES SoCulAttrib(sca_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT coscalookup_uq UNIQUE (co_id, sca_id)
  );

CREATE TABLE Benefits (
	ben_id			CHAR(03),
	ben_name		VARCHAR(50) NOT NULL,
	ben_desc		VARCHAR(300),
  CONSTRAINT benefits_ben_id_pk PRIMARY KEY (ben_id)
);

CREATE TABLE CoBenLookup (
	coben_lk_id		CHAR(03),
	co_id			CHAR(04) NOT NULL,
	ben_id			CHAR(03) NOT NULL,
	rating_id		CHAR(03),
  CONSTRAINT cobenlookup_coben_lk_id_pk PRIMARY KEY (coben_lk_id),
  CONSTRAINT cobenlookup_co_id_fk FOREIGN KEY (co_id) REFERENCES Company(co_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT cobenlookup_ben_id_fk FOREIGN KEY (ben_id) REFERENCES Benefits(ben_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
  CONSTRAINT cobenlookup_uq UNIQUE (co_id, ben_id) /* Must be unique to identify a specific benefit to rate */
);

CREATE TABLE Position (
	pos_id			CHAR(03),
	pos_name		VARCHAR(50) NOT NULL,
	co_id			CHAR(04) NOT NULL,
	loc_id			CHAR(03) NOT NULL,
	pos_desc		VARCHAR(600),
  CONSTRAINT position_pos_id_pk PRIMARY KEY (pos_id),
  CONSTRAINT position_co_id_fk FOREIGN KEY (co_id) REFERENCES Company(co_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
  CONSTRAINT position_loc_id_fk FOREIGN KEY (loc_id) REFERENCES Location(loc_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
  CONSTRAINT position_uq UNIQUE (pos_name, co_id, loc_id) /* Must be unique to identify a specific position*/
);

CREATE TABLE MoneyComp (
	mcomp_id		CHAR(03),
	mcomp_item		VARCHAR(40) NOT NULL,
	mcomp_item_desc	VARCHAR(200),
	mcomp_item_min	DECIMAL(12,2),
	mcomp_item_max	DECIMAL(12,2),
	mcomp_item_unit	VARCHAR(15), /* The min/max may be specified in dollars or percentage (e.g. Yr End Bonus)*/
	pos_id			CHAR(03) NOT NULL, /*Money compensation is specific to a position not just a company */
  CONSTRAINT moneycomp_mcomp_id_pk PRIMARY KEY (mcomp_id),
  CONSTRAINT moneycomp_pos_id_fk FOREIGN KEY (pos_id) REFERENCES Position(pos_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
  CONSTRAINT moneycomp_mcomp_item_unit_chk CHECK (LOWER(mcomp_item_unit) IN ("dollars", "percentage"))
);

---Insert records into table - TBD

INSERT INTO Candidate (can_id, can_lname, can_fname, can_middle, can_dob, can_gender, can_email, can_mphone, can_hphone, can_city, can_state, can_zip, can_gradstatus, can_major, can_minor)
VALUES
('000001', 'Johnson', 'John', 'M', '1998-10-15', 'M', 'john.johnson@example.com', '+1-555-123-4567', '+1-555-987-6543', 'New York', 'NY', '10001', 'Senior', 'Computer Science', 'Mathematics'),
('000002', 'Lee', 'Sarah', 'A', '1999-05-23', 'F', 'sarah.lee@example.com', '+1-555-234-5678', '+1-555-876-5432', 'San Francisco', 'CA', '94102', 'Graduate', 'Business Administration', NULL),
('000003', 'Smith', 'David', 'L', '2000-03-18', 'M', 'david.smith@example.com', '+1-555-345-6789', '+1-555-765-4321', 'Seattle', 'WA', '98101', 'Sophomore', 'Psychology', 'Sociology'),
('000004', 'Williams', 'Emily', 'R', '1999-11-12', 'F', 'emily.williams@example.com', '+1-555-456-7890', '+1-555-654-3210', 'Boston', 'MA', '02109', 'Junior', 'English', 'History'),
('000005', 'Brown', 'Daniel', 'K', '1998-07-29', 'M', 'daniel.brown@example.com', '+1-555-567-8901', '+1-555-432-1098', 'Austin', 'TX', '78701', 'Freshman', 'Biology', NULL),
('000006', 'Garcia', 'Sophia', 'E', '1999-02-10', 'F', 'sophia.garcia@example.com', '+1-555-678-9012', '+1-555-321-0987', 'Miami', 'FL', '33131', 'Senior', 'Computer Engineering', 'Mathematics'),
('000007', 'Jones', 'Jacob', 'T', '2000-06-22', 'M', 'jacob.jones@example.com', '+1-555-789-0123', '+1-555-210-9876', 'Denver', 'CO', '80202', 'Graduate', 'Marketing', NULL),
('000008', 'Davis', 'Madison', 'S', '1998-12-01', 'F', 'madison.davis@example.com', '+1-555-890-1234', '+1-555-109-8765', 'Los Angeles', 'CA', '90001', 'Alum', 'History', 'Political Science'),
('000009', 'Rodriguez', 'Isabella', 'G', '1999-09-14', 'F', 'isabella.rodriguez@example.com', '+1-555-901-2345', '+1-555-098-7654', 'Chicago', 'IL', '60601', 'Sophomore', 'Journalism', 'English'),
('000010', 'Martin', 'Andrew', 'P', '1998-04-17', 'M', 'martin.andrew@example.com', '+1-555-370-9273', '+1-555-370-5193', 'Denver', 'CO', '80202', 'Graduate', 'Engineering', NULL);

INSERT INTO SoCulAttrib (sca_id, sca_name, sca_desc)
VALUES
('001', 'Diversity and Inclusion', 'Embracing and valuing differences in race, gender, age, sexual orientation, and other characteristics to promote a respectful and inclusive workplace.'),
('002', 'Work-Life Balance', 'Supporting employees in achieving a healthy balance between their work responsibilities and personal life commitments to promote overall wellbeing and job satisfaction.'),
('003', 'LGBTQ Acceptance', 'Creating an environment of respect and support for employees who identify as LGBTQ, and promoting equality and inclusivity for all members of the LGBTQ community.'),
('004', 'Mental Health Support', 'Providing resources and support for employees who may be struggling with mental health issues to promote overall wellbeing and reduce stigma.'),
('005', 'Community Engagement', 'Encouraging employees to engage with and give back to their local communities through volunteering and other community-based initiatives.'),
('006', 'Ethical Business Practices', 'Committing to conducting business in a socially responsible and ethical manner, and promoting transparency and accountability in all business operations.'),
('007', 'Environmental Sustainability', 'Promoting environmentally sustainable practices and initiatives to reduce the company’s impact on the environment and promote a more sustainable future.'),
('008', 'Health and Wellness', 'Providing resources and support for employees to maintain their physical health and wellness, including fitness programs, healthy food options, and wellness resources.'),
('009', 'Diversity in Hiring', 'Actively seeking to hire a diverse range of employees to promote a more inclusive and representative workforce.'),
('010', 'Professional Development', 'Providing opportunities for employees to learn and grow professionally, including training, mentorship, and career advancement programs.');

INSERT INTO Rating (rating_id, rating_level, rating_desc) VALUES 
('001', 1, 'None'),  
('002', 2, 'Below average'), 
('003', 3, 'Average'),
('004', 4, 'Above average'),
('005', 5, 'Critical');

INSERT INTO CanSCALookup (cansca_lk_id, can_id, sca_id, rating_id) VALUES
('001', '000001', '001', '002'),
('002', '000001', '002', '003'),
('003', '000001', '003', '005'),
('004', '000001', '004', '004'),
('005', '000001', '005', '001'),
('006', '000002', '001', '003'),
('007', '000002', '002', '005'),
('008', '000002', '003', '001'),
('009', '000003', '001', '002'),
('010', '000003', '004', '004');

INSERT INTO Location (loc_id, loc_region, loc_desc) VALUES
('001', 'Northeast', 'Northeastern US'),
('002', 'Southeast', 'Southeastern US'),
('003', 'Midwest', 'Midwestern US'),
('004', 'West', 'Western US'),
('005', 'Southwest', 'Southwestern US');

INSERT INTO CanLocLookup (canloc_lk_id, can_id, loc_id) VALUES
('001', '000001', '001'),
('002', '000001', '003'),
('003', '000002', '004'),
('004', '000003', '001'),
('005', '000003', '005'),
('006', '000004', '002'),
('007', '000004', '004'),
('008', '000005', '003'),
('009', '000006', '001'),
('010', '000006', '003');

INSERT INTO Company (co_id, co_name, co_profile, co_hq_city, co_hq_state, co_hq_zip) VALUES
('0001', 'World Wide Widgets', 'Technology company that develops, licenses, and sells computer software, consumer electronics, and personal computers.', 'Redmond', 'WA', '98052'),
('0002', 'Globex Corporation', 'Multinational technology company that focuses on e-commerce, cloud computing, digital streaming, and artificial intelligence.', 'Seattle', 'WA', '98109'),
('0003', 'InGenius Markets', 'Multinational retail corporation that operates a chain of hypermarkets, discount department stores, and grocery stores.', 'Dallas', 'TX', '75001'),
('0004', 'Global Pharmaceuticals', 'Multinational pharmaceutical corporation that develops and produces medicines and vaccines for a wide range of medical disciplines.', 'New York City', 'NY', '10017'),
('0005', 'Total Plan Investments', 'Multinational investment bank and financial services holding company that engages in investment banking, securities, asset management, and consumer and commercial banking.', 'New York City', 'NY', '10017');

INSERT INTO CoLocLookup (coloc_lk_id, co_id, loc_id) VALUES
('001', '0001', '001'),
('002', '0001', '003'),
('003', '0002', '004'),
('004', '0002', '005'),
('005', '0003', '001'),
('006', '0004', '001'),
('007', '0004', '004'),
('008', '0005', '001'),
('009', '0005', '004'),
('010', '0005', '005');

INSERT INTO CoSCALookup (cosca_lk_id, co_id, sca_id, rating_id) VALUES
('001', '0001', '001', '001'),
('002', '0003', '002', '004'),
('003', '0005', '003', '003'),
('004', '0002', '004', '005'),
('005', '0004', '005', '003'),
('006', '0001', '006', '002'),
('007', '0003', '007', '004'),
('008', '0005', '008', '001'),
('009', '0002', '009', '005'),
('010', '0004', '010', '002');

INSERT INTO Benefits (ben_id, ben_name, ben_desc) VALUES
('001', 'Health Insurance', 'Coverage for medical expenses, including hospital stays, doctor visits, and prescription medications.'),
('002', 'Dental Insurance', 'Coverage for dental care, including routine cleanings, fillings, and major procedures.'),
('003', 'Vision Insurance', 'Coverage for vision care, including eye exams, glasses, and contact lenses.'),
('004', 'Retirement Plans', 'Opportunities for employees to save for their retirement, often with employer contributions.'),
('005', 'Paid Time Off', 'Time off work that employees can use for vacation, sick days, or personal reasons.'),
('006', 'Employee Discounts', 'Discounts on products or services offered by the company or its partners.'),
('007', 'Tuition Assistance', 'Financial assistance provided by the company to help employees pursue further education or training.'),
('008', 'Stock Options', 'Opportunities for employees to purchase company stock at a discounted price.'),
('009', 'Childcare Assistance', 'Assistance with the cost of childcare, such as subsidies, vouchers, or on-site childcare facilities.'),
('010', 'Gym Membership', 'Subsidized or discounted membership to a gym or fitness center for employees to use.');

INSERT INTO CoBenLookup (coben_lk_id, co_id, ben_id, rating_id) VALUES
('001', '0001', '002', '001'),
('002', '0001', '004', '004'),
('003', '0002', '007', '003'),
('004', '0002', '005', '005'),
('005', '0003', '006', '003'),
('006', '0003', '003', '002'),
('007', '0004', '008', '004'),
('008', '0004', '001', '001'),
('009', '0005', '010', '005'),
('010', '0005', '009', '002');

INSERT INTO Position (pos_id, pos_name, co_id, loc_id, pos_desc) VALUES
('001', 'Software Engineer', '0001', '001', 'Develop and maintain software applications'),
('002', 'Data Analyst', '0002', '002', 'Analyze and interpret data to inform business decisions'),
('003', 'Marketing Manager', '0003', '003', 'Develop and implement marketing strategies'),
('004', 'Human Resources Generalist', '0004', '004', 'Provide HR support and services'),
('005', 'Account Manager', '0005', '005', 'Manage and grow client relationships'),
('006', 'Customer Service Representative', '0001', '001', 'Assist customers with inquiries and issues'),
('007', 'Financial Analyst', '0002', '002', 'Analyze financial data and provide insights'),
('008', 'Sales Representative', '0003', '003', 'Sell products or services to customers'),
('009', 'Operations Manager', '0004', '004', 'Oversee and manage business operations'),
('010', 'Graphic Designer', '0005', '005', 'Design visual content for marketing materials');

INSERT INTO MoneyComp (mcomp_id, mcomp_item, mcomp_item_desc, mcomp_item_min, mcomp_item_max, mcomp_item_unit, pos_id) VALUES
('001', 'Junior Salary', 'The annual base salary for Junior Level', 75000.00, 90000.00, 'Dollars', '001'),
('002', 'Mid Level Salary', 'The annual base salary for Mid Level', 85000.00, 100000.00, 'Dollars', '002'),
('003', 'Senior Level Salary', 'The annual base salary for Senior Level', 95000.00, 110000.00, 'Dollars', '003'),
('004', 'Manager Salary', 'The annual base salary for Manager position', 155000.00, 170000.00, 'Dollars', '004'),
('005', 'Director Salary', 'The annual base salary for Director position', 165000.00, 180000.00, 'Dollars', '005');

.output stdout
.echo OFF
