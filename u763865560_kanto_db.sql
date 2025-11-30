-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 30, 2025 at 10:16 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u763865560_kanto_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `content`, `is_active`, `created_at`) VALUES
(1, 'Our Schedule!', '<p><strong>December 20 to 23</strong><br>Open 8:00am - 7:00pm</p><p><strong>December 24</strong><br>Open 7:00am - 7:00pm</p><p><strong>December 25</strong><br>Closed. Merry Christmas!</p>', 1, '2025-11-14 03:03:51'),
(2, 'Our Schedule!', 'HIIIIII', 0, '2025-11-14 03:13:39'),
(3, 'Jeremiah', 'KALBO PO KAYO LAHAT', 0, '2025-11-14 03:14:28'),
(4, 'It\'s Ber Months!', 'Happy Ber Months!', 0, '2025-11-14 03:55:07'),
(5, 'New Announcement!', 'Libre pag kalbo ang gupit!!!', 0, '2025-11-14 03:57:24'),
(6, 'NewAnnouncement!', 'Libre pag kalbo ang gupit!!!', 0, '2025-11-14 04:03:21'),
(7, 'New Announcement!', 'Libre pag kalbo ang gupit!!!', 0, '2025-11-14 04:04:15'),
(8, 'Announcement!', 'Libre pag kalbo ang gupit!!!', 0, '2025-11-14 05:47:31'),
(9, 'Announcement!', 'libre', 0, '2025-11-14 07:42:42');

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `style` varchar(100) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `quote` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `style`, `bio`, `quote`, `image_path`, `created_at`) VALUES
(5, 'Jonet Carpio', 'Abstract Expressionism', '...', 'Once a better gunner, always a better gunner.', '1764488831_artist_cb2395974cf0735694f5c6a632729a9e.jpg', '2025-11-30 06:55:44'),
(6, 'Jun Talanay', 'Figurative Expressionism', '...', 'My heart and Sword is always on painting.', '1764488841_artist_27ac0410cded79b505228f996647a039.jpg', '2025-11-30 07:07:25'),
(7, 'Ramcos Nulud', 'Digital Expressionism', '...', 'We as man must have aesthetic in our hearts.', '1764488855_artist_a6da879e9d12fec1893cbad0cae39998.jpg', '2025-11-30 07:19:52'),
(8, 'Melvin Culaba', 'Figurative Expressionism', '...', 'Death is like a wind, always by my side.', '1764488981_artist_47faf1724e7060b91d3fa0f956a2f723.jpg', '2025-11-30 07:49:41'),
(10, 'Honesto Guirella III', 'Sculpture Master', '...', 'Everything you mold will be as unique as you.', '1764489491_artist_cdc3a3ab0e9660e72f5173089b10e9e8.jpg', '2025-11-30 07:58:11');

-- --------------------------------------------------------

--
-- Table structure for table `artist_likes`
--

CREATE TABLE `artist_likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artist_likes`
--

