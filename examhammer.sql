CREATE DATABASE  IF NOT EXISTS `examhammer` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `examhammer`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: examhammer
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `difficulty_level`
--

DROP TABLE IF EXISTS `difficulty_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `difficulty_level` (
  `difficulty_id` int NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `level` enum('BEGINNER','EASY','HARD','MEDIUM') NOT NULL,
  PRIMARY KEY (`difficulty_id`),
  UNIQUE KEY `UKjo3qbp7mvthtwcxd2rtts8nfi` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `difficulty_level`
--

LOCK TABLES `difficulty_level` WRITE;
/*!40000 ALTER TABLE `difficulty_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `difficulty_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `duration_minutes` int NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `exam_name` varchar(255) NOT NULL,
  `exam_type` enum('COLLEGE','JOB','SCHOOL') NOT NULL,
  `negative_marking` bit(1) DEFAULT NULL,
  `passing_score` int DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT NULL,
  `total_marks` int NOT NULL,
  `total_questions` int NOT NULL,
  `created_by` int NOT NULL,
  `difficulty_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `FKpvl69735airphwhxp59qhvhvb` (`created_by`),
  KEY `FKjw3wg0nnr6hpanh2uffdvks3p` (`difficulty_id`),
  KEY `FKos7g6kn2748ll3ofc3w163gxh` (`subject_id`),
  CONSTRAINT `FKjw3wg0nnr6hpanh2uffdvks3p` FOREIGN KEY (`difficulty_id`) REFERENCES `difficulty_level` (`difficulty_id`),
  CONSTRAINT `FKos7g6kn2748ll3ofc3w163gxh` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`),
  CONSTRAINT `FKpvl69735airphwhxp59qhvhvb` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_attempt`
--

DROP TABLE IF EXISTS `exam_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_attempt` (
  `attempt_id` int NOT NULL AUTO_INCREMENT,
  `end_time` datetime(6) DEFAULT NULL,
  `percentage` double DEFAULT NULL,
  `result` enum('FAIL','PASS') DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `status` enum('COMPLETED','IN_PROGRESS') DEFAULT NULL,
  `total_score` double DEFAULT NULL,
  `exam_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`attempt_id`),
  KEY `FKn1sj3wwcaqpmn5t43fukvnpwv` (`exam_id`),
  KEY `FK17uy2hhgl426dkr932lv3kc9q` (`student_id`),
  CONSTRAINT `FK17uy2hhgl426dkr932lv3kc9q` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKn1sj3wwcaqpmn5t43fukvnpwv` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_attempt`
--

LOCK TABLES `exam_attempt` WRITE;
/*!40000 ALTER TABLE `exam_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_question`
--

DROP TABLE IF EXISTS `exam_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_question` (
  `exam_question_id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`exam_question_id`),
  KEY `FK75y5n4rt15oyfmshrwwi73d` (`exam_id`),
  KEY `FKtrwrv2gj3cya4ipcgnm6v70vy` (`question_id`),
  CONSTRAINT `FK75y5n4rt15oyfmshrwwi73d` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`),
  CONSTRAINT `FKtrwrv2gj3cya4ipcgnm6v70vy` FOREIGN KEY (`question_id`) REFERENCES `question_bank` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_question`
--

