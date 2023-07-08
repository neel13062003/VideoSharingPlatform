-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2023 at 12:14 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `youtube`
--

-- --------------------------------------------------------

--
-- Table structure for table `liked`
--

CREATE TABLE `liked` (
  `lid` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `liked`
--

INSERT INTO `liked` (`lid`, `pid`, `uid`) VALUES
(233, 51, 9),
(234, 52, 9),
(236, 50, 9),
(237, 53, 12),
(238, 54, 5),
(239, 53, 5),
(241, 54, 9);

-- --------------------------------------------------------

--
-- Table structure for table `subscriber`
--

CREATE TABLE `subscriber` (
  `id` int(11) NOT NULL,
  `uid` int(15) NOT NULL,
  `channel_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriber`
--

INSERT INTO `subscriber` (`id`, `uid`, `channel_id`) VALUES
(54, 9, 9),
(55, 9, 5),
(58, 5, 10),
(59, 5, 5),
(61, 5, 9),
(62, 11, 5),
(63, 11, 10),
(64, 11, 9),
(65, 12, 11),
(66, 12, 12),
(67, 11, 12),
(68, 5, 12),
(69, 5, 11),
(70, 9, 11),
(71, 9, 12);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(5, 'Neel Soni', 'neelnsoni13@gmail.com', '123456'),
(8, 'Kalp Soni', 'kalpsoni10@gmail.com', '123456'),
(9, 'Ayushi Gusani', 'ayu@gmail.com', '123456'),
(10, 'Mansi Jay', 'mansi@gmail.com', '123456'),
(11, 'Jinansh Soni', 'jinu@gmail.com', '123456'),
(12, 'Yugu Soni', 'yugu@gmail.com', '1111');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `video_url` varchar(255) NOT NULL,
  `thumbnail_url` varchar(255) NOT NULL,
  `owner` varchar(25) NOT NULL,
  `ownerid` int(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `title`, `description`, `video_url`, `thumbnail_url`, `owner`, `ownerid`, `created_at`) VALUES
(50, 'Osho Motivational Video', 'Osho\'s video understanding level is unbelievable', 'uploads/status osho_578e58ca-1cd7-4540-829b-74a6427dda0e.mp4', 'uploads/oshio_30450686-aacd-402d-885d-13e4c48bc16a.jpg', 'Neel Soni', 5, '2023-05-17 08:50:23'),
(51, 'Osho Life Learning Lesson', 'Osho will give you different level of Understanding of Living', 'uploads/y2mate.com - Osho whatsapp status  à¤® à¤ªà¤°à¤® à¤¹_1080p_57a6047c-ddc6-4f40-bd5c-441a960519cb.mp4', 'uploads/1_d0c6a503-bab1-44f1-8617-aa98c7b27da0.jpg', 'Mansi Jay', 10, '2023-05-17 08:53:33'),
(52, 'Osho Inspirational Video', 'Osho Motivational Video', 'uploads/Vi_0d7e9912-8ecd-4528-aa24-c915a8e965ed.mp4', 'uploads/images_269a7e1a-c100-4259-9ab7-d70618baf551.jpg', 'Ayushi Gusani', 9, '2023-05-17 08:56:58'),
(53, 'Krishana Video', 'Pls like my video', 'uploads/abc_59b38891-3862-42da-af2e-024c55e073a0.mp4', 'uploads/download_081117db-f3ae-4532-9647-dde8f5068150.jpg', 'Jinansh Soni', 11, '2023-05-17 10:05:48'),
(54, 'Ganesh Bhagawan', 'Pls Like My Video & Subsciber My Channel', 'uploads/abcd_130db0c6-a093-4963-b447-5a37cf7b51b4.mp4', 'uploads/images (1)_08fac2a4-d8cb-4dce-a58b-8c143a07bc9a.jpg', 'Yugu Soni', 12, '2023-05-17 10:09:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `liked`
--
ALTER TABLE `liked`
  ADD PRIMARY KEY (`lid`),
  ADD KEY `pid` (`pid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `subscriber`
--
ALTER TABLE `subscriber`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `liked`
--
ALTER TABLE `liked`
  MODIFY `lid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `subscriber`
--
ALTER TABLE `subscriber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `liked`
--
ALTER TABLE `liked`
  ADD CONSTRAINT `liked_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `videos` (`id`),
  ADD CONSTRAINT `liked_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
