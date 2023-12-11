DELETE FROM Member;
DELETE FROM Trainer;
DELETE FROM Admin;
DELETE FROM Routine;
DELETE FROM Group_Activity;
DELETE FROM Group_Enrollment;
DELETE FROM Training_Session;
DELETE FROM Member_Goal;
DELETE FROM Member_Routine;
DELETE FROM Membership_Fee;
DELETE FROM Payroll;

INSERT INTO Member (email, pwd, fname, lname, loyalty) VALUES ('johndoe@email.com', 'abcd', 'John', 'Doe', 10);
INSERT INTO Member (email, pwd, fname, lname, loyalty) VALUES ('annawalker@email.com', 'efg', 'Anna', 'Walker', 0);
INSERT INTO Member (email, pwd, fname, lname, loyalty) VALUES ('minabell@email.com', 'hijk', 'Mina', 'Bell', 50);
INSERT INTO Member (email, pwd, fname, lname, loyalty) VALUES ('pauldoe@email.com', 'lmnop', 'Paul', 'Doe', 30);

INSERT INTO Trainer (email, pwd, fname, lname, salary) VALUES ('janesmith@email.com', 'qwer', 'Jane', 'Smith', 50000);
INSERT INTO Trainer (email, pwd, fname, lname, salary) VALUES ('bob@email.com', 'zxcv', 'Bob', 'Fit', 60000);
INSERT INTO Trainer (email, pwd, fname, lname, salary) VALUES ('alice@email.com', 'asdf', 'Alice', 'Pro', 70000);

INSERT INTO Admin (email, pwd, fname, lname, role) VALUES ('jimsmart@email.com', '1234', 'Jim', 'Smart', 'Payroll Manager');
INSERT INTO Admin (email, pwd, fname, lname, role) VALUES ('runner@email.com', '0987', 'Chris', 'Runner', 'Accountant');
INSERT INTO Admin (email, pwd, fname, lname, role) VALUES ('long@email.com', '4321', 'Phoebe', 'Swimmer', 'Maintenance Supervisor');

INSERT INTO Routine (id, name) VALUES (1, 'Treadmill');
INSERT INTO Routine (id, name) VALUES (2, 'Swimming');
INSERT INTO Routine (id, name) VALUES (3, 'Dumbbells');
INSERT INTO Routine (id, name) VALUES (4, 'Barbells');
INSERT INTO Routine (id, name) VALUES (5, 'Stretching');
INSERT INTO Routine (id, name) VALUES (6, 'Bicycling');

INSERT INTO Group_Activity (title, descript, category, price, instructor, g_room, time_begin, time_end) 
	VALUES ('Cardio Workshop', 'Do Treadmill and Bicycle Together', 'Workshop', 80, 1, 100, '2023-11-13 12:00:00', '2023-11-13 14:00:00');
INSERT INTO Group_Activity (title, descript, category, price, instructor, g_room, time_begin, time_end) 
	VALUES ('Swimming Contest', 'Who is the best swimmer?', 'Competition', 50, 2, 102, '2023-11-15 11:00:00', '2023-11-15 12:00:00');

INSERT INTO Group_Enrollment (gid, mid) VALUES (1, 2);
INSERT INTO Group_Enrollment (gid, mid) VALUES (1, 1);
INSERT INTO Group_Enrollment (gid, mid) VALUES (2, 1);
INSERT INTO Group_Enrollment (gid, mid) VALUES (2, 2);
INSERT INTO Group_Enrollment (gid, mid) VALUES (2, 3);

INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) VALUES (3, 1, 100, '2023-11-12 09:00:00', '2023-11-12 10:00:00', 100);
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) VALUES (2, 2, 100, '2023-11-11 10:00:00', '2023-11-11 12:00:00', 200);
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) VALUES (2, 3, 100, '2023-11-13 13:00:00', '2023-11-11 14:00:00', 100);
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) VALUES (1, 1, 100, '2023-12-30 10:00:00', '2023-12-30 12:00:00', 200);
INSERT INTO Training_Session(mid, tid, ts_room, time_begin, time_end, payAmount) VALUES (2, 1, 100, '2023-12-30 13:00:00', '2023-12-30 14:00:00', 100);

INSERT INTO Member_Goal (mid, routine_id, routine_hrs) VALUES (3, 4, 20);
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) VALUES (3, 5, 25);
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) VALUES (1, 2, 20);
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) VALUES (1, 3, 30);
INSERT INTO Member_Goal (mid, routine_id, routine_hrs) VALUES (1, 4, 20);

INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (2, 4, '2023-11-11 13:00:00', 1);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (3, 2, '2023-11-12 09:00:00', 1);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (1, 2, '2023-11-12 09:00:00', 2);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (1, 1, '2023-11-13 12:00:00', 2);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (2, 1, '2023-11-13 12:00:00', 2);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (2, 6, '2023-11-13 13:00:00', 1);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (1, 4, '2023-11-13 13:00:00', 2);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (1, 4, '2023-11-14 13:00:00', 2);
INSERT INTO Member_Routine (mid, routine_id, routine_time, numHour) VALUES (1, 2, '2023-11-15 13:00:00', 2);

INSERT INTO Membership_Fee (mid, payDate, payAmount) VALUES (4, '2023-11-08', 200);
INSERT INTO Membership_Fee (mid, payDate, payAmount) VALUES (3, '2023-11-09', 200);
INSERT INTO Membership_Fee (mid, payDate, payAmount) VALUES (2, '2023-11-10', 200);
INSERT INTO Membership_Fee (mid, payDate, payAmount) VALUES (1, '2023-11-11', 200);

INSERT INTO Payroll (tid, payDate, payAmount, aid) VALUES (1, '2023-11-01', 5000, 1);
INSERT INTO Payroll (tid, payDate, payAmount, aid) VALUES (2, '2023-10-01', 6000, 2);
INSERT INTO Payroll (tid, payDate, payAmount, aid) VALUES (3, '2023-11-01', 7000, 1);


