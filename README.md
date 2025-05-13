

# Project Documentation

### Project Title
**MMU RHSF Fellowship Management System**

### Description
This database system is designed for the Multimedia University Repentance and Holiness Student Fellowship (RHSF) to manage their members, track attendance at various events, organize fellowship activities, and monitor spiritual growth of members. The system provides a comprehensive solution for:
- Member registration and management
- Event planning and attendance tracking
- Departmental service assignments
- Spiritual follow-up and growth monitoring
- Testimony recording and announcement dissemination

### How to Setup and Run
1. Ensure you have MySQL installed on your system
2. Create a new database (or use an existing one)
3. Execute the provided SQL script to create all tables and relationships
4. The database is now ready for use with your application

### ER Diagram Description
The database consists of 10 interrelated tables:
- **members**: Core table storing all member information
- **events**: Records all fellowship events and activities
- **attendance**: Tracks member participation in events
- **departments**: Manages different service departments
- **member_departments**: Junction table for many-to-many relationship between members and departments
- **testimonies**: Stores member spiritual testimonies
- **follow_ups**: Tracks spiritual follow-up activities
- **announcements**: Manages fellowship announcements
- **member_exits**: Records information about members who leave
- **spiritual_growth**: Monitors members' spiritual development

Relationships include:
- One-to-many: Members to Events (through attendance)
- Many-to-many: Members to Departments (through member_departments)
- One-to-one: Members to their exit records (if applicable)

### Implementation Notes
1. The database is normalized to 3NF with appropriate constraints
2. All tables include proper primary and foreign key relationships
3. Data integrity is enforced through constraints and checks
4. Indexes are created for performance optimization on frequently queried columns
5. The design accommodates all the fellowship activities mentioned in your requirements

This implementation provides a solid foundation for building a complete fellowship management system that can scale as the ministry grows.
