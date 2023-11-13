# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.
# To be able to drop table and then have the FKs active we first set "0" and then "1" for the FK checks.

SET FOREIGN_KEY_CHECKS=0;
# Order of dropping tables matters
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS roles;
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

CREATE TABLE skills (
    id INT NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL DEFAULT '(default description)',
    tag varchar(255) NOT NULL,
    url varchar(255),
    time_commitment INT,
    PRIMARY KEY (id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

INSERT INTO skills ( id, name, description, tag, url, time_commitment) VALUES
 (1, 'kick boxing', 'knowing martial arts', 'Skill 1', "www.a.com", 9023),
 (2, 'python coding', 'writing python program', "Skill 2", "www.b.com", 56562),
 (3, 'reading', 'reading an article', 'Skill 3', "www.c.com", 56523),
 (4, 'dancing', 'ballet', "Skill 4", "www.d.com", 8941),
 (5, 'drawing', 'drawing', 'Skill 5', "www.e.com", 12345),
 (6, 'painting', 'oil painting', "Skill 6", "www.f.com", 78412),
 (7, 'writing', 'poetry writing', 'Skill 7', "www.g.com", 2124),
 (8, 'ice skating', 'ice skating', 'Skill 8', "www.h.com", 84213)
;

# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

CREATE TABLE people (
    id INT NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    linkedin_url VARCHAR(255),
    headshot_url VARCHAR(255), 
    discord_handle VARCHAR(255), 
    brief_bio VARCHAR(4096), 
    date_joined DATE NOT NULL,
    PRIMARY KEY (id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

INSERT INTO people ( id, first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined) VALUES 
    (1,'Amelia','Person 1', 'abcd@email.com', "www.abc.com", "www.bac.com", 'delklm','About me...','2022-01-01'),
    (2, 'Hermione', 'Person 2', 'efgh@email.com', "www.def.com", "www.edf.com", 'dwokl', 'What I do...','2022-02-02'),
    (3,'Harry','Person 3', 'ijkl@email.com', "www.ghi.com", "www.hgi.com", 'wqdkp', 'My passions...','2022-03-03'),
    (4,'Draco','Person 4', 'mnop@email.com', "www.jkl.com", "www.kjl.com", 'wslwp','After graduating...','2022-04-04'),
    (5,'Robert','Person 5', 'rstu@email.com', "www.mno.com", "www.nmo.com",'ejkem','I have been...','2022-05-05'),
    (6,'Alex','Person 6', 'vwxy@email.com', "www.prs.com", "www.rps.com",'xsmlq','My interest in...','2022-06-06'),
    (7,'Luke','Person 7', 'z123@email.com', "www.stu.com", "www.tsu.com",'swspl','I have bachelors...','2022-07-07'),
    (8,'Ashton','Person 8', '4567@email.com', "www.vyz.com", "www.yvz.com",'malqam','Working for...','2022-08-08'),
    (9,'Phillip','Person 9', '8901@email.com', "www.a11c.com", "www.11ac.com",'fjemk',"I hope to...",'2022-09-09'),
    (10,'Henry','Person 10', 'hjde@email.com', "www.1b1.com", "www.b11.com",'dmmlq',"Hey, my...",'2022-10-10')
;

# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

# This is a JOIN table

CREATE TABLE peopleskills(
    id INT auto_increment NOT NULL,
    skills_id INT NOT NULL,
    people_id INT NOT NULL,
    date_aquired DATE default (current_date) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (skills_id) REFERENCES skills (id) ON DELETE CASCADE,
    FOREIGN KEY (people_id) REFERENCES people (id),
    UNIQUE (skills_id, people_id)
);

# If we add "ON DELETE CASCADE" for skills_id, then we can delete skills by id (from skills table). Otherwise, we'll not be able to since it's a FK to peopleskills 

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.

INSERT INTO peopleskills (people_id, skills_id) VALUES
    (1,1),(1,3),(1,6),
    (2,3),(2,4),(2,5),
    (3,1),(3,5),
    (5,3),(5,6),
    (6,2),(6,3),(6,4),
    (7,3),(7,5),(7,6),
    (8,1),(8,3),(8,5),(8,6),
    (9,2),(9,5),(9,6),
    (10,1),(10,4),(10,5)
;

# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

CREATE TABLE roles (
    id INT NOT NULL,
    name VARCHAR(255),
    sort_priority INT,
    PRIMARY KEY (id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles (id, name, sort_priority) VALUES
    (1, 'Designer', 10),
    (2, 'Developer', 20),
    (3, 'Recruit', 30),
    (4, 'Team Lead', 40),
    (5, 'Boss', 50),
    (6, 'Mentor', 60)
;

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

CREATE TABLE peopleroles(
    id INT auto_increment NOT NULL, 
    people_id INT NOT NULL, 
    role_id INT NOT NULL, 
    date_assigned DATE NOT NULL DEFAULT (current_date),
    FOREIGN KEY (people_id) REFERENCES people (id),
    FOREIGN KEY (role_id) REFERENCES roles (id),
    PRIMARY KEY (id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles (people_id, role_id) VALUES
    (1,2),
    (2,5), (2,6),
    (3,2),(3,4),
    (4,3),
    (5,3),
    (6,2),(6,1),
    (7,1),
    (8,1),(8,4),
    (9,2),
    (10,2),(10,1)
;
