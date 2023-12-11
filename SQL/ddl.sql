DROP TABLE IF EXISTS Group_Enrollment;
DROP TABLE IF EXISTS Group_Activity;
DROP TABLE IF EXISTS Member_Goal;
DROP TABLE IF EXISTS Member_Routine;
DROP TABLE IF EXISTS Membership_Fee;
DROP TABLE IF EXISTS Payroll;
DROP TABLE IF EXISTS Training_Session;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Trainer;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Routine;


CREATE TABLE IF NOT EXISTS Member (
    id              SERIAL  PRIMARY KEY,
    email           VARCHAR(254)    UNIQUE  NOT NULL,
    pwd             TEXT    NOT NULL,
    fname           TEXT,
    lname           TEXT,
    loyalty         INT
);

CREATE TABLE IF NOT EXISTS Trainer (
    id          SERIAL  PRIMARY KEY,
    email       VARCHAR (254)   UNIQUE  NOT NULL,
    pwd         TEXT            NOT NULL,
    fname       TEXT,
    lname       TEXT,
    salary      INT
);

CREATE TABLE IF NOT EXISTS Admin (
    id          SERIAL  PRIMARY KEY,
    email       VARCHAR (254)   UNIQUE  NOT NULL,
    pwd         TEXT            NOT NULL,
    fname       TEXT,
    lname       TEXT,
    role        VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Routine (
    id      INT PRIMARY KEY,
    name    VARCHAR(254)    NOT NULL    UNIQUE
);


CREATE TABLE IF NOT EXISTS Member_Goal (
    mid             INT,
    routine_id      INT,
    routine_hrs     INT, 
    PRIMARY KEY (mid, routine_id),
    FOREIGN KEY (mid)
        REFERENCES Member (id),
    FOREIGN KEY (routine_id)
        REFERENCES Routine (id)
);

CREATE TABLE IF NOT EXISTS Member_Routine (
    mid             INT,
    routine_id      INT,
    routine_time    TIMESTAMP,
    numHour        INT,
    PRIMARY KEY (mid, routine_id, routine_time),
    FOREIGN KEY (mid)
        REFERENCES Member (id),
    FOREIGN KEY (routine_id)
        REFERENCES Routine (id)
);


CREATE TABLE IF NOT EXISTS Membership_Fee (
    mid         INT,
    payDate     DATE,
    payAmount   INT,
    PRIMARY KEY (mid, payDate),
    FOREIGN KEY (mid)
        REFERENCES Member (id)
);

CREATE TABLE IF NOT EXISTS Training_Session (
    mid         INT,
    tid         INT,
    ts_room     INT         NOT NULL,
    time_begin  TIMESTAMP   NOT NULL, 
    time_end    TIMESTAMP   NOT NULL, 
    payAmount   INT,
    progress    TEXT,
    PRIMARY KEY (mid, tid, time_begin),
    FOREIGN KEY (mid)
        REFERENCES  Member (id),
    FOREIGN KEY (tid)
        REFERENCES  Trainer(id)
);

CREATE TABLE IF NOT EXISTS Group_Activity (
    gid         SERIAL  PRIMARY KEY,
    title       VARCHAR(200)    NOT NULL,
    descript    text,
    category    VARCHAR(50),
    price       INT,
    instructor  INT,
    g_room      INT,
    time_begin  TIMESTAMP    NOT NULL, 
    time_end    TIMESTAMP    NOT NULL, 
    UNIQUE (g_room, time_begin),
    FOREIGN KEY (instructor)
        REFERENCES  Trainer (id)
);


CREATE TABLE IF NOT EXISTS Payroll (
    tid         INT,
    payDate     DATE,
    payAmount   INT,
    aid         INT,
    PRIMARY KEY (tid, payDate),
    FOREIGN KEY (tid)
        REFERENCES Trainer (id),
    FOREIGN KEY (aid)
        REFERENCES Admin (id)
);

CREATE TABLE IF NOT EXISTS Group_Enrollment (
    gid         INT,
    mid         INT,
    PRIMARY KEY (gid, mid),
    FOREIGN KEY (gid)
        REFERENCES Group_Activity (gid)
        ON DELETE CASCADE,
    FOREIGN KEY (mid)
        REFERENCES Member (id)
);
