-- aptipro database initialization script
-- This will recreate the database structure and sample data

-- Set SQL modes and character sets
SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8mb4;
SET @OLD_TIME_ZONE=@@TIME_ZONE;
SET TIME_ZONE='+00:00';
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0;

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS `aptipro` 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci 
DEFAULT ENCRYPTION='N';

USE `aptipro`;

-- Table structure for table `department`
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_name` varchar(255) NOT NULL,
  PRIMARY KEY (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `department`
LOCK TABLES `department` WRITE;
INSERT INTO `department` VALUES 
('Computer Science'),
('Electrical'),
('EXTC'),
('Information Technology'),
('Mechanical');
UNLOCK TABLES;

-- Table structure for table `subjects`
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `subject_name` varchar(255) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`subject_name`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `subjects`
LOCK TABLES `subjects` WRITE;
INSERT INTO `subjects` VALUES 
('Computer Networks','Information Technology'),
('D.B.M.S','Information Technology'),
('D.S.A','Information Technology'),
('Operating Systems','Information Technology'),
('Web Development','Information Technology');
UNLOCK TABLES;

-- Table structure for table `teachers`
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers` (
  `id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `verified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `teachers`
LOCK TABLES `teachers` WRITE;
INSERT INTO `teachers` VALUES 
('5021152','azeempinjari30@gmail.com','Azeem Pinjari','Information Technology','gAAAAABn6BzoKFn6Qp2XQj4ZorXsfYSciJqgdwkkrQVeosidFEFaIBIgiEyMqRtbEJeAcN3KC_Navk0Gf7KR6UVMcy0n4e0uhw==',1);
UNLOCK TABLES;

-- Table structure for table `students`
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `verified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `students`
LOCK TABLES `students` WRITE;
INSERT INTO `students` VALUES 
('5021145','Manas Patil','manasvpatil2016@gmail.com','Information Technology','gAAAAABn6T2Gt8Jy0JmaEa8_mR5qt_irsC5LdAcs9S1lVlssPfGa92rM4UKl0syi7WkZkqiv3UfDr3VVb1XnNA9I-eO3ahvPWA==',1);
UNLOCK TABLES;

-- Table structure for table `mcq`
DROP TABLE IF EXISTS `mcq`;
CREATE TABLE `mcq` (
  `id` int NOT NULL,
  `question` text,
  `optionA` text NOT NULL,
  `optionB` text NOT NULL,
  `optionC` text NOT NULL,
  `optionD` text NOT NULL,
  `correct_option` text NOT NULL,
  `difficulty` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject`),
  CONSTRAINT `mcq_ibfk_1` FOREIGN KEY (`subject`) REFERENCES `subjects` (`subject_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `mcq
-- Table structure for table `tests`
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `marks` int NOT NULL,
  `questions_count` int NOT NULL,
  `duration` int NOT NULL,
  `difficulty` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `teacher` varchar(255) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject`),
  KEY `fk_teacher_email` (`teacher`),
  KEY `fk_test_department` (`dept_name`),
  CONSTRAINT `fk_teacher_email` FOREIGN KEY (`teacher`) REFERENCES `teachers` (`email`),
  CONSTRAINT `fk_test_department` FOREIGN KEY (`dept_name`) REFERENCES `department` (`department_name`),
  CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`subject`) REFERENCES `subjects` (`subject_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `results`
DROP TABLE IF EXISTS `results`;
CREATE TABLE `results` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `marks` int NOT NULL,
  `total_marks` int NOT NULL,
  `difficulty` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `student_email` varchar(255) NOT NULL,
  `teacher_email` varchar(255) NOT NULL,
  `data` json DEFAULT NULL,
  `test_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject`),
  KEY `test_id` (`test_id`),
  KEY `student_email` (`student_email`),
  KEY `teacher_email` (`teacher_email`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`subject`) REFERENCES `subjects` (`subject_name`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`),
  CONSTRAINT `results_ibfk_3` FOREIGN KEY (`student_email`) REFERENCES `students` (`email`),
  CONSTRAINT `results_ibfk_4` FOREIGN KEY (`teacher_email`) REFERENCES `teachers` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Restore original SQL modes
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
SET TIME_ZONE=@OLD_TIME_ZONE;
SET SQL_NOTES=@OLD_SQL_NOTES;