INSERT INTO `artist_likes` (`id`, `user_id`, `artist_id`, `created_at`) VALUES
(2, 1, 1, '2025-11-29 08:41:20'),
(3, 1, 2, '2025-11-29 11:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `artworks`
--

CREATE TABLE `artworks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `artist` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `status` enum('Available','Reserved','Sold') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artworks`
--

INSERT INTO `artworks` (`id`, `title`, `artist`, `description`, `price`, `image_path`, `status`, `created_at`) VALUES
(10, 'Whispers Beneath the Water', 'Jonet Carpio', '...', 100000.00, '1764485875_img-11.jpg', 'Available', '2025-11-30 06:57:55'),
(11, 'Eyes of the Cosmos', 'Jonet Carpio', '...', 2000000.00, '1764485926_img-21.jpg', 'Available', '2025-11-30 06:58:46'),
(12, 'Celestial Echoes of a Fragmented Mind', 'Jonet Carpio', '...', 70000.00, '1764485995_img-22.jpg', 'Available', '2025-11-30 06:59:55'),
(13, 'Luminous Echo', 'Jonet Carpio', '...', 70000.00, '1764486054_img-14.jpg', 'Available', '2025-11-30 07:00:54'),
(14, '\"Four Ps\" Series 4', 'Melvin Culaba', '...', 17000.00, '1764486259_590223575_122111043405057268_527086352923694948_n.jpg', 'Available', '2025-11-30 07:04:19'),
(15, '\"Four Ps\" Series 3', 'Melvin Culaba', '...', 17000.00, '1764486289_590223575_122111043405057268_527086352923694948_n.jpg', 'Available', '2025-11-30 07:04:31'),
(16, '\"Four Ps\" Series 2', 'Melvin Culaba', '...', 17000.00, '1764486315_590223575_122111043405057268_527086352923694948_n.jpg', 'Available', '2025-11-30 07:05:15'),
(17, '\"Four Ps\" Series 1', 'Melvin Culaba', '...', 17000.00, '1764486332_590223575_122111043405057268_527086352923694948_n.jpg', 'Available', '2025-11-30 07:05:32'),
(18, 'V5', 'Jun Talanay', '...', 35000.00, '1764486562_img-12.jpg', 'Available', '2025-11-30 07:09:22'),
(19, 'DIAMOS', 'Jun Talanay', '...', 35000.00, '1764486737_1.jpg', 'Available', '2025-11-30 07:12:17'),
(20, 'MAZ-Z', 'Jun Talanay', '...', 35000.00, '1764486775_257c5e6bfbaddd78f8620439653a7928.jpg', 'Available', '2025-11-30 07:12:55'),
(21, 'KOTA NA (SURBATERO)', 'Jun Talanay', '...', 15000.00, '1764486870_img-13.jpg', 'Available', '2025-11-30 07:14:30'),
(22, 'SWAG (KAWS)', 'Jun Talanay', '', 500000.00, '1764486915_c30d62b0b698af7d3399086864049e31.jpg', 'Available', '2025-11-30 07:15:15'),
(23, 'Flower Girl', 'Ramcos Nulud', '...', 110000.00, '1764487236_d29fab3aa48256fb36db86d42d8a2c6e.jpg', 'Available', '2025-11-30 07:20:36'),
(24, 'Monkey', 'Ramcos Nulud', '...', 100000.00, '1764487262_5887e846d8508190dae27e21fccc4b86.jpg', 'Available', '2025-11-30 07:21:02'),
(25, 'Blossom', 'Ramcos Nulud', '...', 200000.00, '1764487302_39c275e72d35758bbdec44eb2513b064.jpg', 'Available', '2025-11-30 07:21:42'),
(26, 'Maskara', 'Ramcos Nulud', '...', 80000.00, '1764487328_29b6784201a2debb1e26c00abe24587d.jpg', 'Available', '2025-11-30 07:22:08'),
(27, 'Samurai III', 'Ramcos Nulud', '...', 220000.00, '1764487350_c492e89c5cdf25dc1577a9b8aed02c4a.jpg', 'Available', '2025-11-30 07:22:30'),
(29, 'ESTUDYANTE CLUES', 'Honesto Guirella III', '...', 60000.00, '1764489564_c9d939069163ea19d276a17cae66477f.jpg', 'Available', '2025-11-30 07:59:24'),
(30, 'BLACK MANILA', 'Honesto Guirella III', '...', 100000.00, '1764489589_3d7a8d43a5b1c31308306bc03f9fb76d.jpg', 'Available', '2025-11-30 07:59:49');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artwork_id` int(11) DEFAULT NULL,
  `service` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(100) DEFAULT NULL,
  `vehicle_model` varchar(100) DEFAULT NULL,
  `preferred_date` date DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `special_requests` text DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `is_rated` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `artwork_id`, `service`, `vehicle_type`, `vehicle_model`, `preferred_date`, `full_name`, `phone_number`, `special_requests`, `status`, `created_at`, `deleted_at`, `is_rated`) VALUES
(52, 7, NULL, 'full paint job', 'sendan', '2010', '2025-11-08', 'jem', '09999999999', 'full', 'approved', '2025-10-01 15:28:00', '2025-11-17 22:03:47', 0),
(53, 7, NULL, 'retouch', 'sendan', '2', '2025-10-14', 'adasdasd', '1', 'wqe', 'approved', '2025-10-12 03:16:58', '2025-11-17 22:09:06', 0),
(54, 7, NULL, 'jjjj', 'sendan', '1', '2025-10-13', 'wqe', '09342423424', 'we', 'completed', '2025-10-12 03:21:57', NULL, 0),
(56, 33, NULL, 'kalbo', '1:30 PM', '', '2025-11-14', 'Unknown User', '', 'thank you\r\n', 'rejected', '2025-11-14 01:52:37', '2025-11-17 22:09:14', 0),
(57, 34, NULL, 'SEMI kalbo', '2:00 PM', '', '2025-11-14', 'Kanto', '', 'Burst facde', '', '2025-11-14 03:30:29', NULL, 0),
(58, 34, NULL, 'KAllllllbo', '10:30 AM', '', '2025-11-14', 'Kanto', '', 'Thank you', 'approved', '2025-11-14 03:31:54', '2025-11-17 22:03:49', 0),
(59, 34, NULL, '', '', '', '2025-11-14', 'Kanto', '', '', 'approved', '2025-11-14 03:42:51', '2025-11-17 22:09:13', 0),
(60, 34, NULL, '', '', '', '2025-11-14', 'Kanto', '', '', 'approved', '2025-11-14 03:43:06', '2025-11-17 22:09:11', 0),
(61, 34, NULL, '', '', '', '2025-11-14', 'Kanto', '', '', 'approved', '2025-11-14 03:43:12', '2025-11-17 22:09:09', 0),
(62, 34, NULL, '', '', '', '2025-11-14', 'Kanto', '', '', 'rejected', '2025-11-14 03:43:19', '2025-11-14 15:00:04', 0),
(63, 36, NULL, 'SEMI kalbo', '10:00 AM', '', '2025-11-19', 'Jem', '', 'aojsdasdsa', 'rejected', '2025-11-19 03:48:44', NULL, 0),
(64, 1, NULL, 'Girl with a Pearl Earring', '', '', '2025-11-30', 'Vincent paul Pena', '09334257317', 'I want this \r\n', '', '2025-11-29 03:58:29', NULL, 0),
(65, 1, NULL, '', '', '', '2025-12-05', '', '', '', 'approved', '2025-11-29 04:02:28', NULL, 0),
(66, 1, NULL, 'Girl with a Pearl Earring', '', '', '2025-11-30', 'Vincent paul Pena', '09334257317', 'selkjtredfghjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg', '', '2025-11-29 04:03:11', NULL, 0),
(67, 1, NULL, 'Girl with a Pearl Earring', '', '', '2025-12-01', 'Vincent paul Pena', '09334257317', 'thank you', '', '2025-11-29 05:02:55', NULL, 0),
(68, 1, NULL, 'meee', '', '', '2025-11-30', 'Vincent paul Pena', '09334257317', 'geee', '', '2025-11-29 05:18:03', NULL, 0),
(69, 1, NULL, '', '', '', '2025-12-01', '', '', '', '', '2025-11-29 05:23:30', NULL, 0),
(70, 1, NULL, '', '', '', '2025-12-04', '', '', '', '', '2025-11-29 07:41:36', NULL, 0),
(71, 1, NULL, 'meee', '', '', '2025-11-30', 'Vincent paul Pena', '09334257317', 'thank you ', '', '2025-11-29 07:48:48', '2025-11-30 05:44:44', 0),
(72, 1, NULL, 'meee', '', '', '2025-11-29', 'Vincent paul Pena', '09334257317', 'geee', 'approved', '2025-11-29 07:50:51', '2025-11-29 18:13:34', 0),
(73, 40, 7, 'Starryyy', '', '', '2025-12-06', '', '', '', 'approved', '2025-11-29 14:49:49', NULL, 0),
(74, 1, 7, 'Starryyy', '', '', '2025-11-30', 'VIncent paul Pena', '09334257317', 'hjiopojh', 'approved', '2025-11-29 15:38:37', NULL, 0),
(75, 1, 30, 'BLACK MANILA', '', '', '2025-11-30', 'VIncent paul ', '09334257317', 'wertghyjkl', 'completed', '2025-11-30 10:04:11', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` varchar(50) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `event_date`, `event_time`, `location`, `created_at`) VALUES
(2, 'Modern Abstract Night', '2025-12-10', '10:00 PM', 'Main Gallery Hall', '2025-11-30 06:33:58');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `image_path`, `description`, `uploaded_at`) VALUES
(39, 'uploads/1753622886_Media (8).jpg', 'Door Trunk Refinishing', '2025-07-27 13:28:06'),
(40, 'uploads/1753622891_Media (9).jpg', 'Side Bumper Restoring', '2025-07-27 13:28:11'),
(41, 'uploads/1753622896_Media (10).jpg', 'Bumper  Restoring', '2025-07-27 13:28:16'),
(42, 'uploads/1753622901_Media (11).jpg', 'Full Paint Job', '2025-07-27 13:28:21'),
(43, 'uploads/1753622906_Media (12).jpg', 'Refinishing', '2025-07-27 13:28:26'),
(44, 'uploads/1753622912_Media (13).jpg', 'Touching up and Mags Refinishing', '2025-07-27 13:28:32'),
(45, 'uploads/1753622916_Media (14).jpg', 'Full Paint Job', '2025-07-27 13:28:37'),
(46, 'uploads/1753622922_Media (15).jpg', 'Fairings Refinishing', '2025-07-27 13:28:42'),
(47, 'uploads/1753622926_Media (16).jpg', 'Hood  Restoring', '2025-07-27 13:28:46'),
(48, 'uploads/1753622931_Media (17).jpg', 'Bumper Restoring', '2025-07-27 13:28:51'),
(65, 'uploads/1753622871_Media (7).jpg', 'Side Bumper Restoring', '2025-10-14 12:49:48'),
(66, 'uploads/1753622866_Media (6).jpg', 'Changing Color Refinishing', '2025-11-14 07:01:21');

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` enum('unread','read','replied') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`id`, `username`, `email`, `mobile`, `subject`, `message`, `attachment`, `status`, `created_at`, `deleted_at`) VALUES
(68, 'jem', 'jem@gmail.com', '', '', 'dasdsadasd', NULL, 'read', '2025-10-14 12:32:40', NULL),
(70, 'Guest', 'example@gmail.com', '29343934234', '', 'cjeicijdckcdndi', NULL, 'read', '2025-11-27 19:11:30', NULL),
(71, 'Guest', 'example@gmail.com', '29343934234', '', 'cjeicijdckcdndi', NULL, 'read', '2025-11-27 19:11:35', NULL),
(76, 'Keycm', 'keycm109@gmail.com', '29343934234', '', 'Hello, I am interested in requesting a copy or similar commission of the artwork: &quot;Girl with a Pearl Earring&quot;. Please contact me with details.', NULL, 'unread', '2025-11-29 08:53:33', NULL),
(77, 'Keycm', 'keycm109@gmail.com', '29343934234', '', 'Hello, I am interested in requesting a copy or similar commission of the artwork: &quot;Girl with a Pearl Earring&quot;. Please contact me with details.', NULL, 'read', '2025-11-29 08:53:40', NULL),
(92, 'Isaac Jed Macaraeg', 'isaacjedm@gmail.com', '09942170085', '', 'I want to reserve a painting', NULL, 'read', '2025-11-29 14:52:38', NULL),
(94, 'Guest', 'keycm109@gmail.com', '09334257317', '', 'sdfghjk', NULL, 'read', '2025-11-29 15:37:37', NULL),
(95, 'Isaac Jed Macaraeg', 'isaacjedm@gmail.com', '09942170085', '', 'I want to reserve a painting', NULL, 'read', '2025-11-29 16:21:28', NULL),
(96, 'Jermin', 'jerminmercado1@gmail.com', '', '', 'cabyou give nme the', NULL, 'read', '2025-10-12 05:43:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `is_read`, `created_at`) VALUES
(39, 1, 'Your booking has been approved.', 1, '2025-11-29 04:01:59'),
(40, 1, 'Your booking has been approved.', 1, '2025-11-29 04:10:50'),
(41, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 04:10:55'),
(42, 1, 'Your booking has been approved.', 1, '2025-11-29 05:03:05'),
(43, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 05:03:07'),
(44, 1, 'Your booking has been approved.', 1, '2025-11-29 05:18:25'),
(45, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 05:18:53'),
(46, 1, 'Your booking has been approved.', 1, '2025-11-29 05:23:38'),
(47, 1, 'Your booking has been approved.', 1, '2025-11-29 07:41:42'),
(48, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 07:41:57'),
(52, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 10:26:11'),
(53, 1, 'Your booking has been marked as completed. Thank you!', 1, '2025-11-29 10:30:11'),
(55, 1, 'Your booking has been approved. Please check your email for collection details.', 1, '2025-11-29 15:58:54'),
(56, 40, 'Your booking has been approved. Please check your email for collection details.', 1, '2025-11-29 16:02:11'),
(57, 1, 'Your booking has been approved. Please check your email for collection details.', 1, '2025-11-30 05:46:00'),
(58, 1, 'Your booking has been approved. Please check your email for collection details.', 0, '2025-11-30 10:04:24'),
(59, 1, 'Your booking has been marked as completed. Thank you!', 0, '2025-11-30 10:04:29');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `price`, `duration`, `image`) VALUES
(35, 'Art Appraisal', 'Art appraisal is the process of checking an artwork to find out how much it is worth. An appraiser looks at the artist, the artwork’s condition, its history, and current market prices to give a fair value.', 20000000.00, '2 Hours', '1764491275_779350aab55e1428a8c9c8b825aa5083.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `trash_bin`
--

CREATE TABLE `trash_bin` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `source` enum('bookings','services','gallery','inquiries') NOT NULL,
  `deleted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trash_bin`
--

INSERT INTO `trash_bin` (`id`, `item_id`, `item_name`, `source`, `deleted_at`) VALUES
(141, 62, 'Kanto|{\"service_name\":\"\",\"vehicle_type\":\"\",\"vehicle_model\":\"\",\"full_name\":\"Kanto\",\"phone\":\"\",\"special_request\":\"\",\"username\":\"Kanto\",\"email\":\"keycm109@gmail.com\"}', 'bookings', '2025-11-14 15:00:04'),
(142, 8, 'Spot Repair|{\"description\":\"Professional touch-up for scratches, dings, and small damaged areas to restore your car\'s finish.\",\"price\":\"3000.00\",\"duration\":\"1-2 Days\",\"image\":\"Media (7).jpg\"}', 'services', '2025-11-14 15:00:21'),
(143, 52, 'jem|{\"service_name\":\"full paint job\",\"vehicle_type\":\"sendan\",\"vehicle_model\":\"2010\",\"full_name\":\"jem\",\"phone\":\"09999999999\",\"special_request\":\"full\",\"username\":\"\",\"email\":\"\"}', 'bookings', '2025-11-17 22:03:46'),
(144, 58, 'Kanto|{\"service_name\":\"KAllllllbo\",\"vehicle_type\":\"10:30 AM\",\"vehicle_model\":\"\",\"full_name\":\"Kanto\",\"phone\":\"\",\"special_request\":\"Thank you\",\"username\":\"Kanto\",\"email\":\"keycm109@gmail.com\"}', 'bookings', '2025-11-17 22:03:49'),
(145, 53, 'adasdasd|{\"service_name\":\"retouch\",\"vehicle_type\":\"sendan\",\"vehicle_model\":\"2\",\"full_name\":\"adasdasd\",\"phone\":\"1\",\"special_request\":\"wqe\",\"username\":\"\",\"email\":\"\"}', 'bookings', '2025-11-17 22:09:06'),
(146, 61, 'Kanto|{\"service_name\":\"\",\"vehicle_type\":\"\",\"vehicle_model\":\"\",\"full_name\":\"Kanto\",\"phone\":\"\",\"special_request\":\"\",\"username\":\"Kanto\",\"email\":\"keycm109@gmail.com\"}', 'bookings', '2025-11-17 22:09:09'),
(147, 60, 'Kanto|{\"service_name\":\"\",\"vehicle_type\":\"\",\"vehicle_model\":\"\",\"full_name\":\"Kanto\",\"phone\":\"\",\"special_request\":\"\",\"username\":\"Kanto\",\"email\":\"keycm109@gmail.com\"}', 'bookings', '2025-11-17 22:09:11'),
(148, 59, 'Kanto|{\"service_name\":\"\",\"vehicle_type\":\"\",\"vehicle_model\":\"\",\"full_name\":\"Kanto\",\"phone\":\"\",\"special_request\":\"\",\"username\":\"Kanto\",\"email\":\"keycm109@gmail.com\"}', 'bookings', '2025-11-17 22:09:13'),
(149, 56, 'Unknown User|{\"service_name\":\"kalbo\",\"vehicle_type\":\"1:30 PM\",\"vehicle_model\":\"\",\"full_name\":\"Unknown User\",\"phone\":\"\",\"special_request\":\"thank you\\r\\n\",\"username\":\"\",\"email\":\"\"}', 'bookings', '2025-11-17 22:09:14'),
(152, 34, 'trizone|{\"description\":\"werty\",\"price\":\"12.00\",\"duration\":\"20\",\"image\":\"1764360366_img-10.jpg\"}', 'services', '2025-11-29 04:13:49'),
(153, 7, 'Full Face Job|{\"description\":\"Complete transformation of your vehicle\'s appearance with our premium paint solutions.\",\"price\":\"4000.00\",\"duration\":\"2-3 Days\",\"image\":\"Media (11).jpg\"}', 'services', '2025-11-29 04:16:40'),
(172, 6, 'NIGHT NIHTT|{\"id\":\"6\",\"title\":\"NIGHT NIHTT\",\"artist\":\"trizone\",\"description\":\"dfghjk\",\"price\":\"160.00\",\"image_path\":\"1764404934_img-10.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-29 10:06:48\"}', '', '2025-11-29 12:53:13'),
(173, 4, 'meee|{\"id\":\"4\",\"title\":\"meee\",\"artist\":\"Johannes Vermeer\",\"description\":\"sdf\",\"price\":\"120.00\",\"image_path\":\"1764393448_img-21.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-29 05:17:28\"}', '', '2025-11-29 12:53:15'),
(174, 3, 'Girl with a Pearl Earring|{\"id\":\"3\",\"title\":\"Girl with a Pearl Earring\",\"artist\":\"Johannes Vermeer\",\"description\":\"Oil painting.\",\"price\":\"18000.00\",\"image_path\":\"1763888922_img-10.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-22 14:56:00\"}', '', '2025-11-29 12:53:17'),
(175, 2, 'The Scream|{\"id\":\"2\",\"title\":\"The Scream\",\"artist\":\"Edvard Munch\",\"description\":\"Expressionist masterpiece.\",\"price\":\"25000.00\",\"image_path\":\"1763888960_img-21.jpg\",\"status\":\"Reserved\",\"created_at\":\"2025-11-22 14:56:00\"}', '', '2025-11-29 12:53:18'),
(176, 1, 'Starry Night|{\"id\":\"1\",\"title\":\"Starry Night\",\"artist\":\"Vincent Van Gogh\",\"description\":\"Oil on canvas.\",\"price\":\"15000.00\",\"image_path\":\"1763888841_img-12.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-22 14:56:00\"}', '', '2025-11-29 12:53:20'),
(177, 1, 'NIGHT|{\"id\":\"1\",\"title\":\"NIGHT\",\"event_date\":\"2025-11-30\",\"event_time\":\"6;00\",\"location\":\"fghgf\",\"created_at\":\"2025-11-28 20:12:12\"}', '', '2025-11-29 12:53:24'),
(178, 2, 'trizone|{\"id\":\"2\",\"name\":\"trizone\",\"style\":\"paint\",\"bio\":\"gfds\",\"quote\":\"giii\",\"image_path\":\"1764360747_artist_img-21.jpg\",\"created_at\":\"2025-11-29 10:07:06\"}', '', '2025-11-29 12:53:26'),
(179, 39, 'jem123|{\"id\":\"39\",\"username\":\"jem123\",\"email\":\"keycm109@gmail.com\",\"password\":\"$2y$10$VGoRNP2XvrIMk6EX7bhJ9OEfX2Tq5f.hDTPND6CvEkP6px\\/YI.Py6\",\"role\":\"user\",\"reset_token_hash\":null,\"reset_token_expires_at\":null,\"account_activation_hash\":null,\"image_path\":n', '', '2025-11-29 12:53:31'),
(180, 91, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:33\"}', 'inquiries', '2025-11-29 12:53:35'),
(181, 90, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:30\"}', 'inquiries', '2025-11-29 12:53:36'),
(182, 89, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:26\"}', 'inquiries', '2025-11-29 12:53:38'),
(183, 88, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:22\"}', 'inquiries', '2025-11-29 12:53:40'),
(184, 87, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:19\"}', 'inquiries', '2025-11-29 12:53:42'),
(185, 86, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:15\"}', 'inquiries', '2025-11-29 12:53:44'),
(186, 85, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:11\"}', 'inquiries', '2025-11-29 12:53:45'),
(187, 84, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:08\"}', 'inquiries', '2025-11-29 12:53:47'),
(188, 83, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:04\"}', 'inquiries', '2025-11-29 12:53:49'),
(189, 82, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:55:01\"}', 'inquiries', '2025-11-29 12:53:51'),
(190, 81, 'Keycm|{\"username\":\"Keycm\",\"email\":\"keycm109@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"dfghjkl\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-29 10:54:57\"}', 'inquiries', '2025-11-29 12:53:53'),
(191, 79, 'Guest|{\"username\":\"Guest\",\"email\":\"example@gmail.com\",\"mobile\":\"29343934234\",\"message\":\"cjeicijdckcdndi\",\"attachment\":null,\"status\":\"unread\",\"created_at\":\"2025-11-27 19:11:42\"}', 'inquiries', '2025-11-29 12:53:55'),
(197, 41, 'Jinzo|{\"id\":41,\"username\":\"Jinzo\",\"email\":\"valencia04jeremiah29@gmail.com\",\"password\":\"$2y$10$LPqw\\/E1MrcScBQJGvmGadOlFuQx4QIPOcqcC1GXEk\\/y7zgLxcW2a.\",\"role\":\"admin\",\"reset_token_hash\":null,\"reset_token_expires_at\":\"2025-11-29 16:33:43\",\"account_activatio', '', '2025-11-30 06:31:40'),
(198, 42, 'note|{\"id\":42,\"username\":\"note\",\"email\":\"crunchybox321@gmail.com\",\"password\":\"$2y$10$.hRqiFZmPlNXghRibEYQqe\\/hrDXhlOs3VRQKXveJDjZMjsbIAkbnu\",\"role\":\"user\",\"reset_token_hash\":null,\"reset_token_expires_at\":\"2025-11-29 16:51:41\",\"account_activation_hash\":\"57', '', '2025-11-30 06:31:43'),
(199, 43, 'elle|{\"id\":43,\"username\":\"elle\",\"email\":\"valenciajeremiah29@gmail.com\",\"password\":\"$2y$10$FCi2lBiFauIS3OLGS2ykne4jxQnk35rpYeCg.JpV4d06UdPIHHGZC\",\"role\":\"user\",\"reset_token_hash\":null,\"reset_token_expires_at\":\"2025-11-29 16:53:29\",\"account_activation_hash\"', '', '2025-11-30 06:31:46'),
(200, 44, 'isaac jed|{\"id\":44,\"username\":\"isaac jed\",\"email\":\"vibrancy0616@gmail.com\",\"password\":\"$2y$10$Smd3GKg9FBkdz4Ko2cH6o.8IsE\\/Yxzv1DfMKnKOflYrEckmdEQHai\",\"role\":\"user\",\"reset_token_hash\":null,\"reset_token_expires_at\":\"2025-11-29 16:56:03\",\"account_activation_', '', '2025-11-30 06:31:51'),
(201, 7, 'Starryyy|{\"id\":\"7\",\"title\":\"Starryyy\",\"artist\":\"Felix\",\"description\":\"The best among the rest.\",\"price\":\"10000.00\",\"image_path\":\"1764427599_img-12.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-29 14:46:39\"}', '', '2025-11-30 06:58:50'),
(202, 8, 'Nightt|{\"id\":\"8\",\"title\":\"Nightt\",\"artist\":\"Felix\",\"description\":\"Beautiful and Elegant\",\"price\":\"10000.00\",\"image_path\":\"1764482193_img-10.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-30 05:56:33\"}', '', '2025-11-30 06:58:54'),
(203, 9, '\"Four Ps\" Series 1|{\"id\":\"9\",\"title\":\"\"Four Ps\" Series 1\",\"artist\":\"Melvin Culaba\",\"description\":\"...\",\"price\":\"50000.00\",\"image_path\":\"1764485141_590223575_122111043405057268_527086352923694948_n.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-30 06:45:4', '', '2025-11-30 07:03:48'),
(204, 3, 'Felix|{\"id\":\"3\",\"name\":\"Felix\",\"style\":\"Abstract Expressionism\",\"bio\":\"A fashionate painter.\",\"quote\":\"life is a mess, but painting is a must.\",\"image_path\":\"1764427501_artist_img-2.jpg\",\"created_at\":\"2025-11-29 14:45:01\"}', '', '2025-11-30 07:18:17'),
(205, 4, 'Melvin Culaba|{\"id\":\"4\",\"name\":\"Melvin Culaba\",\"style\":\"Figurative Expressionism\",\"bio\":\"Meet Melvin Culaba, an artist known for his unflinching exploration of human emotion and societal complexities through the meticulous use of graphite. His technique t', '', '2025-11-30 07:49:45'),
(206, 9, 'Angelo Roxas|{\"id\":\"9\",\"name\":\"Angelo Roxas\",\"style\":\"Portraiture\",\"bio\":\"...\",\"quote\":\"Inspiration is a must.\",\"image_path\":\"1764489199_artist_cd70ce2d7f2bf2c8d2fe54ec668f7e5a.jpg\",\"created_at\":\"2025-11-30 07:53:19\"}', '', '2025-11-30 08:01:19'),
(207, 28, 'The Head Hunter|{\"id\":\"28\",\"title\":\"The Head Hunter\",\"artist\":\"Angelo Roxas\",\"description\":\"...\",\"price\":\"88000.00\",\"image_path\":\"1764489296_3d88ea128a8df90dea42cb6b1863f118.jpg\",\"status\":\"Available\",\"created_at\":\"2025-11-30 07:54:56\"}', '', '2025-11-30 08:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `reset_token_hash` varchar(64) DEFAULT NULL,
  `reset_token_expires_at` datetime DEFAULT NULL,
  `account_activation_hash` varchar(64) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `reset_token_hash`, `reset_token_expires_at`, `account_activation_hash`, `image_path`) VALUES
(1, 'Keycm', 'penapaul858@gmail.com', '$2y$10$uLXGTKqqRQgVsXBwO89aHeI7L9NdNURnqiIt8NBbKUl8Z2IVOFi1.', 'admin', 'b9196683c40dd7cecb4dfc8ffc9ed64d4bc192f126d9d771706e791726582b26', '2025-11-29 16:05:41', NULL, '1764414221_img-17.jpg'),
(40, 'Isaac Jed Macaraeg', 'isaacjedm@gmail.com', '$2y$10$u36UOTtqy6kctr.lwCRNL.M06xvl6wCZcMvyq3FVxghDVSJODtDhu', 'user', NULL, NULL, NULL, '1764427752_makima.jpg'),
(45, 'isaacjed', 'gnc.isaacjedm@gmail.com', '$2y$10$fVyq7VeGoVVKD/I1l6RiiuO70RXgqNoKjskMSC8gz/eHW28Z69Gpq', 'user', NULL, '2025-11-29 17:16:41', '150025', NULL),
(46, 'jann kyle', 'yuta.zzz06@gmail.com', '$2y$10$ZaaoBPdkVY2f2rtj7OC9m.Sa1nLiWk8E/IfeURjK33ySO2Wy7WCbW', 'user', NULL, '2025-11-29 17:21:56', '752455', NULL),
(48, 'Khazmiri', 'johnfelix.dizon123@gmail.com', '$2y$10$L1o/StwXFa2LNS0g8m28RuWuLBQ19/hwZbZKguA3fLG1L6L.Bbl.u', 'manager', NULL, NULL, NULL, '1764493492_cdc3a3ab0e9660e72f5173089b10e9e8.jpg'),
(50, 'Jinzo', 'valencia04jeremiah29@gmail.com', '$2y$10$.E7NFTUyk7N6IzofUvmoeuJiLriWWYylUAe4MP0TpYXDaYFGE/6UO', 'admin', NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `artist_likes`
--
ALTER TABLE `artist_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_artist_like` (`user_id`,`artist_id`);

--
-- Indexes for table `artworks`
--
ALTER TABLE `artworks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `artwork_id` (`artwork_id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trash_bin`
--
ALTER TABLE `trash_bin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `reset_token_hash` (`reset_token_hash`),
  ADD UNIQUE KEY `account_activation_hash` (`account_activation_hash`),
  ADD UNIQUE KEY `email_2` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `artist_likes`
--
ALTER TABLE `artist_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `artworks`
--
ALTER TABLE `artworks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `trash_bin`
--
ALTER TABLE `trash_bin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
