
/* =========================
Functionalities for Members
========================== */

-- Successful login: 
--      given an email and a password, if they match with a member, return the member data
SELECT id, fname, lname, email, loyalty 
FROM Member 
WHERE email = 'johndoe@email.com' 
AND pwd = 'abcd'
LIMIT 1;

-- Failed login (wrong password, returns no row)
SELECT id, fname, lname, email, loyalty 
FROM Member 
WHERE EXISTS 
    (SELECT 1 
    FROM Member
    WHERE email = 'johndoe@email.com' 
        AND pwd = 'zyxw')
LIMIT 1;

-- View profile of member with id 1
SELECT id, fname, lname, email, loyalty 
FROM Member 
WHERE id = 1;

-- Successful Member Registration
INSERT INTO Member (email, pwd, fname, lname, loyalty) 
VALUES ('fitness@example.com', '1234', 'Fit', 'Ness', 10)
RETURNING *;

-- Failed Member Registration with a duplicate email (returns error)
INSERT INTO Member (email, pwd, fname, lname, loyalty) 
VALUES ('fitness@example.com', 'aaaa', 'Data', 'Base', 10)
RETURNING *;

-- Password change: 
--      user input with member id 1 and new password 'asdf'
UPDATE Member 
SET pwd = 'asdf' 
WHERE id = 1
RETURNING *;

-- Update member name: 
-- input with member id 4, new firstname 'Barb' and new lastname 'Bell'
UPDATE Member 
SET fname = 'Barb', lname = 'Bell' 
WHERE id = 4
RETURNING *;

-- Add a new fitness goal for a member: 
--      input with member id 1, routine_id 2, and desired routine hours 20
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) 
VALUES (1, 6, 20)
RETURNING *;

-- Adding a fitness goal with duplicate routine (results in failure)
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) 
VALUES (1, 4, 30)
RETURNING *;

-- Fitness goal update: 
--      for member id 3 and routine id 4, change desired routine hours to 30
UPDATE Member_Goal 
SET routine_hrs = 30 
WHERE mid = 3 AND routine_id = 4
RETURNING *;

-- Add a fitness routine:
--      member id 2, routine_id 5, routine start time Nov 15th, 2023 8:00AM, 1 hour of workout 
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) 
VALUES (2, 5, '2023-11-15 08:00:00', 1)
RETURNING *;

-- Register for a group activity: member id 3, activity id 1
INSERT INTO Group_Enrollment (gid, mid) 
VALUES (1, 3)
RETURNING *;

-- Unregister from group activity: member id 3, activity id 1
DELETE FROM Group_Enrollment 
WHERE mid = 3 and gid = 1
RETURNING *;

-- loyalty point deduction: 
--  Input of member id 1 and deduction of 10 points
UPDATE Member SET loyalty = loyalty - 10 WHERE id = 1
RETURNING *;

-- Pay membership fee
INSERT INTO Membership_Fee (mid, payDate, payAmount) VALUES (4, '2023-11-14', 200)
RETURNING *;

-- View fitness achievements:
SELECT r.id, r.name, SUM(numHour) 
FROM Member_Routine mr 
INNER JOIN Routine r 
ON mr.routine_id = r.id  
WHERE mid = 1 
GROUP BY r.id, r.name;

-- View fitness goal
SELECT r.id, r.name, mg.routine_hrs 
FROM Member_Goal mg 
INNER JOIN Routine r 
ON mg.routine_id = r.id  
WHERE mid = 1 
GROUP BY r.id, r.name,mg.routine_hrs;

/* =========================
Functionalities for Trainers
========================== */

-- Login for Trainer
SELECT id, fname, lname, email, salary
FROM Trainer 
WHERE email = 'janesmith@email.com' 
AND pwd = 'qwer';

-- Registration for Trainer:
INSERT INTO Trainer (email, pwd, fname, lname, salary) 
VALUES ('newtrainer@example.com', '1234', 'New', 'Guy', 20000)
RETURNING *;

-- Update Trainer Name:
--      for trainer id 4, change firstname to No, lastname to Name
UPDATE Trainer 
SET fname = 'No', lname = 'Name' 
WHERE id = 4
RETURNING *;

-- View profiles of members trained by the trainer with id 1
SELECT m.id, m.fname, m.lname, m.email 
FROM Member m 
WHERE m.id IN
    (SELECT DISTINCT ts.mid 
    FROM Training_Session ts
    WHERE ts.tid = 1);

-- Check the training session data
SELECT * 
FROM Training_Session
WHERE tid = 1 AND mid = 1 AND time_begin = '2023-12-30 10:00:00';

-- add progress notes after the training session:
--     input with trainer id 1, member id 1, start time 2023-12-30 10:00:00
UPDATE Training_Session
SET progress = 'Did treadmill for 1 hour. Good.'
WHERE tid = 1 AND mid = 1 AND time_begin = '2023-12-30 10:00:00'
RETURNING *;

