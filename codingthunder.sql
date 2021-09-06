-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2021 at 01:29 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `name` text NOT NULL,
  `sno` bigint(20) UNSIGNED NOT NULL,
  `ph_num` int(20) NOT NULL,
  `mes` text NOT NULL,
  `email` varchar(20) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`name`, `sno`, `ph_num`, `mes`, `email`, `date`) VALUES
('Devansh Pratap Singh', 1, 0, '', '', '2021-08-26'),
('Devansh Pratap Singh', 2, 0, '', '', '2021-08-26'),
('Devansh Pratap Singh', 3, 0, '', '', '2021-08-26'),
('', 4, 0, '', '', '2021-08-26'),
('Devansh Pratap Singh', 5, 0, '', '', '2021-08-26'),
('Devansh Pratap Singh', 6, 2147483647, 'sdfghj', 'devanshsingh134@gmai', '2021-08-26'),
('Devansh Pratap Singh', 7, 2147483647, 'hjk', 'devanshsingh134@gmai', '2021-08-26'),
('shivansh', 8, 1234567890, 'hello guys\r\n', 'shivansh@gmail.com', '2021-08-27'),
('Devansh Pratap Singh', 9, 2147483647, 'hello i am nishad', 'nishadansh47@gmail.c', '2021-08-27'),
('Devansh Pratap Singh', 10, 2147483647, 'hello i am nishad', 'nishadansh47@gmail.c', '2021-08-27'),
('Devansh Pratap Singh', 11, 2147483647, 'hello i am devansh', 'devanshsingh134@gmai', '2021-08-27'),
('Devansh Pratap Singh', 12, 2147483647, 'm hvgf', 'devanshsingh134@gmai', '2021-08-27'),
('Devansh Pratap Singh', 13, 2147483647, 'ASDF', 'devanshsingh134@gmai', '2021-08-27'),
('nishad ', 14, 2147483647, 'ASDFGHJKL;', 'nishad47@gmail.com', '2021-08-27'),
('Devansh Pratap Singh', 15, 2147483647, 'lesson', 'devanshsingh134@gmai', '2021-08-27'),
('', 16, 0, '', '', '2021-08-29');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` bigint(20) UNSIGNED NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `sub` text NOT NULL,
  `img_file` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `sub`, `img_file`) VALUES
(1, 'this is my first blog post', 'first-blog-post', 'this is my first post i am very excited for my blog, sdgsudgudg', '2021-09-04', 'first blog sjbjsbjs', 'post-bg.jpg'),
(3, 'Second Blog Post ', 'testing-1', 'Notes can be used to notify the user about something special: danger, success, information or warning', '2021-09-06', 'hey there i am just testing.', 'post-bg.jpg'),
(4, 'third blog post', 'testing-2', 'Notes can be used to notify the user about something special: danger, success, information or warning', '2021-09-06', 'hey there i am just testing.', 'post-bg.jpg'),
(10, 'hey', 'testing-3', 'Pagination is typically where you have navigation that links to multiple pages within a series. For example, search results that return many pages will have pagination that enables the user to navigate to the next page or even jump forward several pages.', '2021-09-06', 'devansh pratap singh', 'hey.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD UNIQUE KEY `sno` (`sno`),
  ADD UNIQUE KEY `sno_2` (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD UNIQUE KEY `sno` (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
