-- clinic_booking_system.sql

-- --------------------------------------------
-- Project: Clinic Booking System Database
-- Description: A relational DB for managing patients, doctors, appointments & prescriptions
-- --------------------------------------------

-- Create the database
CREATE DATABASE IF NOT EXISTS clinic_booking_system;
USE clinic_booking_system;

-- Drop tables if they already exist to avoid errors on re-run
DROP TABLE IF EXISTS prescriptions, appointments, medications, patients, doctors, specializations;

-- Table: Specializations
-- Stores medical specialties (e.g., Cardiology, Dermatology)
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Doctors
-- Stores doctor profiles with specialization link
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
);

-- Table: Patients
-- Stores patient profiles
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Table: Appointments
-- Stores appointments between doctors and patients
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    UNIQUE (patient_id, doctor_id, appointment_date)
);

-- Table: Medications
-- Stores catalog of medicines that can be prescribed
CREATE TABLE medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    dosage VARCHAR(50),
    manufacturer VARCHAR(100)
);

-- Table: Prescriptions
-- Junction table between appointments and medications
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    quantity INT NOT NULL,
    dosage_instructions VARCHAR(255),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
    UNIQUE (appointment_id, medication_id)
);
