-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 25, 2023 at 08:07 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
(252, 59, 17),
(253, 59, 19),
(254, 60, 19),
(258, 65, 20);

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
(87, 18, 17),
(88, 19, 18),
(89, 19, 17),
(98, 20, 17),
(99, 20, 19),
(100, 20, 20);

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
(17, 'Neel Soni', 'neelnsoni13@gmail.com', '123456'),
(18, 'Kalp Soni', 'kalp@gmail.com', '123456'),
(19, 'Jay Devariya', 'jay@gmail.com', '123456'),
(20, 'Yugansh Soni', 'yugu@gmail.com', '123456');

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
(59, 'Tere Vaste', 'Tere Vaste is currently trending song', 'uploads/videoplayback_e2cfbd1d-e087-4739-9cdb-e019abe0e78f.mp4', 'uploads/download (1)_6e3944c3-7fbd-4b00-9fb3-f28b4ab5e52c.jpeg', 'Neel Soni', 17, '2023-07-24 14:07:50'),
(60, 'Swami Narayan', 'Swami narayan song', 'uploads/Swaminarayan_58a56db8-5b4f-4d2a-b978-2163d4e5b9a4.mp4', 'uploads/download_411d4a13-cff8-4a04-a8eb-99bc8df3bde2.jpeg', 'Kalp Soni', 18, '2023-07-24 14:10:55'),
(61, 'Akhand Bharat', 'Akhand Bharat only one wish', 'uploads/videoplayback1_83efda00-d531-49d5-8e59-22b3f1a725f6.mp4', 'uploads/download_16ba7202-dd27-4d58-a579-7c024851f471.jpeg', 'Jay Devariya', 19, '2023-07-24 14:13:25'),
(65, 'Ram Siya Ram', 'Ram Siya Ram Song with tom and jerry', 'uploads/videoplayback (1)_8f1e30d0-2baa-4719-b0f4-59f7f1b98ec8.mp4', 'uploads/download1_c79a7ae2-7e29-4f56-a2b2-3e12d100756a.jpeg', 'Yugansh Soni', 20, '2023-07-24 15:12:27');

-- --------------------------------------------------------

--
-- Table structure for table `video_tags`
--

CREATE TABLE `video_tags` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `tag` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `video_tags`
--

INSERT INTO `video_tags` (`id`, `video_id`, `tag`) VALUES
(19, 59, 'music'),
(20, 60, 'god'),
(22, 61, 'music'),
(29, 65, 'God'),
(30, 65, 'bharat');

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
-- Indexes for table `video_tags`
--
ALTER TABLE `video_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `video_id` (`video_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `liked`
--
ALTER TABLE `liked`
  MODIFY `lid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT for table `subscriber`
--
ALTER TABLE `subscriber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `video_tags`
--
ALTER TABLE `video_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `liked`
--
ALTER TABLE `liked`
  ADD CONSTRAINT `liked_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `videos` (`id`),
  ADD CONSTRAINT `liked_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`id`);

--
-- Constraints for table `video_tags`
--
ALTER TABLE `video_tags`
  ADD CONSTRAINT `video_tags_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
