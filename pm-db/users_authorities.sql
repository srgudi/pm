-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 31, 2011 at 06:48 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `chiguru2`
--

-- --------------------------------------------------------

--
-- Table structure for table `authorities`
--

CREATE TABLE IF NOT EXISTS `authorities` (
  `username` varchar(255) NOT NULL,
  `authority` varchar(255) NOT NULL,
  `CREATED_BY` varchar(50) NOT NULL,
  `CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) NOT NULL,
  `UPDATED_DATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `index ix_auth_username` (`username`,`authority`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authorities`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `party_relationship_id` int(11) NOT NULL,
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
  `UPDATED_DATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `username` (`username`),
  KEY `username_2` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



insert into `users`(`username`,`password`,`enabled`,`party_relationship_id`,`CREATED_BY`,`CREATED_DATE`,`UPDATED_BY`,`UPDATED_DATE`) values ('admin@firm.com','admin',1,5,'','0001-01-01 00:00:00','','0001-01-01 00:00:00');
insert into `users`(`username`,`password`,`enabled`,`party_relationship_id`,`CREATED_BY`,`CREATED_DATE`,`UPDATED_BY`,`UPDATED_DATE`) values ('guest','admin',1,0,'','0001-01-01 00:00:00','','0001-01-01 00:00:00');
insert into `users`(`username`,`password`,`enabled`,`party_relationship_id`,`CREATED_BY`,`CREATED_DATE`,`UPDATED_BY`,`UPDATED_DATE`) values ('vishnu_sharma@yahoo.com','password',1,138,'system','2011-01-31 00:00:00','system','2011-01-31 00:00:00');
insert into `users`(`username`,`password`,`enabled`,`party_relationship_id`,`CREATED_BY`,`CREATED_DATE`,`UPDATED_BY`,`UPDATED_DATE`) values ('krishna@iscon.com','password',1,140,'system','2011-01-31 00:00:00','system','2011-01-31 00:00:00');


insert into `authorities`(`username`,`authority`) values ('admin@firm.com','ROLE_PARTY');
insert into `authorities`(`username`,`authority`) values ('admin@firm.com','ROLE_STAFF');
insert into `authorities`(`username`,`authority`) values ('guest','ROLE_USER');
insert into `authorities`(`username`,`authority`) values ('james@chase.com','ROLE_STAFF');