LOCK TABLES `exam_question` WRITE;
/*!40000 ALTER TABLE `exam_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `total_marks` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `FKa9pp7fvh0i6302peis1x76ots` (`created_by`),
  CONSTRAINT `FKa9pp7fvh0i6302peis1x76ots` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_bank`
--

DROP TABLE IF EXISTS `question_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_bank` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `correct_option` varchar(255) NOT NULL,
  `explanation` varchar(2000) DEFAULT NULL,
  `optiona` varchar(255) NOT NULL,
  `optionb` varchar(255) NOT NULL,
  `optionc` varchar(255) NOT NULL,
  `optiond` varchar(255) NOT NULL,
  `question_text` varchar(2000) NOT NULL,
  `created_by` int NOT NULL,
  `difficulty_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FKj7krc5jekd0vg2qp5d0yqq53n` (`created_by`),
  KEY `FKmlw5xt1xqxyr9op6k084kxso4` (`difficulty_id`),
  KEY `FKq0bfrg1p1rkrc1tqfuxf4e5mo` (`subject_id`),
  CONSTRAINT `FKj7krc5jekd0vg2qp5d0yqq53n` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKmlw5xt1xqxyr9op6k084kxso4` FOREIGN KEY (`difficulty_id`) REFERENCES `difficulty_level` (`difficulty_id`),
  CONSTRAINT `FKq0bfrg1p1rkrc1tqfuxf4e5mo` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_bank`
--

LOCK TABLES `question_bank` WRITE;
/*!40000 ALTER TABLE `question_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `correct_answer` varchar(255) DEFAULT NULL,
  `marks` int DEFAULT NULL,
  `optiona` varchar(255) DEFAULT NULL,
  `optionb` varchar(255) DEFAULT NULL,
  `optionc` varchar(255) DEFAULT NULL,
  `optiond` varchar(255) DEFAULT NULL,
  `question_text` varchar(255) DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FKrk78bmt53fns7np8casqa3q44` (`exam_id`),
  CONSTRAINT `FKrk78bmt53fns7np8casqa3q44` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `result_id` int NOT NULL AUTO_INCREMENT,
  `declared_at` datetime(6) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  `obtained_marks` int DEFAULT NULL,
  `total_marks` int DEFAULT NULL,
  `exam_exam_id` int DEFAULT NULL,
  `student_user_id` int DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  KEY `FKo82ivns1qo0prqgkhp22paec7` (`exam_exam_id`),
  KEY `FK6x21i6qdcwsv094p0o69mn5hn` (`student_user_id`),
  CONSTRAINT `FK6x21i6qdcwsv094p0o69mn5hn` FOREIGN KEY (`student_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKo82ivns1qo0prqgkhp22paec7` FOREIGN KEY (`exam_exam_id`) REFERENCES `exams` (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_answer`
--

DROP TABLE IF EXISTS `student_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_answer` (
  `answer_id` int NOT NULL AUTO_INCREMENT,
  `is_correct` bit(1) DEFAULT NULL,
  `marks_awarded` int DEFAULT NULL,
  `selected_option` varchar(255) DEFAULT NULL,
  `attempt_id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FKrgryfgmpwv63ts3h37nkph06r` (`attempt_id`),
  KEY `FKgu474qr0jmdh9kk1xwd8ly9fr` (`question_id`),
  CONSTRAINT `FKgu474qr0jmdh9kk1xwd8ly9fr` FOREIGN KEY (`question_id`) REFERENCES `question_bank` (`question_id`),
  CONSTRAINT `FKrgryfgmpwv63ts3h37nkph06r` FOREIGN KEY (`attempt_id`) REFERENCES `exam_attempt` (`attempt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_answer`
--

LOCK TABLES `student_answer` WRITE;
/*!40000 ALTER TABLE `student_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_answers`
--

DROP TABLE IF EXISTS `student_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_answers` (
  `answer_id` int NOT NULL AUTO_INCREMENT,
  `selected_answer` varchar(255) DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `student_exam_id` int DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FK8nyksamccim8emu803uhf2da` (`question_id`),
  KEY `FKdpopt35cp9mv7lato62vt3s8x` (`student_exam_id`),
  CONSTRAINT `FK8nyksamccim8emu803uhf2da` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `FKdpopt35cp9mv7lato62vt3s8x` FOREIGN KEY (`student_exam_id`) REFERENCES `student_exams` (`student_exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_answers`
--

LOCK TABLES `student_answers` WRITE;
/*!40000 ALTER TABLE `student_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_exams`
--

DROP TABLE IF EXISTS `student_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_exams` (
  `student_exam_id` int NOT NULL AUTO_INCREMENT,
  `passed` bit(1) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  PRIMARY KEY (`student_exam_id`),
  KEY `FK4fquxbl5dsgopumluf9dkxaav` (`exam_id`),
  KEY `FKi37r268vxkhv7ihfw4w4ggt4o` (`student_id`),
  CONSTRAINT `FK4fquxbl5dsgopumluf9dkxaav` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`),
  CONSTRAINT `FKi37r268vxkhv7ihfw4w4ggt4o` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_exams`
--

LOCK TABLES `student_exams` WRITE;
/*!40000 ALTER TABLE `student_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_progress`
--

DROP TABLE IF EXISTS `student_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_progress` (
  `progress_id` int NOT NULL AUTO_INCREMENT,
  `average_score` double DEFAULT NULL,
  `best_score` double DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `total_attempts` int DEFAULT NULL,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`progress_id`),
  KEY `FK679hy9hhha4829swq8efg3u0w` (`student_id`),
  KEY `FKsvw8nw80ku0atgmlxxdcjqjaf` (`subject_id`),
  CONSTRAINT `FK679hy9hhha4829swq8efg3u0w` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKsvw8nw80ku0atgmlxxdcjqjaf` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_progress`
--

LOCK TABLES `student_progress` WRITE;
/*!40000 ALTER TABLE `student_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `category` enum('COLLEGE','JOB','SCHOOL') DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subject_name` varchar(255) NOT NULL,
  PRIMARY KEY (`subject_id`),
  UNIQUE KEY `UK9x44p8j4xvkb6vhaccexngaao` (`subject_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `create_at` date DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `profile_picurl` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `profile_pic_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jawadpasheriya@gmail.com','Jawad','Ali','0000',NULL,_binary '',5555555,'9426261019','2026-02-10','Male',NULL,'','STUDENT',NULL),(2,'jawadpasheriya@gmail.com','Mohammad','Jawad','00000',NULL,_binary '',2000,'9426261019','2026-02-11','Male',NULL,'','STUDENT',NULL),(3,'abcd@gmail.com','aaaaa','bbbbb','00000',NULL,_binary '',1000,'1234567891','2026-02-11','Male',NULL,'','STUDENT',NULL),(4,'mj110@gmail.com','Mohammad','Jawad','00000',NULL,_binary '',2000,'9400050000','2026-02-12','Male',NULL,'','STUDENT',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-13 12:08:35
