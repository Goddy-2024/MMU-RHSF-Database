-- MMU RHSF Fellowship Management System Database
-- Created for Multimedia University Repentance and Holiness Student Fellowship
-- This database tracks members, attendance, events, and fellowship activities

-- Database creation
DROP DATABASE IF EXISTS mmu_rhsf;
CREATE DATABASE mmu_rhsf;
USE mmu_rhsf;

-- Members table - tracks all fellowship members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    faculty VARCHAR(50) NOT NULL,
    course VARCHAR(50) NOT NULL,
    year_of_study INT NOT NULL,
    date_joined DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    baptism_status ENUM('Baptized', 'Not Baptized', 'Seeking Baptism') NOT NULL,
    spiritual_role VARCHAR(50),
    CONSTRAINT chk_year CHECK (year_of_study BETWEEN 1 AND 6)
) ENGINE=InnoDB;

-- Events table - tracks all fellowship events
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_type ENUM('Meeting', 'Conference', 'Crusade', 'Bible Study', 'Fellowship') NOT NULL,
    event_date DATETIME NOT NULL,
    location VARCHAR(100) NOT NULL,
    description TEXT,
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES members(member_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Attendance table - tracks member attendance at events
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    member_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    time_in TIME,
    time_out TIME,
    is_visitor BOOLEAN DEFAULT FALSE,
    visitor_details TEXT,
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT unique_attendance UNIQUE (event_id, member_id, attendance_date)
) ENGINE=InnoDB;

-- Departments table - tracks different service departments in the fellowship
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    leader_id INT,
    FOREIGN KEY (leader_id) REFERENCES members(member_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Member departments - many-to-many relationship between members and departments
CREATE TABLE member_departments (
    member_id INT NOT NULL,
    department_id INT NOT NULL,
    role VARCHAR(50),
    date_joined DATE NOT NULL,
    PRIMARY KEY (member_id, department_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Testimonies table - records member testimonies
CREATE TABLE testimonies (
    testimony_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    testimony_date DATE NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Follow-up table - tracks spiritual follow-up of members
CREATE TABLE follow_ups (
    follow_up_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    follow_up_date DATE NOT NULL,
    follow_up_type ENUM('New Convert', 'Backslider', 'Regular Check-in') NOT NULL,
    notes TEXT,
    follow_up_by INT,
    next_follow_up_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (follow_up_by) REFERENCES members(member_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Announcements table - tracks fellowship announcements
CREATE TABLE announcements (
    announcement_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    announcement_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATE,
    posted_by INT,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (posted_by) REFERENCES members(member_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Member exit records - tracks members who leave the fellowship
CREATE TABLE member_exits (
    exit_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    exit_date DATE NOT NULL,
    reason ENUM('Graduation', 'Transfer', 'Backsliding', 'Personal Reasons', 'Other') NOT NULL,
    details TEXT,
    follow_up_notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Spiritual growth tracking
CREATE TABLE spiritual_growth (
    growth_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    assessment_date DATE NOT NULL,
    prayer_life_rating INT CHECK (prayer_life_rating BETWEEN 1 AND 5),
    bible_study_rating INT CHECK (bible_study_rating BETWEEN 1 AND 5),
    fellowship_rating INT CHECK (fellowship_rating BETWEEN 1 AND 5),
    evangelism_rating INT CHECK (evangelism_rating BETWEEN 1 AND 5),
    overall_notes TEXT,
    assessed_by INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (assessed_by) REFERENCES members(member_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Create indexes for better performance
CREATE INDEX idx_member_name ON members(last_name, first_name);
CREATE INDEX idx_event_date ON events(event_date);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);
CREATE INDEX idx_follow_up_date ON follow_ups(follow_up_date);
