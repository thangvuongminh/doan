-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: learning2
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `announcements`
--
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: learning2
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `announcements`
--

CREATE DATABASE IF NOT EXISTS `learning2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `announcement_title` varchar(100) DEFAULT NULL,
  `announcement_content` text,
  `announcement_date` datetime DEFAULT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `answer_id` int NOT NULL AUTO_INCREMENT,
  `answer_text` text,
  `answer_question_id` int DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `answer_question_id` (`answer_question_id`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`answer_question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badges` (
  `badge_id` int NOT NULL AUTO_INCREMENT,
  `badge_name` varchar(50) DEFAULT NULL,
  `badge_description` text,
  PRIMARY KEY (`badge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges`
--

LOCK TABLES `badges` WRITE;
/*!40000 ALTER TABLE `badges` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatgroupmembers`
--

DROP TABLE IF EXISTS `chatgroupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgroupmembers` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `joined_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `chatgroupmembers_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `chatgroups` (`group_id`),
  CONSTRAINT `chatgroupmembers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatgroupmembers`
--

LOCK TABLES `chatgroupmembers` WRITE;
/*!40000 ALTER TABLE `chatgroupmembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatgroupmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatgroups`
--

DROP TABLE IF EXISTS `chatgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgroups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `chatgroups_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatgroups`
--

LOCK TABLES `chatgroups` WRITE;
/*!40000 ALTER TABLE `chatgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatmessages`
--

DROP TABLE IF EXISTS `chatmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatmessages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `message_content` text,
  `sent_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `group_id` (`group_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `chatmessages_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `chatgroups` (`group_id`),
  CONSTRAINT `chatmessages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatmessages`
--

LOCK TABLES `chatmessages` WRITE;
/*!40000 ALTER TABLE `chatmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dailychallenges`
--

DROP TABLE IF EXISTS `dailychallenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dailychallenges` (
  `daily_challenge_id` int NOT NULL AUTO_INCREMENT,
  `daily_challenge_title` varchar(100) DEFAULT NULL,
  `daily_challenge_description` text,
  `daily_challenge_date` date DEFAULT NULL,
  PRIMARY KEY (`daily_challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailychallenges`
--

LOCK TABLES `dailychallenges` WRITE;
/*!40000 ALTER TABLE `dailychallenges` DISABLE KEYS */;
/*!40000 ALTER TABLE `dailychallenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examquestions`
--

DROP TABLE IF EXISTS `examquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examquestions` (
  `exam_question_id` int NOT NULL AUTO_INCREMENT,
  `exam_question_exam_id` int DEFAULT NULL,
  `exam_question_question_id` int DEFAULT NULL,
  PRIMARY KEY (`exam_question_id`),
  KEY `exam_question_exam_id` (`exam_question_exam_id`),
  KEY `exam_question_question_id` (`exam_question_question_id`),
  CONSTRAINT `examquestions_ibfk_1` FOREIGN KEY (`exam_question_exam_id`) REFERENCES `exams` (`exam_id`),
  CONSTRAINT `examquestions_ibfk_2` FOREIGN KEY (`exam_question_question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examquestions`
--

LOCK TABLES `examquestions` WRITE;
/*!40000 ALTER TABLE `examquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `examquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examresults`
--

DROP TABLE IF EXISTS `examresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examresults` (
  `exam_result_id` int NOT NULL AUTO_INCREMENT,
  `exam_result_user_exam_id` int DEFAULT NULL,
  `exam_result_question_id` int DEFAULT NULL,
  `exam_result_selected_answer_id` int DEFAULT NULL,
  PRIMARY KEY (`exam_result_id`),
  KEY `exam_result_user_exam_id` (`exam_result_user_exam_id`),
  KEY `exam_result_question_id` (`exam_result_question_id`),
  KEY `exam_result_selected_answer_id` (`exam_result_selected_answer_id`),
  CONSTRAINT `examresults_ibfk_1` FOREIGN KEY (`exam_result_user_exam_id`) REFERENCES `userexams` (`user_exam_id`),
  CONSTRAINT `examresults_ibfk_2` FOREIGN KEY (`exam_result_question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `examresults_ibfk_3` FOREIGN KEY (`exam_result_selected_answer_id`) REFERENCES `answers` (`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examresults`
--

LOCK TABLES `examresults` WRITE;
/*!40000 ALTER TABLE `examresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `examresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `exam_title` varchar(100) DEFAULT NULL,
  `exam_subject_id` int DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `exam_duration` int DEFAULT NULL,
  `total_marks` int DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `exam_subject_id` (`exam_subject_id`),
  CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`exam_subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritequestions`
--

DROP TABLE IF EXISTS `favoritequestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritequestions` (
  `favorite_question_id` int NOT NULL AUTO_INCREMENT,
  `favorite_question_user_id` int DEFAULT NULL,
  `favorite_question_question_id` int DEFAULT NULL,
  PRIMARY KEY (`favorite_question_id`),
  KEY `favorite_question_user_id` (`favorite_question_user_id`),
  KEY `favorite_question_question_id` (`favorite_question_question_id`),
  CONSTRAINT `favoritequestions_ibfk_1` FOREIGN KEY (`favorite_question_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `favoritequestions_ibfk_2` FOREIGN KEY (`favorite_question_question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritequestions`
--

LOCK TABLES `favoritequestions` WRITE;
/*!40000 ALTER TABLE `favoritequestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritequestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `feedback_user_id` int DEFAULT NULL,
  `feedback_content` text,
  `feedback_date` datetime DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `feedback_user_id` (`feedback_user_id`),
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`feedback_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forumanswers`
--

DROP TABLE IF EXISTS `forumanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forumanswers` (
  `forum_answer_id` int NOT NULL AUTO_INCREMENT,
  `forum_question_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `answer_content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`forum_answer_id`),
  KEY `forum_question_id` (`forum_question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `forumanswers_ibfk_1` FOREIGN KEY (`forum_question_id`) REFERENCES `forumquestions` (`forum_question_id`),
  CONSTRAINT `forumanswers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forumanswers`
--

LOCK TABLES `forumanswers` WRITE;
/*!40000 ALTER TABLE `forumanswers` DISABLE KEYS */;
/*!40000 ALTER TABLE `forumanswers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forumquestions`
--

DROP TABLE IF EXISTS `forumquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forumquestions` (
  `forum_question_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`forum_question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `forumquestions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forumquestions`
--

LOCK TABLES `forumquestions` WRITE;
/*!40000 ALTER TABLE `forumquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `forumquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaderboard`
--

DROP TABLE IF EXISTS `leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaderboard` (
  `leaderboard_id` int NOT NULL AUTO_INCREMENT,
  `leaderboard_user_id` int DEFAULT NULL,
  `leaderboard_score` int DEFAULT NULL,
  `leaderboard_date` date DEFAULT NULL,
  PRIMARY KEY (`leaderboard_id`),
  KEY `leaderboard_user_id` (`leaderboard_user_id`),
  CONSTRAINT `leaderboard_ibfk_1` FOREIGN KEY (`leaderboard_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaderboard`
--

LOCK TABLES `leaderboard` WRITE;
/*!40000 ALTER TABLE `leaderboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaderboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetingparticipants`
--

DROP TABLE IF EXISTS `meetingparticipants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetingparticipants` (
  `participant_id` int NOT NULL AUTO_INCREMENT,
  `meeting_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `joined_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participant_id`),
  KEY `meeting_id` (`meeting_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `meetingparticipants_ibfk_1` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`meeting_id`),
  CONSTRAINT `meetingparticipants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetingparticipants`
--

LOCK TABLES `meetingparticipants` WRITE;
/*!40000 ALTER TABLE `meetingparticipants` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetingparticipants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings` (
  `meeting_id` int NOT NULL AUTO_INCREMENT,
  `host_user_id` int DEFAULT NULL,
  `topic` varchar(200) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `meeting_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`meeting_id`),
  KEY `host_user_id` (`host_user_id`),
  CONSTRAINT `meetings_ibfk_1` FOREIGN KEY (`host_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `note_id` int NOT NULL AUTO_INCREMENT,
  `note_user_id` int DEFAULT NULL,
  `note_content` text,
  `note_create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  KEY `note_user_id` (`note_user_id`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`note_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `payment_user_id` int DEFAULT NULL,
  `payment_amount` decimal(10,2) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `payment_user_id` (`payment_user_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`payment_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practiceresults`
--

DROP TABLE IF EXISTS `practiceresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practiceresults` (
  `practice_result_id` int NOT NULL AUTO_INCREMENT,
  `practice_result_user_practice_id` int DEFAULT NULL,
  `practice_result_question_id` int DEFAULT NULL,
  `practice_result_selected_answer_id` int DEFAULT NULL,
  PRIMARY KEY (`practice_result_id`),
  KEY `practice_result_user_practice_id` (`practice_result_user_practice_id`),
  KEY `practice_result_question_id` (`practice_result_question_id`),
  KEY `practice_result_selected_answer_id` (`practice_result_selected_answer_id`),
  CONSTRAINT `practiceresults_ibfk_1` FOREIGN KEY (`practice_result_user_practice_id`) REFERENCES `userpractices` (`user_practice_id`),
  CONSTRAINT `practiceresults_ibfk_2` FOREIGN KEY (`practice_result_question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `practiceresults_ibfk_3` FOREIGN KEY (`practice_result_selected_answer_id`) REFERENCES `answers` (`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practiceresults`
--

LOCK TABLES `practiceresults` WRITE;
/*!40000 ALTER TABLE `practiceresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `practiceresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practicetestquestions`
--

DROP TABLE IF EXISTS `practicetestquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practicetestquestions` (
  `practice_test_question_id` int NOT NULL AUTO_INCREMENT,
  `practice_test_question_test_id` int DEFAULT NULL,
  `practice_test_question_question_id` int DEFAULT NULL,
  PRIMARY KEY (`practice_test_question_id`),
  KEY `practice_test_question_test_id` (`practice_test_question_test_id`),
  KEY `practice_test_question_question_id` (`practice_test_question_question_id`),
  CONSTRAINT `practicetestquestions_ibfk_1` FOREIGN KEY (`practice_test_question_test_id`) REFERENCES `practicetests` (`practice_test_id`),
  CONSTRAINT `practicetestquestions_ibfk_2` FOREIGN KEY (`practice_test_question_question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practicetestquestions`
--

LOCK TABLES `practicetestquestions` WRITE;
/*!40000 ALTER TABLE `practicetestquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `practicetestquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practicetests`
--

DROP TABLE IF EXISTS `practicetests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practicetests` (
  `practice_test_id` int NOT NULL AUTO_INCREMENT,
  `practice_test_title` varchar(100) DEFAULT NULL,
  `practice_test_subject_id` int DEFAULT NULL,
  `practice_test_duration` int DEFAULT NULL,
  `total_marks` int DEFAULT NULL,
  PRIMARY KEY (`practice_test_id`),
  KEY `practice_test_subject_id` (`practice_test_subject_id`),
  CONSTRAINT `practicetests_ibfk_1` FOREIGN KEY (`practice_test_subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practicetests`
--

LOCK TABLES `practicetests` WRITE;
/*!40000 ALTER TABLE `practicetests` DISABLE KEYS */;
/*!40000 ALTER TABLE `practicetests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progresstracker`
--

DROP TABLE IF EXISTS `progresstracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progresstracker` (
  `progress_tracker_id` int NOT NULL AUTO_INCREMENT,
  `progress_tracker_user_id` int DEFAULT NULL,
  `progress_tracker_topic_id` int DEFAULT NULL,
  `progress_tracker_progress` int DEFAULT NULL,
  PRIMARY KEY (`progress_tracker_id`),
  KEY `progress_tracker_user_id` (`progress_tracker_user_id`),
  KEY `progress_tracker_topic_id` (`progress_tracker_topic_id`),
  CONSTRAINT `progresstracker_ibfk_1` FOREIGN KEY (`progress_tracker_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `progresstracker_ibfk_2` FOREIGN KEY (`progress_tracker_topic_id`) REFERENCES `topics` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progresstracker`
--

LOCK TABLES `progresstracker` WRITE;
/*!40000 ALTER TABLE `progresstracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `progresstracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `question_text` text,
  `question_topic_id` int DEFAULT NULL,
  `question_type_id` int DEFAULT NULL,
  `question_difficulty` int DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `question_topic_id` (`question_topic_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `questiontypes` (`question_type_id`),
  CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`question_topic_id`) REFERENCES `topics` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questiontypes`
--

DROP TABLE IF EXISTS `questiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questiontypes` (
  `question_type_id` int NOT NULL AUTO_INCREMENT,
  `question_type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`question_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questiontypes`
--

LOCK TABLES `questiontypes` WRITE;
/*!40000 ALTER TABLE `questiontypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `questiontypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studymaterials`
--

DROP TABLE IF EXISTS `studymaterials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studymaterials` (
  `study_material_id` int NOT NULL AUTO_INCREMENT,
  `study_material_title` varchar(100) DEFAULT NULL,
  `study_material_content` text,
  `study_material_topic_id` int DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`study_material_id`),
  KEY `study_material_topic_id` (`study_material_topic_id`),
  CONSTRAINT `studymaterials_ibfk_1` FOREIGN KEY (`study_material_topic_id`) REFERENCES `topics` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studymaterials`
--

LOCK TABLES `studymaterials` WRITE;
/*!40000 ALTER TABLE `studymaterials` DISABLE KEYS */;
/*!40000 ALTER TABLE `studymaterials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studysessions`
--

DROP TABLE IF EXISTS `studysessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studysessions` (
  `study_session_id` int NOT NULL AUTO_INCREMENT,
  `study_session_user_id` int DEFAULT NULL,
  `study_session_start_time` datetime DEFAULT NULL,
  `study_session_end_time` datetime DEFAULT NULL,
  `study_session_topic_id` int DEFAULT NULL,
  PRIMARY KEY (`study_session_id`),
  KEY `study_session_topic_id` (`study_session_topic_id`),
  KEY `study_session_user_id` (`study_session_user_id`),
  CONSTRAINT `studysessions_ibfk_1` FOREIGN KEY (`study_session_topic_id`) REFERENCES `topics` (`topic_id`),
  CONSTRAINT `studysessions_ibfk_2` FOREIGN KEY (`study_session_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studysessions`
--

LOCK TABLES `studysessions` WRITE;
/*!40000 ALTER TABLE `studysessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `studysessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjectcategories`
--

DROP TABLE IF EXISTS `subjectcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjectcategories` (
  `subject_category_id` int NOT NULL AUTO_INCREMENT,
  `subject_category_subject_id` int DEFAULT NULL,
  `subject_category_category_id` int DEFAULT NULL,
  PRIMARY KEY (`subject_category_id`),
  KEY `subject_category_subject_id` (`subject_category_subject_id`),
  KEY `subject_category_category_id` (`subject_category_category_id`),
  CONSTRAINT `subjectcategories_ibfk_1` FOREIGN KEY (`subject_category_subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `subjectcategories_ibfk_2` FOREIGN KEY (`subject_category_category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjectcategories`
--

LOCK TABLES `subjectcategories` WRITE;
/*!40000 ALTER TABLE `subjectcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjectcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `subscription_id` int NOT NULL AUTO_INCREMENT,
  `subscription_user_id` int DEFAULT NULL,
  `subscription_start_date` date DEFAULT NULL,
  `subscription_end_date` date DEFAULT NULL,
  `subscription_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  KEY `subscription_user_id` (`subscription_user_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`subscription_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `topic_id` int NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(100) DEFAULT NULL,
  `topic_subject_id` int DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `topic_subject_id` (`topic_subject_id`),
  CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`topic_subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userbadges`
--

DROP TABLE IF EXISTS `userbadges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userbadges` (
  `user_badge_id` int NOT NULL AUTO_INCREMENT,
  `user_badge_user_id` int DEFAULT NULL,
  `user_badge_badge_id` int DEFAULT NULL,
  PRIMARY KEY (`user_badge_id`),
  KEY `user_badge_user_id` (`user_badge_user_id`),
  KEY `user_badge_badge_id` (`user_badge_badge_id`),
  CONSTRAINT `userbadges_ibfk_1` FOREIGN KEY (`user_badge_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `userbadges_ibfk_2` FOREIGN KEY (`user_badge_badge_id`) REFERENCES `badges` (`badge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userbadges`
--

LOCK TABLES `userbadges` WRITE;
/*!40000 ALTER TABLE `userbadges` DISABLE KEYS */;
/*!40000 ALTER TABLE `userbadges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userchallenges`
--

DROP TABLE IF EXISTS `userchallenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userchallenges` (
  `user_challenge_id` int NOT NULL AUTO_INCREMENT,
  `user_challenge_user_id` int DEFAULT NULL,
  `user_challenge_challenge_id` int DEFAULT NULL,
  `user_challenge_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_challenge_id`),
  KEY `user_challenge_user_id` (`user_challenge_user_id`),
  KEY `user_challenge_challenge_id` (`user_challenge_challenge_id`),
  CONSTRAINT `userchallenges_ibfk_1` FOREIGN KEY (`user_challenge_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `userchallenges_ibfk_2` FOREIGN KEY (`user_challenge_challenge_id`) REFERENCES `dailychallenges` (`daily_challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userchallenges`
--

LOCK TABLES `userchallenges` WRITE;
/*!40000 ALTER TABLE `userchallenges` DISABLE KEYS */;
/*!40000 ALTER TABLE `userchallenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userexams`
--

DROP TABLE IF EXISTS `userexams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userexams` (
  `user_exam_id` int NOT NULL AUTO_INCREMENT,
  `user_exam_user_id` int DEFAULT NULL,
  `user_exam_exam_id` int DEFAULT NULL,
  `user_exam_score` int DEFAULT NULL,
  PRIMARY KEY (`user_exam_id`),
  KEY `user_exam_exam_id` (`user_exam_exam_id`),
  KEY `user_exam_user_id` (`user_exam_user_id`),
  CONSTRAINT `userexams_ibfk_1` FOREIGN KEY (`user_exam_exam_id`) REFERENCES `exams` (`exam_id`),
  CONSTRAINT `userexams_ibfk_2` FOREIGN KEY (`user_exam_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userexams`
--

LOCK TABLES `userexams` WRITE;
/*!40000 ALTER TABLE `userexams` DISABLE KEYS */;
/*!40000 ALTER TABLE `userexams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpractices`
--

DROP TABLE IF EXISTS `userpractices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpractices` (
  `user_practice_id` int NOT NULL AUTO_INCREMENT,
  `user_practice_user_id` int DEFAULT NULL,
  `user_practice_test_id` int DEFAULT NULL,
  `user_practice_score` int DEFAULT NULL,
  PRIMARY KEY (`user_practice_id`),
  KEY `user_practice_test_id` (`user_practice_test_id`),
  KEY `user_practice_user_id` (`user_practice_user_id`),
  CONSTRAINT `userpractices_ibfk_1` FOREIGN KEY (`user_practice_test_id`) REFERENCES `practicetests` (`practice_test_id`),
  CONSTRAINT `userpractices_ibfk_2` FOREIGN KEY (`user_practice_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpractices`
--

LOCK TABLES `userpractices` WRITE;
/*!40000 ALTER TABLE `userpractices` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpractices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_role` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2025-09-27 15:34:49

--test

-- -- 1. Thêm sinh viên
-- INSERT INTO users(user_id, user_name, user_email, user_password, user_role)
-- VALUES (1, 'Nguyen Van A', 'vana@example.com', '123456', 'student');

-- -- 2. Thêm môn học
-- INSERT INTO subjects(subject_id, subject_name)
-- VALUES (1, 'Toán học');

-- -- 3. Thêm topic (chủ đề) thuộc môn Toán
-- INSERT INTO topics(topic_id, topic_name, topic_subject_id)
-- VALUES (1, 'Số học cơ bản', 1);

-- -- 4. Thêm loại câu hỏi (multiple choice)
-- INSERT INTO questiontypes(question_type_id, question_type_name)
-- VALUES (1, 'Multiple Choice');

-- -- 5. Thêm đề thi
-- INSERT INTO exams(exam_id, exam_title, exam_subject_id, exam_date, exam_duration, total_marks)
-- VALUES (1, 'Đề kiểm tra Toán số 1', 1, '2025-09-27', 30, 10);

-- -- 6. Thêm câu hỏi
-- INSERT INTO questions(question_id, question_text, question_topic_id, question_type_id, question_difficulty)
-- VALUES
-- (1, '2 + 2 = ?', 1, 1, 1),
-- (2, '5 * 3 = ?', 1, 1, 1);

-- -- 7. Thêm đáp án cho mỗi câu
-- INSERT INTO answers(answer_id, answer_text, answer_question_id, is_correct)
-- VALUES
-- -- Câu 1
-- (1, '3', 1, 0),
-- (2, '4', 1, 1), -- đúng
-- (3, '5', 1, 0),
-- (4, '6', 1, 0),
-- -- Câu 2
-- (5, '15', 2, 1), -- đúng
-- (6, '20', 2, 0),
-- (7, '25', 2, 0),
-- (8, '30', 2, 0);

-- -- 8. Gán câu hỏi vào đề thi
-- INSERT INTO examquestions(exam_question_id, exam_question_exam_id, exam_question_question_id)
-- VALUES
-- (1, 1, 1),
-- (2, 1, 2);