-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 01, 2021 at 08:48 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booki`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CHECK_EMAIL` (IN `_email` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
    DECLARE result BOOLEAN;
    IF(EXISTS(
        SELECT uid
        FROM `user`
        WHERE email= _email
    )) THEN
        SET result = FALSE;
    ELSE 
        SET result = TRUE;
    END IF;
    SELECT result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CHECK_PHONE` (IN `_phone` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
    DECLARE result BOOLEAN;
    IF(EXISTS(
        SELECT uid
        FROM `user`
        WHERE phone =_phone
    )) THEN
        SET result = FALSE;
    ELSE 
        SET result = TRUE;
    END IF;
    SELECT result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_USER` (IN `uname` VARCHAR(15), IN `psswd` VARCHAR(30), IN `name` VARCHAR(50), IN `phone` VARCHAR(10), IN `email` TEXT)  BEGIN
    INSERT INTO `user`(username, password, name, phone, email, role)
    VALUES (uname, PASSWORD(psswd), name, phone, email, 'customer');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_USERS` ()  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_ID` (IN `id` INT)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE uid = id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_USN` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE username = usn; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_INFO` (IN `uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `psswd` VARCHAR(30), IN `_name` VARCHAR(50) COLLATE utf8mb4_unicode_ci, IN `_phone` VARCHAR(10) COLLATE utf8mb4_unicode_ci, IN `_email` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
    UPDATE `user`
    SET
    	password = PASSWORD(psswd),
        name = _name,
        phone = _phone,
        email = _email
    WHERE
    	username = uname;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VALIDATE_LOGIN` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `psswd` VARCHAR(30) COLLATE utf8mb4_unicode_ci, IN `_role` VARCHAR(9) COLLATE utf8mb4_unicode_ci)  BEGIN
	
	DECLARE id INT;
    IF(EXISTS(
        SELECT uid FROM `user` 
        WHERE 
        	username = usn
        	AND password = PASSWORD(psswd)
        	AND role = _role
    )) THEN
    	SET id = (SELECT uid FROM `user` WHERE username=usn);
    ELSE
    	SET id = -1;
        SET usn = '-1';
        SET _role = '-1';
        
    END IF;
    SELECT id as uid, usn as username, _role as role;       
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `bid` int(11) NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `username`, `password`, `name`, `phone`, `email`, `role`, `active`) VALUES
(1, 'hoanduy', '*3060F61EB5671C11A3605E847AF27763E555374A', 'Nguyễn Trần Hoàn Duy', '0378927810', 'duy@gmail.com', 'customer', 1),
(8, 'hieule', '*8C869A400A96A09D7483D88A490701C56D474BF1', 'Hiếu Đẹp Trai', '0969969696', 'hieulengoc@outlook.com', 'customer', 1),
(9, 'longpham', '*F55C3F419C97BDEEBAD764C2DFF8BE3B4990D9CE', 'Long Pham', '0378823356', 'longpham@gmail.com', 'customer', 1),
(10, 'dungmeo', '*FFCB7EF476F95690D1FFB871DEA274343CD9C284', 'Dũng Đình Rumble', '0345123456', 'dungdinh@gmail.com', 'customer', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`rid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `uid` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
