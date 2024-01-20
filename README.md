# Sports Tournament Management System Database - PostgreSQL

## Project Overview

This project involves the creation of a PostgreSQL database for a Sports Tournament Management System. It's designed as part of a university database course. The database caters to different users including external users, tournament organizers, referees, and administrators, each with specific permissions and functionalities.

## User Roles and Permissions

### External Users
- **Permissions:** Read-only access to specific database views.
- **Restrictions:** No direct database read access and limited view access.

### Tournament Organizers
- **Permissions:** Add, delete, and edit records in designated database views.
- **Restrictions:** Cannot alter the database structure.

### Referees
- **Permissions:** Perform DML (Data Manipulation Language) operations on predefined views.
- **Restrictions:** Limited to specific operational views.

### Administrators
- **Permissions:** Full control over the database including creating views, tables, columns, and managing all user access levels.

## Required Functionalities

### External Users
- View all tournaments, participants (limited personal data), teams, and coaches.
- Access results with participant and tournament details.
- Register for competitions and add personal, contact, and team information.

### Tournament Organizers
- All read functionalities of external users.
- Add, delete, and edit records related to tournaments and participants.
- Critical sections protected by transactions.

### Referees
- Insert, delete, and edit individual and team results.
- Critical sections protected by transactions.

### Administrators
- Full functionality access including database structure editing.
- View creation and transaction management.
- Access to original database structure and system logs.

## Potential Database Access Conflicts

Conflicts may arise during simultaneous access, especially by organizers. Examples include:
- Concurrent modification of the same records (e.g., registering users for competitions, modifying results).
- Overwriting or unintended changes in results.
- Inconsistencies in payment status or duplicate registrations for the same tournament.

To address these conflicts, the system should implement transaction management and conflict resolution mechanisms.

## Installation and Setup
To install DB install PostgreSQL DBMS and use this commands in bash:
(If you have old instance to uninstall)
```bash
dropdb [name of old DB instance]
```
```bash
createdb [name of new DB instance] 
```
```bash
psql -f sport_tournaments_db.dump [name of new DB instance]
```