-- check booked dates for trainer with id 1
SELECT time_begin, time_end, 'Training Session' AS category FROM Training_Session WHERE tid = 1
UNION
SELECT time_begin, time_end, 'Group Activity' AS category FROM Group_Activity WHERE instructor = 1
ORDER BY time_begin;



/* =======================
Functionalities for Admin
=========================*/

-- Registration for Administrative staff:
INSERT INTO Admin (email, pwd, fname, lname, role) 
VALUES ('adminstaff@example.com', '1234', 'Admin', 'Staff', 'Customer Service')
RETURNING *;

-- Login
SELECT id, fname, lname, email, role
FROM Admin
WHERE email = 'jimsmart@email.com' 
AND pwd = '1234'
LIMIT 1;

-- Update Name:
--  For admin id 4, change name to Funny Name
UPDATE Admin 
SET fname = 'Funny', lname = 'Name' 
WHERE id = 4
RETURNING *;

-- View all members' profiles
SELECT id, fname, lname, email, loyalty 
FROM Member;

-- Successful creation of group activity:
--      Weight Training
--      Room: 100
--      Start time: 2023-12-20 09:00:00
--      End Time: 2023-12-20 11:00:00
INSERT INTO Group_Activity (title, descript, category, price, instructor, g_room, time_begin, time_end) 
SELECT 'Weight Training', 'Gain muscles', 'Group Class', 70, 2, 100, '2023-12-20 09:00:00', '2023-12-20 11:00:00'
WHERE NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE ga.g_room = 100 
    AND (
        ('2023-12-20 09:00:00' >= ga.time_begin 
        AND '2023-12-20 09:00:00' < ga.time_end)
        OR ('2023-12-20 11:00:00' > ga.time_begin 
            AND '2023-12-20 11:00:00' <= ga.time_end)
        ))
RETURNING *;

-- Failed creation of group activity (time and room conflict):
--      Room: 100
--      Start time: 2023-12-20 10:00:00
--      End Time: 2023-12-20 13:00:00
INSERT INTO Group_Activity (title, descript, category, price, instructor, g_room, time_begin, time_end) 
SELECT 'Duplicate Time', 'Gain muscles', 'Group Class', 70, 2, 100, '2023-12-20 10:00:00', '2023-12-20 13:00:00'
WHERE NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE ga.g_room = 100 
    AND (
        ('2023-12-20 10:00:00' >= ga.time_begin 
        AND '2023-12-20 10:00:00' < ga.time_end)
        OR ('2023-12-20 13:00:00' > ga.time_begin 
            AND '2023-12-20 13:00:00' <= ga.time_end)
        ))
RETURNING *;

-- View all group activities
SELECT * FROM Group_Activity;

-- Reschedule group activity:
--      Change Weight Training group class schedule
--      Start time: 2023-12-20 10:00:00
--      End Time: 2023-12-20 13:00:00
UPDATE Group_Activity 
SET time_begin = '2023-12-20 10:00:00', 
    time_end = '2023-12-20 13:00:00',
    g_room = 100
WHERE gid = 3
AND NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE gid != 3
    AND ga.g_room = 100 
    AND (
        ('2023-12-20 10:00:00' >= ga.time_begin 
        AND '2023-12-20 10:00:00' < ga.time_end)
        OR ('2023-12-20 13:00:00' > ga.time_begin 
            AND '2023-12-20 13:00:00' <= ga.time_end)
        ))
RETURNING *;

-- Failed Rescheduling group activity:
--      Change Swimming Contest schedule
--      Start time: 2023-12-20 10:00:00
--      End Time: 2023-12-20 13:00:00
UPDATE Group_Activity 
SET time_begin = '2023-12-20 10:00:00', 
    time_end = '2023-12-20 13:00:00',
    g_room = 100
WHERE gid = 2
AND NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE gid != 2
    AND ga.g_room = 100 
    AND (
        ('2023-12-20 10:00:00' >= ga.time_begin 
        AND '2023-12-20 10:00:00' < ga.time_end)
        OR ('2023-12-20 13:00:00' > ga.time_begin 
            AND '2023-12-20 13:00:00' <= ga.time_end)
        ))
RETURNING *;


-- Cancel group activity (with id 2)
DELETE FROM Group_Activity 
WHERE gid = 3
RETURNING *;

-- Pay trainer:
--  Trainer id 4, paydate Dec 1st 2023, amount 1000
INSERT INTO Payroll (tid, payDate, payAmount, aid) 
VALUES (4, '2023-12-01', 1000, 1)
RETURNING *;

-- View Training Session Revenue
SELECT SUM(payAmount) AS training_revenue FROM Training_Session;

-- View Membership Fee Revenue
SELECT SUM(payAmount) AS membership_revenue FROM Membership_Fee;

