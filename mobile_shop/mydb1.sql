-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 08, 2026 at 06:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb1`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add product', 7, 'add_product'),
(26, 'Can change product', 7, 'change_product'),
(27, 'Can delete product', 7, 'delete_product'),
(28, 'Can view product', 7, 'view_product'),
(29, 'Can add product brand', 8, 'add_productbrand'),
(30, 'Can change product brand', 8, 'change_productbrand'),
(31, 'Can delete product brand', 8, 'delete_productbrand'),
(32, 'Can view product brand', 8, 'view_productbrand'),
(33, 'Can add product category', 9, 'add_productcategory'),
(34, 'Can change product category', 9, 'change_productcategory'),
(35, 'Can delete product category', 9, 'delete_productcategory'),
(36, 'Can view product category', 9, 'view_productcategory'),
(37, 'Can add role', 10, 'add_role'),
(38, 'Can change role', 10, 'change_role'),
(39, 'Can delete role', 10, 'delete_role'),
(40, 'Can view role', 10, 'view_role'),
(41, 'Can add order', 11, 'add_order'),
(42, 'Can change order', 11, 'change_order'),
(43, 'Can delete order', 11, 'delete_order'),
(44, 'Can view order', 11, 'view_order'),
(45, 'Can add order item', 12, 'add_orderitem'),
(46, 'Can change order item', 12, 'change_orderitem'),
(47, 'Can delete order item', 12, 'delete_orderitem'),
(48, 'Can view order item', 12, 'view_orderitem'),
(49, 'Can add cart', 13, 'add_cart'),
(50, 'Can change cart', 13, 'change_cart'),
(51, 'Can delete cart', 13, 'delete_cart'),
(52, 'Can view cart', 13, 'view_cart'),
(53, 'Can add wishlist', 14, 'add_wishlist'),
(54, 'Can change wishlist', 14, 'change_wishlist'),
(55, 'Can delete wishlist', 14, 'delete_wishlist'),
(56, 'Can view wishlist', 14, 'view_wishlist'),
(57, 'Can add user profile', 15, 'add_userprofile'),
(58, 'Can change user profile', 15, 'change_userprofile'),
(59, 'Can delete user profile', 15, 'delete_userprofile'),
(60, 'Can view user profile', 15, 'view_userprofile'),
(61, 'Can add hot deal', 16, 'add_hotdeal'),
(62, 'Can change hot deal', 16, 'change_hotdeal'),
(63, 'Can delete hot deal', 16, 'delete_hotdeal'),
(64, 'Can view hot deal', 16, 'view_hotdeal'),
(65, 'Can add newsletter subscriber', 17, 'add_newslettersubscriber'),
(66, 'Can change newsletter subscriber', 17, 'change_newslettersubscriber'),
(67, 'Can delete newsletter subscriber', 17, 'delete_newslettersubscriber'),
(68, 'Can view newsletter subscriber', 17, 'view_newslettersubscriber'),
(69, 'Can add order return', 18, 'add_orderreturn'),
(70, 'Can change order return', 18, 'change_orderreturn'),
(71, 'Can delete order return', 18, 'delete_orderreturn'),
(72, 'Can view order return', 18, 'view_orderreturn'),
(73, 'Can add order status history', 19, 'add_orderstatushistory'),
(74, 'Can change order status history', 19, 'change_orderstatushistory'),
(75, 'Can delete order status history', 19, 'delete_orderstatushistory'),
(76, 'Can view order status history', 19, 'view_orderstatushistory'),
(77, 'Can add notification', 20, 'add_notification'),
(78, 'Can change notification', 20, 'change_notification'),
(79, 'Can delete notification', 20, 'delete_notification'),
(80, 'Can view notification', 20, 'view_notification'),
(81, 'Can add payment', 21, 'add_payment'),
(82, 'Can change payment', 21, 'change_payment'),
(83, 'Can delete payment', 21, 'delete_payment'),
(84, 'Can view payment', 21, 'view_payment'),
(85, 'Can add product review', 22, 'add_productreview'),
(86, 'Can change product review', 22, 'change_productreview'),
(87, 'Can delete product review', 22, 'delete_productreview'),
(88, 'Can view product review', 22, 'view_productreview'),
(89, 'Can add shipment', 23, 'add_shipment'),
(90, 'Can change shipment', 23, 'change_shipment'),
(91, 'Can delete shipment', 23, 'delete_shipment'),
(92, 'Can view shipment', 23, 'view_shipment'),
(93, 'Can add address', 24, 'add_address'),
(94, 'Can change address', 24, 'change_address'),
(95, 'Can delete address', 24, 'delete_address'),
(96, 'Can view address', 24, 'view_address'),
(97, 'Can add refund', 25, 'add_refund'),
(98, 'Can change refund', 25, 'change_refund'),
(99, 'Can delete refund', 25, 'delete_refund'),
(100, 'Can view refund', 25, 'view_refund');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$lVZP44Ku14u7Ys0ZbXSfG0$IoJnt8yB949uw3WfqKHyPgyN64u8F4iPBrrVJshVZxg=', '2026-02-08 04:53:21.060104', 1, 'admin', '', '', 'admin12@gmail.com', 1, 1, '2026-02-01 12:55:59.867440'),
(2, 'pbkdf2_sha256$600000$1Q6gXaDJ7cjhQRFQph3R92$4QGhkwpbLUKhUWB9+OMYijc1huhgevW0dTwpkSgy/Ko=', '2026-02-08 04:55:22.531050', 0, 'Tanvi', '', '', 'tanviparmar006@gmail.com', 0, 1, '2026-02-01 14:26:22.580381');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-02-01 13:01:44.860802', '1', 'Smartphones', 1, '[{\"added\": {}}]', 9, 1),
(2, '2026-02-01 13:09:29.150226', '1', 'Smartphones', 3, '', 9, 1),
(3, '2026-02-01 13:11:22.998038', '2', 'Smartphones', 1, '[{\"added\": {}}]', 9, 1),
(4, '2026-02-01 13:13:16.296184', '1', 'Samsung', 1, '[{\"added\": {}}]', 8, 1),
(5, '2026-02-01 13:14:35.360376', '1', 'Samsung Galaxy S23', 1, '[{\"added\": {}}]', 7, 1),
(6, '2026-02-01 13:15:27.116991', '2', 'Samsung Galaxy S23 Ultra', 1, '[{\"added\": {}}]', 7, 1),
(7, '2026-02-01 13:16:08.255571', '3', 'Samsung Galaxy A54', 1, '[{\"added\": {}}]', 7, 1),
(8, '2026-02-01 13:17:12.160417', '4', 'Samsung Galaxy M34', 1, '[{\"added\": {}}]', 7, 1),
(9, '2026-02-01 13:17:58.778783', '5', 'Samsung Galaxy F15', 1, '[{\"added\": {}}]', 7, 1),
(10, '2026-02-01 13:28:38.751554', '1', 'Samsung Galaxy S23', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(11, '2026-02-01 13:33:56.241863', '5', 'Samsung Galaxy F15', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(12, '2026-02-01 13:35:29.607413', '4', 'Samsung Galaxy M34', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(13, '2026-02-01 13:35:45.117190', '3', 'Samsung Galaxy A54', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(14, '2026-02-01 13:35:57.612630', '2', 'Samsung Galaxy S23 Ultra', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(15, '2026-02-01 13:36:09.986594', '1', 'Samsung Galaxy S23', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 7, 1),
(16, '2026-02-01 13:54:33.152940', '2', 'Apple', 1, '[{\"added\": {}}]', 8, 1),
(17, '2026-02-01 13:55:07.023973', '3', 'OnePlus', 1, '[{\"added\": {}}]', 8, 1),
(18, '2026-02-01 13:55:19.892928', '4', 'Boat', 1, '[{\"added\": {}}]', 8, 1),
(19, '2026-02-01 13:57:09.583301', '3', 'Mobile Accessories', 1, '[{\"added\": {}}]', 9, 1),
(20, '2026-02-01 13:57:30.453200', '4', 'Chargers', 1, '[{\"added\": {}}]', 9, 1),
(21, '2026-02-01 13:58:28.802284', '5', 'Headphones', 1, '[{\"added\": {}}]', 9, 1),
(22, '2026-02-01 14:01:23.850964', '5', 'JBL', 1, '[{\"added\": {}}]', 8, 1),
(23, '2026-02-01 14:01:33.357001', '6', 'Sony', 1, '[{\"added\": {}}]', 8, 1),
(24, '2026-02-01 14:07:29.452860', '6', 'boAt Rockerz 255 Pro+', 1, '[{\"added\": {}}]', 7, 1),
(25, '2026-02-01 14:09:24.651970', '7', 'JBL C100SI Wired Earphones', 1, '[{\"added\": {}}]', 7, 1),
(26, '2026-02-01 14:11:10.116132', '8', 'Sony WH-1000XM4', 1, '[{\"added\": {}}]', 7, 1),
(27, '2026-02-01 14:13:31.756005', '9', 'boAt Airdopes 141', 1, '[{\"added\": {}}]', 7, 1),
(28, '2026-02-01 14:13:58.689589', '7', 'Noise', 1, '[{\"added\": {}}]', 8, 1),
(29, '2026-02-01 14:14:07.110750', '8', 'MI', 1, '[{\"added\": {}}]', 8, 1),
(30, '2026-02-01 14:14:18.067583', '9', 'Realme', 1, '[{\"added\": {}}]', 8, 1),
(31, '2026-02-01 14:16:26.460194', '10', 'Noise Buds VS104', 1, '[{\"added\": {}}]', 7, 1),
(32, '2026-02-01 14:22:58.709950', '11', 'Samsung 25W Fast Charger', 1, '[{\"added\": {}}]', 7, 1),
(33, '2026-02-01 14:24:25.504061', '12', 'MI 33W SonicCharge', 1, '[{\"added\": {}}]', 7, 1),
(34, '2026-02-06 02:34:14.646846', '1', 'HOT DEAL OF THE DAY', 1, '[{\"added\": {}}]', 16, 1),
(35, '2026-02-07 10:50:41.286357', '3', 'Mobile Accessories', 3, '', 9, 1),
(36, '2026-02-07 11:11:04.886266', '9', 'boAt Airdopes 141', 2, '[{\"changed\": {\"fields\": [\"Is hot deal\"]}}]', 7, 1),
(37, '2026-02-07 11:12:23.144145', '1', 'HOT DEAL OF THE DAY', 2, '[{\"changed\": {\"fields\": [\"Products\"]}}]', 16, 1),
(38, '2026-02-07 11:12:32.870946', '9', 'boAt Airdopes 141', 2, '[]', 7, 1),
(39, '2026-02-07 11:12:40.961227', '4', 'Samsung Galaxy M34', 2, '[{\"changed\": {\"fields\": [\"Is hot deal\"]}}]', 7, 1),
(40, '2026-02-07 11:13:26.221705', '1', 'HOT DEAL OF THE DAY', 2, '[{\"changed\": {\"fields\": [\"Products\"]}}]', 16, 1),
(41, '2026-02-07 12:49:37.803906', '7', 'Order #7 - Tanvi', 3, '', 11, 1),
(42, '2026-02-07 12:49:37.808493', '6', 'Order #6 - Tanvi', 3, '', 11, 1),
(43, '2026-02-07 12:49:37.811589', '5', 'Order #5 - Tanvi', 3, '', 11, 1),
(44, '2026-02-07 12:49:37.814318', '4', 'Order #4 - Tanvi', 3, '', 11, 1),
(45, '2026-02-07 12:49:37.817476', '3', 'Order #3 - Tanvi', 3, '', 11, 1),
(46, '2026-02-07 12:49:37.820811', '2', 'Order #2 - Tanvi', 3, '', 11, 1),
(47, '2026-02-07 18:20:47.902196', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email\", \"Phone\", \"Address\", \"City\", \"Country\", \"Zip code\", \"Status\"]}}]', 11, 1),
(48, '2026-02-07 18:20:55.407476', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Is paid\"]}}]', 11, 1),
(49, '2026-02-07 18:27:08.066004', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1),
(50, '2026-02-07 18:38:48.871581', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1),
(51, '2026-02-07 18:47:12.144564', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Payment status\", \"Status\"]}}]', 11, 1),
(52, '2026-02-07 18:47:25.710862', '1', 'Order #1 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Payment status\", \"Status\"]}}]', 11, 1),
(53, '2026-02-07 18:47:57.665220', '8', 'Order #8 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"Is paid\", \"First name\", \"Last name\", \"Email\", \"Phone\", \"Address\", \"City\", \"Country\", \"Zip code\", \"Payment status\", \"Status\"]}}]', 11, 1),
(54, '2026-02-07 18:50:40.618887', '9', 'Order #9 - Tanvi', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email\", \"Phone\", \"Address\", \"City\", \"Country\", \"Zip code\", \"Status\"]}}]', 11, 1),
(55, '2026-02-08 04:01:53.623782', '6', 'Mobile Accessories', 1, '[{\"added\": {}}]', 9, 1),
(56, '2026-02-08 04:04:24.142854', '10', 'Spigen', 1, '[{\"added\": {}}]', 8, 1),
(57, '2026-02-08 04:04:36.114818', '11', 'Ringke', 1, '[{\"added\": {}}]', 8, 1),
(58, '2026-02-08 04:04:46.762714', '12', 'Generic', 1, '[{\"added\": {}}]', 8, 1),
(59, '2026-02-08 04:05:02.478148', '13', 'PopSockets', 1, '[{\"added\": {}}]', 8, 1),
(60, '2026-02-08 04:08:00.106028', '13', 'Spigen Rugged Armor Case', 1, '[{\"added\": {}}]', 7, 1),
(61, '2026-02-08 04:09:51.707734', '14', 'Ringke Fusion Back Cover', 1, '[{\"added\": {}}]', 7, 1),
(62, '2026-02-08 04:11:19.794886', '15', 'Tempered Glass Screen Guard', 1, '[{\"added\": {}}]', 7, 1),
(63, '2026-02-08 04:12:47.596339', '16', 'Wireless Charging Pad', 1, '[{\"added\": {}}]', 7, 1),
(64, '2026-02-08 04:37:00.370079', '1', 'Samsung Galaxy S23', 2, '[{\"changed\": {\"fields\": [\"Stock\"]}}]', 7, 1),
(65, '2026-02-08 04:54:27.280463', '15', 'Tempered Glass Screen Guard', 2, '[{\"changed\": {\"fields\": [\"Stock\"]}}]', 7, 1),
(66, '2026-02-08 04:54:39.050058', '14', 'Ringke Fusion Back Cover', 2, '[{\"changed\": {\"fields\": [\"Stock\"]}}]', 7, 1),
(67, '2026-02-08 04:54:56.108981', '8', 'Sony WH-1000XM4', 2, '[{\"changed\": {\"fields\": [\"Stock\"]}}]', 7, 1),
(68, '2026-02-08 04:55:12.095419', '12', 'MI 33W SonicCharge', 2, '[{\"changed\": {\"fields\": [\"Stock\"]}}]', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(24, 'shop', 'address'),
(13, 'shop', 'cart'),
(16, 'shop', 'hotdeal'),
(17, 'shop', 'newslettersubscriber'),
(20, 'shop', 'notification'),
(11, 'shop', 'order'),
(12, 'shop', 'orderitem'),
(18, 'shop', 'orderreturn'),
(19, 'shop', 'orderstatushistory'),
(21, 'shop', 'payment'),
(7, 'shop', 'product'),
(8, 'shop', 'productbrand'),
(9, 'shop', 'productcategory'),
(22, 'shop', 'productreview'),
(25, 'shop', 'refund'),
(10, 'shop', 'role'),
(23, 'shop', 'shipment'),
(15, 'shop', 'userprofile'),
(14, 'shop', 'wishlist');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-01 12:19:22.360421'),
(2, 'auth', '0001_initial', '2026-02-01 12:19:23.399764'),
(3, 'admin', '0001_initial', '2026-02-01 12:19:23.683715'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-01 12:19:23.703421'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-01 12:19:23.727220'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-02-01 12:19:23.894226'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-02-01 12:19:24.032091'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-02-01 12:19:24.070404'),
(9, 'auth', '0004_alter_user_username_opts', '2026-02-01 12:19:24.096665'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-02-01 12:19:24.209717'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-02-01 12:19:24.216401'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-02-01 12:19:24.245325'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-02-01 12:19:24.305346'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-02-01 12:19:24.347927'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-02-01 12:19:24.400034'),
(16, 'auth', '0011_update_proxy_permissions', '2026-02-01 12:19:24.418199'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-02-01 12:19:24.444560'),
(18, 'sessions', '0001_initial', '2026-02-01 12:19:24.516894'),
(19, 'shop', '0001_initial', '2026-02-01 12:19:25.743817'),
(20, 'shop', '0002_userprofile', '2026-02-01 12:19:25.965184'),
(21, 'shop', '0003_hotdeal', '2026-02-01 12:19:25.993166'),
(22, 'shop', '0004_remove_hotdeal_button_link_and_more', '2026-02-01 12:19:26.358507'),
(23, 'shop', '0005_product_is_hot_deal_product_mrp', '2026-02-01 12:19:26.441283'),
(24, 'shop', '0006_newslettersubscriber', '2026-02-01 12:19:26.508250'),
(25, 'shop', '0007_order_payment_status_order_status_order_total_amount_and_more', '2026-02-01 12:19:27.125986'),
(26, 'shop', '0008_alter_userprofile_profile_image', '2026-02-01 12:19:27.171405'),
(27, 'shop', '0009_alter_userprofile_profile_image', '2026-02-01 12:19:27.282814'),
(28, 'shop', '0010_alter_userprofile_profile_image', '2026-02-01 12:19:27.310718'),
(29, 'shop', '0011_order_is_paid', '2026-02-01 12:19:27.421053'),
(30, 'shop', '0012_shipment_refund_payment_notification_address_and_more', '2026-02-01 12:27:47.506000'),
(31, 'shop', '0013_productcategory_description_productcategory_slug', '2026-02-01 13:08:36.077503'),
(32, 'shop', '0014_productbrand_slug', '2026-02-01 13:12:27.602682'),
(33, 'shop', '0015_alter_notification_message', '2026-02-01 16:41:42.121482');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('304aovq1x1pskcma8y9y4bav6aoshi33', '.eJxVjEEOwiAQRe_C2hAyUOi4dO8ZCMNMpWogKe3KeHdt0oVu_3vvv1RM21ri1mWJM6uzAnX63Sjlh9Qd8D3VW9O51XWZSe-KPmjX18byvBzu30FJvXxrdBQwOwMUPBD4wXrIbkrWInoIYoiBMFkwCAFk9CYT4uDFTjwyO_X-ALqMNyM:1vowpO:iJyfzB07Cemld-tAKH3C-E35RdBv7vyZhrRFTZax2S4', '2026-02-22 04:55:22.536263');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Rate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products1`
--

