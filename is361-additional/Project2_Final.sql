
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS usergrp;
DROP TABLE IF EXISTS grproom;

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name varchar(64) NOT NULL
  );

CREATE TABLE groups (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name varchar(64) NOT NULL
  );

CREATE TABLE rooms (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name varchar(64) NOT NULL
  );

CREATE TABLE usergrp (
  uID INT,
  gID INT,
  PRIMARY KEY (uID, gID)
  );

CREATE TABLE grproom (
  gID INT,
  rID INT,
  PRIMARY KEY (gID, rID)
  );

INSERT INTO users
(name)
VALUES
('Modesto'),
('Ayine'),
('Christopher'),
('Cheong woo'),
('Saulat'),
('Heidy');

INSERT INTO groups
(name)
VALUES
('I.T.'),
('Sales'),
('Administration'),
('Operations');

INSERT INTO rooms
(name)
VALUES
('101'),
('102'),
('Auditorium A'),
('Auditorium B');

INSERT INTO usergrp
(gID, uID)
VALUES
((SELECT id FROM groups WHERE name = 'I.T.'),
(SELECT id FROM users WHERE name = 'Modesto')),
((SELECT id FROM groups WHERE name = 'I.T.'),
(SELECT id FROM users WHERE name = 'Ayine')),
((SELECT id FROM groups WHERE name = 'Sales'),
(SELECT id FROM users WHERE name = 'Christopher')),
((SELECT id FROM groups WHERE name = 'Sales'),
(SELECT id FROM users WHERE name = 'Cheong woo')),
((SELECT id FROM groups WHERE name = 'Administration'),
(SELECT id FROM users WHERE name = 'Saulat'));

INSERT INTO grproom
(gID, rID)
VALUES
((SELECT id FROM groups WHERE name = 'I.T.'),
(SELECT id FROM rooms WHERE name = '101')),
((SELECT id FROM groups WHERE name = 'I.T.'),
(SELECT id FROM rooms WHERE name = '102')),
((SELECT id FROM groups WHERE name = 'Sales'),
(SELECT id FROM rooms WHERE name = '102')),
((SELECT id FROM groups WHERE name = 'Sales'),
(SELECT id FROM rooms WHERE name = 'Auditorium A'));

-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
SELECT
g.name AS 'Groups',
u.name AS 'Users'
FROM groups AS g
LEFT JOIN usergrp AS ug
ON g.id = ug.gID
LEFT JOIN users AS u
ON u.id = ug.uID
ORDER BY Groups;

-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
-- assigned to them.

SELECT
r.name AS 'Room',
g.name AS 'Groups'
FROM rooms AS r
LEFT JOIN grproom AS gr
ON r.id = gr.rID
LEFT JOIN groups AS g
ON g.id = gr.gID
ORDER BY Room;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
-- alphabetically by user, then by group, then by room.

SELECT
u.name AS 'Users',
g.name AS 'Groups',
r.name AS 'Room'
FROM users AS u
LEFT JOIN usergrp AS ug
-- If users without an assigned group should not be included in this list then you would use this instead
-- JOIN usergrp as ug
ON u.id = ug.uID
LEFT JOIN groups AS g
ON g.id = ug.gID
LEFT JOIN grproom AS gr
ON g.id = gr.gID
LEFT JOIN rooms AS r
ON r.id = gr.rID
ORDER BY Users, Groups, Room;