-- View revenue for each group activity
SELECT g.gid, g.title AS ga_title, SUM(g.price) AS revenue
FROM Group_Activity g
INNER JOIN Group_Enrollment e
ON e.gid = g.gid 
GROUP BY g.gid;

-- View total revenue from all group activities
SELECT SUM(g.price) AS group_activity_revenue
FROM Group_Enrollment e 
JOIN Group_Activity g 
ON e.gid = g.gid ;

-- View total revenue
SELECT SUM(revenue) AS total_revenue
FROM (
    SELECT SUM(payAmount) AS revenue FROM Training_Session
    UNION
    SELECT SUM(payAmount) AS revenue FROM Membership_Fee
    UNION
    SELECT SUM(g.price) AS revenue FROM Group_Enrollment e 
        JOIN Group_Activity g 
        ON e.gid = g.gid
);

-- View salary payments
SELECT p.*, t.email, t.fname, t.lname, t.salary
FROM Payroll p 
INNER JOIN Trainer t 
ON p.tid = t.id;

-- View total salary paid to trainers
SELECT SUM(payAmount) 
FROM Payroll p 
INNER JOIN Trainer t 
ON p.tid = t.id



/* =========================
Functionalities for everyone
========================== */

-- Schedule training session for member with id 2
-- Check room availability to prevent conflict with group activities
-- As well as trainer's schedule
--     Trainer id : 2
--     Room number: 100
--     Start time: 2023-11-23 09:00:00
--     End Time: 2023-11-23 10:00:00
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) 
SELECT 2, 2, 100, '2023-11-23 09:00:00', '2023-11-23 10:00:00', 150
WHERE NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE (ga.g_room = 100 OR ga.instructor = 2)
    AND (
        ('2023-11-23 09:00:00' >= ga.time_begin 
        AND '2023-11-23 09:00:00' < ga.time_end)
        OR ('2023-11-23 10:00:00' > ga.time_begin 
            AND '2023-11-23 10:00:00' <= ga.time_end)
        )
    )
    AND
    NOT EXISTS (SELECT 1
    FROM Training_Session ts
    WHERE ts.tid = 2
    AND (
        ('2023-11-23 09:00:00' >= ts.time_begin 
        AND '2023-11-23 09:00:00' < ts.time_end)
        OR ('2023-11-23 10:00:00' > ts.time_begin 
            AND '2023-11-23 10:00:00' <= ts.time_end)
        ))
RETURNING *;

-- Failed Scheduling training session for member with id 1
-- Conflict with trainer's schedule
--     Trainer id : 2
--     Room number: 102
--     Start time: 2023-11-23 09:00:00
--     End Time: 2023-11-23 10:00:00
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) 
SELECT 1, 2, 102, '2023-11-23 09:00:00', '2023-11-23 10:00:00', 150
WHERE NOT EXISTS 
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE (ga.g_room = 102 OR ga.instructor = 2)
    AND (
        ('2023-11-23 09:00:00' >= ga.time_begin 
        AND '2023-11-23 09:00:00' < ga.time_end)
        OR ('2023-11-23 10:00:00' > ga.time_begin 
            AND '2023-11-23 10:00:00' <= ga.time_end)
        )
    )
    AND
    NOT EXISTS (SELECT 1
    FROM Training_Session ts
    WHERE ts.tid = 2
    AND (
        ('2023-11-23 09:00:00' >= ts.time_begin 
        AND '2023-11-23 09:00:00' < ts.time_end)
        OR ('2023-11-23 10:00:00' > ts.time_begin 
            AND '2023-11-23 10:00:00' <= ts.time_end)
        ))
RETURNING *;

SELECT * FROM Training_Session;

-- Reschedule the training session
UPDATE Training_Session 
SET ts_room = 101, time_begin = '2023-11-23 10:00:00', time_end = '2023-11-23 11:00:00'
WHERE tid = 2 AND mid = 2 AND time_begin = '2023-11-23 09:00:00'
AND NOT EXISTS
    (SELECT 1 
    FROM Group_Activity ga 
    WHERE (ga.g_room = 100 OR ga.instructor = 2)
    AND (
        ('2023-11-23 10:00:00' >= ga.time_begin 
        AND '2023-11-23 10:00:00' < ga.time_end)
        OR ('2023-11-23 11:00:00' > ga.time_begin 
            AND '2023-11-23 11:00:00' <= ga.time_end)
        )
    )
    AND
    NOT EXISTS (SELECT 1
    FROM Training_Session ts
    WHERE ts.tid = 2
    AND (
        ('2023-11-23 10:00:00' >= ts.time_begin 
        AND '2023-11-23 10:00:00' < ts.time_end)
        OR ('2023-11-23 11:00:00' > ts.time_begin 
            AND '2023-11-23 11:00:00' <= ts.time_end)
        ))
RETURNING *;


-- Cancel training session
DELETE FROM Training_Session 
WHERE tid = 2 AND mid = 2 AND time_begin = '2023-11-23 10:00:00'
RETURNING *;