CREATE TABLE `products1` (
  `pro_id` int(11) DEFAULT NULL,
  `pro_name` varchar(20) NOT NULL,
  `Pro_price` int(11) NOT NULL,
  `Qty` int(11) DEFAULT NULL,
  `Rate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products1`
--

INSERT INTO `products1` (`pro_id`, `pro_name`, `Pro_price`, `Qty`, `Rate`) VALUES
(2, 'pen', 12, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shop_address`
--

CREATE TABLE `shop_address` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_address`
--

INSERT INTO `shop_address` (`id`, `full_name`, `phone`, `address`, `city`, `state`, `country`, `pincode`, `is_default`, `user_id`) VALUES
(1, 'tanvi', '8733081481', 'dhrangadhra', 'dhrangadhra', 'gujarat', 'india', '363310', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `shop_cart`
--

CREATE TABLE `shop_cart` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `added_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_cart`
--

INSERT INTO `shop_cart` (`id`, `quantity`, `added_at`, `user_id`, `product_id`) VALUES
(27, 6, '2026-02-08 04:52:05.889324', 1, 10),
(28, 3, '2026-02-08 04:55:37.723554', 2, 12);

-- --------------------------------------------------------

--
-- Table structure for table `shop_hotdeal`
--

CREATE TABLE `shop_hotdeal` (
  `id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(200) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_hotdeal`
--

INSERT INTO `shop_hotdeal` (`id`, `title`, `subtitle`, `end_time`, `is_active`) VALUES
(1, 'HOT DEAL OF THE DAY', 'Up to 40% Off on Top Smartphones', '2026-02-15 23:59:00.000000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop_hotdeal_products`
--

CREATE TABLE `shop_hotdeal_products` (
  `id` int(11) NOT NULL,
  `hotdeal_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_hotdeal_products`
--

INSERT INTO `shop_hotdeal_products` (`id`, `hotdeal_id`, `product_id`) VALUES
(3, 1, 4),
(4, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `shop_newslettersubscriber`
--

CREATE TABLE `shop_newslettersubscriber` (
  `id` bigint(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `subscribed_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_notification`
--

CREATE TABLE `shop_notification` (
  `id` bigint(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_notification`
--

INSERT INTO `shop_notification` (`id`, `message`, `is_read`, `created_at`, `user_id`) VALUES
(1, 'Product added to cart', 0, '2026-02-01 16:47:55.128018', 2),
(2, 'Product added to cart', 0, '2026-02-01 16:55:34.540775', 2),
(3, 'Product added to cart', 0, '2026-02-01 16:55:38.128557', 2),
(4, 'Product added to cart', 0, '2026-02-01 16:55:41.307818', 2),
(5, 'Product added to cart', 0, '2026-02-01 16:55:56.207363', 2),
(6, 'Product added to cart', 0, '2026-02-06 02:29:24.636404', 2),
(7, 'Product added to cart', 0, '2026-02-07 11:01:02.493376', 2),
(8, 'Product added to cart', 0, '2026-02-07 11:01:21.017790', 2),
(9, 'Product added to cart', 0, '2026-02-07 11:01:35.156926', 2),
(10, 'Product added to cart', 0, '2026-02-07 11:07:39.489480', 2),
(11, 'Product added to cart', 0, '2026-02-07 11:11:31.250266', 1),
(12, 'Product added to cart', 0, '2026-02-07 11:13:50.678449', 1),
(13, 'Product added to cart', 0, '2026-02-07 11:44:23.814940', 2),
(14, 'Product added to cart', 0, '2026-02-07 11:54:07.877008', 2),
(15, 'Product added to cart', 0, '2026-02-07 11:54:59.759564', 2),
(16, 'Samsung Galaxy S23 added to cart', 0, '2026-02-07 12:03:40.972683', 2),
(17, 'boAt Rockerz 255 Pro+ added to cart', 0, '2026-02-07 12:17:56.322752', 2),
(18, 'boAt Rockerz 255 Pro+ added to cart', 0, '2026-02-07 12:18:06.320932', 2),
(19, 'Your order has been placed successfully', 0, '2026-02-07 12:18:24.257616', 2),
(20, 'Your order has been placed successfully', 0, '2026-02-07 12:21:56.719986', 2),
(21, 'Your order has been placed successfully', 0, '2026-02-07 12:27:56.873172', 2),
(22, 'Samsung Galaxy S23 added to cart', 0, '2026-02-07 12:32:55.768382', 2),
(23, 'Your order has been placed successfully', 0, '2026-02-07 12:33:07.160022', 2),
(24, 'Noise Buds VS104 added to cart', 0, '2026-02-07 12:37:52.312269', 2),
(25, 'Your order has been placed successfully', 0, '2026-02-07 12:38:19.159488', 2),
(26, 'boAt Rockerz 255 Pro+ added to cart', 0, '2026-02-07 12:39:46.760568', 2),
(27, 'Your order has been placed successfully', 0, '2026-02-07 12:39:57.806359', 2),
(28, 'Noise Buds VS104 added to cart', 0, '2026-02-07 12:41:17.685329', 2),
(29, 'Your order has been placed successfully', 0, '2026-02-07 12:41:29.285926', 2),
(30, 'Samsung Galaxy S23 added to cart', 1, '2026-02-07 12:50:45.596254', 2),
(31, 'Your order has been placed successfully', 1, '2026-02-07 12:50:56.413742', 2),
(32, 'JBL C100SI Wired Earphones added to cart', 0, '2026-02-07 12:51:39.025436', 2),
(33, 'Your order has been placed successfully', 0, '2026-02-07 12:51:49.450261', 2),
(34, 'Payment successful for Order #9', 0, '2026-02-07 12:54:15.057903', 2),
(35, 'boAt Rockerz 255 Pro+ added to cart', 0, '2026-02-07 14:32:03.120190', 2),
(36, 'Samsung Galaxy A54 added to cart', 0, '2026-02-07 14:50:31.968118', 2),
(37, 'Your order has been placed successfully', 0, '2026-02-07 14:50:47.002165', 2),
(38, 'Payment successful for Order #10', 0, '2026-02-07 14:50:48.594140', 2),
(39, 'Return requested for Order #1', 0, '2026-02-07 18:36:10.740348', 2),
(40, 'Return requested for Order #8', 0, '2026-02-07 18:48:28.334350', 2),
(41, 'Return requested for Order #9', 0, '2026-02-07 18:52:45.459404', 2),
(42, 'Samsung Galaxy S23 added to cart', 0, '2026-02-08 04:37:24.242725', 1),
(43, 'Samsung Galaxy S23 Ultra added to cart', 0, '2026-02-08 04:37:37.823454', 1),
(44, 'Samsung Galaxy S23 added to cart', 0, '2026-02-08 04:50:01.695414', 1),
(45, 'Samsung Galaxy S23 Ultra added to cart', 0, '2026-02-08 04:51:51.782575', 1),
(46, 'Noise Buds VS104 added to cart', 0, '2026-02-08 04:52:05.895264', 1),
(47, 'MI 33W SonicCharge added to cart', 0, '2026-02-08 04:55:37.731101', 2),
(48, 'MI 33W SonicCharge added to cart', 0, '2026-02-08 05:04:07.029319', 2),
(49, 'MI 33W SonicCharge added to cart', 0, '2026-02-08 05:04:21.452161', 2),
(50, 'MI 33W SonicCharge added to cart', 0, '2026-02-08 05:04:27.226182', 2);

-- --------------------------------------------------------

--
-- Table structure for table `shop_order`
--

CREATE TABLE `shop_order` (
  `id` bigint(20) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `zip_code` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `is_paid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_order`
--

INSERT INTO `shop_order` (`id`, `first_name`, `last_name`, `email`, `address`, `city`, `country`, `zip_code`, `phone`, `payment_method`, `created_at`, `user_id`, `payment_status`, `status`, `total_amount`, `is_paid`) VALUES
(1, 'Tanvi', 'Parmar', 'tanviparmar006@gmail.com', 'Dhrangadhra', 'Dhrangadhra', 'India', '363310', '8733081481', 'UPI / GPAY', '2026-02-07 12:18:24.244163', 2, 'paid', 'confirmed', 1299.00, 1),
(8, 'Tanvi', 'Parmar', 'tanviparmar006@gmail.com', 'Dhrangadhra', 'Dhrangadhra', 'India', '363310', '8733081481', 'Cash On Delivery', '2026-02-07 12:50:56.403684', 2, 'paid', 'returned', 69999.00, 1),
(9, 'Tanvi', 'Parmar', 'tanviparmar006@gmail.com', 'Dhrangadhra', 'Dhrangadhra', 'India', '363310', '8733081481', 'UPI', '2026-02-07 12:51:49.436742', 2, 'paid', 'returned', 799.00, 1),
(10, '', '', '', '', '', '', '', '', 'UPI', '2026-02-07 14:50:46.981343', 2, 'paid', 'confirmed', 40298.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop_orderitem`
--

CREATE TABLE `shop_orderitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_orderitem`
--

INSERT INTO `shop_orderitem` (`id`, `quantity`, `price`, `order_id`, `product_id`) VALUES
(1, 1, 1299.00, 1, 6),
(8, 1, 69999.00, 8, 1),
(9, 1, 799.00, 9, 7),
(10, 1, 1299.00, 10, 6),
(11, 1, 38999.00, 10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `shop_orderreturn`
--

CREATE TABLE `shop_orderreturn` (
  `id` bigint(20) NOT NULL,
  `reason` longtext NOT NULL,
  `requested_at` datetime(6) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_orderreturn`
--

INSERT INTO `shop_orderreturn` (`id`, `reason`, `requested_at`, `approved`, `order_id`) VALUES
(1, 'nothing', '2026-02-07 18:36:10.729382', 0, 1),
(3, 'defected', '2026-02-07 18:48:28.327722', 0, 8),
(4, 'defected item', '2026-02-07 18:52:45.446744', 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `shop_orderstatushistory`
--

CREATE TABLE `shop_orderstatushistory` (
  `id` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `changed_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_payment`
--

CREATE TABLE `shop_payment` (
  `id` bigint(20) NOT NULL,
  `razorpay_order_id` varchar(100) DEFAULT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  `razorpay_signature` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_product`
--

CREATE TABLE `shop_product` (
  `id` bigint(20) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `is_hot_deal` tinyint(1) NOT NULL,
  `mrp` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_product`
--

INSERT INTO `shop_product` (`id`, `product_name`, `description`, `price`, `stock`, `image`, `brand_id`, `category_id`, `is_hot_deal`, `mrp`) VALUES
(1, 'Samsung Galaxy S23', 'Samsung Galaxy S23 with Snapdragon processor and AMOLED display', 69999.00, 2, 'products/samsung_s23_j9ZUYJc.jpg', 1, 2, 0, 79999.00),
(2, 'Samsung Galaxy S23 Ultra', 'Premium flagship phone with 200MP camera', 114999.00, 10, 'products/samsung_s23_ultra.jpg', 1, 2, 0, 124999.00),
(3, 'Samsung Galaxy A54', 'Best mid-range phone with great camera', 38999.00, 20, 'products/samsung_galaxy_A54.webp', 1, 2, 0, 45999.00),
(4, 'Samsung Galaxy M34', 'Samsung Galaxy M34', 19999.00, 25, 'products/samsung_galaxy_m34.jpg', 1, 2, 1, 24999.00),
(5, 'Samsung Galaxy F15', 'Affordable smartphone with AMOLED display', 14999.00, 30, 'products/samsung_galaxy_a15.jpg', 1, 2, 1, 17999.00),
(6, 'boAt Rockerz 255 Pro+', 'Wireless neckband earphones with powerful bass, fast charging, and long battery life.', 1299.00, 50, 'products/boat_blootooth.jpg', 4, 5, 0, 2999.00),
(7, 'JBL C100SI Wired Earphones', 'Comfortable wired earphones with clear sound and deep bass, ideal for music and calls.', 799.00, 20, 'products/jbl_blootooth.jpg', 5, 5, 0, 1299.00),
(8, 'Sony WH-1000XM4', 'Premium noise-cancelling headphones with industry-leading sound quality and comfort.', 24999.00, 2, 'products/sony_headphone.jpg', 6, 5, 0, 34999.00),
(9, 'boAt Airdopes 141', 'True wireless earbuds offering immersive sound, long playback time, and stylish design.', 1499.00, 30, 'products/boat_bt.jpg', 4, 5, 1, 4490.00),
(10, 'Noise Buds VS104', 'Affordable wireless earbuds with touch controls, clear audio, and compact charging case', 1199.00, 25, 'products/noise_bt.jpg', 7, 5, 0, 3499.00),
(11, 'Samsung 25W Fast Charger', 'Original Samsung fast charger ensuring safe and quick charging for supported devices', 1299.00, 30, 'products/samsung_charger.jpg', 1, 4, 0, 1999.00),
(12, 'MI 33W SonicCharge', 'High-speed charger with smart protection and durable build quality.', 999.00, 4, 'products/mi_chargr.jpg', 8, 4, 0, 1999.00),
(13, 'Spigen Rugged Armor Case', 'Durable and slim protective case for smartphones.', 799.00, 50, 'products/spigen_case.jpg', 10, 6, 0, 999.00),
(14, 'Ringke Fusion Back Cover', 'Transparent case with shock absorption for daily use.', 699.00, 10, 'products/ringke.jpg', 11, 6, 0, 899.00),
(15, 'Tempered Glass Screen Guard', 'High-quality tempered glass to protect screen from scratches.', 299.00, 20, 'products/tempered_glass.jpg', 12, 6, 0, 499.00),
(16, 'Wireless Charging Pad', 'Fast wireless charging pad compatible with Qi devices.', 1299.00, 25, 'products/wireless_charging.jpg', 1, 6, 0, 1599.00);

-- --------------------------------------------------------

--
-- Table structure for table `shop_productbrand`
--

CREATE TABLE `shop_productbrand` (
  `id` bigint(20) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_productbrand`
--

INSERT INTO `shop_productbrand` (`id`, `brand_name`, `slug`) VALUES
(1, 'Samsung', 'samsung'),
(2, 'Apple', 'apple'),
(3, 'OnePlus', 'oneplus'),
(4, 'Boat', 'boat'),
(5, 'JBL', 'jbl'),
(6, 'Sony', 'sony'),
(7, 'Noise', 'noise'),
(8, 'MI', 'mi'),
(9, 'Realme', 'realme'),
(10, 'Spigen', 'spigen'),
(11, 'Ringke', 'ringke'),
(12, 'Generic', 'generic'),
(13, 'PopSockets', 'popsockets');

-- --------------------------------------------------------

--
-- Table structure for table `shop_productcategory`
--

CREATE TABLE `shop_productcategory` (
  `id` bigint(20) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_productcategory`
--

INSERT INTO `shop_productcategory` (`id`, `category_name`, `description`, `slug`) VALUES
(2, 'Smartphones', 'Latest smartphones with best offers', 'smartphones'),
(4, 'Chargers', 'Fast and reliable chargers and cables compatible with multiple smartphone brands.', 'chargers'),
(5, 'Headphones', 'High-quality wired and wireless headphones with clear sound and deep bass.', 'headphones'),
(6, 'Mobile Accessories', 'Cases, screen guards, etc.', 'mobile-accessories');

-- --------------------------------------------------------

--
-- Table structure for table `shop_productreview`
--

CREATE TABLE `shop_productreview` (
  `id` bigint(20) NOT NULL,
  `rating` int(10) UNSIGNED NOT NULL CHECK (`rating` >= 0),
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_productreview`
--

INSERT INTO `shop_productreview` (`id`, `rating`, `comment`, `created_at`, `product_id`, `user_id`) VALUES
(1, 4, 'nice product', '2026-02-07 13:37:20.835705', 1, 2),
(2, 5, 'nice product', '2026-02-07 14:45:40.688662', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop_refund`
--

CREATE TABLE `shop_refund` (
  `id` bigint(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `reason` longtext NOT NULL,
  `status` varchar(20) NOT NULL,
  `refunded_at` datetime(6) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_role`
--

CREATE TABLE `shop_role` (
  `id` bigint(20) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `can_manage_orders` tinyint(1) NOT NULL,
  `can_manage_products` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_shipment`
--

CREATE TABLE `shop_shipment` (
  `id` bigint(20) NOT NULL,
  `courier_name` varchar(100) NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `shipped_at` datetime(6) DEFAULT NULL,
  `delivered_at` datetime(6) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_userprofile`
--

CREATE TABLE `shop_userprofile` (
  `id` bigint(20) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_userprofile`
--

INSERT INTO `shop_userprofile` (`id`, `phone`, `address`, `city`, `state`, `pincode`, `profile_image`, `user_id`) VALUES
(1, '', '', '', '', '', '', 1),
(2, '8733081481', 'Dhrangadhra', 'Dhrangadhra', 'Gujarat', '363310', 'profile/1000062872.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `shop_wishlist`
--

CREATE TABLE `shop_wishlist` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_wishlist`
--

INSERT INTO `shop_wishlist` (`id`, `product_id`, `user_id`) VALUES
(1, 6, 1),
(2, 1, 2),
(3, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `shop_address`
--
ALTER TABLE `shop_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_address_user_id_3edd3b17_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `shop_cart`
--
ALTER TABLE `shop_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_cart_user_id_27925ac6_fk_auth_user_id` (`user_id`),
  ADD KEY `shop_cart_product_id_48b482ee_fk_shop_product_id` (`product_id`);

--
-- Indexes for table `shop_hotdeal`
--
ALTER TABLE `shop_hotdeal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shop_hotdeal_products`
--
ALTER TABLE `shop_hotdeal_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shop_hotdeal_products_hotdeal_id_product_id_a4ff47eb_uniq` (`hotdeal_id`,`product_id`),
  ADD KEY `shop_hotdeal_products_product_id_302ebd1b_fk_shop_product_id` (`product_id`);

--
-- Indexes for table `shop_newslettersubscriber`
--
ALTER TABLE `shop_newslettersubscriber`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `shop_notification`
--
ALTER TABLE `shop_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_notification_user_id_24ae0d8a_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `shop_order`
--
ALTER TABLE `shop_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_order_user_id_00aba627_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `shop_orderitem`
--
ALTER TABLE `shop_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_orderitem_order_id_2f1b00cf_fk_shop_order_id` (`order_id`),
  ADD KEY `shop_orderitem_product_id_48153f22_fk_shop_product_id` (`product_id`);

--
-- Indexes for table `shop_orderreturn`
--
ALTER TABLE `shop_orderreturn`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `shop_orderstatushistory`
--
ALTER TABLE `shop_orderstatushistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_orderstatushistory_order_id_3e6d3984_fk_shop_order_id` (`order_id`);

--
-- Indexes for table `shop_payment`
--
ALTER TABLE `shop_payment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `shop_product`
--
ALTER TABLE `shop_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_product_brand_id_505fec11_fk_shop_productbrand_id` (`brand_id`),
  ADD KEY `shop_product_category_id_14d7eea8_fk_shop_productcategory_id` (`category_id`);

--
-- Indexes for table `shop_productbrand`
--
ALTER TABLE `shop_productbrand`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `shop_productcategory`
--
ALTER TABLE `shop_productcategory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `shop_productreview`
--
ALTER TABLE `shop_productreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shop_productreview_product_id_user_id_f7cfacac_uniq` (`product_id`,`user_id`),
  ADD KEY `shop_productreview_user_id_e5ade595_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `shop_refund`
--
ALTER TABLE `shop_refund`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `shop_role`
--
ALTER TABLE `shop_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shop_shipment`
--
ALTER TABLE `shop_shipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `shop_userprofile`
--
ALTER TABLE `shop_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `shop_wishlist`
--
ALTER TABLE `shop_wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_wishlist_product_id_0fc70568_fk_shop_product_id` (`product_id`),
  ADD KEY `shop_wishlist_user_id_131c4a81_fk_auth_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `shop_address`
--
ALTER TABLE `shop_address`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shop_cart`
--
ALTER TABLE `shop_cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `shop_hotdeal`
--
ALTER TABLE `shop_hotdeal`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shop_hotdeal_products`
--
ALTER TABLE `shop_hotdeal_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shop_newslettersubscriber`
--
ALTER TABLE `shop_newslettersubscriber`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_notification`
--
ALTER TABLE `shop_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `shop_order`
--
ALTER TABLE `shop_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shop_orderitem`
--
ALTER TABLE `shop_orderitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `shop_orderreturn`
--
ALTER TABLE `shop_orderreturn`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shop_orderstatushistory`
--
ALTER TABLE `shop_orderstatushistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_payment`
--
ALTER TABLE `shop_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_product`
--
ALTER TABLE `shop_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `shop_productbrand`
--
ALTER TABLE `shop_productbrand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `shop_productcategory`
--
ALTER TABLE `shop_productcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `shop_productreview`
--
ALTER TABLE `shop_productreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shop_refund`
--
ALTER TABLE `shop_refund`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_role`
--
ALTER TABLE `shop_role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_shipment`
--
ALTER TABLE `shop_shipment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_userprofile`
--
ALTER TABLE `shop_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `shop_wishlist`
--
ALTER TABLE `shop_wishlist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_address`
--
ALTER TABLE `shop_address`
  ADD CONSTRAINT `shop_address_user_id_3edd3b17_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_cart`
--
ALTER TABLE `shop_cart`
  ADD CONSTRAINT `shop_cart_product_id_48b482ee_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  ADD CONSTRAINT `shop_cart_user_id_27925ac6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_hotdeal_products`
--
ALTER TABLE `shop_hotdeal_products`
  ADD CONSTRAINT `shop_hotdeal_products_hotdeal_id_7e35e3f4_fk_shop_hotdeal_id` FOREIGN KEY (`hotdeal_id`) REFERENCES `shop_hotdeal` (`id`),
  ADD CONSTRAINT `shop_hotdeal_products_product_id_302ebd1b_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`);

--
-- Constraints for table `shop_notification`
--
ALTER TABLE `shop_notification`
  ADD CONSTRAINT `shop_notification_user_id_24ae0d8a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_order`
--
ALTER TABLE `shop_order`
  ADD CONSTRAINT `shop_order_user_id_00aba627_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_orderitem`
--
ALTER TABLE `shop_orderitem`
  ADD CONSTRAINT `shop_orderitem_order_id_2f1b00cf_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`),
  ADD CONSTRAINT `shop_orderitem_product_id_48153f22_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`);

--
-- Constraints for table `shop_orderreturn`
--
ALTER TABLE `shop_orderreturn`
  ADD CONSTRAINT `shop_orderreturn_order_id_a0962751_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`);

--
-- Constraints for table `shop_orderstatushistory`
--
ALTER TABLE `shop_orderstatushistory`
  ADD CONSTRAINT `shop_orderstatushistory_order_id_3e6d3984_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`);

--
-- Constraints for table `shop_payment`
--
ALTER TABLE `shop_payment`
  ADD CONSTRAINT `shop_payment_order_id_20828773_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`);

--
-- Constraints for table `shop_product`
--
ALTER TABLE `shop_product`
  ADD CONSTRAINT `shop_product_brand_id_505fec11_fk_shop_productbrand_id` FOREIGN KEY (`brand_id`) REFERENCES `shop_productbrand` (`id`),
  ADD CONSTRAINT `shop_product_category_id_14d7eea8_fk_shop_productcategory_id` FOREIGN KEY (`category_id`) REFERENCES `shop_productcategory` (`id`);

--
-- Constraints for table `shop_productreview`
--
ALTER TABLE `shop_productreview`
  ADD CONSTRAINT `shop_productreview_product_id_cd68779d_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  ADD CONSTRAINT `shop_productreview_user_id_e5ade595_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_refund`
--
ALTER TABLE `shop_refund`
  ADD CONSTRAINT `shop_refund_order_id_0ad89e2e_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`);

--
-- Constraints for table `shop_shipment`
--
ALTER TABLE `shop_shipment`
  ADD CONSTRAINT `shop_shipment_order_id_21305c8c_fk_shop_order_id` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`);

--
-- Constraints for table `shop_userprofile`
--
ALTER TABLE `shop_userprofile`
  ADD CONSTRAINT `shop_userprofile_user_id_f68b553c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `shop_wishlist`
--
ALTER TABLE `shop_wishlist`
  ADD CONSTRAINT `shop_wishlist_product_id_0fc70568_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  ADD CONSTRAINT `shop_wishlist_user_id_131c4a81_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
