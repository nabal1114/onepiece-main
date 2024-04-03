SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `miu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `miu`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL COMMENT 'ID is used for management and auto-increase',
  `username` varchar(30) NOT NULL COMMENT 'Admin uses username to log in',
  `hashed_password` varchar(64) NOT NULL COMMENT 'Password after hashing with SHA256',
  `role` enum('super_admin','admin') NOT NULL COMMENT 'Decentralized, super_admin can create admin',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `admin` (`id`, `username`, `hashed_password`, `role`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'super_admin', '2023-11-17 09:46:24', NULL, NULL),
(2, 'thuy', '5adf805ab91494fb0803dc1f111a31877545576686847d8790a46a30c7e6e285', 'admin', '2023-11-17 09:50:33', NULL, NULL),
(3, 'hoang', '270723e7f50a26d4ae90da0e13079f293dd37e9953f7f9801ce7de19a35fc58e', 'admin', '2023-11-17 09:51:12', NULL, NULL),
(4, 'vuong', '9ef78ba5f2594c24944ce9a90f2a6358d260a7cc3bb7db8e37f06c5d41249eef', 'admin', '2023-11-17 09:51:41', NULL, NULL);

CREATE TABLE `category` (
  `id` int(11) NOT NULL COMMENT 'ID is used for management and auto-increase',
  `name` varchar(30) NOT NULL COMMENT 'Product type name',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `category` (`id`, `name`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'NIKE', '2023-11-16 15:34:35', NULL, NULL),
(2, 'ADIDAS', '2023-11-16 15:34:35', NULL, NULL),
(3, 'NEW BALANCE', '2023-11-16 15:34:35', NULL, NULL),
(4, 'VANS', '2023-11-16 15:34:35', NULL, NULL),
(5, 'CONVERSE', '2023-11-16 15:34:35', NULL, NULL),
(6, 'FILA', '2023-11-16 15:34:35', NULL, NULL);

CREATE TABLE `order` (
  `id` int(11) NOT NULL COMMENT 'ID is used for management and auto-increase',
  `user_id` int(11) NOT NULL COMMENT 'Bind to user table id',
  `address` longtext NOT NULL COMMENT 'Delivery address',
  `total_price` bigint(20) NOT NULL COMMENT 'Calculated based on order_data table',
  `payment` enum('cod','vnpay') NOT NULL COMMENT 'Select payment method',
  `status` enum('processing','shipping','done','canceled') NOT NULL COMMENT 'Order status',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `order_data` (
  `order_id` int(11) NOT NULL COMMENT 'Bind to order table id',
  `product_id` int(11) NOT NULL COMMENT 'Bind to the product table id',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT 'Number of products selected'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `product` (
  `id` int(11) NOT NULL COMMENT 'ID is used for management and auto-increase',
  `brand` varchar(30) NOT NULL DEFAULT 'M.O.I' COMMENT 'Company name, default is M.O.I',
  `name` varchar(100) NOT NULL COMMENT 'Product name',
  `category_id` int(11) NOT NULL COMMENT 'Product type ID',
  `origin` varchar(50) NOT NULL COMMENT 'Origin',
  `expiry_date` varchar(50) NOT NULL COMMENT 'Expiry',
  `weight` varchar(50) NOT NULL COMMENT 'Weight',
  `preservation` varchar(150) NOT NULL COMMENT 'Methods of preservation',
  `price` bigint(20) NOT NULL COMMENT 'Product price',
  `amount` int(11) NOT NULL COMMENT 'Number of products currently available',
  `thumbnail` longtext DEFAULT NULL,
  `images` longtext DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `product` (`id`, `brand`, `name`, `category_id`, `origin`, `expiry_date`, `weight`, `preservation`, `price`, `amount`, `thumbnail`, `images`, `create_at`, `update_at`, `delete_at`) VALUES
(1, 'NIKE', 'NIKE RENEW RIDE 3', 1, '베트남', '2024-01-01', 'Nike Inc.', '250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290', 62000, 100, 'assets/images/thumbnails/52088_1687844535154.jpg', '[\"assets/images/products/52088_1687844535154.jpg\",\"assets/images/products/70436_1687844535327.jpg\",\"assets/images/products/17283_1687844535479.jpg\",\"assets/images/products/23137_1687844535643.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(2, 'NIKE', 'AIR WINFLO 10', 1, '베트남', '2024-01-01', 'Nike Inc.', '250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290', 95000, 100, 'assets/images/thumbnails/28915_1687846111113.jpg', '[\"assets/images/products/28915_1687846111113.jpg\",\"assets/images/products/34604_1687846112643.jpg\",\"assets/images/products/67114_1687846112500.jpg\",\"assets/images/products/71832_1687846112964.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(3, 'NIKE', 'W NIKE AIR MAX SYSTM NCPS', 1, '인도', '2024-01-01', 'Nike Inc.', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290', 95000, 100, 'assets/images/thumbnails/80119_1696582570370.jpeg', '[\"assets/images/products/80119_1696582570370.jpeg\",\"assets/images/products/23983_1696582572169.jpg\",\"assets/images/products/34176_1696582572006.jpg\",\"assets/images/products/77064_1696582571855.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(4, 'NIKE', 'W NIKE DOWNSHIFTER 12', 1, '베트남', '2024-01-01', 'Nike Inc.', '230 / 235 / 240 / 245 / 250', 55000, 100, 'assets/images/thumbnails/23071_1687844735588.jpg', '[\"assets/images/products/23071_1687844735588.jpg\",\"assets/images/products/29844_1687844735436.jpg\",\"assets/images/products/47008_1687844735910.jpg\",\"assets/images/products/67997_1687844735736.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(5, 'NIKE', 'NIKE AIR MAX SOLO', 1, '인도네시아', '2024-01-01', 'Nike Inc.', '240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290', 119000, 100, 'assets/images/thumbnails/43989_1689120671648.jpeg', '[\"assets/images/products/43989_1689120671648.jpeg\",\"assets/images/products/85473_1689120673150.jpg\",\"assets/images/products/61889_1689120673304.jpg\",\"assets/images/products/07514_1689120673474.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(6, 'NIKE', 'NIKE COURT VISION LO NN', 1, '인도', '2024-01-01', 'Nike Inc.', '240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290', 49000, 100, 'assets/images/thumbnails/36565_1687844895943.jpg', '[\"assets/images/products/36565_1687844895943.jpg\",\"assets/images/products/05848_1687844896973.jpg\",\"assets/images/products/21296_1687844896830.jpg\",\"assets/images/products/45411_1687844897136.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(7, 'NIKE', 'WMNS NIKE COURT LEGACY NN', 1, '인도네시아', '2024-01-01', 'Nike Inc.', '220 / 225 / 230 / 235 / 240 / 245 / 250', 79000, 100, 'assets/images/thumbnails/77109_1641186370312.jpg', '[\"assets/images/products/77109_1641186370312.jpg\",\"assets/images/products/88925_1641186370655.jpg\",\"assets/images/products/85208_1641186370483.jpg\",\"assets/images/products/40709_1641186371001.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(8, 'NIKE', 'NIKE FLEX ADVANCE BOOT BT', 1, '베트남', '2024-01-01', 'Nike Inc.', '120 / 130 / 140 / 150 / 160', 47000, 100, 'assets/images/thumbnails/25154_1700783368512.jpg', '[\"assets/images/products/25154_1700783368512.jpg\",\"assets/images/products/58092_1700783369137.jpg\",\"assets/images/products/71959_1700783368808.jpg\",\"assets/images/products/15676_1700783369524.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(9, 'NIKE', 'W NIKE VICTORI ONE SLIDE', 1, '중국', '2024-01-01', 'Nike Inc.', '220 / 230 / 240 / 250 / 260', 39000, 100, 'assets/images/thumbnails/65885_1642999374597.jpg', '[\"assets/images/products/65885_1642999374597.jpg\",\"assets/images/products/72234_1642999374936.jpg\",\"assets/images/products/35184_1642999374785.jpg\",\"assets/images/products/85981_1642999375257.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(10, 'ADIDAS', 'GALAXY 6 M', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '250 / 255 / 260 / 265 / 270 / 275 / 280 / 290 / 300', 79000, 100, 'assets/images/thumbnails/68203_1664182295736.jpg', '[\"assets/images/products/68203_1664182295736.jpg\",\"assets/images/products/75847_1664182295899.jpg\",\"assets/images/products/60547_1664182296199.jpg\",\"assets/images/products/95855_1664182296350.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(11, 'ADIDAS', 'SUPERSTAR CF I', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '120 / 130 / 140 / 150 / 160', 29000, 100, 'assets/images/thumbnails/16440_1609208437616.jpg', '[\"assets/images/products/16440_1609208437616.jpg\",\"assets/images/products/02200_1600748937867.jpg\",\"assets/images/products/20195_1600748938032.jpg\",\"assets/images/products/25598_1600748937713.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(12, 'ADIDAS', 'RESPONSE RUNNER U', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290 / 300', 69000, 100, 'assets/images/thumbnails/20521_1691738614166.jpg', '[\"assets/images/products/20521_1691738614166.jpg\",\"assets/images/products/27578_1691738613991.jpg\",\"assets/images/products/50131_1691738614650.jpg\",\"assets/images/products/68740_1691738614339.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(13, 'ADIDAS', 'SUPERSTAR CF C', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '170 / 180 / 190 / 200 / 210', 39000, 100, 'assets/images/thumbnails/99343_1581065153026.jpg', '[\"assets/images/products/99343_1581065153026.jpg\",\"assets/images/products/89407_1581065152844.jpg\",\"assets/images/products/20596_1609207642510.jpg\",\"assets/images/products/18814_1581065153316.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(14, 'ADIDAS', 'ADIDAS SWITCH MOVE', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '250 / 255 / 260 / 265 / 270 / 275 / 280 / 290 / 300', 69000, 100, 'assets/images/thumbnails/99624_1695720229471.jpg', '[\"assets/images/products/99624_1695720229471.jpg\",\"assets/images/products/76060_1695720229646.jpg\",\"assets/images/products/47276_1695720229793.jpg\",\"assets/images/products/28129_1695720230083.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(15, 'ADIDAS', 'SUPERSTAR 360 BOOT', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '120 / 130 / 140 / 150 / 160', 53000, 100, 'assets/images/thumbnails/32030_1697445632926.jpg', '[\"assets/images/products/32030_1697445632926.jpg\",\"assets/images/products/33048_1697445633603.jpg\",\"assets/images/products/49221_1697445633264.jpg\",\"assets/images/products/79417_1697445633100.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(16, 'ADIDAS', 'DURAMO 10 EL K', 2, '인도네시아', '2024-01-01', '	아디다스코리아', '170 / 180 / 190 / 200 / 210 / 220 / 230 / 240', 29000, 100, 'assets/images/thumbnails/98516_1679993660077.jpg', '[\"assets/images/products/98516_1679993660077.jpg\",\"assets/images/products/45276_1679993660388.jpg\",\"assets/images/products/33358_1679993660231.jpg\",\"assets/images/products/22545_1679993660681.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(17, 'Newbalance', 'W480KR5', 3, '베트남', '2024-01-01', 'NEW BALANCE', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290', 99000, 100, 'assets/images/thumbnails/22913_1611630950959.jpg', '[\"assets/images/products/22913_1611630950959.jpg\",\"assets/images/products/25703_1611630951130.jpg\",\"assets/images/products/22567_1611630951430.jpg\",\"assets/images/products/33596_1611630951567.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(18, 'Newbalance', 'SD3601GGY', 3, '한국', '2024-01-01', 'NEW BALANCE', '220 / 230 / 240 / 250 / 260 / 270 / 280 / 290', 29000, 100, 'assets/images/thumbnails/38158_1587703410197.jpg', '[\"assets/images/products/38158_1587703410197.jpg\",\"assets/images/products/08850_1587703410667.jpg\",\"assets/images/products/39434_1587703410376.jpg\",\"assets/images/products/63104_1587703410822.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(19, 'Newbalance', 'PV2002SF', 3, '베트남', '2024-01-01', 'NEW BALANCE', '170 / 180 / 190 / 200 / 210 / 220', 109000, 100, 'assets/images/thumbnails/69796_1694395772765.jpg', '[\"assets/images/products/69796_1694395772765.jpg\",\"assets/images/products/35122_1694395773477.jpg\",\"assets/images/products/67426_1694395773968.jpg\",\"assets/images/products/77427_1694395773644.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(20, 'Newbalance', 'SD1501WT3', 3, '베트남', '2024-01-01', 'NEW BALANCE', '220 / 230 / 240 / 250 / 260 / 270 / 280 / 290', 59000, 100, 'assets/images/thumbnails/20_1.jpg', '[\"assets/images/products/20_1.jpg\",\"assets/images/products/20_2.jpg\",\"assets/images/products/20_3.jpg\",\"assets/images/products/20_4.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(21, 'Newbalance', 'SD1501BK3', 3, '한국', '2024-01-01', 'NEW BALANCE', '220 / 230 / 240 / 250 / 260 / 270 / 280 / 290', 59000, 100, 'assets/images/thumbnails/21_1.jpg', '[\"assets/images/products/21_1.jpg\",\"assets/images/products/21_2.jpg\",\"assets/images/products/21_3.jpg\",\"assets/images/products/21_4.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(22, 'Newbalance', 'SD3405KH2', 3, '한국', '2024-01-01', 'NEW BALANCE', '230 / 240 / 250 / 260 / 270 / 280 / 290', 119000, 100, 'assets/images/thumbnails/221.jpg', '[\"assets/images/products/221.jpg\",\"assets/images/products/222.jpg\",\"assets/images/products/223.jpg\",\"assets/images/products/224.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(23, 'Newbalance', 'CT05WP1', 3, '베트남', '2024-01-01', 'NEW BALANCE', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260', 69000, 100, 'assets/images/thumbnails/231.jpg', '[\"assets/images/products/231.jpg\",\"assets/images/products/232.jpg\",\"assets/images/products/233.jpg\",\"assets/images/products/234.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(24, 'VANS', 'STANCE', 4, '베트남', 'VANS', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290', 53000, 100, 'assets/images/thumbnails/241.jpg', '[\"assets/images/products/241.jpg\",\"assets/images/products/242.jpg\",\"assets/images/products/243.jpg\",\"assets/images/products/244.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(25, 'VANS', 'SLIP-ER 2', 4, '중국', 'VANS', '2024-01-01', '	220 / 230 / 240 / 250 / 260', 47000, 100, 'assets/images/thumbnails/251.jpg', '[\"assets/images/products/251.jpg\",\"assets/images/products/252.jpg\",\"assets/images/products/253.jpg\",\"assets/images/products/254.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(26, 'VANS', 'CLASSIC SLIP-ON', 4, '베트남', 'VANS', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290', 29000, 100, 'assets/images/thumbnails/261.jpg', '[\"assets/images/products/261.jpg\",\"assets/images/products/262.jpg\",\"assets/images/products/263.jpg\",\"assets/images/products/264.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(27, 'VANS', 'COMFYCUSH SLIP-ON', 4, '중국', 'VANS', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290 / 300', 60000, 100, 'assets/images/thumbnails/271.jpg', '[\"assets/images/products/271.jpg\",\"assets/images/products/272.jpg\",\"assets/images/products/273.jpg\",\"assets/images/products/274.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(28, 'VANS', 'CLASSIC SLIP-ON', 4, '베트남', 'VANS', '2024-01-01', '175 / 185 / 190 / 200 / 210', 34000, 100, 'assets/images/thumbnails/281.jpg', '[\"assets/images/products/281.jpg\",\"assets/images/products/282.jpg\",\"assets/images/products/283.jpg\",\"assets/images/products/284.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(29, 'VANS', 'OLD SKOOL', 4, '베트남', 'VANS', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290 / 300', 44000, 100, 'assets/images/thumbnails/291.jpg', '[\"assets/images/products/291.jpg\",\"assets/images/products/292.jpg\",\"assets/images/products/293.jpg\",\"assets/images/products/294.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(30, 'VANS', 'STYLE 36', 4, '중국', 'VANS', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 290', 69000, 100, 'assets/images/thumbnails/301.jpg', '[\"assets/images/products/301.jpg\",\"assets/images/products/302.jpg\",\"assets/images/products/303.jpg\",\"assets/images/products/304.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(31, 'Converse', 'CT AS Core', 5, '인도네시아', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290 / 300', 53000, 100, 'assets/images/thumbnails/311.jpg', '[\"assets/images/products/311.jpg\",\"assets/images/products/312.jpg\",\"assets/images/products/313.jpg\",\"assets/images/products/314.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(32, 'Converse', 'Chuck Taylor All Star 70', 5, '베트남', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290 / 300', 85000, 100, 'assets/images/thumbnails/321.jpg', '[\"assets/images/products/321.jpg\",\"assets/images/products/322.jpg\",\"assets/images/products/323.jpg\",\"assets/images/products/324.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(33, 'Converse', 'CTAS MOVE OX', 5, '베트남', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260', 76000, 100, 'assets/images/thumbnails/331.jpg', '[\"assets/images/products/331.jpg\",\"assets/images/products/332.jpg\",\"assets/images/products/333.jpg\",\"assets/images/products/334.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(34, 'Converse', 'CHUCK 70 OX', 5, '중국', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290 / 300', 39000, 100, 'assets/images/thumbnails/341.jpg', '[\"assets/images/products/341.jpg\",\"assets/images/products/342.jpg\",\"assets/images/products/343.jpg\",\"assets/images/products/344.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(35, 'Converse', 'CHUCK 70 HI', 5, '베트남', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290 / 300', 69000, 100, 'assets/images/thumbnails/351.jpg', '[\"assets/images/products/351.jpg\",\"assets/images/products/352.jpg\",\"assets/images/products/353.jpg\",\"assets/images/products/354.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(36, 'Converse', 'CTAS DAINTY MULE', 5, '베트남', 'CONVERSE', '2024-01-01', '220 / 225 / 230 / 235 / 240 / 245 / 250 / 255 / 260 / 270', 19000, 100, 'assets/images/thumbnails/361.jpg', '[\"assets/images/products/361.jpg\",\"assets/images/products/362.jpg\",\"assets/images/products/363.jpg\",\"assets/images/products/364.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(37, 'Converse', 'CHUCK 70 OX', 5, '베트남', 'CONVERSE', '2024-01-01', '170 / 180 / 190 / 200 / 210', 41000, 100, 'assets/images/thumbnails/371.jpg', '[\"assets/images/products/371.jpg\",\"assets/images/products/372.jpg\",\"assets/images/products/373.jpg\",\"assets/images/products/374.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(38, 'FILA', 'FILA FIELDGAGE', 6, '중국', '휠라코리아', '2024-01-01', '220 / 230 / 240 / 250 / 260 / 270 / 280', 69000, 100, 'assets/images/thumbnails/381.jpg', '[\"assets/images/products/381.jpg\",\"assets/images/products/382.jpg\",\"assets/images/products/383.jpg\",\"assets/images/products/384.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(39, 'FILA', 'FILA RGB PIER 2.0', 6, '중국', '휠라코리아', '2024-01-01', '230 / 240 / 250 / 260 / 270 / 280', 55000, 100, 'assets/images/thumbnails/391.jpg', '[\"assets/images/products/391.jpg\",\"assets/images/products/392.jpg\",\"assets/images/products/393.jpg\",\"assets/images/products/394.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(40, 'FILA', 'FILA PONG THONG', 6, '중국', '휠라코리아', '2024-01-01', '230 / 240 / 250 / 260 / 270 / 280', 19000, 100, 'assets/images/thumbnails/401.jpg', '[\"assets/images/products/401.jpg\",\"assets/images/products/402.jpg\",\"assets/images/products/403.jpg\",\"assets/images/products/404.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(41, 'FILA', 'FILA NEURON 3 STIMULUS', 6, '중국', '휠라코리아', '2024-01-01', '230 / 235 / 240 / 245 / 250 / 255 / 260 / 265 / 270 / 275 / 280 / 285', 49000, 100, 'assets/images/thumbnails/411.jpg', '[\"assets/images/products/411.jpg\",\"assets/images/products/412.jpg\",\"assets/images/products/413.jpg\",\"assets/images/products/414.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(42, 'FILA', 'FILA GGUMI LIGHT RABBIT', 6, '베트남', '휠라코리아', '2024-01-01', '170 / 180 / 190 / 200 / 210', 69000, 100, 'assets/images/thumbnails/421.jpg', '[\"assets/images/products/421.jpg\",\"assets/images/products/422.jpg\",\"assets/images/products/423.jpg\",\"assets/images/products/424.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(43, 'FILA', 'FILA TREXLER N3', 6, '중국', '휠라코리아', '2024-01-01', '220 / 230 / 240 / 250 / 260 / 270 / 280', 69000, 100, 'assets/images/thumbnails/431.jpg', '[\"assets/images/products/431.jpg\",\"assets/images/products/432.jpg\",\"assets/images/products/433.jpg\",\"assets/images/products/434.jpg\"]', '2023-11-16 15:34:35', NULL, NULL),
(44, 'FILA', 'FLUID TRAINER KD', 6, '중국', '휠라코리아', '2024-01-01', '170 / 180 / 190 / 200 / 210 / 220 / 230', 48000, 100, 'assets/images/thumbnails/441.jpg', '[\"assets/images/products/441.jpg\",\"assets/images/products/442.jpg\",\"assets/images/products/443.jpg\",\"assets/images/products/444.jpg\"]', '2023-11-16 15:34:35', NULL, NULL);

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT 'ID is used for management and auto-increase',
  `full_name` varchar(255) NOT NULL COMMENT 'Username',
  `birth_year` int(11) NOT NULL COMMENT 'Birth year',
  `gender` enum('male','female') NOT NULL COMMENT 'Gender',
  `email` varchar(255) NOT NULL COMMENT 'Email',
  `hashed_password` varchar(64) NOT NULL COMMENT 'Password after hashing with SHA256',
  `avatar_path` varchar(255) DEFAULT NULL COMMENT 'Path to save avatar',
  `address` longtext DEFAULT NULL COMMENT 'Delivery address, saved as json',
  `status` enum('activate','deactivate') NOT NULL COMMENT 'If set to deactivate, you will be banned',
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `delete_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user` (`id`, `full_name`, `birth_year`, `gender`, `email`, `hashed_password`, `avatar_path`, `address`, `status`, `create_at`, `update_at`, `delete_at`) VALUES
(1, '현준', 1993, 'male', '123@naver.com', 'c4965dce1c6d1e875b44edb2b4e7b761a6d2a59f4ec271786b298b29d6dc545e', 'assets/images/avatars/6e7eae42904517363a738483f2629e8760a278d2b090dfda7d50916ca092fe4c.webp', '[]', 'activate', '2023-11-17 09:54:01', NULL, NULL),
(2, '민성', 1994, 'male', 'naver@naver.com', '488ba517ecbe334d80d9b03835604247e2415b5c7a64150bf10edc3505b477b3', 'assets/images/avatars/0913a5b201de74b1cc693a3ce5254c31e963a4b334ebf34d0699f03b28972d55.webp', '[]', 'activate', '2023-11-17 10:01:32', NULL, NULL),
(3, '준혁', 1996, 'female', 'zzz@naver.com', 'b875317db55c109e8805165e6f5e61adf8f77a5f292f303caf180dab1856e503', 'assets/images/avatars/d78338e0264bc91f5ba801d979fa7a33a8882d6bce9a952cce9a004649a9523e.webp', '[]', 'activate', '2023-11-17 10:03:47', NULL, NULL),
(4, '영채', 1998, 'male', 'cloud@naver.com', '71b4cdd7716dda60cb6478a30f3611bab6404974b4031e6544ac6cd1952c1a74', 'assets/images/avatars/b4181bc38fe63d2cd5270ab78b616a84dfe1bd1b11b8e0281eea677903994328.webp', '[]', 'activate', '2023-11-20 15:34:35', NULL, NULL);

ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `order_data`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID is used for management and auto-increase', AUTO_INCREMENT=5;

ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID is used for management and auto-increase', AUTO_INCREMENT=7;

ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID is used for management and auto-increase';

ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID is used for management and auto-increase', AUTO_INCREMENT=51;

ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID is used for management and auto-increase', AUTO_INCREMENT=15;

ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `order_data`
  ADD CONSTRAINT `order_data_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_data_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;