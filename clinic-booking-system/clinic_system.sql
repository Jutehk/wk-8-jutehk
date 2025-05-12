-- Clinic Booking System SQL Schema
-- Author: Juliana 
--Email: julianandunge54@gmail.com
-- Date: 12/05/2025


-- Drop tables if they exist (reverse dependency order)
DROP TABLE IF EXISTS Appointments, DoctorSpecializations, Specializations, Patients, Doctors;

-- -------------------------
--  Patients Table
-- -------------------------
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20) NOT NULL
);

-- -------------------------
--  Doctors Table
-- -------------------------
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20) NOT NULL
);

-- -------------------------
--  Specializations Table
-- -------------------------
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- -----------------------------------------------------
--  DoctorSpecializations (Many-to-Many Relationship)
-- -----------------------------------------------------
CREATE TABLE DoctorSpecializations (
    DoctorID INT NOT NULL,
    SpecializationID INT NOT NULL,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- -------------------------
-- . Appointments Table (1-M: Patient to Appointments, Doctor to Appointments)
-- -------------------------
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- -------------------------
--  Dummy Data Insertion
-- -------------------------

-- Patients
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Email, Phone) VALUES
('John', 'Doe', '1990-06-15', 'john.doe@gmail.com', '0722000001'),
('Jane', 'Williams', '1985-09-20', 'jane.w@gmail.com', '0722000002'),
('Emily', 'Clark', '1995-12-01', 'emilyc@gmail.com', '0722000003'),
('Michael', 'Brown', '1978-08-10', 'mikeb@gmail.com', '0722000004'),
('Sophia', 'Ngugi', '2000-01-25', 'sophia.n@gmail.com', '0722000005');

-- Doctors
INSERT INTO Doctors (FirstName, LastName, Email, Phone) VALUES
('Alice', 'Smith', 'alice.smith@clinic.com', '0711000001'),
('Brian', 'Lee', 'brian.lee@clinic.com', '0711000002'),
('Clara', 'Jones', 'clara.jones@clinic.com', '0711000003'),
('David', 'Kim', 'david.kim@clinic.com', '0711000004');

-- Specializations
INSERT INTO Specializations (Name) VALUES
('Cardiology'),
('Dermatology'),
('Pediatrics'),
('Neurology'),
('Orthopedics');

-- Doctor-Specializations (M-M)
INSERT INTO DoctorSpecializations (DoctorID, SpecializationID) VALUES
(1, 1), -- Alice - Cardiology
(1, 3), -- Alice - Pediatrics
(2, 2), -- Brian - Dermatology
(3, 4), -- Clara - Neurology
(4, 5); -- David - Orthopedics

-- Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Notes) VALUES
(1, 1, '2025-05-15 10:30:00', 'Annual heart checkup'),
(2, 2, '2025-05-16 14:00:00', 'Skin rash consultation'),
(3, 3, '2025-05-17 11:00:00', 'Migraine evaluation'),
(4, 4, '2025-05-18 09:30:00', 'Knee pain'),
(5, 1, '2025-05-19 13:45:00', 'Child vaccination');
