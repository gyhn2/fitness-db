## Links
* Github: https://github.com/gyhn2/fitness-db
* Youtube: https://youtu.be/2e9ksqshdwc?si=OptSRdDSQJYra-vx

## Project Structure
* Project Report.pdf
* SQL Directory: ddl.sql, initialdata.sql, queries.sql

## Files
* Project Report: ERD Diagrams, Explanations and Assumptions, Relational Database Schema, Normalization, Final Schema, Implementation Explanations
* `ddl.sql`: create the tables in a PostgreSQL database
* `initialdata.sql`: insert initial data into the tables
* `queries.sql`: SQL queries that members, trainers, and administrative staff perform.

## Instruction

Prep: Initialize the database
1. Run the `ddl.sql` file to create the tables.
2. Run the `initialdata.sql` file to insert initial data.
3. Run each SQL query from `queries.sql`.

## Description

There are 11 tables, including Member, Trainer, Admin, Routine, Member_Goals (fitness goals for members), Member_Routines (fitness routines by members), Membership_Fee, Payroll (trainer earnings), Training_Session, Group_Activity, Group_Enrollments (group activity enrollments).

Members view their own profile, pay membership fees, add fitness goals, record fitness routines, and enroll in group activities. Trainers can view the members' profiles they train, check their schedules/availability, and add progress notes for their training session. Admin create and (re-)schedule group activities, pay the trainers, and view the revenues from membership fees, training sessions and group activities.
All users can authenticate, register their account, and update their user data. All the members, trainers, and admin can schedule, reschedule and cancel training sessions, after checking time, room, and trainer achedule conflicts.

## Bonus
* The app implementation roadmap is in the Project REport.
