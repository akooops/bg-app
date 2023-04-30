-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 29 avr. 2023 à 00:19
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `iec_bg`
--

-- --------------------------------------------------------

--
-- Structure de la table `action_events`
--

DROP TABLE IF EXISTS `action_events`;
CREATE TABLE IF NOT EXISTS `action_events` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `batch_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionable_id` bigint UNSIGNED NOT NULL,
  `target_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED DEFAULT NULL,
  `fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'running',
  `exception` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `original` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `changes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `action_events_actionable_type_actionable_id_index` (`actionable_type`,`actionable_id`),
  KEY `action_events_batch_id_model_type_model_id_index` (`batch_id`,`model_type`,`model_id`),
  KEY `action_events_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=609 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `action_events`
--

INSERT INTO `action_events` (`id`, `batch_id`, `user_id`, `name`, `actionable_type`, `actionable_id`, `target_type`, `target_id`, `model_type`, `model_id`, `fields`, `status`, `exception`, `created_at`, `updated_at`, `original`, `changes`) VALUES
(1, '92fb662f-b249-4bf7-b185-89002cc6ba34', 1, 'Create', 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, '', 'finished', '', '2021-03-18 15:21:28', '2021-03-18 15:21:28', NULL, '{\"name\":\"Chiffre d\'Affaire\",\"code\":\"ca\",\"updated_at\":\"2021-03-18T16:21:28.000000Z\",\"created_at\":\"2021-03-18T16:21:28.000000Z\",\"id\":1}'),
(2, '92fb663c-39aa-4fbf-9b55-c14d524f213b', 1, 'Update', 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, '', 'finished', '', '2021-03-18 15:21:36', '2021-03-18 15:21:36', '[]', '[]'),
(3, '92fb6667-d232-4bf9-99a9-8178ff408369', 1, 'Create', 'App\\Models\\Indicator', 2, 'App\\Models\\Indicator', 2, 'App\\Models\\Indicator', 2, '', 'finished', '', '2021-03-18 15:22:05', '2021-03-18 15:22:05', NULL, '{\"name\":\"Nombre d\'employ\\u00e9s\",\"code\":\"nb_workers\",\"updated_at\":\"2021-03-18T16:22:05.000000Z\",\"created_at\":\"2021-03-18T16:22:05.000000Z\",\"id\":2}'),
(4, '92fb667f-53a9-483c-89f0-ae9acbc2cd13', 1, 'Create', 'App\\Models\\Indicator', 3, 'App\\Models\\Indicator', 3, 'App\\Models\\Indicator', 3, '', 'finished', '', '2021-03-18 15:22:20', '2021-03-18 15:22:20', NULL, '{\"name\":\"Part du March\\u00e9\",\"code\":\"market_share\",\"updated_at\":\"2021-03-18T16:22:20.000000Z\",\"created_at\":\"2021-03-18T16:22:20.000000Z\",\"id\":3}'),
(5, '92ffdf9b-8436-4dff-9135-3a3df21e26f7', 1, 'Create', 'App\\Models\\Department', 1, 'App\\Models\\Department', 1, 'App\\Models\\Department', 1, '', 'finished', '', '2021-03-20 20:44:18', '2021-03-20 20:44:18', NULL, '{\"name\":\"Production\",\"starting_worker_nb\":\"5\",\"updated_at\":\"2021-03-20T21:44:18.000000Z\",\"created_at\":\"2021-03-20T21:44:18.000000Z\",\"id\":1}'),
(6, '92ffed8a-ac28-4ee1-86c6-513151b2f2f8', 1, 'Update', 'App\\Models\\Department', 1, 'App\\Models\\Department', 1, 'App\\Models\\Department', 1, '', 'finished', '', '2021-03-20 21:23:16', '2021-03-20 21:23:16', '{\"icon\":null}', '{\"icon\":\"fa-industry\"}'),
(7, '92ffedb6-0390-4372-928f-a092a4874c6a', 1, 'Create', 'App\\Models\\Department', 2, 'App\\Models\\Department', 2, 'App\\Models\\Department', 2, '', 'finished', '', '2021-03-20 21:23:44', '2021-03-20 21:23:44', NULL, '{\"name\":\"Approvisionnement\",\"icon\":\"fa-box-open\",\"starting_worker_nb\":\"2\",\"updated_at\":\"2021-03-20T22:23:44.000000Z\",\"created_at\":\"2021-03-20T22:23:44.000000Z\",\"id\":2}'),
(8, '92ffedcc-3088-405a-bf20-df318c0dc7a7', 1, 'Create', 'App\\Models\\Department', 3, 'App\\Models\\Department', 3, 'App\\Models\\Department', 3, '', 'finished', '', '2021-03-20 21:23:58', '2021-03-20 21:23:58', NULL, '{\"name\":\"Marketing\",\"icon\":\"fa-ad\",\"starting_worker_nb\":\"5\",\"updated_at\":\"2021-03-20T22:23:58.000000Z\",\"created_at\":\"2021-03-20T22:23:58.000000Z\",\"id\":3}'),
(9, '92ffee42-535d-426a-a86c-d9a03bf0542a', 1, 'Create', 'App\\Models\\Department', 4, 'App\\Models\\Department', 4, 'App\\Models\\Department', 4, '', 'finished', '', '2021-03-20 21:25:16', '2021-03-20 21:25:16', NULL, '{\"name\":\"Finance\",\"icon\":\"fa-file-invoice-dollar\",\"starting_worker_nb\":\"3\",\"updated_at\":\"2021-03-20T22:25:16.000000Z\",\"created_at\":\"2021-03-20T22:25:16.000000Z\",\"id\":4}'),
(10, '92fff0d8-2e81-48ac-bab4-5f675c9dbbc9', 1, 'Create', 'App\\Models\\Department', 5, 'App\\Models\\Department', 5, 'App\\Models\\Department', 5, '', 'finished', '', '2021-03-20 21:32:30', '2021-03-20 21:32:30', NULL, '{\"name\":\"RH\",\"icon\":\"fa-users\",\"starting_worker_nb\":\"2\",\"updated_at\":\"2021-03-20T22:32:30.000000Z\",\"created_at\":\"2021-03-20T22:32:30.000000Z\",\"id\":5}'),
(11, '9301324c-654b-44bf-808d-e1ecabfe56c6', 1, 'Create', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2021-03-21 12:31:21', '2021-03-21 12:31:21', NULL, '{\"name\":\"Amoxycyline\",\"unit\":\"g\",\"price\":\"10\",\"updated_at\":\"2021-03-21T13:31:21.000000Z\",\"created_at\":\"2021-03-21T13:31:21.000000Z\",\"id\":1}'),
(12, '93013271-d651-4556-beb6-047213419592', 1, 'Create', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2021-03-21 12:31:45', '2021-03-21 12:31:45', NULL, '{\"name\":\"Metaph\\u00e9tamine\",\"unit\":\"g\",\"price\":\"15\",\"updated_at\":\"2021-03-21T13:31:45.000000Z\",\"created_at\":\"2021-03-21T13:31:45.000000Z\",\"id\":2}'),
(13, '930132a4-3685-4582-b5d9-3b126947ebeb', 1, 'Create', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2021-03-21 12:32:18', '2021-03-21 12:32:18', NULL, '{\"name\":\"Ramoxyciline\",\"unit\":\"cl\",\"price\":\"5.2\",\"updated_at\":\"2021-03-21T13:32:18.000000Z\",\"created_at\":\"2021-03-21T13:32:18.000000Z\",\"id\":3}'),
(14, '930132d2-ed3c-4376-b441-21bde3083441', 1, 'Create', 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, '', 'finished', '', '2021-03-21 12:32:49', '2021-03-21 12:32:49', NULL, '{\"name\":\"Principe Actif 1\",\"unit\":\"g\",\"price\":\"25\",\"updated_at\":\"2021-03-21T13:32:49.000000Z\",\"created_at\":\"2021-03-21T13:32:49.000000Z\",\"id\":4}'),
(15, '9301335c-5e1e-4883-9067-7c736fd0cfa9', 1, 'Create', 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, '', 'finished', '', '2021-03-21 12:34:19', '2021-03-21 12:34:19', NULL, '{\"name\":\"Principe Actif 2\",\"unit\":\"g\",\"price\":\"25\",\"updated_at\":\"2021-03-21T13:34:19.000000Z\",\"created_at\":\"2021-03-21T13:34:19.000000Z\",\"id\":5}'),
(16, '9301336d-d54b-4f02-b557-0039ab848f91', 1, 'Create', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-03-21 12:34:30', '2021-03-21 12:34:30', NULL, '{\"name\":\"Doliprane\",\"updated_at\":\"2021-03-21T13:34:30.000000Z\",\"created_at\":\"2021-03-21T13:34:30.000000Z\",\"id\":1}'),
(17, '93013379-b36c-4186-b70d-7fd3cbad355c', 1, 'Create', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-03-21 12:34:38', '2021-03-21 12:34:38', NULL, '{\"name\":\"Clamoxyle\",\"updated_at\":\"2021-03-21T13:34:38.000000Z\",\"created_at\":\"2021-03-21T13:34:38.000000Z\",\"id\":2}'),
(18, '93013386-4bb0-49e2-9904-7d5217ee2998', 1, 'Create', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-03-21 12:34:46', '2021-03-21 12:34:46', NULL, '{\"name\":\"B\\u00e9conase\",\"updated_at\":\"2021-03-21T13:34:46.000000Z\",\"created_at\":\"2021-03-21T13:34:46.000000Z\",\"id\":3}'),
(19, '9301338b-675c-44a1-9712-b9cf0b5c7d57', 1, 'Create', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-03-21 12:34:50', '2021-03-21 12:34:50', NULL, '{\"name\":\"Smecta\",\"updated_at\":\"2021-03-21T13:34:50.000000Z\",\"created_at\":\"2021-03-21T13:34:50.000000Z\",\"id\":4}'),
(20, '93020016-d158-47c9-a5a8-bb6a1eba3074', 1, 'Create', 'App\\Models\\User', 2, 'App\\Models\\User', 2, 'App\\Models\\User', 2, '', 'finished', '', '2021-03-21 22:06:47', '2021-03-21 22:06:47', NULL, '{\"name\":\"Manou\",\"email\":\"manou@iec.com\",\"type\":\"supplier\",\"updated_at\":\"2021-03-21T23:06:47.000000Z\",\"created_at\":\"2021-03-21T23:06:47.000000Z\",\"id\":2}'),
(21, '930202ff-addb-409a-9394-59729ab27e09', 1, 'Update', 'App\\Models\\User', 2, 'App\\Models\\User', 2, 'App\\Models\\User', 2, '', 'finished', '', '2021-03-21 22:14:55', '2021-03-21 22:14:55', '{\"rate\":null,\"ddl_min\":null,\"ddl_max\":null}', '{\"rate\":\"1.2\",\"ddl_min\":\"2\",\"ddl_max\":\"5\"}'),
(22, '9306138a-ce6d-4812-adbc-4e68baf533ac', 1, 'Create', 'App\\Models\\User', 3, 'App\\Models\\User', 3, 'App\\Models\\User', 3, '', 'finished', '', '2021-03-23 22:44:29', '2021-03-23 22:44:29', NULL, '{\"name\":\"IndusPharm\",\"email\":\"induspharm@iec.com\",\"rate\":\"3\",\"ddl_min\":\"4\",\"ddl_max\":\"8\",\"type\":\"supplier\",\"updated_at\":\"2021-03-23T23:44:29.000000Z\",\"created_at\":\"2021-03-23T23:44:29.000000Z\",\"id\":3}'),
(23, '9309c5dd-e8e0-4f88-a61a-1a5a1a057e58', 2, 'Create', 'App\\Models\\User', 4, 'App\\Models\\User', 4, 'App\\Models\\User', 4, '', 'finished', '', '2021-03-25 18:50:36', '2021-03-25 18:50:36', NULL, '{\"name\":\"AGB Agent\",\"email\":\"agb@iec.com\",\"type\":\"banker\",\"updated_at\":\"2021-03-25T19:50:36.000000Z\",\"created_at\":\"2021-03-25T19:50:36.000000Z\",\"id\":4}'),
(24, '9315198c-d07d-4d78-932b-e95b8bded727', 1, 'Update', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-03-31 09:58:42', '2021-03-31 09:58:42', '{\"price_min\":0,\"price_max\":null}', '{\"price_min\":\"10\",\"price_max\":\"100\"}'),
(25, '931519c1-da8b-4669-8f92-5cb99586e489', 1, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-03-31 09:59:17', '2021-03-31 09:59:17', '{\"price_max\":null}', '{\"price_max\":\"12\"}'),
(26, '93153f7d-2056-4141-87dc-08636354c7c1', 1, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-03-31 11:44:47', '2021-03-31 11:44:47', '{\"price_min\":0,\"price_max\":12}', '{\"price_min\":\"1\",\"price_max\":\"150\"}'),
(27, '93153f94-bea0-44ff-ab36-2897ccb9b55f', 1, 'Update', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-03-31 11:45:03', '2021-03-31 11:45:03', '{\"price_min\":0,\"price_max\":null}', '{\"price_min\":\"1\",\"price_max\":\"98\"}'),
(28, '93153fb8-2763-437e-8bf5-574672735984', 1, 'Update', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-03-31 11:45:26', '2021-03-31 11:45:26', '{\"price_min\":0,\"price_max\":null}', '{\"price_min\":\"30\",\"price_max\":\"60\"}'),
(29, '93154032-a372-4599-a258-500196d4c621', 1, 'Update', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-03-31 11:46:46', '2021-03-31 11:46:46', '{\"price_min\":30,\"price_max\":60}', '{\"price_min\":\"1\",\"price_max\":\"20\"}'),
(30, '93154624-e904-4892-b721-b91309910e3d', 1, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-03-31 12:03:24', '2021-03-31 12:03:24', '{\"price_min\":1,\"price_max\":150}', '{\"price_min\":\"10\",\"price_max\":\"70\"}'),
(31, '931580bd-8390-406d-9853-ceff46cb7429', 1, 'Create', 'App\\Models\\Indicator', 4, 'App\\Models\\Indicator', 4, 'App\\Models\\Indicator', 4, '', 'finished', '', '2021-03-31 14:47:15', '2021-03-31 14:47:15', NULL, '{\"name\":\"Nombre Employ\\u00e9s - Production\",\"code\":\"nb_worker_prod\",\"updated_at\":\"2021-03-31T15:47:14.000000Z\",\"created_at\":\"2021-03-31T15:47:14.000000Z\",\"id\":4}'),
(32, '931580e4-4800-4ada-aa0a-ad50eafd3a60', 1, 'Create', 'App\\Models\\Indicator', 5, 'App\\Models\\Indicator', 5, 'App\\Models\\Indicator', 5, '', 'finished', '', '2021-03-31 14:47:40', '2021-03-31 14:47:40', NULL, '{\"name\":\"Capacit\\u00e9 de Production\",\"code\":\"prod_capacity\",\"updated_at\":\"2021-03-31T15:47:40.000000Z\",\"created_at\":\"2021-03-31T15:47:40.000000Z\",\"id\":5}'),
(33, '93178d8a-9216-49f9-b65d-d240d321d11b', 1, 'Create', 'App\\Models\\Indicator', 10, 'App\\Models\\Indicator', 10, 'App\\Models\\Indicator', 10, '', 'finished', '', '2021-04-01 15:14:42', '2021-04-01 15:14:42', NULL, '{\"name\":\"Taux de Rebut\",\"code\":\"reject_rate\",\"starting_value\":\"0.05\",\"is_financial\":false,\"updated_at\":\"2021-04-01T16:14:41.000000Z\",\"created_at\":\"2021-04-01T16:14:41.000000Z\",\"id\":10}'),
(34, '93178dd2-5dfd-480e-b41f-a7704ea76b0b', 1, 'Delete', 'App\\Models\\Indicator', 10, 'App\\Models\\Indicator', 10, 'App\\Models\\Indicator', 10, '', 'finished', '', '2021-04-01 15:15:29', '2021-04-01 15:15:29', NULL, NULL),
(35, '93178de7-5f28-4685-ada8-aeda961689a1', 1, 'Create', 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, '', 'finished', '', '2021-04-01 15:15:42', '2021-04-01 15:15:42', NULL, '{\"name\":\"Taux de Rebut\",\"code\":\"reject_rate\",\"starting_value\":\"0.05\",\"is_financial\":false,\"updated_at\":\"2021-04-01T16:15:42.000000Z\",\"created_at\":\"2021-04-01T16:15:42.000000Z\",\"id\":11}'),
(36, '93180b5e-38a3-47d8-af88-8c89019a33db', 1, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-01 21:06:32', '2021-04-01 21:06:32', '{\"machine_units\":1,\"labor_units\":1}', '{\"machine_units\":\"2\",\"labor_units\":\"3\"}'),
(37, '93181592-53c8-4cf1-8683-115bda66973f', 1, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:35:04', '2021-04-01 21:35:04', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"1\",\"quantity\":\"12\"}'),
(38, '931815a2-3f7c-4902-9e9a-f5bcc400bf8e', 1, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 4, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:35:14', '2021-04-01 21:35:14', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"4\",\"quantity\":\"10\"}'),
(39, '931815b7-a783-4630-890f-0d9632e7595b', 1, 'Attach', 'App\\Models\\Product', 2, 'App\\Models\\RawMaterial', 3, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:35:28', '2021-04-01 21:35:28', NULL, '{\"product_id\":\"2\",\"raw_material_id\":\"3\",\"quantity\":\"12\"}'),
(40, '931815c0-f4a2-43b7-9b82-4c0674a5c153', 1, 'Attach', 'App\\Models\\Product', 2, 'App\\Models\\RawMaterial', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:35:34', '2021-04-01 21:35:34', NULL, '{\"product_id\":\"2\",\"raw_material_id\":\"2\",\"quantity\":\"15\"}'),
(41, '931815e1-5bc5-4a6d-8517-c5056016560d', 1, 'Attach', 'App\\Models\\Product', 2, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:35:55', '2021-04-01 21:35:55', NULL, '{\"product_id\":\"2\",\"raw_material_id\":\"1\",\"quantity\":\"8\"}'),
(42, '93181642-0c24-4fd3-a884-e5ca6b595e41', 1, 'Update', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-04-01 21:36:59', '2021-04-01 21:36:59', '{\"labor_units\":1}', '{\"labor_units\":\"2\"}'),
(43, '9318164e-0ea4-438a-a21a-56e8fc8089bf', 1, 'Attach', 'App\\Models\\Product', 3, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:37:07', '2021-04-01 21:37:07', NULL, '{\"product_id\":\"3\",\"raw_material_id\":\"1\",\"quantity\":\"5\"}'),
(44, '93181666-d11e-4df3-9178-9e2afe04bc05', 1, 'Update', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-04-01 21:37:23', '2021-04-01 21:37:23', '{\"machine_units\":1,\"labor_units\":1}', '{\"machine_units\":\"2\",\"labor_units\":\"4\"}'),
(45, '93181674-dfeb-46c9-b7f6-3d37a15a54be', 1, 'Update Attached', 'App\\Models\\Product', 4, 'App\\Models\\RawMaterial', 4, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:37:32', '2021-04-01 21:37:32', '{\"quantity\":null}', '{\"quantity\":\"5\"}'),
(46, '9318167f-a3e5-452e-8e69-8712d9708669', 1, 'Update Attached', 'App\\Models\\Product', 4, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-01 21:37:39', '2021-04-01 21:37:39', '{\"quantity\":null}', '{\"quantity\":\"9\"}'),
(47, '931a10f7-49fe-4e26-b887-fecaf87290c0', 1, 'Create', 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, '', 'finished', '', '2021-04-02 21:13:50', '2021-04-02 21:13:50', NULL, '{\"name\":\"Disponibilit\\u00e9\",\"code\":\"caisse\",\"starting_value\":\"100000\",\"is_financial\":true,\"updated_at\":\"2021-04-02T22:13:50.000000Z\",\"created_at\":\"2021-04-02T22:13:50.000000Z\",\"id\":12}'),
(48, '931a1119-8076-49f2-b149-a259409f5869', 1, 'Create', 'App\\Models\\Indicator', 13, 'App\\Models\\Indicator', 13, 'App\\Models\\Indicator', 13, '', 'finished', '', '2021-04-02 21:14:13', '2021-04-02 21:14:13', NULL, '{\"name\":\"C\\u00f4uts de Production\",\"code\":\"prod_cost\",\"starting_value\":\"0\",\"is_financial\":true,\"updated_at\":\"2021-04-02T22:14:13.000000Z\",\"created_at\":\"2021-04-02T22:14:13.000000Z\",\"id\":13}'),
(49, '931a112f-50b8-4d9b-bdd2-ff84dd3f0976', 1, 'Update', 'App\\Models\\Indicator', 13, 'App\\Models\\Indicator', 13, 'App\\Models\\Indicator', 13, '', 'finished', '', '2021-04-02 21:14:27', '2021-04-02 21:14:27', '{\"name\":\"C\\u00f4uts de Production\",\"is_financial\":1}', '{\"name\":\"Co\\u00fbts de Production\",\"is_financial\":true}'),
(50, '931a2b0a-a2d0-42db-8919-6b20a1fc9938', 1, 'Create', 'App\\Models\\Indicator', 14, 'App\\Models\\Indicator', 14, 'App\\Models\\Indicator', 14, '', 'finished', '', '2021-04-02 22:26:45', '2021-04-02 22:26:45', NULL, '{\"name\":\"Coefficient de Productivit\\u00e9\",\"code\":\"productivity_coeff\",\"starting_value\":\"1.0\",\"is_financial\":false,\"updated_at\":\"2021-04-02T23:26:45.000000Z\",\"created_at\":\"2021-04-02T23:26:45.000000Z\",\"id\":14}'),
(51, '931ce812-540b-45dc-be8f-72ce0259ecdc', 1, 'Create', 'App\\Models\\Indicator', 15, 'App\\Models\\Indicator', 15, 'App\\Models\\Indicator', 15, '', 'finished', '', '2021-04-04 07:06:58', '2021-04-04 07:06:58', NULL, '{\"name\":\"Machine Occup\\u00e9es\",\"code\":\"busy_machines\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T08:06:58.000000Z\",\"created_at\":\"2021-04-04T08:06:58.000000Z\",\"id\":15}'),
(52, '931ce92a-e019-4aa3-b6f7-2f72decad26b', 1, 'Create', 'App\\Models\\Indicator', 16, 'App\\Models\\Indicator', 16, 'App\\Models\\Indicator', 16, '', 'finished', '', '2021-04-04 07:10:02', '2021-04-04 07:10:02', NULL, '{\"name\":\"Machines en Pannes\",\"code\":\"failed_machines\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T08:10:02.000000Z\",\"created_at\":\"2021-04-04T08:10:02.000000Z\",\"id\":16}'),
(53, '931de9ab-c043-4efe-a89c-be580b06a8c8', 1, 'Create', 'App\\Models\\Indicator', 17, 'App\\Models\\Indicator', 17, 'App\\Models\\Indicator', 17, '', 'finished', '', '2021-04-04 19:07:16', '2021-04-04 19:07:16', NULL, '{\"name\":\"Nombre d\'Abonn\\u00e9s\",\"code\":\"nb_subscribers\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T20:07:15.000000Z\",\"created_at\":\"2021-04-04T20:07:15.000000Z\",\"id\":17}'),
(54, '931de9d4-2b61-4496-8c35-66c704e0899d', 1, 'Create', 'App\\Models\\Indicator', 18, 'App\\Models\\Indicator', 18, 'App\\Models\\Indicator', 18, '', 'finished', '', '2021-04-04 19:07:43', '2021-04-04 19:07:43', NULL, '{\"name\":\"Pr\\u00e9sence RSS\",\"code\":\"social_presence\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T20:07:43.000000Z\",\"created_at\":\"2021-04-04T20:07:43.000000Z\",\"id\":18}'),
(55, '931de9ec-d925-40db-8861-7046cf43df6d', 1, 'Create', 'App\\Models\\Indicator', 19, 'App\\Models\\Indicator', 19, 'App\\Models\\Indicator', 19, '', 'finished', '', '2021-04-04 19:07:59', '2021-04-04 19:07:59', NULL, '{\"name\":\"Pr\\u00e9sence sur les M\\u00e9dias\",\"code\":\"media_presence\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T20:07:59.000000Z\",\"created_at\":\"2021-04-04T20:07:59.000000Z\",\"id\":19}'),
(56, '931dea27-046a-4f4b-8132-a846e9238de9', 1, 'Create', 'App\\Models\\Indicator', 20, 'App\\Models\\Indicator', 20, 'App\\Models\\Indicator', 20, '', 'finished', '', '2021-04-04 19:08:37', '2021-04-04 19:08:37', NULL, '{\"name\":\"Pr\\u00e9sence aux \\u00c9v\\u00e8nements\",\"code\":\"event_presence\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-04T20:08:37.000000Z\",\"created_at\":\"2021-04-04T20:08:37.000000Z\",\"id\":20}'),
(57, '931deb86-7a28-40d9-8112-646fa95e115b', 1, 'Update', 'App\\Models\\Indicator', 17, 'App\\Models\\Indicator', 17, 'App\\Models\\Indicator', 17, '', 'finished', '', '2021-04-04 19:12:27', '2021-04-04 19:12:27', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"10\",\"is_financial\":false}'),
(58, '931e192f-3f07-415d-bc91-9217c00fecb1', 1, 'Create', 'App\\Models\\Indicator', 21, 'App\\Models\\Indicator', 21, 'App\\Models\\Indicator', 21, '', 'finished', '', '2021-04-04 21:20:08', '2021-04-04 21:20:08', NULL, '{\"name\":\"Co\\u00fbt Unitaire de Distribution\",\"code\":\"dist_unit_cost\",\"starting_value\":\"0.5\",\"is_financial\":false,\"updated_at\":\"2021-04-04T22:20:08.000000Z\",\"created_at\":\"2021-04-04T22:20:08.000000Z\",\"id\":21}'),
(59, '931e21dd-ac76-413a-ac8b-3b27ede404d6', 1, 'Create', 'App\\Models\\Indicator', 22, 'App\\Models\\Indicator', 22, 'App\\Models\\Indicator', 22, '', 'finished', '', '2021-04-04 21:44:24', '2021-04-04 21:44:24', NULL, '{\"name\":\"Co\\u00fbts de Distribution\",\"code\":\"dist_cost\",\"starting_value\":\"0\",\"is_financial\":true,\"updated_at\":\"2021-04-04T22:44:24.000000Z\",\"created_at\":\"2021-04-04T22:44:24.000000Z\",\"id\":22}'),
(60, '9321daef-62e2-43f9-ae84-18ca4bce7a2d', 1, 'Create', 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, '', 'finished', '', '2021-04-06 18:09:23', '2021-04-06 18:09:23', NULL, '{\"name\":\"Fiabilit\\u00e9 des Machines\",\"code\":\"machines_health\",\"starting_value\":\"0.7\",\"is_financial\":false,\"updated_at\":\"2021-04-06T19:09:23.000000Z\",\"created_at\":\"2021-04-06T19:09:23.000000Z\",\"id\":23}'),
(61, '9321db2b-03fa-4e2c-9a50-42d26dd7fd0b', 1, 'Update', 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, '', 'finished', '', '2021-04-06 18:10:02', '2021-04-06 18:10:02', '{\"starting_value\":1,\"is_financial\":0}', '{\"starting_value\":\"0.7\",\"is_financial\":false}'),
(62, '9321db72-3035-483e-a98a-c9a4a87887e3', 1, 'Update', 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, '', 'finished', '', '2021-04-06 18:10:48', '2021-04-06 18:10:48', '{\"starting_value\":1,\"is_financial\":0}', '{\"starting_value\":\"70\",\"is_financial\":false}'),
(63, '9321dd86-fc4e-46a7-a2be-61c428d8f753', 1, 'Update', 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, '', 'finished', '', '2021-04-06 18:16:38', '2021-04-06 18:16:38', '{\"starting_value\":70,\"is_financial\":0}', '{\"starting_value\":\"0.7\",\"is_financial\":false}'),
(64, '9321e535-8b06-48ad-92ea-5fb8c2e3b1c4', 1, 'Update', 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, 'App\\Models\\Indicator', 23, '', 'finished', '', '2021-04-06 18:38:06', '2021-04-06 18:38:06', '{\"starting_value\":1,\"is_financial\":0}', '{\"starting_value\":\"0.7\",\"is_financial\":false}'),
(65, '93233758-318b-4b1b-b95a-64c16c38f6c4', 1, 'Create', 'App\\Models\\Indicator', 24, 'App\\Models\\Indicator', 24, 'App\\Models\\Indicator', 24, '', 'finished', '', '2021-04-07 11:23:36', '2021-04-07 11:23:36', NULL, '{\"name\":\"Co\\u00fbts de Mati\\u00e8re Premi\\u00e8re\",\"code\":\"raw_materials_cost\",\"starting_value\":\"0\",\"is_financial\":true,\"updated_at\":\"2021-04-07T11:23:36.000000Z\",\"created_at\":\"2021-04-07T11:23:36.000000Z\",\"id\":24}'),
(66, '9323bf47-9e77-400c-a71f-4f68e8da4803', 1, 'Create', 'App\\Models\\Indicator', 25, 'App\\Models\\Indicator', 25, 'App\\Models\\Indicator', 25, '', 'finished', '', '2021-04-07 17:43:42', '2021-04-07 17:43:42', NULL, '{\"name\":\"Chiffre d\'Affaire du Produit 1\",\"code\":\"ca_1\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-07T17:43:42.000000Z\",\"created_at\":\"2021-04-07T17:43:42.000000Z\",\"id\":25}'),
(67, '9323bf54-b202-43d8-9e6b-e78f32bcbad0', 1, 'Create', 'App\\Models\\Indicator', 26, 'App\\Models\\Indicator', 26, 'App\\Models\\Indicator', 26, '', 'finished', '', '2021-04-07 17:43:51', '2021-04-07 17:43:51', NULL, '{\"name\":\"Chiffre d\'Affaire du Produit 2\",\"code\":\"ca_2\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-07T17:43:51.000000Z\",\"created_at\":\"2021-04-07T17:43:51.000000Z\",\"id\":26}'),
(68, '9323bf66-a379-4545-828f-30de6525e878', 1, 'Create', 'App\\Models\\Indicator', 27, 'App\\Models\\Indicator', 27, 'App\\Models\\Indicator', 27, '', 'finished', '', '2021-04-07 17:44:03', '2021-04-07 17:44:03', NULL, '{\"name\":\"Chiffre d\'Affaire du Produit 3\",\"code\":\"ca_3\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-07T17:44:03.000000Z\",\"created_at\":\"2021-04-07T17:44:03.000000Z\",\"id\":27}'),
(69, '9323bf7d-065d-4ee5-b4e7-cc452cb091db', 1, 'Create', 'App\\Models\\Indicator', 28, 'App\\Models\\Indicator', 28, 'App\\Models\\Indicator', 28, '', 'finished', '', '2021-04-07 17:44:17', '2021-04-07 17:44:17', NULL, '{\"name\":\"Chiffre d\'Affaire du Produit 4\",\"code\":\"ca_4\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2021-04-07T17:44:17.000000Z\",\"created_at\":\"2021-04-07T17:44:17.000000Z\",\"id\":28}'),
(70, '9323d213-4006-4bbc-b097-7061281d4bd3', 1, 'Create', 'App\\Models\\User', 5, 'App\\Models\\User', 5, 'App\\Models\\User', 5, '', 'finished', '', '2021-04-07 18:36:16', '2021-04-07 18:36:16', NULL, '{\"name\":\"Henkel\",\"email\":\"henkel@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-07T18:36:16.000000Z\",\"created_at\":\"2021-04-07T18:36:16.000000Z\",\"id\":5}'),
(71, '9323d28e-888b-4dd7-8570-8cb78302d0ee', 1, 'Create', 'App\\Models\\User', 6, 'App\\Models\\User', 6, 'App\\Models\\User', 6, '', 'finished', '', '2021-04-07 18:37:36', '2021-04-07 18:37:36', NULL, '{\"name\":\"P2P\",\"email\":\"p2p@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-07T18:37:36.000000Z\",\"created_at\":\"2021-04-07T18:37:36.000000Z\",\"id\":6}'),
(72, '9323d2a6-853c-4b3a-9262-28d7ca67867d', 1, 'Update', 'App\\Models\\User', 5, 'App\\Models\\User', 5, 'App\\Models\\User', 5, '', 'finished', '', '2021-04-07 18:37:52', '2021-04-07 18:37:52', '{\"password\":\"$2y$10$50qIbHWZ.ZdAS.hagXB1pu1ekyk0sshviCsEWxPMg8UR0dMJMWMlS\"}', '{\"password\":\"$2y$10$\\/UMxS4ofVg0yJ.PIMFLIsejlbqw\\/21MI5QJEfeFY8ENWVTHXyXbey\"}'),
(73, '9323d421-96e7-4b1e-9de3-d61adfddb91d', 1, 'Update', 'App\\Models\\Indicator', 28, 'App\\Models\\Indicator', 28, 'App\\Models\\Indicator', 28, '', 'finished', '', '2021-04-07 18:42:01', '2021-04-07 18:42:01', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"1000\",\"is_financial\":false}'),
(74, '9323d433-c1c9-49fd-9ff5-ec22555e3395', 1, 'Update', 'App\\Models\\Indicator', 27, 'App\\Models\\Indicator', 27, 'App\\Models\\Indicator', 27, '', 'finished', '', '2021-04-07 18:42:13', '2021-04-07 18:42:13', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"1000\",\"is_financial\":false}'),
(75, '9323d43e-75df-4152-944b-e3693659ecdf', 1, 'Update', 'App\\Models\\Indicator', 25, 'App\\Models\\Indicator', 25, 'App\\Models\\Indicator', 25, '', 'finished', '', '2021-04-07 18:42:20', '2021-04-07 18:42:20', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"1000\",\"is_financial\":false}'),
(76, '9323d44c-6585-45a3-973f-9a2722e52061', 1, 'Update', 'App\\Models\\Indicator', 26, 'App\\Models\\Indicator', 26, 'App\\Models\\Indicator', 26, '', 'finished', '', '2021-04-07 18:42:29', '2021-04-07 18:42:29', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"1000\",\"is_financial\":false}'),
(77, '9323d487-ab49-48d1-b0b3-ca1f64c308b3', 1, 'Update', 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, 'App\\Models\\Indicator', 1, '', 'finished', '', '2021-04-07 18:43:07', '2021-04-07 18:43:07', '{\"starting_value\":0,\"is_financial\":1}', '{\"starting_value\":\"4000\",\"is_financial\":true}'),
(78, '932433e2-5576-49f3-bbdc-e5e33e7adb75', 1, 'Create', 'App\\Models\\Indicator', 29, 'App\\Models\\Indicator', 29, 'App\\Models\\Indicator', 29, '', 'finished', '', '2021-04-07 23:09:45', '2021-04-07 23:09:45', NULL, '{\"name\":\"Dettes\",\"code\":\"dettes\",\"starting_value\":\"0\",\"is_financial\":true,\"updated_at\":\"2021-04-07T23:09:45.000000Z\",\"created_at\":\"2021-04-07T23:09:45.000000Z\",\"id\":29}'),
(79, '932515a3-21c5-4575-a8bd-c60e33e661f9', 1, 'Create', 'App\\Models\\User', 7, 'App\\Models\\User', 7, 'App\\Models\\User', 7, '', 'finished', '', '2021-04-08 09:41:00', '2021-04-08 09:41:00', NULL, '{\"name\":\"Walid\",\"email\":\"walid@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-08T09:41:00.000000Z\",\"created_at\":\"2021-04-08T09:41:00.000000Z\",\"id\":7}'),
(80, '93252404-b1e7-43b3-b5ca-c2e6cb9f2afe', 1, 'Create', 'App\\Models\\User', 8, 'App\\Models\\User', 8, 'App\\Models\\User', 8, '', 'finished', '', '2021-04-08 10:21:13', '2021-04-08 10:21:13', NULL, '{\"name\":\"Nestl\\u00e9\",\"email\":\"neste@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-08T10:21:13.000000Z\",\"created_at\":\"2021-04-08T10:21:13.000000Z\",\"id\":8}'),
(81, '93252421-6842-4969-a766-03b8adcdec9a', 1, 'Create', 'App\\Models\\User', 9, 'App\\Models\\User', 9, 'App\\Models\\User', 9, '', 'finished', '', '2021-04-08 10:21:32', '2021-04-08 10:21:32', NULL, '{\"name\":\"Fournisseur\",\"email\":\"sofiane@business.game\",\"rate\":\"1\",\"ddl_min\":\"2\",\"ddl_max\":\"6\",\"type\":\"supplier\",\"updated_at\":\"2021-04-08T10:21:32.000000Z\",\"created_at\":\"2021-04-08T10:21:32.000000Z\",\"id\":9}'),
(82, '93252446-1ae5-4bdb-b987-d4de3ee14fd2', 1, 'Create', 'App\\Models\\User', 10, 'App\\Models\\User', 10, 'App\\Models\\User', 10, '', 'finished', '', '2021-04-08 10:21:56', '2021-04-08 10:21:56', NULL, '{\"name\":\"Anya Inc\",\"email\":\"anya@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-08T10:21:56.000000Z\",\"created_at\":\"2021-04-08T10:21:56.000000Z\",\"id\":10}'),
(83, '9325246d-37ac-4947-9dcd-0a7e8f928135', 1, 'Update', 'App\\Models\\User', 8, 'App\\Models\\User', 8, 'App\\Models\\User', 8, '', 'finished', '', '2021-04-08 10:22:22', '2021-04-08 10:22:22', '{\"name\":\"Nestl\\u00e9\",\"email\":\"neste@iec.com\",\"password\":\"$2y$10$0lc2e\\/GCWOUDwAa1EyGKGOOAn0zMUxxkGNsrn3iv45Cl1T\\/f8XEAW\"}', '{\"name\":\"Aziz Inc\",\"email\":\"aziz@iec.com\",\"password\":\"$2y$10$HrobUV93cKrk6Ytd6ijyd..m2RLQ8yvDoig8aPAj6gGDuLlYzQrNi\"}'),
(84, '93252484-ba94-48e5-aa73-df2c9828cc64', 1, 'Create', 'App\\Models\\User', 11, 'App\\Models\\User', 11, 'App\\Models\\User', 11, '', 'finished', '', '2021-04-08 10:22:37', '2021-04-08 10:22:37', NULL, '{\"name\":\"Team 8\",\"email\":\"aziz@business.game\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-08T10:22:37.000000Z\",\"created_at\":\"2021-04-08T10:22:37.000000Z\",\"id\":11}'),
(85, '93252490-bef2-49f4-8f4f-07ee696a82a3', 1, 'Create', 'App\\Models\\User', 12, 'App\\Models\\User', 12, 'App\\Models\\User', 12, '', 'finished', '', '2021-04-08 10:22:45', '2021-04-08 10:22:45', NULL, '{\"name\":\"Nabil\",\"email\":\"nabil@iec.com\",\"type\":\"entreprise\",\"updated_at\":\"2021-04-08T10:22:45.000000Z\",\"created_at\":\"2021-04-08T10:22:45.000000Z\",\"id\":12}'),
(86, '9325252e-b4cd-4c16-85ff-1a79af8ea389', 1, 'Update', 'App\\Models\\User', 8, 'App\\Models\\User', 8, 'App\\Models\\User', 8, '', 'finished', '', '2021-04-08 10:24:28', '2021-04-08 10:24:28', '{\"name\":\"Aziz Inc\",\"email\":\"aziz@iec.com\",\"password\":\"$2y$10$HrobUV93cKrk6Ytd6ijyd..m2RLQ8yvDoig8aPAj6gGDuLlYzQrNi\"}', '{\"name\":\"Melissa & Celia Co\",\"email\":\"melissa@iec.com\",\"password\":\"$2y$10$F7GKU1Nguk7DtZSRDGDf9.J6kkVLa7siq5VjNsX52KhXkpMe03YGq\"}'),
(87, '9325266c-531a-4b02-804f-d25b4088498f', 1, 'Update', 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, '', 'finished', '', '2021-04-08 10:27:57', '2021-04-08 10:27:57', '{\"starting_value\":100000,\"is_financial\":1}', '{\"starting_value\":\"10000000\",\"is_financial\":true}'),
(88, '93252722-60fb-46db-9b65-831dfa176a43', 1, 'Update', 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, '', 'finished', '', '2021-04-08 10:29:56', '2021-04-08 10:29:56', '{\"starting_value\":10000000,\"is_financial\":1}', '{\"starting_value\":\"100000\",\"is_financial\":true}'),
(89, '9325272e-9955-4563-95cc-d217ea3cfd58', 1, 'Update', 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, 'App\\Models\\Indicator', 12, '', 'finished', '', '2021-04-08 10:30:04', '2021-04-08 10:30:04', '{\"starting_value\":100000,\"is_financial\":1}', '{\"starting_value\":\"900000\",\"is_financial\":true}'),
(90, '9325283a-73ed-4fb4-8291-130eba4887d5', 1, 'Update', 'App\\Models\\User', 12, 'App\\Models\\User', 12, 'App\\Models\\User', 12, '', 'finished', '', '2021-04-08 10:32:59', '2021-04-08 10:32:59', '{\"type\":\"entreprise\"}', '{\"type\":\"banker\"}'),
(91, '93252927-f289-4f4b-bcc1-93eee4528e8d', 1, 'Create', 'App\\Models\\Indicator', 30, 'App\\Models\\Indicator', 30, 'App\\Models\\Indicator', 30, '', 'finished', '', '2021-04-08 10:35:35', '2021-04-08 10:35:35', NULL, '{\"name\":\"Taux d\'endettement\",\"code\":\"debt_ratio\",\"starting_value\":\"1\",\"is_financial\":false,\"updated_at\":\"2021-04-08T10:35:35.000000Z\",\"created_at\":\"2021-04-08T10:35:35.000000Z\",\"id\":30}'),
(92, '93252943-a851-4dc9-a59e-585ff6739cc3', 1, 'Create', 'App\\Models\\Indicator', 31, 'App\\Models\\Indicator', 31, 'App\\Models\\Indicator', 31, '', 'finished', '', '2021-04-08 10:35:53', '2021-04-08 10:35:53', NULL, '{\"name\":\"Humeur des empoly\\u00e9s\",\"code\":\"workers_mood\",\"starting_value\":\"0.6\",\"is_financial\":false,\"updated_at\":\"2021-04-08T10:35:53.000000Z\",\"created_at\":\"2021-04-08T10:35:53.000000Z\",\"id\":31}'),
(93, '93252f66-2b2d-42d9-9fbd-42cb6a298271', 1, 'Update', 'App\\Models\\Department', 5, 'App\\Models\\Department', 5, 'App\\Models\\Department', 5, '', 'finished', '', '2021-04-08 10:53:02', '2021-04-08 10:53:02', '{\"name\":\"RH\"}', '{\"name\":\"Ressources Humaines\"}'),
(94, '93259115-4128-4cae-9399-69ae6d1bb3c0', 5, 'Update', 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, '', 'finished', '', '2021-04-08 15:26:11', '2021-04-08 15:26:11', '{\"starting_value\":0,\"is_financial\":0}', '{\"starting_value\":\"0.05\",\"is_financial\":false}'),
(95, '9325911d-f837-4c31-89d3-d98eb3376bbb', 5, 'Update', 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, 'App\\Models\\Indicator', 11, '', 'finished', '', '2021-04-08 15:26:17', '2021-04-08 15:26:17', '{\"is_financial\":0}', '{\"is_financial\":false}'),
(96, '9326415a-5e3f-42c5-af76-4841048b8a84', 5, 'Create', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-08 23:39:04', '2021-04-08 23:39:04', NULL, '{\"name\":\"Smartphone BG Pro\",\"description\":\"Smartphone performant avec une RAM de 4  GO, une cam\\u00e9ra de 16 MP et un espace de stockage de 32 GB, ce smartphone est tr\\u00e8s populaire de nos jours, cepandant, la demande d\\u00e9croit tr\\u00e8s rapidement avec l\'augmentation du prix, le marketing n\'est pas assez important pour ce produit.\",\"price_min\":\"20000\",\"price_max\":\"29000\",\"machine_units\":\"2\",\"ad_coef\":\"1\",\"labor_units\":\"2\",\"updated_at\":\"2021-04-08T23:39:04.000000Z\",\"created_at\":\"2021-04-08T23:39:04.000000Z\",\"id\":1}'),
(97, '9326423f-8fd8-422b-bfe1-fc05200c4210', 5, 'Create', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-08 23:41:35', '2021-04-08 23:41:35', NULL, '{\"name\":\"Smartphone BG S+\",\"description\":\"Smartphone de haute gamme avec 8 GO de RAM, un processeur de d\\u00e8rni\\u00e8re g\\u00e9n\\u00e9ration, une double cam\\u00e9ra de 32 MP, un espace de stockage de 64 et 128 GB, ce produit constitue un bien de luxe dont le marketing est un facteur tr\\u00e8s important.\",\"price_min\":\"60000\",\"price_max\":\"75000\",\"machine_units\":\"3\",\"ad_coef\":\"1\",\"labor_units\":\"3\",\"updated_at\":\"2021-04-08T23:41:35.000000Z\",\"created_at\":\"2021-04-08T23:41:35.000000Z\",\"id\":2}'),
(98, '93264266-51ea-4df0-93c1-1550277b5dc3', 5, 'Update', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-08 23:42:00', '2021-04-08 23:42:00', '{\"description\":\"Smartphone de haute gamme avec 8 GO de RAM, un processeur de d\\u00e8rni\\u00e8re g\\u00e9n\\u00e9ration, une double cam\\u00e9ra de 32 MP, un espace de stockage de 64 et 128 GB, ce produit constitue un bien de luxe dont le marketing est un facteur tr\\u00e8s important.\"}', '{\"description\":\"Smartphone de haute gamme avec 8 GO de RAM, un processeur de derni\\u00e8re g\\u00e9n\\u00e9ration, une double cam\\u00e9ra de 32 MP, un espace de stockage de 64 et 128 GB, ce produit constitue un bien de luxe dont le marketing est un facteur tr\\u00e8s important.\"}'),
(99, '932644d1-f504-45eb-bd4a-90617ce28264', 5, 'Delete', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-08 23:48:46', '2021-04-08 23:48:46', NULL, NULL),
(100, '93264708-6839-4b28-91c1-ef459b90c654', 5, 'Create', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-08 23:54:57', '2021-04-08 23:54:57', NULL, '{\"name\":\"Lait BG\",\"description\":\"Le Lait BG est un bien n\\u00e9c\\u00e9ssaire qui est tr\\u00e8s demand\\u00e9, la demande de ce bien est inversement proportionelle \\u00e0 son prix, le marketing n\'est pas assez important.\",\"price_min\":\"25\",\"price_max\":\"50\",\"machine_units\":\"1\",\"ad_coef\":\"1\",\"labor_units\":\"2\",\"updated_at\":\"2021-04-08T23:54:57.000000Z\",\"created_at\":\"2021-04-08T23:54:57.000000Z\",\"id\":1}'),
(101, '9326477d-d75e-4d21-8737-0119c8cc00a1', 5, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-08 23:56:14', '2021-04-08 23:56:14', '{\"price_min\":25,\"price_max\":50}', '{\"price_min\":\"70\",\"price_max\":\"120\"}'),
(102, '93264886-64c2-4e7d-8e05-bcb9f809e8d9', 5, 'Create', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-08 23:59:08', '2021-04-08 23:59:08', NULL, '{\"name\":\"Camembert BG Extra\",\"description\":\"Ce Camembert est un d\\u00e9lice, il est consid\\u00e9r\\u00e9 comme un bien luxueux, sa demande depend fortement de son prix et du marketing de ce dernier.\",\"price_min\":\"350\",\"price_max\":\"500\",\"machine_units\":\"2\",\"ad_coef\":\"4\",\"labor_units\":\"2\",\"updated_at\":\"2021-04-08T23:59:08.000000Z\",\"created_at\":\"2021-04-08T23:59:08.000000Z\",\"id\":2}'),
(103, '932649ea-2de6-45bc-b65e-c5a9a9cb0bb0', 5, 'Create', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-04-09 00:03:01', '2021-04-09 00:03:01', NULL, '{\"name\":\"Yaourt BG Aromatis\\u00e9\",\"description\":\"Le Yaourt est largement demand\\u00e9 dans le march\\u00e9, cependant la demande varie fortement ssselon le prix de vente, le marketing est assez important pour ce produit.\",\"price_min\":\"10\",\"price_max\":\"30\",\"machine_units\":\"2\",\"ad_coef\":\"2\",\"labor_units\":\"1\",\"updated_at\":\"2021-04-09T00:03:01.000000Z\",\"created_at\":\"2021-04-09T00:03:01.000000Z\",\"id\":3}'),
(104, '93264af8-f11b-46a7-b88c-b25db7dce98d', 5, 'Create', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-04-09 00:05:58', '2021-04-09 00:05:58', NULL, '{\"name\":\"Fromage BG Family\",\"description\":\"Le fromage BG Family est vendue en boites de 24 portions, parfait pour la famille, ce produit d\\u00e9pend d\'une mani\\u00e8re assez importante du prix et du marketing aussi.\",\"price_min\":\"150\",\"price_max\":\"220\",\"machine_units\":\"2\",\"ad_coef\":\"3\",\"labor_units\":\"2\",\"updated_at\":\"2021-04-09T00:05:58.000000Z\",\"created_at\":\"2021-04-09T00:05:58.000000Z\",\"id\":4}'),
(105, '93264d09-8b4c-4fc4-88c8-76b7f2177a7b', 5, 'Update', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-09 00:11:45', '2021-04-09 00:11:45', '{\"description\":\"Ce Camembert est un d\\u00e9lice, il est consid\\u00e9r\\u00e9 comme un bien luxueux, sa demande depend fortement de son prix et du marketing de ce dernier.\"}', '{\"description\":\"Le Camembert BG Extra est un d\\u00e9lice, il est consid\\u00e9r\\u00e9 comme un bien luxueux, sa demande depend fortement de son prix et du marketing de ce dernier.\"}'),
(106, '93264f85-ed0b-4c46-88fc-df5af1ffcddf', 5, 'Update', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-04-09 00:18:42', '2021-04-09 00:18:42', '{\"avg_demand\":10000,\"left_demand\":10000}', '{\"avg_demand\":\"60000\",\"left_demand\":\"60000\"}'),
(107, '93264fb7-d940-4dfa-bbb1-148c1e70d743', 5, 'Update', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-04-09 00:19:14', '2021-04-09 00:19:14', '{\"avg_demand\":10000,\"left_demand\":10000}', '{\"avg_demand\":\"80000\",\"left_demand\":\"80000\"}'),
(108, '93264fdd-0ef3-4b88-a282-f2ef0572df94', 5, 'Update', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-09 00:19:39', '2021-04-09 00:19:39', '{\"avg_demand\":10000,\"left_demand\":10000}', '{\"avg_demand\":\"25000\",\"left_demand\":\"25000\"}'),
(109, '93264ff4-4dad-4635-a498-3a4e12519fb5', 5, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-09 00:19:54', '2021-04-09 00:19:54', '{\"avg_demand\":10000,\"left_demand\":10000}', '{\"avg_demand\":\"100000\",\"left_demand\":\"100000\"}'),
(110, '9326518b-ec08-4e83-bae3-22bd3506c6ee', 5, 'Update', 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, 'App\\Models\\Product', 3, '', 'finished', '', '2021-04-09 00:24:21', '2021-04-09 00:24:21', '{\"avg_demand\":80000,\"left_demand\":80000}', '{\"avg_demand\":\"60000\",\"left_demand\":\"60000\"}'),
(111, '932651ad-ce31-4cd0-8407-13766d4a8688', 5, 'Update', 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, 'App\\Models\\Product', 4, '', 'finished', '', '2021-04-09 00:24:43', '2021-04-09 00:24:43', '{\"avg_demand\":60000,\"left_demand\":60000}', '{\"avg_demand\":\"80000\",\"left_demand\":\"80000\"}'),
(112, '932726d2-3e0e-4eef-83be-0a66abe3c294', 5, 'Create', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2021-04-09 10:20:43', '2021-04-09 10:20:43', NULL, '{\"name\":\"Poudre de Lait\",\"unit\":\"Kg\",\"price\":\"45\",\"updated_at\":\"2021-04-09T10:20:43.000000Z\",\"created_at\":\"2021-04-09T10:20:43.000000Z\",\"id\":1}'),
(113, '9327270e-3c3d-4b60-90bc-225c1dc51193', 5, 'Create', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2021-04-09 10:21:22', '2021-04-09 10:21:22', NULL, '{\"name\":\"Ar\\u00f4mes\",\"unit\":\"Unit\\u00e9s\",\"price\":\"60\",\"updated_at\":\"2021-04-09T10:21:22.000000Z\",\"created_at\":\"2021-04-09T10:21:22.000000Z\",\"id\":2}'),
(114, '93272745-b444-4c0c-b7d8-2f4698838c42', 5, 'Create', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2021-04-09 10:21:58', '2021-04-09 10:21:58', NULL, '{\"name\":\"Magn\\u00e9sium\",\"unit\":\"Kg\",\"price\":\"25\",\"updated_at\":\"2021-04-09T10:21:58.000000Z\",\"created_at\":\"2021-04-09T10:21:58.000000Z\",\"id\":3}'),
(115, '9327aa31-f1b1-4f71-8ce9-fb9db5f6b6cc', 5, 'Update', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2021-04-09 16:28:04', '2021-04-09 16:28:04', '{\"price\":45}', '{\"price\":\"410\"}'),
(116, '9327aa3b-90cc-40fc-b09f-dbd2e1cc19cc', 5, 'Update', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2021-04-09 16:28:10', '2021-04-09 16:28:10', '[]', '[]'),
(117, '9327aaa7-8dca-464a-9ea1-c7663512448b', 5, 'Update', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2021-04-09 16:29:21', '2021-04-09 16:29:21', '{\"price\":60,\"unit\":\"Unit\\u00e9s\",\"name\":\"Ar\\u00f4mes\"}', '{\"price\":\"26\",\"unit\":\"Kg\",\"name\":\"Emballage (Carton \\/ Alumnium)\"}'),
(118, '9327aae1-71c0-49af-9018-1032751786cf', 5, 'Update', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2021-04-09 16:29:59', '2021-04-09 16:29:59', '{\"price\":25,\"name\":\"Magn\\u00e9sium\"}', '{\"price\":\"1700\",\"name\":\"Additifs Alimentaire\"}'),
(119, '9327ab0c-105b-428c-b0d7-48e7375d49a4', 5, 'Update', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2021-04-09 16:30:27', '2021-04-09 16:30:27', '{\"name\":\"Additifs Alimentaire\"}', '{\"name\":\"Additifs Alimentaires\"}'),
(120, '9327ab3e-30ba-4d05-998e-b23663828bb4', 5, 'Create', 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, '', 'finished', '', '2021-04-09 16:30:59', '2021-04-09 16:30:59', NULL, '{\"name\":\"Ar\\u00f4mes\",\"unit\":\"Kg\",\"price\":\"2300\",\"updated_at\":\"2021-04-09T16:30:59.000000Z\",\"created_at\":\"2021-04-09T16:30:59.000000Z\",\"id\":4}'),
(121, '9327ab5b-08b6-4c3b-bfb0-feec352ec637', 5, 'Update', 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, 'App\\Models\\Product', 1, '', 'finished', '', '2021-04-09 16:31:18', '2021-04-09 16:31:18', '{\"avg_demand\":100000,\"left_demand\":100000}', '{\"avg_demand\":\"150000\",\"left_demand\":\"150000\"}'),
(122, '9327c898-efe5-49bc-81a6-ea9dd13a79b2', 5, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:53:04', '2021-04-09 17:53:04', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"1\",\"quantity\":\"8.5\"}'),
(123, '9327c96b-8599-421c-ae31-6804d9932a07', 5, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:55:22', '2021-04-09 17:55:22', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"2\",\"quantity\":\"57.5\"}'),
(124, '9327c98c-f996-4472-a979-0eb5ed72baae', 5, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 4, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:55:44', '2021-04-09 17:55:44', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"4\",\"quantity\":\"0.45\"}'),
(125, '9327c9a1-c5b6-4862-b943-88f7288d1b82', 5, 'Attach', 'App\\Models\\Product', 1, 'App\\Models\\RawMaterial', 3, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:55:58', '2021-04-09 17:55:58', NULL, '{\"product_id\":\"1\",\"raw_material_id\":\"3\",\"quantity\":\"0.6\"}'),
(126, '9327c9b9-27f4-4b8c-8691-452ecdb66ffe', 5, 'Update', 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, 'App\\Models\\Product', 2, '', 'finished', '', '2021-04-09 17:56:13', '2021-04-09 17:56:13', '[]', '[]'),
(127, '9327ca3e-c44c-40df-a23f-06e329246420', 5, 'Attach', 'App\\Models\\Product', 2, 'App\\Models\\RawMaterial', 3, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:57:41', '2021-04-09 17:57:41', NULL, '{\"product_id\":\"2\",\"raw_material_id\":\"3\",\"quantity\":\"2\"}'),
(128, '9327ca54-e31b-4241-ad18-5b85230b0b61', 5, 'Attach', 'App\\Models\\Product', 2, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:57:55', '2021-04-09 17:57:55', NULL, '{\"product_id\":\"2\",\"raw_material_id\":\"1\",\"quantity\":\"29\"}'),
(129, '9327caa8-380d-49ca-ad96-a42e3e5e9fc2', 5, 'Attach', 'App\\Models\\Product', 4, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:58:50', '2021-04-09 17:58:50', NULL, '{\"product_id\":\"4\",\"raw_material_id\":\"1\",\"quantity\":\"12\"}'),
(130, '9327cb04-5508-4963-9b97-18a4ef14bf7e', 5, 'Attach', 'App\\Models\\Product', 4, 'App\\Models\\RawMaterial', 4, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:59:50', '2021-04-09 17:59:50', NULL, '{\"product_id\":\"4\",\"raw_material_id\":\"4\",\"quantity\":\"0.5\"}'),
(131, '9327cb12-6d22-45a1-b53e-be2946604a39', 5, 'Attach', 'App\\Models\\Product', 4, 'App\\Models\\RawMaterial', 3, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 17:59:59', '2021-04-09 17:59:59', NULL, '{\"product_id\":\"4\",\"raw_material_id\":\"3\",\"quantity\":\"0.9\"}'),
(132, '9327cb4e-509a-4e83-ad9d-8843bfe2e0a8', 5, 'Attach', 'App\\Models\\Product', 3, 'App\\Models\\RawMaterial', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 18:00:39', '2021-04-09 18:00:39', NULL, '{\"product_id\":\"3\",\"raw_material_id\":\"1\",\"quantity\":\"0.7\"}'),
(133, '9327cb63-de1b-4a5d-8dda-d6c1d61cdf2a', 5, 'Attach', 'App\\Models\\Product', 3, 'App\\Models\\RawMaterial', 4, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 18:00:53', '2021-04-09 18:00:53', NULL, '{\"product_id\":\"3\",\"raw_material_id\":\"4\",\"quantity\":\"0.2\"}'),
(134, '9327cb75-2c09-437b-83c9-f4f84ddaa0a4', 5, 'Attach', 'App\\Models\\Product', 3, 'App\\Models\\RawMaterial', 3, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2021-04-09 18:01:04', '2021-04-09 18:01:04', NULL, '{\"product_id\":\"3\",\"raw_material_id\":\"3\",\"quantity\":\"0.1\"}');
INSERT INTO `action_events` (`id`, `batch_id`, `user_id`, `name`, `actionable_type`, `actionable_id`, `target_type`, `target_id`, `model_type`, `model_id`, `fields`, `status`, `exception`, `created_at`, `updated_at`, `original`, `changes`) VALUES
(503, '98eec7ec-9d1b-4a85-aa38-f1bb8433bc5e', 28, 'Create', 'App\\Models\\User', 29, 'App\\Models\\User', 29, 'App\\Models\\User', 29, '', 'finished', '', '2023-04-14 23:00:38', '2023-04-14 23:00:38', NULL, '{\"name\":\"test\",\"email\":\"test@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-14T23:00:38.000000Z\",\"created_at\":\"2023-04-14T23:00:38.000000Z\",\"id\":29}'),
(504, '98eed546-ec32-4b9c-b5e0-adf865a8bdd8', 28, 'Create', 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, '', 'finished', '', '2023-04-14 23:37:58', '2023-04-14 23:37:58', NULL, '{\"name\":\"Cuire\",\"unit\":\"pi\\u00e9ce\",\"price\":\"3000\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/breakfast.svg\",\"updated_at\":\"2023-04-14T23:37:58.000000Z\",\"created_at\":\"2023-04-14T23:37:58.000000Z\",\"id\":10}'),
(505, '98eed5b4-fdb2-411e-90e5-4a8fce06be7e', 28, 'Delete', 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, '', 'finished', '', '2023-04-14 23:39:10', '2023-04-14 23:39:10', NULL, NULL),
(506, '98efe4e3-5ba7-4290-ac98-7d26bf5dcf93', 28, 'Create', 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, '', 'finished', '', '2023-04-15 12:17:27', '2023-04-15 12:17:27', NULL, '{\"name\":\"Cuire\",\"unit\":\"m\",\"price\":\"1000\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/cuire.svg\",\"updated_at\":\"2023-04-15T12:17:26.000000Z\",\"created_at\":\"2023-04-15T12:17:26.000000Z\",\"id\":11}'),
(507, '98efe514-2aa5-4405-ba48-98bf71fb5dc8', 28, 'Attach', 'App\\Models\\RawMaterial', 11, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-15 12:17:59', '2023-04-15 12:17:59', NULL, '{\"raw_material_id\":\"11\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(508, '98efe7fa-3ffc-427f-8683-0eafc135728d', 28, 'Detach', 'App\\Models\\RawMaterial', 11, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-15 12:26:05', '2023-04-15 12:26:05', NULL, NULL),
(509, '98efe80b-114d-4cfb-85d1-29cdb30f9cdf', 28, 'Delete', 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, '', 'finished', '', '2023-04-15 12:26:16', '2023-04-15 12:26:16', NULL, NULL),
(510, '98eff0da-3f42-4765-84a8-178ed1e0fe98', 28, 'Create', 'App\\Models\\RawMaterial', 12, 'App\\Models\\RawMaterial', 12, 'App\\Models\\RawMaterial', 12, '', 'finished', '', '2023-04-15 12:50:54', '2023-04-15 12:50:54', NULL, '{\"name\":\"Laine\",\"unit\":\"pelote\",\"price\":\"150\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/laine.svg\",\"updated_at\":\"2023-04-15T12:50:54.000000Z\",\"created_at\":\"2023-04-15T12:50:54.000000Z\",\"id\":12}'),
(511, '98eff150-064e-4848-80c7-d71954ededaa', 28, 'Create', 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, '', 'finished', '', '2023-04-15 12:52:11', '2023-04-15 12:52:11', NULL, '{\"name\":\"Coton\",\"unit\":\"m\",\"price\":\"500\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/coton.svg\",\"updated_at\":\"2023-04-15T12:52:11.000000Z\",\"created_at\":\"2023-04-15T12:52:11.000000Z\",\"id\":13}'),
(512, '98eff1de-a73d-4a63-8d04-ec22f57a2e67', 28, 'Create', 'App\\Models\\RawMaterial', 14, 'App\\Models\\RawMaterial', 14, 'App\\Models\\RawMaterial', 14, '', 'finished', '', '2023-04-15 12:53:45', '2023-04-15 12:53:45', NULL, '{\"name\":\"Mati\\u00e8res chimiques\",\"unit\":\"kg\",\"price\":\"1000\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/chemicals.svg\",\"updated_at\":\"2023-04-15T12:53:45.000000Z\",\"created_at\":\"2023-04-15T12:53:45.000000Z\",\"id\":14}'),
(513, '98eff215-56d9-4ea4-9fa0-5f65ff471f40', 28, 'Create', 'App\\Models\\RawMaterial', 15, 'App\\Models\\RawMaterial', 15, 'App\\Models\\RawMaterial', 15, '', 'finished', '', '2023-04-15 12:54:20', '2023-04-15 12:54:20', NULL, '{\"name\":\"Fixation\",\"unit\":\"kg\",\"price\":\"2000\",\"volume\":\"2\",\"icon\":\"\\/assets\\/icons\\/nv\\/fixation.svg\",\"updated_at\":\"2023-04-15T12:54:20.000000Z\",\"created_at\":\"2023-04-15T12:54:20.000000Z\",\"id\":15}'),
(514, '98eff33e-6b63-4c01-9866-6c80a4db406f', 28, 'Create', 'App\\Models\\RawMaterial', 16, 'App\\Models\\RawMaterial', 16, 'App\\Models\\RawMaterial', 16, '', 'finished', '', '2023-04-15 12:57:35', '2023-04-15 12:57:35', NULL, '{\"name\":\"Polyester\",\"unit\":\"m\",\"price\":\"800\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/polyester.svg\",\"updated_at\":\"2023-04-15T12:57:35.000000Z\",\"created_at\":\"2023-04-15T12:57:35.000000Z\",\"id\":16}'),
(515, '98eff391-a3d7-47c1-88fb-38a7d9b16bae', 28, 'Create', 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, '', 'finished', '', '2023-04-15 12:58:30', '2023-04-15 12:58:30', NULL, '{\"name\":\"Packaging\",\"unit\":\"Kg\",\"price\":\"1000\",\"volume\":\"3\",\"icon\":\"\\/assets\\/icons\\/nv\\/packaging.svg\",\"updated_at\":\"2023-04-15T12:58:30.000000Z\",\"created_at\":\"2023-04-15T12:58:30.000000Z\",\"id\":17}'),
(516, '98eff3d9-18bc-4761-8813-9f9be558613c', 28, 'Create', 'App\\Models\\RawMaterial', 18, 'App\\Models\\RawMaterial', 18, 'App\\Models\\RawMaterial', 18, '', 'finished', '', '2023-04-15 12:59:16', '2023-04-15 12:59:16', NULL, '{\"name\":\"Lin\",\"unit\":\"m\",\"price\":\"700\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/lin.svg\",\"updated_at\":\"2023-04-15T12:59:16.000000Z\",\"created_at\":\"2023-04-15T12:59:16.000000Z\",\"id\":18}'),
(517, '98eff405-fa13-4260-ae3c-ca9ff2c1b45b', 28, 'Create', 'App\\Models\\RawMaterial', 19, 'App\\Models\\RawMaterial', 19, 'App\\Models\\RawMaterial', 19, '', 'finished', '', '2023-04-15 12:59:46', '2023-04-15 12:59:46', NULL, '{\"name\":\"Garniture\",\"unit\":\"kg\",\"price\":\"1000\",\"volume\":\"3\",\"icon\":\"\\/assets\\/icons\\/nv\\/garniture.svg\",\"updated_at\":\"2023-04-15T12:59:46.000000Z\",\"created_at\":\"2023-04-15T12:59:46.000000Z\",\"id\":19}'),
(518, '98eff42e-924e-4893-bbb5-300968974262', 28, 'Create', 'App\\Models\\RawMaterial', 20, 'App\\Models\\RawMaterial', 20, 'App\\Models\\RawMaterial', 20, '', 'finished', '', '2023-04-15 13:00:12', '2023-04-15 13:00:12', NULL, '{\"name\":\"La soie\",\"unit\":\"m\",\"price\":\"1000\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/soie.svg\",\"updated_at\":\"2023-04-15T13:00:12.000000Z\",\"created_at\":\"2023-04-15T13:00:12.000000Z\",\"id\":20}'),
(519, '98eff464-46d5-4f44-bbd3-da53cf69892d', 28, 'Create', 'App\\Models\\RawMaterial', 21, 'App\\Models\\RawMaterial', 21, 'App\\Models\\RawMaterial', 21, '', 'finished', '', '2023-04-15 13:00:48', '2023-04-15 13:00:48', NULL, '{\"name\":\"Cuir\",\"unit\":\"m\",\"price\":\"1200\",\"volume\":\"1\",\"icon\":\"\\/assets\\/icons\\/nv\\/cuire.svg\",\"updated_at\":\"2023-04-15T13:00:48.000000Z\",\"created_at\":\"2023-04-15T13:00:48.000000Z\",\"id\":21}'),
(520, '98eff49a-668f-4626-a03f-e97a1ada4b9a', 28, 'Update', 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, '', 'finished', '', '2023-04-15 13:01:23', '2023-04-15 13:01:23', '{\"price\":1000}', '{\"price\":\"100\"}'),
(521, '98f01c3e-edfc-42f5-8a9c-925623163c64', 28, 'Attach', 'App\\Models\\RawMaterial', 12, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-15 14:52:14', '2023-04-15 14:52:14', NULL, '{\"raw_material_id\":\"12\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(522, '98f01ce4-b0bc-4d3d-a2e3-c0f9076bf683', 28, 'Attach', 'App\\Models\\RawMaterial', 13, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-15 14:54:03', '2023-04-15 14:54:03', NULL, '{\"raw_material_id\":\"13\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(523, '98f01d08-3516-447d-a4f8-d17893032104', 28, 'Attach', 'App\\Models\\RawMaterial', 14, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-15 14:54:26', '2023-04-15 14:54:26', NULL, '{\"raw_material_id\":\"14\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(524, '98f01d8d-6a0f-4977-a694-cee8fa9d42c0', 28, 'Update', 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, '', 'finished', '', '2023-04-15 14:55:53', '2023-04-15 14:55:53', '{\"icon\":\"\\/assets\\/icons\\/nv\\/coton.svg\"}', '{\"icon\":\"\\/assets\\/icons\\/nv\\/coton.svg A CHANGER\"}'),
(525, '98f07aac-d441-43cb-adb5-02fdafe2c899', 28, 'Create', 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, '', 'finished', '', '2023-04-15 19:16:17', '2023-04-15 19:16:17', NULL, '{\"name\":\"Robe\",\"price_min\":\"1500\",\"price_max\":\"2000\",\"prod_speed_factor\":\"1\",\"unit_prod_price\":\"800\",\"ad_coef\":\"1\",\"avg_demand\":\"1000\",\"left_demand\":\"444\",\"percent_population\":\"0.03\",\"icon\":\"\\/assets\\/robe.jpg\",\"description\":\"hifieeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\",\"updated_at\":\"2023-04-15T19:16:17.000000Z\",\"created_at\":\"2023-04-15T19:16:17.000000Z\",\"id\":10}'),
(526, '98f07b93-39fd-439f-a0c7-8c5d592587bd', 28, 'Update', 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, '', 'finished', '', '2023-04-15 19:18:48', '2023-04-15 19:18:48', '{\"name\":\"Robe\",\"left_demand\":195000,\"description\":\"hifieeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\",\"icon\":\"\\/assets\\/robe.jpg\"}', '{\"name\":\"chemise\",\"left_demand\":\"444\",\"description\":\"une belle robe\",\"icon\":\"\\/assets\\/chemise.jpg\"}'),
(527, '98f1c508-385c-4504-929c-57fae980058d', 28, 'Delete', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2023-04-16 10:40:01', '2023-04-16 10:40:01', NULL, NULL),
(528, '98f1c593-ee3b-4ce9-904c-564b0af01566', 28, 'Delete', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2023-04-16 10:41:33', '2023-04-16 10:41:33', NULL, NULL),
(529, '98f1c5b7-1d0c-4619-b2b4-d33ca4883cf7', 28, 'Delete', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(530, '98f1c5b7-3b7e-43c1-b1e4-84bbb8cab386', 28, 'Delete', 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(531, '98f1c5b7-5612-4aab-87e2-178442cef5db', 28, 'Delete', 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(532, '98f1c5b7-762a-4895-8882-292e36c20626', 28, 'Delete', 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(533, '98f1c5b7-93c1-4617-9241-72dcb8707f34', 28, 'Delete', 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(534, '98f1c5b7-b308-4164-8fc0-12d4131496e7', 28, 'Delete', 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(535, '98f1c5b7-d4f4-4a14-9c94-6dbea7756804', 28, 'Delete', 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, '', 'finished', '', '2023-04-16 10:41:56', '2023-04-16 10:41:56', NULL, NULL),
(536, '98f24619-9d37-40fc-887d-e64208694ab0', 28, 'Update', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2023-04-16 16:40:55', '2023-04-16 16:40:55', '{\"icon\":\"\\/assets\\/icons\\/nv\\/coton.svg A CHANGER\"}', '{\"icon\":\"\\/assets\\/icons\\/nv\\/coton.svg\"}'),
(537, '98f2473f-faa4-4c63-b7a6-9db0ed3f81e0', 28, 'Update', 'App\\Models\\GameSetting', 25, 'App\\Models\\GameSetting', 25, 'App\\Models\\GameSetting', 25, '', 'finished', '', '2023-04-16 16:44:08', '2023-04-16 16:44:08', '{\"value\":\"0\"}', '{\"value\":\"1\"}'),
(538, '98f247de-de99-42bd-bd94-a20003f15a9a', 28, 'Attach', 'App\\Models\\RawMaterial', 10, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-16 16:45:52', '2023-04-16 16:45:52', NULL, '{\"raw_material_id\":\"10\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(539, '98f2cb36-4f0c-4fda-895c-9f05b981443a', 28, 'Attach', 'App\\Models\\RawMaterial', 10, 'App\\Models\\Supplier', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-16 22:53:08', '2023-04-16 22:53:08', NULL, '{\"raw_material_id\":\"10\",\"supplier_id\":\"2\",\"price_factor\":\"0.8\",\"is_available\":true,\"time_to_deliver\":\"6\"}'),
(540, '98f2cbf8-336d-4860-bbda-feb35ec195eb', 28, 'Attach', 'App\\Models\\RawMaterial', 11, 'App\\Models\\Supplier', 1, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-16 22:55:15', '2023-04-16 22:55:15', NULL, '{\"raw_material_id\":\"11\",\"supplier_id\":\"1\",\"price_factor\":\"1\",\"is_available\":true,\"time_to_deliver\":\"3\"}'),
(541, '98f42944-6b7b-4e14-bc56-31acef441082', 28, 'Delete', 'App\\Models\\Product', 5, 'App\\Models\\Product', 5, 'App\\Models\\Product', 5, '', 'finished', '', '2023-04-17 15:11:57', '2023-04-17 15:11:57', NULL, NULL),
(542, '98f42944-8180-4579-a016-4923e3416058', 28, 'Delete', 'App\\Models\\Product', 6, 'App\\Models\\Product', 6, 'App\\Models\\Product', 6, '', 'finished', '', '2023-04-17 15:11:57', '2023-04-17 15:11:57', NULL, NULL),
(543, '98f42944-8e8c-4c45-83c0-c23b66b6cc54', 28, 'Delete', 'App\\Models\\Product', 7, 'App\\Models\\Product', 7, 'App\\Models\\Product', 7, '', 'finished', '', '2023-04-17 15:11:58', '2023-04-17 15:11:58', NULL, NULL),
(544, '98f42944-9b94-4c49-831d-c3e038093952', 28, 'Delete', 'App\\Models\\Product', 8, 'App\\Models\\Product', 8, 'App\\Models\\Product', 8, '', 'finished', '', '2023-04-17 15:11:58', '2023-04-17 15:11:58', NULL, NULL),
(545, '98f42944-a88b-4472-84a6-46290700dd75', 28, 'Delete', 'App\\Models\\Product', 9, 'App\\Models\\Product', 9, 'App\\Models\\Product', 9, '', 'finished', '', '2023-04-17 15:11:58', '2023-04-17 15:11:58', NULL, NULL),
(546, '98f42944-b5bf-4bdb-a09f-4ff2e5105863', 28, 'Delete', 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, 'App\\Models\\Product', 10, '', 'finished', '', '2023-04-17 15:11:58', '2023-04-17 15:11:58', NULL, NULL),
(547, '98f48d58-3536-43b0-afea-d5e908d7712d', 28, 'Delete', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(548, '98f48d58-68b8-4670-9ac0-53b97799684a', 28, 'Delete', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(549, '98f48d58-9146-4bd1-b7b0-d54aa9cb0470', 28, 'Delete', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(550, '98f48d58-b8e6-43e7-b140-db79598d7dc0', 28, 'Delete', 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(551, '98f48d58-e292-4da6-b0d9-e2fa44b664c7', 28, 'Delete', 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(552, '98f48d59-0c72-4af0-8527-c65b587cc735', 28, 'Delete', 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(553, '98f48d59-389f-4ac2-ab49-79c271499f52', 28, 'Delete', 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(554, '98f48d59-637f-4a12-b6d7-ab2bf2613bf1', 28, 'Delete', 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(555, '98f48d59-8e17-46a4-a9e7-4da6a0fc4a51', 28, 'Delete', 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, '', 'finished', '', '2023-04-17 19:51:48', '2023-04-17 19:51:48', NULL, NULL),
(556, '98f4907b-b69f-4f21-a6d2-62e7fe8406be', 28, 'Delete', 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, '', 'finished', '', '2023-04-17 20:00:34', '2023-04-17 20:00:34', NULL, NULL),
(557, '98f4907b-e51f-45d9-8d64-389e9d16bce3', 28, 'Delete', 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, 'App\\Models\\RawMaterial', 11, '', 'finished', '', '2023-04-17 20:00:34', '2023-04-17 20:00:34', NULL, NULL),
(558, '98f4907c-1290-486f-82fc-c9ee54e68e23', 28, 'Delete', 'App\\Models\\RawMaterial', 12, 'App\\Models\\RawMaterial', 12, 'App\\Models\\RawMaterial', 12, '', 'finished', '', '2023-04-17 20:00:34', '2023-04-17 20:00:34', NULL, NULL),
(559, '98f4907c-3fc3-47d1-919e-8c66abb55060', 28, 'Delete', 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, 'App\\Models\\RawMaterial', 13, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(560, '98f4907c-6ad5-4832-8c0a-7cfc35408448', 28, 'Delete', 'App\\Models\\RawMaterial', 14, 'App\\Models\\RawMaterial', 14, 'App\\Models\\RawMaterial', 14, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(561, '98f4907c-9726-49ab-ae00-c3f588e30579', 28, 'Delete', 'App\\Models\\RawMaterial', 15, 'App\\Models\\RawMaterial', 15, 'App\\Models\\RawMaterial', 15, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(562, '98f4907c-ca2a-4019-90f0-cb84ea17ead5', 28, 'Delete', 'App\\Models\\RawMaterial', 16, 'App\\Models\\RawMaterial', 16, 'App\\Models\\RawMaterial', 16, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(563, '98f4907c-fa4e-4963-9d7e-4a05de291722', 28, 'Delete', 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, 'App\\Models\\RawMaterial', 17, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(564, '98f4907d-272c-48d3-96f1-b2914d18cd1e', 28, 'Delete', 'App\\Models\\RawMaterial', 18, 'App\\Models\\RawMaterial', 18, 'App\\Models\\RawMaterial', 18, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(565, '98f4907d-5362-4de3-addf-2d5b12d022f6', 28, 'Delete', 'App\\Models\\RawMaterial', 19, 'App\\Models\\RawMaterial', 19, 'App\\Models\\RawMaterial', 19, '', 'finished', '', '2023-04-17 20:00:35', '2023-04-17 20:00:35', NULL, NULL),
(566, '98f4910f-c7b8-46c7-86d7-3089fca0ed21', 28, 'Delete', 'App\\Models\\RawMaterial', 22, 'App\\Models\\RawMaterial', 22, 'App\\Models\\RawMaterial', 22, '', 'finished', '', '2023-04-17 20:02:11', '2023-04-17 20:02:11', NULL, NULL),
(567, '98f4910f-fc56-4626-952b-2f839d031bf5', 28, 'Delete', 'App\\Models\\RawMaterial', 23, 'App\\Models\\RawMaterial', 23, 'App\\Models\\RawMaterial', 23, '', 'finished', '', '2023-04-17 20:02:11', '2023-04-17 20:02:11', NULL, NULL),
(568, '98f49110-28ce-439e-a716-4876a1bf5c9a', 28, 'Delete', 'App\\Models\\RawMaterial', 24, 'App\\Models\\RawMaterial', 24, 'App\\Models\\RawMaterial', 24, '', 'finished', '', '2023-04-17 20:02:11', '2023-04-17 20:02:11', NULL, NULL),
(569, '98f49110-53fd-4d40-a798-c7294e28c63d', 28, 'Delete', 'App\\Models\\RawMaterial', 25, 'App\\Models\\RawMaterial', 25, 'App\\Models\\RawMaterial', 25, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(570, '98f49110-8030-495b-bcb0-937353825909', 28, 'Delete', 'App\\Models\\RawMaterial', 26, 'App\\Models\\RawMaterial', 26, 'App\\Models\\RawMaterial', 26, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(571, '98f49110-add0-407a-9851-088a003c25f0', 28, 'Delete', 'App\\Models\\RawMaterial', 27, 'App\\Models\\RawMaterial', 27, 'App\\Models\\RawMaterial', 27, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(572, '98f49110-da37-483c-b66e-1a44f5b6dc3b', 28, 'Delete', 'App\\Models\\RawMaterial', 28, 'App\\Models\\RawMaterial', 28, 'App\\Models\\RawMaterial', 28, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(573, '98f49111-0660-4da1-b500-30e224fcefd8', 28, 'Delete', 'App\\Models\\RawMaterial', 29, 'App\\Models\\RawMaterial', 29, 'App\\Models\\RawMaterial', 29, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(574, '98f49111-33e9-481f-8f54-d47a504b34eb', 28, 'Delete', 'App\\Models\\RawMaterial', 30, 'App\\Models\\RawMaterial', 30, 'App\\Models\\RawMaterial', 30, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(575, '98f49111-5a6a-48a7-aed6-662f3690620b', 28, 'Delete', 'App\\Models\\RawMaterial', 31, 'App\\Models\\RawMaterial', 31, 'App\\Models\\RawMaterial', 31, '', 'finished', '', '2023-04-17 20:02:12', '2023-04-17 20:02:12', NULL, NULL),
(576, '98f49304-bd9a-436f-bdb1-07cdb20e69ee', 28, 'Delete', 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, 'App\\Models\\RawMaterial', 1, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(577, '98f49304-e8ca-492d-82d2-f17c2605ea93', 28, 'Delete', 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, 'App\\Models\\RawMaterial', 2, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(578, '98f49305-1346-42f3-a446-baa8d3f20dac', 28, 'Delete', 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, 'App\\Models\\RawMaterial', 3, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(579, '98f49305-4302-4d08-bcb5-09689dd5fd7e', 28, 'Delete', 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, 'App\\Models\\RawMaterial', 4, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(580, '98f49305-6cb9-478d-b8fa-f4884612b262', 28, 'Delete', 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, 'App\\Models\\RawMaterial', 5, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(581, '98f49305-91f7-4f54-a213-5db37bbed971', 28, 'Delete', 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, 'App\\Models\\RawMaterial', 6, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(582, '98f49305-b8e3-48cf-bca3-600ae126ad70', 28, 'Delete', 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, 'App\\Models\\RawMaterial', 7, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(583, '98f49305-e240-46d1-ad3c-c0c6b724d3ab', 28, 'Delete', 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, 'App\\Models\\RawMaterial', 8, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(584, '98f49306-0e06-4c94-9df1-6a484d255b6f', 28, 'Delete', 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, 'App\\Models\\RawMaterial', 9, '', 'finished', '', '2023-04-17 20:07:40', '2023-04-17 20:07:40', NULL, NULL),
(585, '98f49306-35c7-46b2-9310-dd4e3f67b0ae', 28, 'Delete', 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, 'App\\Models\\RawMaterial', 10, '', 'finished', '', '2023-04-17 20:07:41', '2023-04-17 20:07:41', NULL, NULL),
(586, '98fa4260-4ff9-4125-aeb2-1d4390b67250', 28, 'Create', 'App\\Models\\User', 30, 'App\\Models\\User', 30, 'App\\Models\\User', 30, '', 'finished', '', '2023-04-20 15:57:09', '2023-04-20 15:57:09', NULL, '{\"name\":\"test2\",\"email\":\"test2@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-20T15:57:08.000000Z\",\"created_at\":\"2023-04-20T15:57:08.000000Z\",\"id\":30}'),
(587, '98fa713f-483a-41d9-8019-c616b9ed66b0', 28, 'Create', 'App\\Models\\User', 31, 'App\\Models\\User', 31, 'App\\Models\\User', 31, '', 'finished', '', '2023-04-20 18:08:12', '2023-04-20 18:08:12', NULL, '{\"name\":\"testt\",\"email\":\"testt@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-20T18:08:12.000000Z\",\"created_at\":\"2023-04-20T18:08:12.000000Z\",\"id\":31}'),
(588, '98fab50f-8057-4bd9-bd1f-d977858e37f7', 28, 'Create', 'App\\Models\\User', 32, 'App\\Models\\User', 32, 'App\\Models\\User', 32, '', 'finished', '', '2023-04-20 21:17:49', '2023-04-20 21:17:49', NULL, '{\"name\":\"agg\",\"email\":\"agg@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-20T21:17:49.000000Z\",\"created_at\":\"2023-04-20T21:17:49.000000Z\",\"id\":32}'),
(589, '98fab60c-d0eb-4064-bfdc-0c216613d2c8', 28, 'Create', 'App\\Models\\User', 33, 'App\\Models\\User', 33, 'App\\Models\\User', 33, '', 'finished', '', '2023-04-20 21:20:35', '2023-04-20 21:20:35', NULL, '{\"name\":\"a\",\"email\":\"a@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-20T21:20:35.000000Z\",\"created_at\":\"2023-04-20T21:20:35.000000Z\",\"id\":33}'),
(590, '98fab676-eb5e-447b-a13f-e5589bc89a69', 28, 'Delete', 'App\\Models\\User', 32, 'App\\Models\\User', 32, 'App\\Models\\User', 32, '', 'finished', '', '2023-04-20 21:21:44', '2023-04-20 21:21:44', NULL, NULL),
(591, '98fab676-f61b-4336-8d8e-7e596e0f782a', 28, 'Delete', 'App\\Models\\User', 33, 'App\\Models\\User', 33, 'App\\Models\\User', 33, '', 'finished', '', '2023-04-20 21:21:44', '2023-04-20 21:21:44', NULL, NULL),
(592, '98fe53b7-f63f-4bf1-829a-f91078681a78', 28, 'Create', 'App\\Models\\User', 34, 'App\\Models\\User', 34, 'App\\Models\\User', 34, '', 'finished', '', '2023-04-22 16:28:56', '2023-04-22 16:28:56', NULL, '{\"name\":\"amine\",\"email\":\"amine@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-22T16:28:56.000000Z\",\"created_at\":\"2023-04-22T16:28:56.000000Z\",\"id\":34}'),
(593, '99021f63-1ef6-417e-ab8b-bc1db4d07acd', 28, 'Create', 'App\\Models\\Indicator', 50, 'App\\Models\\Indicator', 50, 'App\\Models\\Indicator', 50, '', 'finished', '', '2023-04-24 13:45:56', '2023-04-24 13:45:56', NULL, '{\"name\":\"Sant\\u00e9 machines - Niveau 0\",\"code\":\"machines_lv0_health\",\"starting_value\":\"1\",\"is_financial\":false,\"updated_at\":\"2023-04-24T13:45:55.000000Z\",\"created_at\":\"2023-04-24T13:45:55.000000Z\",\"id\":50}'),
(594, '99021f87-6f29-4052-a1af-cf88380f2289', 28, 'Create', 'App\\Models\\Indicator', 51, 'App\\Models\\Indicator', 51, 'App\\Models\\Indicator', 51, '', 'finished', '', '2023-04-24 13:46:19', '2023-04-24 13:46:19', NULL, '{\"name\":\"Machines Occup\\u00e9es - Niveau 0\",\"code\":\"nb_machines_lv0_busy\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2023-04-24T13:46:19.000000Z\",\"created_at\":\"2023-04-24T13:46:19.000000Z\",\"id\":51}'),
(595, '99021fac-b101-4832-850d-f679914efea4', 28, 'Create', 'App\\Models\\Indicator', 52, 'App\\Models\\Indicator', 52, 'App\\Models\\Indicator', 52, '', 'finished', '', '2023-04-24 13:46:43', '2023-04-24 13:46:43', NULL, '{\"name\":\"Machines - Niveau 0\",\"code\":\"nb_machines_lv0\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2023-04-24T13:46:43.000000Z\",\"created_at\":\"2023-04-24T13:46:43.000000Z\",\"id\":52}'),
(596, '99022217-747f-4d6b-83d7-44e0cf92a3c9', 28, 'Create', 'App\\Models\\GameSetting', 31, 'App\\Models\\GameSetting', 31, 'App\\Models\\GameSetting', 31, '', 'finished', '', '2023-04-24 13:53:29', '2023-04-24 13:53:29', NULL, '{\"name\":\"Durabilit\\u00e9 machines niveau 0\",\"code\":\"machines_lv0_durability\",\"value\":\"0.2\",\"default_value\":\"0.2\",\"type\":\"float\",\"updated_at\":\"2023-04-24T13:53:29.000000Z\",\"created_at\":\"2023-04-24T13:53:29.000000Z\",\"id\":31}'),
(597, '9902224d-8216-4684-94c6-9cf1b8e6a8e4', 28, 'Create', 'App\\Models\\GameSetting', 32, 'App\\Models\\GameSetting', 32, 'App\\Models\\GameSetting', 32, '', 'finished', '', '2023-04-24 13:54:04', '2023-04-24 13:54:04', NULL, '{\"name\":\"Pollution machines niveau 0\",\"code\":\"machines_lv0_pollution\",\"value\":\"10\",\"default_value\":\"10\",\"type\":\"float\",\"updated_at\":\"2023-04-24T13:54:04.000000Z\",\"created_at\":\"2023-04-24T13:54:04.000000Z\",\"id\":32}'),
(598, '99022299-0cbe-41c5-8ce9-e727f25b13fc', 28, 'Create', 'App\\Models\\GameSetting', 33, 'App\\Models\\GameSetting', 33, 'App\\Models\\GameSetting', 33, '', 'finished', '', '2023-04-24 13:54:54', '2023-04-24 13:54:54', NULL, '{\"name\":\"Vitesse machines niveau 0\",\"code\":\"machines_lv0_speed\",\"value\":\"5\",\"default_value\":\"5\",\"type\":\"float\",\"updated_at\":\"2023-04-24T13:54:54.000000Z\",\"created_at\":\"2023-04-24T13:54:54.000000Z\",\"id\":33}'),
(599, '990222d1-9537-4e60-afe8-788285530724', 28, 'Create', 'App\\Models\\GameSetting', 34, 'App\\Models\\GameSetting', 34, 'App\\Models\\GameSetting', 34, '', 'finished', '', '2023-04-24 13:55:31', '2023-04-24 13:55:31', NULL, '{\"name\":\"Prix machines niveau 0\",\"code\":\"machines_lv0_price\",\"value\":\"300000\",\"default_value\":\"300000\",\"type\":\"int\",\"updated_at\":\"2023-04-24T13:55:31.000000Z\",\"created_at\":\"2023-04-24T13:55:31.000000Z\",\"id\":34}'),
(600, '99049b97-6863-4cb4-b131-17e5f5b217e6', 28, 'Create', 'App\\Models\\Indicator', 53, 'App\\Models\\Indicator', 53, 'App\\Models\\Indicator', 53, '', 'finished', '', '2023-04-25 19:24:53', '2023-04-25 19:24:53', NULL, '{\"name\":\"Jupe ajust\\u00e9e\",\"code\":\"ca_10\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2023-04-25T19:24:53.000000Z\",\"created_at\":\"2023-04-25T19:24:53.000000Z\",\"id\":53}'),
(601, '99049bba-4e95-4604-82b1-08f2e154aff8', 28, 'Create', 'App\\Models\\Indicator', 54, 'App\\Models\\Indicator', 54, 'App\\Models\\Indicator', 54, '', 'finished', '', '2023-04-25 19:25:15', '2023-04-25 19:25:15', NULL, '{\"name\":\"Jupe longue\",\"code\":\"ca_11\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2023-04-25T19:25:15.000000Z\",\"created_at\":\"2023-04-25T19:25:15.000000Z\",\"id\":54}'),
(602, '99049daf-9525-4d80-889c-8b90bf0bf0f4', 28, 'Create', 'App\\Models\\Product', 12, 'App\\Models\\Product', 12, 'App\\Models\\Product', 12, '', 'finished', '', '2023-04-25 19:30:44', '2023-04-25 19:30:44', NULL, '{\"name\":\"Pull \\u00e0 col b\\u00e2teau\",\"price_min\":\"1\",\"price_max\":\"1\",\"prod_speed_factor\":\"1\",\"unit_prod_price\":\"1\",\"ad_coef\":\"1\",\"avg_demand\":\"1\",\"left_demand\":\"10000\",\"percent_population\":\"1\",\"icon\":\"1\",\"description\":\"TROP BEAU\",\"updated_at\":\"2023-04-25T19:30:44.000000Z\",\"created_at\":\"2023-04-25T19:30:44.000000Z\",\"id\":12}'),
(603, '99049e19-a70e-4f16-9b75-e2aaf4abb93a', 28, 'Create', 'App\\Models\\Indicator', 55, 'App\\Models\\Indicator', 55, 'App\\Models\\Indicator', 55, '', 'finished', '', '2023-04-25 19:31:54', '2023-04-25 19:31:54', NULL, '{\"name\":\"Pull \\u00e0 col b\\u00e2teau\",\"code\":\"ca_12\",\"starting_value\":\"0\",\"is_financial\":false,\"updated_at\":\"2023-04-25T19:31:53.000000Z\",\"created_at\":\"2023-04-25T19:31:53.000000Z\",\"id\":55}'),
(604, '9906c00f-9bff-40e2-aa8e-14d7b03770e0', 28, 'Attach', 'App\\Models\\RawMaterial', 11, 'App\\Models\\Supplier', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-26 20:58:31', '2023-04-26 20:58:31', NULL, '{\"raw_material_id\":\"11\",\"supplier_id\":\"2\",\"price_factor\":\"0.8\",\"is_available\":true,\"time_to_deliver\":\"6\"}'),
(605, '9906c077-1d83-4428-be28-e845a050af95', 28, 'Attach', 'App\\Models\\RawMaterial', 12, 'App\\Models\\Supplier', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-26 20:59:38', '2023-04-26 20:59:38', NULL, '{\"raw_material_id\":\"12\",\"supplier_id\":\"2\",\"price_factor\":\"0.8\",\"is_available\":true,\"time_to_deliver\":\"6\"}'),
(606, '9906c0b2-a3c6-41ce-9daa-18d4e6ba08c9', 28, 'Attach', 'App\\Models\\RawMaterial', 13, 'App\\Models\\Supplier', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-26 21:00:17', '2023-04-26 21:00:17', NULL, '{\"raw_material_id\":\"13\",\"supplier_id\":\"2\",\"price_factor\":\"0.8\",\"is_available\":true,\"time_to_deliver\":\"6\"}'),
(607, '9906c0e9-ccc5-41a6-8cfa-acaf4fc52b63', 28, 'Attach', 'App\\Models\\RawMaterial', 14, 'App\\Models\\Supplier', 2, 'Illuminate\\Database\\Eloquent\\Relations\\Pivot', NULL, '', 'finished', '', '2023-04-26 21:00:54', '2023-04-26 21:00:54', NULL, '{\"raw_material_id\":\"14\",\"supplier_id\":\"2\",\"price_factor\":\"0.8\",\"is_available\":true,\"time_to_deliver\":\"6\"}'),
(608, '990ad283-a0e0-4898-9383-d2fba8b2d795', 28, 'Create', 'App\\Models\\User', 35, 'App\\Models\\User', 35, 'App\\Models\\User', 35, '', 'finished', '', '2023-04-28 21:33:26', '2023-04-28 21:33:26', NULL, '{\"name\":\"sim\",\"email\":\"sim@bg.iec\",\"type\":\"entreprise\",\"updated_at\":\"2023-04-28T21:33:25.000000Z\",\"created_at\":\"2023-04-28T21:33:25.000000Z\",\"id\":35}');

-- --------------------------------------------------------

--
-- Structure de la table `ads`
--

DROP TABLE IF EXISTS `ads`;
CREATE TABLE IF NOT EXISTS `ads` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `entreprise_id` bigint UNSIGNED NOT NULL,
  `amount` bigint DEFAULT NULL,
  `result` bigint DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `days` int DEFAULT NULL,
  `creation_date` int NOT NULL,
  `predicted_result` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ads_entreprise_id_foreign` (`entreprise_id`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ads`
--

INSERT INTO `ads` (`id`, `created_at`, `updated_at`, `entreprise_id`, `amount`, `result`, `type`, `status`, `days`, `creation_date`, `predicted_result`) VALUES
(125, '2023-04-20 16:15:25', '2023-04-20 16:15:25', 30, 1000, 538, 'social', 'done', 1, 226, 480),
(126, '2023-04-25 22:17:16', '2023-04-25 22:17:16', 29, 2001, 726, 'media', 'done', 1, 996, 640);

-- --------------------------------------------------------

--
-- Structure de la table `daily_stats`
--

DROP TABLE IF EXISTS `daily_stats`;
CREATE TABLE IF NOT EXISTS `daily_stats` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `day` int NOT NULL,
  `entreprise_id` int NOT NULL,
  `sales` bigint NOT NULL,
  `caisse` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `starting_worker_nb` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `departments`
--

INSERT INTO `departments` (`id`, `name`, `starting_worker_nb`, `created_at`, `updated_at`, `icon`) VALUES
(1, 'Production', 5, '2021-03-20 20:44:18', '2021-03-20 21:23:16', 'fa-industry'),
(2, 'Approvisionnement', 2, '2021-03-20 21:23:44', '2021-03-20 21:23:44', 'fa-box-open'),
(3, 'Marketing', 5, '2021-03-20 21:23:58', '2021-03-20 21:23:58', 'fa-ad'),
(4, 'Finance', 3, '2021-03-20 21:25:16', '2021-03-20 21:25:16', 'fa-file-invoice-dollar'),
(5, 'Ressources Humaines', 2, '2021-03-20 21:32:30', '2021-04-08 10:53:02', 'fa-users');

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

DROP TABLE IF EXISTS `entreprises`;
CREATE TABLE IF NOT EXISTS `entreprises` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entreprises_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `entreprises`
--

INSERT INTO `entreprises` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'GSK', 'gsk@bg.com', NULL, '$2y$10$b2uirxheG/2/QTlLlKpemuBtmob4dgRkgyxYUJGAo74.dUkncxWPK', NULL, '2021-03-17 12:57:15', '2021-03-17 12:57:15');

-- --------------------------------------------------------

--
-- Structure de la table `entreprise_indicator`
--

DROP TABLE IF EXISTS `entreprise_indicator`;
CREATE TABLE IF NOT EXISTS `entreprise_indicator` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `entreprise_id` int NOT NULL,
  `indicator_id` int NOT NULL,
  `value` double DEFAULT NULL,
  `phase` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=991 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `entreprise_indicator`
--

INSERT INTO `entreprise_indicator` (`id`, `entreprise_id`, `indicator_id`, `value`, `phase`) VALUES

(673, 29, 43, 30, 0),
(674, 29, 4, 0, 0),
(675, 29, 38, 0, 0),
(676, 29, 33, 0, 0),
(677, 29, 39, 0, 0),
(678, 29, 31, 0, 0),
(679, 29, 44, 0, 0),
(680, 29, 12, 4.018356350503402e22, 0),
(681, 29, 1, 100000990, 0),
(682, 29, 45, 990, 0),
(683, 29, 46, 0, 0),
(684, 29, 47, 0, 0),
(685, 29, 48, 0, 0),
(686, 29, 49, 0, 0),
(687, 29, 9, 3, 0),
(688, 29, 34, 4, 0),
(689, 29, 36, 0, 0),
(690, 29, 29, 3.422693262584463e21, 0),
(691, 29, 40, 0, 0),
(692, 29, 41, 0, 0),
(693, 29, 42, 1, 0),
(694, 29, 15, 0, 0),
(695, 29, 35, 0, 0),
(696, 29, 37, 0, 0),
(697, 29, 11, 0.01, 0),
(698, 29, 14, 0.7, 0),
(699, 29, 21, 1, 0),
(700, 29, 17, 736, 0),
(701, 29, 18, 0, 0),
(702, 29, 19, 72.6, 0),
(703, 29, 20, 0, 0),
(704, 29, 32, 0, 0),
(705, 29, 13, 4450, 0),
(706, 29, 22, 0, 0),
(707, 29, 24, 0, 0),
(708, 29, 30, 1, 0),
(709, 29, 27, 1000, 0),
(710, 29, 26, 1000, 0),
(711, 29, 25, 1000, 0),
(712, 29, 28, 1000, 0),
(713, 30, 12, 48541361, 0),
(714, 30, 29, 0, 0),
(715, 30, 9, 3, 0),
(716, 30, 34, 0, 0),
(717, 30, 36, 0, 0),
(718, 30, 15, 0, 0),
(719, 30, 35, 0, 0),
(720, 30, 37, 0, 0),
(721, 30, 40, 0, 0),
(722, 30, 41, 1, 0),
(723, 30, 42, 1, 0),
(724, 30, 4, 0, 0),
(725, 30, 38, 0, 0),
(726, 30, 33, 0, 0),
(727, 30, 39, 0, 0),
(728, 30, 31, 0, 0),
(729, 30, 43, 30, 0),
(730, 30, 1, 990, 0),
(731, 30, 11, 0.01, 0),
(732, 30, 14, 0.7, 0),
(733, 30, 21, 1, 0),
(734, 30, 44, 0, 0),
(735, 30, 45, 990, 0),
(736, 30, 46, 0, 0),
(737, 30, 47, 0, 0),
(738, 30, 48, 0, 0),
(739, 30, 49, 0, 0),
(740, 30, 13, 1000, 0),
(741, 30, 17, 548, 0),
(742, 30, 18, 53.8, 0),
(743, 30, 19, 0, 0),
(744, 30, 20, 0, 0),
(745, 30, 22, 0, 0),
(746, 31, 12, 49169000, 0),
(747, 31, 29, 0, 0),
(748, 31, 9, 3, 0),
(749, 31, 34, 0, 0),
(750, 31, 36, 0, 0),
(751, 31, 15, 0, 0),
(752, 31, 35, 0, 0),
(753, 31, 37, 0, 0),
(754, 31, 40, 0, 0),
(755, 31, 41, 1, 0),
(756, 31, 42, 1, 0),
(757, 31, 4, 0, 0),
(758, 31, 38, 0, 0),
(759, 31, 33, 0, 0),
(760, 31, 39, 0, 0),
(761, 31, 31, 0, 0),
(762, 31, 43, 30, 0),
(763, 31, 1, 0, 0),
(764, 31, 11, 0.01, 0),
(765, 31, 14, 0.7, 0),
(766, 31, 21, 1, 0),
(767, 31, 44, 0, 0),
(768, 31, 45, 0, 0),
(769, 31, 46, 0, 0),
(770, 31, 47, 0, 0),
(771, 31, 48, 0, 0),
(772, 31, 49, 0, 0),
(773, 31, 17, 10, 0),
(774, 31, 18, 0, 0),
(775, 31, 19, 0, 0),
(776, 31, 20, 0, 0),
(777, 32, 43, 8, 0),
(778, 32, 4, 3, 0),
(779, 32, 38, 0, 0),
(780, 32, 33, 0, 0),
(781, 32, 39, 0, 0),
(782, 32, 31, 0.7999999999999998, 0),
(783, 32, 44, 0, 0),
(784, 32, 12, 50000000, 0),
(785, 32, 1, 0, 0),
(786, 32, 45, 0, 0),
(787, 32, 46, 0, 0),
(788, 32, 47, 0, 0),
(789, 32, 48, 0, 0),
(790, 32, 49, 0, 0),
(791, 32, 29, 0, 0),
(792, 32, 9, 3, 0),
(793, 32, 34, 0, 0),
(794, 32, 36, 0, 0),
(795, 32, 15, 0, 0),
(796, 32, 35, 0, 0),
(797, 32, 37, 0, 0),
(798, 32, 40, 1, 0),
(799, 32, 41, 1, 0),
(800, 32, 42, 1, 0),
(801, 32, 11, 0.01, 0),
(802, 32, 14, 0.7, 0),
(803, 32, 21, 1, 0),
(804, 33, 43, 5, 0),
(805, 33, 4, 3, 0),
(806, 33, 38, 0, 0),
(807, 33, 33, 0, 0),
(808, 33, 39, 0, 0),
(809, 33, 31, 0.95, 0),
(810, 33, 44, 0, 0),
(811, 33, 12, 50000000, 0),
(812, 33, 1, 0, 0),
(813, 33, 45, 0, 0),
(814, 33, 46, 0, 0),
(815, 33, 47, 0, 0),
(816, 33, 48, 0, 0),
(817, 33, 49, 0, 0),
(818, 34, 43, 30, 0),
(819, 34, 4, 0, 0),
(820, 34, 38, 0, 0),
(821, 34, 33, 0, 0),
(822, 34, 39, 0, 0),
(823, 34, 31, 0, 0),
(824, 34, 44, 0, 0),
(825, 34, 12, 44876000, 0),
(826, 34, 9, 3, 0),
(827, 34, 34, 0, 0),
(828, 34, 36, 0, 0),
(829, 34, 1, 0, 0),
(830, 34, 45, 0, 0),
(831, 34, 46, 0, 0),
(832, 34, 47, 0, 0),
(833, 34, 48, 0, 0),
(834, 34, 49, 0, 0),
(835, 34, 29, 0, 0),
(836, 34, 15, 0, 0),
(837, 34, 35, 0, 0),
(838, 34, 37, 0, 0),
(839, 34, 40, 0, 0),
(840, 34, 41, 1, 0),
(841, 34, 42, 1, 0),
(842, 34, 11, 0.01, 0),
(843, 34, 14, 0.7, 0),
(844, 34, 21, 1, 0),
(845, 2, 50, 1, 0),
(846, 4, 50, 1, 0),
(847, 5, 50, 1, 0),
(848, 7, 50, 1, 0),
(849, 10, 50, 1, 0),
(850, 11, 50, 1, 0),
(851, 13, 50, 1, 0),
(852, 14, 50, 1, 0),
(853, 22, 50, 1, 0),
(854, 23, 50, 1, 0),
(855, 24, 50, 1, 0),
(856, 25, 50, 1, 0),
(857, 29, 50, 0, 0),
(858, 34, 50, 1, 0),
(859, 2, 51, 0, 0),
(860, 4, 51, 0, 0),
(861, 5, 51, 0, 0),
(862, 7, 51, 0, 0),
(863, 10, 51, 0, 0),
(864, 11, 51, 0, 0),
(865, 13, 51, 0, 0),
(866, 14, 51, 0, 0),
(867, 22, 51, 0, 0),
(868, 23, 51, 0, 0),
(869, 24, 51, 0, 0),
(870, 25, 51, 0, 0),
(871, 29, 51, 0, 0),
(872, 34, 51, 0, 0),
(873, 2, 52, 0, 0),
(874, 4, 52, 0, 0),
(875, 5, 52, 0, 0),
(876, 7, 52, 0, 0),
(877, 10, 52, 0, 0),
(878, 11, 52, 0, 0),
(879, 13, 52, 0, 0),
(880, 14, 52, 0, 0),
(881, 22, 52, 0, 0),
(882, 23, 52, 0, 0),
(883, 24, 52, 0, 0),
(884, 25, 52, 0, 0),
(885, 29, 52, 6, 0),
(886, 34, 52, 0, 0),
(887, 29, 50, 0, 0),
(888, 2, 53, 0, 0),
(889, 4, 53, 0, 0),
(890, 5, 53, 0, 0),
(891, 7, 53, 0, 0),
(892, 10, 53, 0, 0),
(893, 11, 53, 0, 0),
(894, 13, 53, 0, 0),
(895, 14, 53, 0, 0),
(896, 22, 53, 0, 0),
(897, 23, 53, 0, 0),
(898, 24, 53, 0, 0),
(899, 25, 53, 0, 0),
(900, 29, 53, 0, 0),
(901, 34, 53, 0, 0),
(902, 2, 54, 0, 0),
(903, 4, 54, 0, 0),
(904, 5, 54, 0, 0),
(905, 7, 54, 0, 0),
(906, 10, 54, 0, 0),
(907, 11, 54, 0, 0),
(908, 13, 54, 0, 0),
(909, 14, 54, 0, 0),
(910, 22, 54, 0, 0),
(911, 23, 54, 0, 0),
(912, 24, 54, 0, 0),
(913, 25, 54, 0, 0),
(914, 29, 54, 0, 0),
(915, 34, 54, 0, 0),
(916, 2, 55, 0, 0),
(917, 4, 55, 0, 0),
(918, 5, 55, 0, 0),
(919, 7, 55, 0, 0),
(920, 10, 55, 0, 0),
(921, 11, 55, 0, 0),
(922, 13, 55, 0, 0),
(923, 14, 55, 0, 0),
(924, 22, 55, 0, 0),
(925, 23, 55, 0, 0),
(926, 24, 55, 0, 0),
(927, 25, 55, 0, 0),
(928, 29, 55, 0, 0),
(929, 34, 55, 0, 0),
(930, 29, 52, 2, 0),
(931, 29, 51, 0, 0),
(932, 29, 50, 0, 0),
(933, 34, 27, 1000, 0),
(934, 34, 26, 1000, 0),
(935, 34, 25, 1000, 0),
(936, 34, 28, 1000, 0),
(937, 34, 17, 10, 0),
(938, 34, 18, 0, 0),
(939, 34, 19, 0, 0),
(940, 34, 20, 0, 0),
(941, 34, 32, 0, 0),
(942, 34, 13, 0, 0),
(943, 34, 22, 0, 0),
(944, 34, 24, 0, 0),
(945, 34, 30, 1, 0),
(946, 35, 12, 49319000, 0),
(947, 35, 29, 0, 0),
(948, 35, 17, 10, 0),
(949, 35, 18, 0, 0),
(950, 35, 19, 0, 0),
(951, 35, 20, 0, 0),
(952, 35, 43, 30, 0),
(953, 35, 4, 1, 0),
(954, 35, 38, 0, 0),
(955, 35, 33, 0, 0),
(956, 35, 39, 0, 0),
(957, 35, 31, 0, 0),
(958, 35, 44, 0, 0),
(959, 35, 1, 0, 0),
(960, 35, 45, 0, 0),
(961, 35, 46, 0, 0),
(962, 35, 47, 0, 0),
(963, 35, 48, 0, 0),
(964, 35, 49, 0, 0),
(965, 35, 14, 0.7, 0),
(966, 35, 9, 3, 0),
(967, 35, 52, 0, 0),
(968, 35, 34, 0, 0),
(969, 35, 36, 0, 0),
(970, 35, 15, 0, 0),
(971, 35, 51, 0, 0),
(972, 35, 35, 0, 0),
(973, 35, 37, 0, 0),
(974, 35, 40, 0, 0),
(975, 35, 50, 1, 0),
(976, 35, 41, 1, 0),
(977, 35, 42, 1, 0),
(978, 35, 11, 0.01, 0),
(979, 35, 21, 1, 0),
(980, 35, 13, 0, 0),
(981, 35, 22, 0, 0),
(982, 35, 24, 0, 0),
(983, 35, 25, 1000, 0),
(984, 35, 26, 1000, 0),
(985, 35, 27, 1000, 0),
(986, 35, 28, 1000, 0),
(987, 35, 53, 0, 0),
(988, 35, 54, 0, 0),
(989, 35, 55, 0, 0),
(990, 35, 30, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM AUTO_INCREMENT=239 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(224, 'df2fbfc1-b669-4916-8669-fb4b39996da7', 'database', 'default', '{\"uuid\":\"df2fbfc1-b669-4916-8669-fb4b39996da7\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 11:36:02'),
(225, '087672ec-cf56-43b2-83b9-78c5d079f259', 'database', 'default', '{\"uuid\":\"087672ec-cf56-43b2-83b9-78c5d079f259\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:36:01'),
(226, '5a31679d-f6f4-4b08-8b19-bca260919c60', 'database', 'default', '{\"uuid\":\"5a31679d-f6f4-4b08-8b19-bca260919c60\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:50:01'),
(227, '1b2ed117-cc62-4a19-bf0b-984f07dcfd69', 'database', 'default', '{\"uuid\":\"1b2ed117-cc62-4a19-bf0b-984f07dcfd69\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:51:01'),
(228, 'f159985b-cc35-4d5c-a4b0-8147f7af3334', 'database', 'default', '{\"uuid\":\"f159985b-cc35-4d5c-a4b0-8147f7af3334\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:52:02');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(229, 'be359815-78e7-461b-9831-a9a4ac2c035c', 'database', 'default', '{\"uuid\":\"be359815-78e7-461b-9831-a9a4ac2c035c\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:53:01'),
(230, 'e5d37d02-b4c5-4d52-9163-35f7d6d571f5', 'database', 'default', '{\"uuid\":\"e5d37d02-b4c5-4d52-9163-35f7d6d571f5\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:55:02'),
(231, 'a9ad32af-4bf8-443a-854a-d2f814514441', 'database', 'default', '{\"uuid\":\"a9ad32af-4bf8-443a-854a-d2f814514441\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:56:03'),
(232, '08015310-3dbb-4a67-99a2-d9c424314286', 'database', 'default', '{\"uuid\":\"08015310-3dbb-4a67-99a2-d9c424314286\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:57:03'),
(233, '705435ea-3286-4d5d-b3e9-a2529b3a2817', 'database', 'default', '{\"uuid\":\"705435ea-3286-4d5d-b3e9-a2529b3a2817\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:58:01');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(234, '785c6b7b-cac4-44c0-860a-bfb2380bca03', 'database', 'default', '{\"uuid\":\"785c6b7b-cac4-44c0-860a-bfb2380bca03\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 18:59:01'),
(235, '9c94af1d-92b9-40c6-a244-3097ea42f632', 'database', 'default', '{\"uuid\":\"9c94af1d-92b9-40c6-a244-3097ea42f632\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 19:00:02'),
(236, 'afa9079d-33ad-4710-bea0-365293af95cc', 'database', 'default', '{\"uuid\":\"afa9079d-33ad-4710-bea0-365293af95cc\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 19:01:04'),
(237, 'e8c21e27-3e45-44e6-bb98-25a96a9cac0f', 'database', 'default', '{\"uuid\":\"e8c21e27-3e45-44e6-bb98-25a96a9cac0f\",\"displayName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SellProductionsScheduler\",\"command\":\"O:33:\\\"App\\\\Jobs\\\\SellProductionsScheduler\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"left_demand\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php:51\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\SellProductionsScheduler.php(51): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 51)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\SellProductionsScheduler->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\SellProductionsScheduler), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\SellProductionsScheduler))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\SellProductionsScheduler))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 19:02:01'),
(238, 'fae8a648-8cc8-49c1-8e8c-279330adcccf', 'database', 'default', '{\"uuid\":\"fae8a648-8cc8-49c1-8e8c-279330adcccf\",\"displayName\":\"App\\\\Jobs\\\\MonthlyCosts\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\MonthlyCosts\",\"command\":\"O:21:\\\"App\\\\Jobs\\\\MonthlyCosts\\\":10:{s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Attempt to read property \"value\" on null in C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\MonthlyCosts.php:97\nStack trace:\n#0 C:\\Users\\PC\\Desktop\\bg\\bg-app\\app\\Jobs\\MonthlyCosts.php(97): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\PC\\\\Des...\', 97)\n#1 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\MonthlyCosts->handle()\n#2 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#7 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\MonthlyCosts))\n#8 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\MonthlyCosts))\n#9 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(119): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\MonthlyCosts), false)\n#11 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\MonthlyCosts))\n#12 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\MonthlyCosts))\n#13 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(118): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\MonthlyCosts))\n#15 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(116): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(100): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(120): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(1040): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(301): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\Users\\PC\\Desktop\\bg\\bg-app\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\Users\\PC\\Desktop\\bg\\bg-app\\artisan(35): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 {main}', '2023-04-28 21:36:06');

-- --------------------------------------------------------

--
-- Structure de la table `game_settings`
--

DROP TABLE IF EXISTS `game_settings`;
CREATE TABLE IF NOT EXISTS `game_settings` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'float',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `game_settings`
--

INSERT INTO `game_settings` (`id`, `name`, `code`, `value`, `default_value`, `created_at`, `updated_at`, `type`) VALUES
(2, 'Salaire employés niveau 1', 'salary_lv1', '30000', '30000', '2022-04-23 22:50:04', '2022-04-27 21:21:51', 'int'),
(3, 'Salaire employés niveau 2', 'salary_lv2', '60000', '60000', '2022-04-23 22:54:15', '2022-04-27 21:22:08', 'int'),
(4, 'Prix formation', 'workshop_price', '30000', '30000', '2022-04-23 23:27:32', '2022-04-24 06:50:15', 'int'),
(5, 'Coefficient prime', 'bonus_coeff', '2', '2', '2022-04-23 23:27:53', '2022-04-25 03:34:29', 'float'),
(6, 'Seuil humeur pour quitter', 'mood_quitting_threshold', '0.25', '0.25', '2022-04-23 23:28:20', '2022-04-27 21:23:27', 'float'),
(7, 'Probabilité de démission', 'quitting_prob', '0.1', '0.1', '2022-04-23 23:29:40', '2022-04-24 06:50:13', 'float'),
(8, 'Probabilité d\'embaucher', 'hiring_prob', '0.8', '0.8', '2022-04-23 23:30:56', '2022-04-24 06:50:07', 'float'),
(9, 'Vitesse réduction humeur employés', 'workers_mood_decay_rate', '0.05', '0.05', '2022-04-23 23:32:02', '2022-05-11 17:08:16', 'float'),
(10, 'Prix machines niveau 1', 'machines_lv1_price', '9000000', '9000000', '2022-04-23 23:32:30', '2023-04-18 21:34:21', 'int'),
(11, 'Prix machines niveau 2', 'machines_lv2_price', '18000000', '18000000', '2022-04-23 23:32:51', '2023-04-18 21:34:21', 'int'),
(12, 'Prix machines niveau 3', 'machines_lv3_price', '45000000', '45000000', '2022-04-23 23:33:38', '2023-04-18 21:34:21', 'int'),
(13, 'Vitesse machines niveau 1', 'machines_lv1_speed', '1', '1', '2022-04-23 23:34:03', '2022-04-24 06:50:09', 'float'),
(14, 'Vitesse machines niveau 2', 'machines_lv2_speed', '2.5', '2.5', '2022-04-23 23:34:17', '2022-05-05 13:37:28', 'float'),
(15, 'Vitesse machines niveau 3', 'machines_lv3_speed', '7', '7', '2022-04-23 23:34:30', '2022-05-05 13:38:00', 'float'),
(16, 'Pollution machines niveau 1', 'machines_lv1_pollution', '3', '3', '2022-04-23 23:35:08', '2022-04-24 06:50:08', 'float'),
(17, 'Pollution machines niveau 2', 'machines_lv2_pollution', '2', '2', '2022-04-23 23:35:31', '2022-04-24 06:50:09', 'float'),
(18, 'Pollution machines niveau 3', 'machines_lv3_pollution', '1', '1', '2022-04-23 23:35:53', '2022-04-24 06:50:11', 'float'),
(19, 'Durabilité machines niveau 1', 'machines_lv1_durability', '0.2', '0.2', '2022-04-23 23:36:40', '2022-05-07 10:18:31', 'float'),
(20, 'Durabilité machines niveau 2', 'machines_lv2_durability', '0.125', '0.125', '2022-04-23 23:37:00', '2022-04-24 06:50:09', 'float'),
(21, 'Durabilité machines niveau 3', 'machines_lv3_durability', '0.0416', '0.0416', '2022-04-23 23:38:46', '2022-04-24 06:50:10', 'float'),
(22, 'Cout unitaire de distribution', 'dist_unit_cost', '5', '5', '2022-04-23 23:39:56', '2022-04-24 06:50:07', 'float'),
(23, 'Cout unitaire pollution', 'pollution_unit_cost', '1000', '1000', '2022-04-23 23:40:20', '2022-04-24 06:50:12', 'float'),
(24, 'Prix de la manutention des MP', 'mp_stock_price', '2.5', '2.5', '2022-04-23 23:41:09', '2022-04-24 06:50:12', 'float'),
(25, 'Simulation en cours ?', 'game_started', '1', '0', '2022-04-23 23:41:29', '2023-04-18 21:35:12', 'bool'),
(26, 'Semaine début de simulation', 'start_date', '1', '1', '2022-04-23 23:42:50', '2022-04-24 06:50:14', 'int'),
(27, 'Semaine courante de la simulation', 'current_date', '2598', '1', '2022-04-23 23:43:28', '2023-04-29 00:19:01', 'int'),
(28, 'Afficher le score finale', 'show_final_score', '0', '0', '2022-04-23 23:43:53', '2022-04-24 06:50:14', 'bool'),
(29, 'Population', 'population', '1000000', '1000000', '2022-04-27 20:11:28', '2022-04-27 20:11:28', 'float'),
(30, 'Pourcentage taxe CA', 'ca_tax_percent', '0.1', '0.1', '2022-05-04 12:07:27', '2022-05-11 17:08:02', 'float'),
(31, 'Durabilité machines niveau 0', 'machines_lv0_durability', '0.25', '0.25', '2023-04-24 13:53:29', '2023-04-24 13:53:29', 'float'),
(32, 'Pollution machines niveau 0', 'machines_lv0_pollution', '10', '10', '2023-04-24 13:54:04', '2023-04-24 13:54:04', 'float'),
(33, 'Vitesse machines niveau 0', 'machines_lv0_speed', '2', '2', '2023-04-24 13:54:54', '2023-04-24 13:54:54', 'float'),
(34, 'Prix machines niveau 0', 'machines_lv0_price', '6200000', '6200000', '2023-04-24 13:55:31', '2023-04-24 13:55:31', 'int');

-- --------------------------------------------------------

--
-- Structure de la table `indicators`
--

DROP TABLE IF EXISTS `indicators`;
CREATE TABLE IF NOT EXISTS `indicators` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `starting_value` double NOT NULL DEFAULT '0',
  `is_financial` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `indicators`
--

INSERT INTO `indicators` (`id`, `name`, `code`, `created_at`, `updated_at`, `starting_value`, `is_financial`) VALUES
(1, 'Chiffre d\'Affaire', 'ca', NULL, '2022-05-07 10:09:43', 0, 1),
(2, 'Nombre d\'Employés', 'nb_workers', NULL, '2021-04-10 20:05:34', 8, 0),
(3, 'Part du Marché', 'market_share', NULL, NULL, 0, 1),
(4, 'Employés - Niveau 1', 'nb_workers_lv1', NULL, '2022-05-07 10:15:26', 3, 0),
(5, 'Employés - Approvisionnement', 'nb_workers_approv', NULL, NULL, 3, 0),
(6, 'Employés - RH', 'nb_workers_rh', NULL, NULL, 3, 0),
(7, 'Employés - Marketing', 'nb_workers_marketing', NULL, NULL, 3, 0),
(8, 'Employés - Finance', 'nb_workers_finance', NULL, NULL, 3, 0),
(9, 'Machines - Niveau 1', 'nb_machines_lv1', NULL, '2022-05-07 10:13:07', 3, 0),
(11, 'Taux de Rebut', 'reject_rate', '2021-04-01 15:15:42', '2021-04-08 15:26:17', 0.01, 0),
(12, 'Disponibilité', 'caisse', '2021-04-02 21:13:50', '2022-05-07 01:26:06', 50000000, 1),
(13, 'Coefficients de Production', 'prod_cost', '2021-04-02 21:14:13', '2021-04-02 21:14:27', 0, 1),
(14, 'Coefficient de Productivité', 'productivity_coeff', '2021-04-02 22:26:45', '2021-04-11 13:01:30', 0.7, 0),
(15, 'Machines Occupées - Niveau 1', 'nb_machines_lv1_busy', '2021-04-04 07:06:58', '2021-04-04 07:06:58', 0, 0),
(16, 'Machines en Pannes', 'failed_machines', '2021-04-04 07:10:02', '2021-04-04 07:10:02', 0, 0),
(17, 'Nombre d\'Abonnés', 'nb_subscribers', '2021-04-04 19:07:15', '2021-04-04 19:12:27', 10, 0),
(18, 'Présence RSS', 'social_presence', '2021-04-04 19:07:43', '2021-04-04 19:07:43', 0, 0),
(19, 'Présence sur les Médias', 'media_presence', '2021-04-04 19:07:59', '2021-04-04 19:07:59', 0, 0),
(20, 'Présence aux évènements', 'events_presence', '2021-04-04 19:08:37', '2021-04-11 13:01:01', 0, 0),
(21, 'Coefficient Unitaire de Distribution', 'dist_unit_cost', '2021-04-04 21:20:08', '2021-04-04 21:20:08', 1, 0),
(22, 'Coefficients de Distribution', 'dist_cost', '2021-04-04 21:44:24', '2021-04-04 21:44:24', 0, 1),
(23, 'Fiabilité des Machines', 'machines_health', '2021-04-06 18:09:23', '2021-04-06 18:38:06', 0.7, 0),
(24, 'Coefficients de Matière Première', 'raw_materials_cost', '2021-04-07 11:23:36', '2021-04-07 11:23:36', 0, 1),
(25, 'Pantalon cargo ', 'ca_1', '2021-04-07 17:43:42', '2021-04-10 11:23:24', 1000, 0),
(26, 'Pantalon portfino', 'ca_2', '2021-04-07 17:43:51', '2021-04-10 11:23:15', 1000, 0),
(27, 'Robe marriage', 'ca_3', '2021-04-07 17:44:03', '2021-04-10 11:23:08', 1000, 0),
(28, 'T-shirt', 'ca_4', '2021-04-07 17:44:17', '2021-04-10 11:22:52', 1000, 0),
(29, 'Dettes', 'dettes', '2021-04-07 23:09:45', '2021-04-07 23:09:45', 0, 1),
(30, 'Taux d\'endettement', 'debt_ratio', '2021-04-08 10:35:35', '2021-04-08 10:35:35', 1, 0),
(31, 'Humeur des employés', 'workers_mood', '2021-04-08 10:35:53', '2022-05-07 16:58:55', 1, 0),
(32, 'Score Finale', 'score_final', '2021-04-10 22:18:01', '2021-04-10 22:18:01', 0, 0),
(33, 'Employés Occupés - Niveau 1', 'nb_workers_lv1_busy', '2022-03-11 01:27:02', '2022-03-11 01:27:02', 0, 0),
(34, 'Machines - Niveau 2', 'nb_machines_lv2', '2022-03-12 01:56:50', '2022-03-12 01:56:50', 0, 0),
(35, 'Machines Occupées - Niveau 2', 'nb_machines_lv2_busy', '2022-03-12 01:57:16', '2022-03-12 01:57:16', 0, 0),
(36, 'Machines - Niveau 3', 'nb_machines_lv3', '2022-03-12 01:57:46', '2022-03-12 01:57:46', 0, 0),
(37, 'Machines Occupées - Niveau 3', 'nb_machines_lv3_busy', '2022-03-12 01:58:01', '2022-03-12 01:58:11', 0, 0),
(38, 'Employés - Niveau 2', 'nb_workers_lv2', '2022-03-12 02:02:04', '2022-03-12 02:02:04', 0, 0),
(39, 'Employés Occupés - Niveau 2', 'nb_workers_lv2_busy', '2022-03-12 02:02:25', '2022-03-12 02:02:25', 0, 0),
(40, 'Santé machines - Niveau 1', 'machines_lv1_health', '2022-03-13 23:48:15', '2022-03-13 23:48:15', 1, 0),
(41, 'Santé machines - Niveau 2', 'machines_lv2_health', '2022-03-13 23:48:44', '2022-03-13 23:48:44', 1, 0),
(42, 'Santé machines - Niveau 3', 'machines_lv3_health', '2022-03-13 23:49:01', '2022-03-13 23:49:01', 1, 0),
(43, '5S - Semaine', '5s_day', '2022-03-15 00:08:07', '2022-03-15 00:08:07', 4, 0),
(44, 'Nombre employés à embaucher', 'nb_workers_to_hire', '2022-03-16 18:02:51', '2022-03-16 18:02:51', 0, 0),
(45, 'Polo rugby', 'ca_5', '2022-04-25 01:36:50', '2022-05-07 10:11:53', 0, 0),
(46, 'Pull à col rond\n', 'ca_6', '2022-04-25 01:37:22', '2022-05-07 10:11:39', 0, 0),
(47, 'Parka', 'ca_7', '2022-04-25 01:37:33', '2022-05-07 10:11:16', 0, 0),
(48, 'Richelieu', 'ca_8', '2022-04-25 01:37:44', '2022-05-07 10:10:21', 0, 0),
(49, 'Tuxedo', 'ca_9', '2022-04-25 01:37:54', '2022-05-07 10:10:10', 0, 0),
(50, 'Santé machines - Niveau 0', 'machines_lv0_health', '2023-04-24 13:45:55', '2023-04-24 13:45:55', 1, 0),
(51, 'Machines Occupées - Niveau 0', 'nb_machines_lv0_busy', '2023-04-24 13:46:19', '2023-04-24 13:46:19', 0, 0),
(52, 'Machines - Niveau 0', 'nb_machines_lv0', '2023-04-24 13:46:43', '2023-04-24 13:46:43', 0, 0),
(53, 'Jupe ajustée', 'ca_10', '2023-04-25 19:24:53', '2023-04-25 19:24:53', 0, 0),
(54, 'Jupe longue', 'ca_11', '2023-04-25 19:25:15', '2023-04-25 19:25:15', 0, 0),
(55, 'Pull à col bâteau', 'ca_12', '2023-04-25 19:31:53', '2023-04-25 19:31:53', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM AUTO_INCREMENT=89298 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `loans`
--

DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `banker_id` bigint UNSIGNED NOT NULL,
  `entreprise_id` bigint UNSIGNED NOT NULL,
  `amount` bigint DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ratio` decimal(8,2) DEFAULT NULL,
  `payment_status` tinyint(1) DEFAULT NULL,
  `remaining_amount` bigint DEFAULT NULL,
  `creation_date` int NOT NULL,
  `deadline` int UNSIGNED DEFAULT NULL,
  `days` int UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loans_entreprise_id_foreign` (`entreprise_id`),
  KEY `loans_banker_id_foreign` (`banker_id`)
) ENGINE=MyISAM AUTO_INCREMENT=608 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `loans`
--


-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_01_01_000000_create_action_events_table', 1),
(4, '2019_05_10_000000_add_fields_to_action_events_table', 1),
(5, '2019_08_13_000000_create_nova_settings_table', 1),
(6, '2019_08_19_000000_create_failed_jobs_table', 1),
(7, '2021_02_15_000000_update_nova_settings_value_column', 1),
(8, '2021_03_17_134930_create_entreprises_table', 1),
(9, '2021_03_17_141654_create_departments_table', 1),
(10, '2021_03_18_141210_create_indicators_table', 1),
(11, '2021_03_18_144511_create_entreprise_indicator_table', 1),
(12, '2021_03_20_151356_add_type_in_users_table', 1),
(13, '2021_03_20_194240_create_products_table', 1),
(14, '2021_03_20_194334_create_raw_materials_table', 1),
(15, '2021_03_20_194822_create_raw_materials_products', 1),
(16, '2021_03_20_195301_create_raw_materials_stock', 1),
(17, '2021_03_20_201201_create_stock', 1),
(18, '2021_03_20_214540_add_image_to_department', 1),
(19, '2021_03_21_131711_create_commands_table', 1),
(20, '2021_03_21_230831_add_ddl_rate_suppliers', 1),
(21, '2021_03_23_225106_create_loans_table', 1),
(22, '2021_03_24_222032_add_status_commands', 1),
(23, '2021_03_30_161838_create_ads', 1),
(24, '2021_03_31_104122_add_pricee_info_products', 1),
(25, '2021_03_31_210528_alter_indicators_table', 1),
(26, '2021_04_01_151511_add_costs_to_products', 1),
(27, '2021_04_02_103712_add_demand_to_products', 1),
(28, '2021_04_02_103834_create_production_table', 1),
(29, '2021_04_02_111607_create_product_stock_table', 1),
(30, '2021_04_02_192832_add_ad_coef_into_products_table', 1),
(31, '2021_04_02_214448_add_cost_percent_to_productions', 1),
(32, '2021_04_02_215429_add_dates_to_ads_table', 1),
(33, '2021_04_06_193345_change_indicator_starting_value_type', 1),
(34, '2021_04_06_220606_add_ratio_to_loans_table', 1),
(35, '2021_04_07_182212_create_daily_stats_table', 1),
(36, '2021_04_07_232438_edit_ads_table', 1),
(37, '2021_04_08_114020_alter_entrep_ind', 1),
(38, '2021_04_08_181321_add_date_to_multiple_tables', 1),
(39, '2021_04_08_214310_add_deadline_in_loans_table', 1),
(40, '2021_04_08_224909_add_command_day_prod_command', 1),
(41, '2021_04_09_002920_add_description_to_products', 1),
(42, '2021_04_09_122215_change_pk_commands', 1),
(43, '2021_04_09_184736_change_products_raw_materials_table', 1),
(44, '2021_04_09_214220_add_days_to_loans_table', 1),
(45, '2022_03_03_174357_create_jobs_table', 1),
(46, '2022_03_12_201816_add_machines_workers_to_productions_table', 1),
(47, '2022_03_14_025525_add_volume_to_raw_materials_table', 1),
(48, '2022_03_30_231424_create_suppliers_table', 1),
(49, '2022_03_31_002815_create_raw_material_supplier_table', 1),
(50, '2022_03_31_205535_add_time_to_ship_to_commands', 1),
(51, '2022_04_01_203402_edit_products_table', 1),
(52, '2022_04_01_211139_add_unit_prod_price_to_products_table', 1),
(53, '2022_04_02_153104_edit_raw_material_supplier_table', 1),
(54, '2022_04_05_171032_create_notifications_table', 1),
(55, '2022_04_17_045958_update_ads_table', 1),
(56, '2022_04_18_181955_change_amount_type_in_loans_table', 1),
(57, '2022_04_18_223550_change_amount_type_in_ads_table', 1),
(58, '2022_04_19_010559_add_icon_to_products_table', 1),
(59, '2022_04_19_013058_add_quantity_selling_to_stock_table', 1),
(60, '2022_04_19_141216_add_dist_cost_to_products_table', 1),
(61, '2022_04_20_182350_edit_types_in_commands_table', 1),
(62, '2022_04_20_185336_edit_types_in_productions_table', 1),
(63, '2022_04_20_191320_drop_columns_from_productions_table', 1),
(64, '2022_04_23_232507_create_game_settings_table', 2),
(65, '2022_04_24_024516_add_type_to_game_settings_table', 3),
(66, '2022_04_24_075514_add_icon_to_raw_materials_table', 4),
(69, '2022_04_27_060531_create_stats_table', 5),
(70, '2022_04_27_214954_add_percent_population_to_products_table', 5),
(71, '2023_04_25_232730_add_lot_to_products_table', 6),
(72, '2023_04_26_154327_add_lot_quantity_to_products_table', 7),
(73, '2023_04_26_162618_add_machine0_to_productions_table', 8),
(74, '2023_04_28_155444_add_cout_t_to_raw_material_supplier', 9);

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_min` int NOT NULL DEFAULT '0',
  `price_max` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `avg_demand` int NOT NULL DEFAULT '10000',
  `left_demand` int NOT NULL DEFAULT '10000',
  `ad_coef` double(8,2) NOT NULL DEFAULT '1.00',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prod_speed_factor` double(8,2) NOT NULL,
  `unit_prod_price` double(8,2) NOT NULL,
  `icon` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `dist_cost` int NOT NULL DEFAULT '0',
  `percent_population` double(8,2) NOT NULL DEFAULT '0.00',
  `lot_quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `created_at`, `updated_at`, `name`, `price_min`, `price_max`, `quantity`, `avg_demand`, `left_demand`, `ad_coef`, `description`, `prod_speed_factor`, `unit_prod_price`, `icon`, `dist_cost`, `percent_population`, `lot_quantity`) VALUES
(12, '2023-04-25 19:30:44', '2023-04-25 19:30:44', 'Pull à col bâteau', 2399, 3399, 0, 198671, 198671, 1.00, 'Fabriqué à partir d’un mélange doux de coton et de lin, ce pull vous offrira un confort optimal tout en vous tenant bien au chaud. Son col bateau élégant apporte une touche de sophistication à votre tenue.
Ce pull s'adapte à tous les styles et toutes les occasions. Sa coupe ajustée mettra en valeur votre silhouette tout en vous offrant une liberté de mouvement totale.
C’est la pièce ultime qui complètera votre collection de vêtements d’hiver.', 1.50, 500.00, '/assets/pullcol.webp', 0, 0.73, 500),
(11, '2023-04-15 19:55:47', '2023-04-15 19:55:47', 'Jupe longue', 2399, 3399, 0, 74836, 74836, 1.00, 'Cette jupe est un choix abordable pour ceux qui recherchent un style à la mode sans se ruiner. Elle est fabriquée à partir de polyester. un matériau synthétique qui est durable et facile à entretenir. mais qui a également un impact environnemental négatif. La jupe est conçue pour être jetable après quelques utilisations. ce qui la rend moins durable que d\'autres options. Le design est à la mode et suit les dernières tendances de la mode. ce qui en fait un choix populaire pour les acheteurs qui recherchent un style à la pointe de la mode.', 1.50, 500.00, '/assets/jupe2.webp', 0, 0.69, 500),
(10, '2023-04-15 19:55:34', '2023-04-15 19:55:34', 'Jupe ajustée a taille ceinturée', 20999, 30999, 0, 7049, 7049, 1.00, 'Cette jupe est conçue pour mettre en valeur votre silhouette grâce à sa coupe ajustée à la taille et sa ceinture qui souligne votre taille. Elle est fabriquée à partir de coton de haute qualité. ce qui lui confère un toucher doux et confortable. Le tissu est également durable et facile à entretenir. Cette jupe est parfaite pour une variété d\'occasions. qu\'il s\'agisse d\'une journée de travail ou d\'une soirée en ville. Elle se marie parfaitement avec des hauts. des chaussures et des accessoires de toutes sortes. ce qui en fait un choix polyvalent pour votre garde-robe.', 1.00, 2000.00, '/assets/jupe1.webp', 0, 0.05, 100),
(9, '2023-04-15 19:54:57', '2023-04-15 19:54:57', 'Tuxedo', 43999, 58999, 0, 2106, 2106, 1.00, 'Ce costume de luxe en coton et polyester est parfait pour un look élégant et professionnel. La combinaison de ces matières de haute qualité offre un ajustement confortable et une coupe flatteuse. tandis que la conception élégante convient à toutes les occasions professionnelles.', 1.00, 2500.00, '/assets/tuxedo.webp', 0, 0.02, 50),
(8, '2023-04-15 19:54:12', '2023-04-15 19:54:12', 'Richelieu', 22999, 32999, 0, 2078, 2078, 1.00, 'Ces chaussures en cuir sont conçues pour la durabilité et le confort. Le cuir de haute qualité offre un ajustement confortable. tandis que la conception classique et intemporelle convient à toutes les occasions.', 1.00, 2000.00, '/assets/richelieu.webp', 0, 0.04, 100),
(7, '2023-04-15 19:53:54', '2023-04-15 19:53:54', 'Parkas', 4999, 6499, 0, 37841, 37841, 1.00, 'Cette veste en polyester et coton est parfaite pour un style décontracté et pratique. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable. tandis que l\'emballage est conçu pour une présentation soignée. La veste est idéale pour ceux qui cherchent un look décontracté et pratique à un prix abordable.', 1.50, 800.00, '/assets/parka.webp', 0, 0.00, 250),
(6, '2023-04-15 19:53:38', '2023-04-15 19:53:38', 'Pull à col rond', 20999, 30999, 0, 9661, 9661, 1.00, 'Ce pull en coton et polyester est doux et confortable. parfait pour une journée de détente à la maison ou une soirée avec des amis. La coupe flatteuse et la conception simple mais élégante en font un choix polyvalent pour toutes les occasions.', 1.00, 2000.00, '/assets/pull.webp', 0, 0.04, 100),
(5, '2023-04-15 19:53:23', '2023-04-15 19:53:23', 'Polo rugby', 25999, 35999, 0, 9661, 9661, 1.00, 'Ce T-shirt de luxe est conçu avec du coton et de la soie pour une sensation de confort et de qualité supérieure. La combinaison de ces matières de haute qualité offre un ajustement confortable. tandis que la coupe flatteuse et la conception élégante en font un choix parfait pour des occasions spéciales ou des tenues décontractées haut de gamme.', 1.00, 2000.00, '/assets/polo.webp', 0, 0.04, 100),
(4, '2023-04-15 19:52:04', '2023-04-15 19:52:04', 'T-shirt', 1999, 2999, 0, 341278, 341278, 1.00, 'Ce T-shirt est fabriqué en coton et polyester pour un ajustement confortable et facile à porter. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable. malgré qu’il a un effet négatif sur l\'environnement. Ce T-shirt est idéal pour ceux qui cherchent un look décontracté et tendance à un prix abordable.', 1.50, 500.00, '/assets/tshirt.webp', 0, 0.90, 1000),
(3, '2023-04-15 19:51:17', '2023-04-15 19:52:38', 'Robe de mariée à dos ouvert', 91999, 119999, 0, 588, 588, 1.00, 'Nos robes de mariage sont fabriquées à partir des meilleures matières chimiques et des fixations pour obtenir le meilleur tissu possible. Nous ajoutons également de la garniture pour un look élégant et raffiné. La coupe flatteuse et la conception de la robe garantissent une allure inoubliable pour votre jour spécial.', 0.80, 3000.00, '/assets/robe.webp', 0, 0.01, 50),
(2, '2023-04-15 19:50:49', '2023-04-15 19:50:49', 'Pantalon portofino', 25999, 35999, 0, 7625, 7625, 1.00, 'Ce pantalon est conçu avec de la laine et du lin pour une sensation de douceur et de luxe. La combinaison de ces matières de haute qualité offre un ajustement confortable. tandis que la coupe élégante en fait un choix parfait pour des occasions formelles ou professionnelles.', 1.00, 2000.00, '/assets/portofino.webp', 0, 0.04, 100),
(1, '2023-04-15 19:50:12', '2023-04-15 19:50:12', 'Pantalon cargo', 2599, 3599, 0, 66102, 66102, 1.00, 'Ce pantalon est fabriqué en coton et polyester pour un ajustement confortable et facile à porter. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable. tandis que l\'emballage est conçu pour une présentation soignée. Ce pantalon est idéal pour ceux qui cherchent un look moderne et tendance à un prix abordable.', 1.50, 500.00, '/assets/cargo.webp', 0, 0.61, 500);

-- --------------------------------------------------------

--
-- Structure de la table `raw_materials`
--

DROP TABLE IF EXISTS `raw_materials`;
CREATE TABLE IF NOT EXISTS `raw_materials` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` double(8,2) DEFAULT NULL,
  `unit` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume` int NOT NULL,
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `raw_materials`
--

INSERT INTO `raw_materials` (`id`, `created_at`, `updated_at`, `price`, `unit`, `name`, `volume`, `icon`) VALUES
(10, '2023-04-15 12:50:54', '2023-04-15 12:50:54', 10000.00, 'kg', 'Laine', 2, '/assets/icons/nv/laine.svg'),
(11, '2023-04-15 12:52:11', '2023-04-16 16:40:55', 3000.00, 'kg', 'Coton', 2, '/assets/icons/nv/cotton.svg'),
(18, '2023-04-15 12:53:45', '2023-04-15 12:53:45', 800.00, 'kg', 'Matières chimiques', 3, '/assets/icons/nv/chemicals.svg'),
(17, '2023-04-15 12:54:20', '2023-04-15 12:54:20', 850.00, 'kg', 'Fixation', 1, '/assets/icons/nv/fixation.svg'),
(12, '2023-04-15 12:57:35', '2023-04-15 12:57:35', 900.00, 'kg', 'Polyester', 2, '/assets/icons/nv/polyester.svg'),
(19, '2023-04-15 12:58:30', '2023-04-15 13:01:23', 2500.00, 'kg', 'Packaging', 3, '/assets/icons/nv/packaging.svg'),
(14, '2023-04-15 12:59:16', '2023-04-15 12:59:16', 25000.00, 'kg', 'Lin', 1, '/assets/icons/nv/lin.svg'),
(13, '2023-04-15 12:59:46', '2023-04-15 12:59:46', 2800.00, 'kg', 'Garniture', 1, '/assets/icons/nv/garniture.svg'),
(15, '2023-04-15 13:00:12', '2023-04-15 13:00:12', 37000.00, 'kg', 'La soie', 1, '/assets/icons/nv/soie.svg'),
(16, '2023-04-15 13:00:48', '2023-04-15 13:00:48', 8000.00, 'kg', 'Cuir', 1, '/assets/icons/nv/cuire.svg');

-- --------------------------------------------------------

--
-- Structure de la table `raw_materials_products`
--

DROP TABLE IF EXISTS `raw_materials_products`;
CREATE TABLE IF NOT EXISTS `raw_materials_products` (
  `product_id` bigint UNSIGNED NOT NULL,
  `raw_material_id` bigint UNSIGNED NOT NULL,
  `quantity` double DEFAULT NULL,
  PRIMARY KEY (`product_id`,`raw_material_id`),
  KEY `raw_materials_products_raw_material_id_foreign` (`raw_material_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `raw_materials_products`
--

INSERT INTO `raw_materials_products` (`product_id`, `raw_material_id`, `quantity`) VALUES
(1, 18, 75),
(1, 11, 225),
(1, 12, 100),
(1, 17, 30),
(1, 19, 25),
(2, 12, 2),
(2, 14, 50),
(2, 10, 10),
(2, 17, 5),
(2, 18, 4),
(3, 11, 75),
(3, 13, 15),
(3, 15, 60),
(3, 17, 12.5),
(3, 18, 15),
(2, 19, 10),
(3, 19, 17.5),
(4, 11, 300),
(4, 12, 200),
(4, 17, 50),
(4, 18, 200),
(4, 19, 50),
(5, 11, 35),
(5, 14, 50),
(6, 10, 25),
(6, 11, 5),
(5, 19, 15),
(6, 14, 30),
(5, 17, 8),
(5, 18, 5),
(6, 18, 5),
(6, 17, 8),
(7, 13, 25),
(7, 12, 75),
(7, 11, 87.5),
(7, 10, 45),
(6, 19, 15),
(7, 17, 25),
(7, 18, 50),
(7, 19, 20),
(8, 12, 10),
(8, 16, 150),
(8, 11, 10),
(8, 17, 10),
(8, 18, 10),
(8, 19, 20),
(9, 11, 13.5),
(9, 12, 3),
(9, 15, 17.5),
(9, 17, 5),
(9, 18, 4.5),
(9, 13, 5),
(9, 14, 14),
(9, 19, 12.5),
(10, 10, 18),
(10, 13, 5),
(10, 15, 25),
(10, 17, 5),
(10, 18, 4),
(11, 11, 160),
(11, 12, 140),
(10, 19, 10),
(11, 13, 25),
(11, 17, 30),
(11, 18, 125),
(12, 12, 100),
(12, 17, 40),
(12, 18, 125),
(12, 11, 200),
(11, 19, 25),
(12, 19, 25);

-- --------------------------------------------------------

--
-- Structure de la table `raw_material_supplier`
--

DROP TABLE IF EXISTS `raw_material_supplier`;
CREATE TABLE IF NOT EXISTS `raw_material_supplier` (
  `raw_material_id` bigint UNSIGNED NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `price_factor` double(8,2) NOT NULL,
  `time_to_deliver` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `cout_t` int NOT NULL DEFAULT '0',
  KEY `raw_material_supplier_raw_material_id_foreign` (`raw_material_id`),
  KEY `raw_material_supplier_supplier_id_foreign` (`supplier_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `raw_material_supplier`
--

INSERT INTO `raw_material_supplier` (`raw_material_id`, `supplier_id`, `price_factor`, `time_to_deliver`, `created_at`, `updated_at`, `is_available`, `cout_t`) VALUES
(12, 1, 0.90, 6, NULL, NULL, 1, 0),
(13, 1, 0.90, 6, NULL, NULL, 1, 0),
(14, 1, 0.90, 6, NULL, NULL, 1, 0),
(10, 1, 0.90, 6, NULL, NULL, 1, 0),
(10, 2, 1.10, 3, NULL, NULL, 1, 0),
(11, 1, 0.90, 6, NULL, NULL, 1, 0),
(15, 1, 0.90, 6, NULL, NULL, 1, 0),
(16, 1, 0.90, 6, NULL, NULL, 1, 0),
(17, 1, 0.90, 6, NULL, NULL, 1, 0),
(18, 1, 0.90, 6, NULL, NULL, 1, 0),
(19, 1, 0.90, 6, NULL, NULL, 1, 0),
(15, 2, 1.10, 3, NULL, NULL, 1, 0),
(16, 2, 1.10, 3, NULL, NULL, 1, 0),
(17, 2, 1.10, 3, NULL, NULL, 1, 0),
(18, 2, 1.10, 3, NULL, NULL, 1, 0),
(19, 2, 1.10, 3, NULL, NULL, 1, 0),
(11, 2, 1.10, 3, NULL, NULL, 1, 0),
(12, 2, 1.10, 3, NULL, NULL, 1, 0),
(13, 2, 1.10, 3, NULL, NULL, 1, 0),
(14, 2, 1.10, 3, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `foreign`, `created_at`, `updated_at`) VALUES
(1, 'Supplier 1', 0, '2022-03-30 23:31:28', '2022-04-30 15:07:43'),
(2, 'Supplier 2', 0, '2022-04-30 15:14:23', '2022-04-30 15:14:23');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` double(8,2) DEFAULT NULL,
  `ddl_min` double(8,2) DEFAULT NULL,
  `ddl_max` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `type`, `data`, `rate`, `ddl_min`, `ddl_max`) VALUES
(1, 'Annis Admin', 'annis@bg.iec', NULL, '$2y$10$lVttiLQ4B3eCh8XTT5m9vuvdjANSSmbfUQnkJ0xq/PnCWreWUpmS2', NULL, '2021-04-11 07:51:46', '2022-02-24 11:01:39', 'admin', NULL, NULL, NULL, NULL),
(15, 'yousra', 'yousra@bg.iec', NULL, '$2y$10$Ow.Qsvrr2Z3mZyrCqIOmEuzhlFkKXt1L.VdRPmP3eRASt07VWiiJC', 'Z4zCqFeop0qHg19i76i1xexM4i2uGRHLGWfZTUWiaQ4gudV4ETegAmVLXajF', '2021-04-11 08:16:46', '2022-02-24 11:59:38', 'supplier', NULL, 1.00, 1.00, 4.00),
(19, 'ouassim', 'ouassim@bg.iec', NULL, '$2y$10$/z/wiYkUx3y/qSnO4z9WFejFAJbbWyltRZCUnk/q.oaGrp7suMlGC', NULL, '2022-02-24 12:00:32', '2022-02-24 13:31:59', 'supplier', NULL, 1.20, 1.00, 6.00),
(20, 'moncef', 'moncef@bg.iec', NULL, '$2y$10$ttAlYSQ1CLBFZTLWoxPHuOZCK.GVt.rtk9mZiEtHYKwgVtxuO7v32', NULL, '2022-02-28 15:21:26', '2022-02-28 15:21:26', 'admin', NULL, NULL, NULL, NULL),
(21, 'Rayane', 'rayane@bg.iec', NULL, '$2y$10$.NUKbwPgImNkVTSJ1cKhFuB9JtQioK6BMqnPTdTdYubz.fY4o9cp6', NULL, '2022-03-14 13:35:19', '2022-03-14 13:35:19', 'banker', NULL, NULL, NULL, NULL),
(25, 'CAP', 'cap@bg.iec', NULL, '$2y$10$i8mVBjiPvuj53mMQvZ7eYO2Felozq1m4za3mpPAE5kL94RVjE8DuO', NULL, '2022-05-09 12:37:42', '2022-05-11 20:03:45', 'entreprise', NULL, NULL, NULL, NULL),
(28, 'Bouchra', 'bouchra@bg.iec', NULL, '$2y$10$/IiSH2Dt1Ik7wgBFyVP89u2qB/jhmb5HcvbzByv3S/pwyeVb3ilHO', '5q57PjO5kWTrck1gVvdUrQiKJzH7PIqgbcSmotw0Bas5oiPfAkDOsowvQF0u', '2023-04-14 22:57:54', '2023-04-14 22:57:54', 'admin', NULL, NULL, NULL, NULL),
(29, 'test', 'test@bg.iec', NULL, '$2y$10$Encq4A4hon7KNrXJh.IHseIamjoUlTmKulnS/XHAQgo3gz6lCVING', NULL, '2023-04-14 23:00:38', '2023-04-14 23:00:38', 'entreprise', NULL, NULL, NULL, NULL),
(34, 'amine', 'amine@bg.iec', NULL, '$2y$10$P8OBBC29Emq99RxLCeDpkugF.XRwIeStXHTRE5kuL0GQl2L5Qc/Ce', NULL, '2023-04-22 16:28:56', '2023-04-22 16:28:56', 'entreprise', NULL, NULL, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
