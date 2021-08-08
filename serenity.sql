-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 09, 2021 at 12:17 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `serenity`
--

-- --------------------------------------------------------

--
-- Table structure for table `Conversation`
--

CREATE TABLE `Conversation` (
  `id_conv` int(11) NOT NULL,
  `mail1` varchar(50) NOT NULL,
  `mail2` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Conversation`
--

INSERT INTO `Conversation` (`id_conv`, `mail1`, `mail2`) VALUES
(1, 'ala1@gmail.com', 'ala@gmail.com'),
(2, 'ala3@gmail.com', 'ala@gmail.com'),
(3, 'ala@gmail.com', 'ala2@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id_msg` int(11) NOT NULL,
  `id_conv` int(11) NOT NULL,
  `msg` varchar(2000) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id_msg`, `id_conv`, `msg`, `mail`, `date`, `time`) VALUES
(18, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '07:41:19'),
(19, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '07:41:19'),
(20, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '07:41:19'),
(21, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '16:23:34'),
(22, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '16:26:00'),
(23, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '16:29:00'),
(24, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '16:29:00'),
(25, 1, 'saleeeeeeem', 'ala@gmail.com', '2014-08-14', '17:59:25'),
(26, 1, 'sals', 'ala1@gmail.com', '2021-08-06', '17:59:28'),
(27, 1, 'sssss', 'ala@gtari.com', '2021-08-01', '18:05:07'),
(28, 1, 'take my breath', 'ala@gmail.com', '2021-08-07', '18:27:00'),
(29, 1, 'ahla ', 'ala@gmail.com', '2021-08-08', '22:53:00'),
(30, 1, 'jit bch n3addi', 'ala@gmail.com', '2021-08-08', '22:54:00'),
(31, 1, 'ahla2', 'ala@gmail.com', '2021-08-08', '22:56:00'),
(32, 2, 'ahla', 'ala@gmail.com', '2021-08-08', '22:57:00'),
(33, 1, 'ahla manel', 'ala@gmail.com', '2021-08-08', '23:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `mail` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`mail`, `name`, `password`) VALUES
('ala1@gmail.com', 'alagtari', 'ala123'),
('ala2@gmail.com', 'alagtari', 'ala123'),
('ala3@gmail.com', 'alagtari', 'ala123'),
('ala@gmail.com', 'alagtari', 'aaa'),
('ala@gtari.com', 'ala gtari', 'ala123'),
('manel@gmail.com', 'manel belhaj', 'Manelmannoula15@');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Conversation`
--
ALTER TABLE `Conversation`
  ADD PRIMARY KEY (`id_conv`),
  ADD KEY `ck2` (`mail1`),
  ADD KEY `ck6` (`mail2`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id_msg`,`id_conv`) USING BTREE,
  ADD KEY `id_conv` (`id_conv`),
  ADD KEY `ck4` (`mail`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`mail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Conversation`
--
ALTER TABLE `Conversation`
  MODIFY `id_conv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id_msg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Conversation`
--
ALTER TABLE `Conversation`
  ADD CONSTRAINT `ck1` FOREIGN KEY (`mail1`) REFERENCES `user` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ck6` FOREIGN KEY (`mail2`) REFERENCES `user` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `ck3` FOREIGN KEY (`id_conv`) REFERENCES `Conversation` (`id_conv`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ck4` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
