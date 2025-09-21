-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 26-06-2025 a las 20:30:53
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sisopp_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(800) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'AREA 1', 'DESC AREA 1', '2025-06-26', '2025-06-26 18:56:51', '2025-06-26 18:56:51'),
(2, 'AREA 2', '', '2025-06-26', '2025-06-26 18:56:56', '2025-06-26 18:56:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISOPP S.A.', 'SISOPP', '1749567010_1.png', NULL, '2025-06-10 14:50:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"123456\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"777777\", \"tipo\": \"ADMINISTRADOR\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"materno\": \"MAMANI\", \"paterno\": \"PERES\", \"usuario\": \"juan@gmail.com\", \"created_at\": \"2025-06-09T22:30:27.000000Z\", \"updated_at\": \"2025-06-09T22:30:27.000000Z\", \"fecha_registro\": \"2025-06-09\"}', NULL, 'USUARIOS', '2025-06-09', '18:30:27', '2025-06-09 22:30:27', '2025-06-09 22:30:27'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ÁREA DE PRODUCCIÓN', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:54:52.000000Z\", \"descripcion\": \"DESC AREA 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'ÁREAS', '2025-06-26', '14:54:52', '2025-06-26 18:54:52', '2025-06-26 18:54:52'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN ÁREA DE PRODUCCIÓN', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:54:52.000000Z\", \"descripcion\": \"DESC AREA 1\", \"fecha_registro\": \"2025-06-26\"}', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:56:20.000000Z\", \"descripcion\": \"DESC AREA 1ASD\", \"fecha_registro\": \"2025-06-26\"}', 'ÁREAS', '2025-06-26', '14:56:20', '2025-06-26 18:56:20', '2025-06-26 18:56:20'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN ÁREA DE PRODUCCIÓN', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:56:20.000000Z\", \"descripcion\": \"DESC AREA 1ASD\", \"fecha_registro\": \"2025-06-26\"}', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:56:24.000000Z\", \"descripcion\": \"DESC AREA 1\", \"fecha_registro\": \"2025-06-26\"}', 'ÁREAS', '2025-06-26', '14:56:24', '2025-06-26 18:56:24', '2025-06-26 18:56:24'),
(5, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN ÁREA DE PRODUCCIÓN', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:54:52.000000Z\", \"updated_at\": \"2025-06-26T18:56:24.000000Z\", \"descripcion\": \"DESC AREA 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'ÁREAS', '2025-06-26', '14:56:26', '2025-06-26 18:56:26', '2025-06-26 18:56:26'),
(6, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ÁREA DE PRODUCCIÓN', '{\"id\": 1, \"nombre\": \"AREA 1\", \"created_at\": \"2025-06-26T18:56:51.000000Z\", \"updated_at\": \"2025-06-26T18:56:51.000000Z\", \"descripcion\": \"DESC AREA 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'ÁREAS', '2025-06-26', '14:56:51', '2025-06-26 18:56:51', '2025-06-26 18:56:51'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ÁREA DE PRODUCCIÓN', '{\"id\": 2, \"nombre\": \"AREA 2\", \"created_at\": \"2025-06-26T18:56:56.000000Z\", \"updated_at\": \"2025-06-26T18:56:56.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'ÁREAS', '2025-06-26', '14:56:56', '2025-06-26 18:56:56', '2025-06-26 18:56:56'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MATERIAL', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:35.000000Z\", \"descripcion\": \"DESC MAT 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'MATERIALES', '2025-06-26', '14:58:35', '2025-06-26 18:58:35', '2025-06-26 18:58:35'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN MATERIAL', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:35.000000Z\", \"descripcion\": \"DESC MAT 1\", \"fecha_registro\": \"2025-06-26\"}', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:38.000000Z\", \"descripcion\": \"DESC MAT 1ASD\", \"fecha_registro\": \"2025-06-26\"}', 'MATERIALES', '2025-06-26', '14:58:38', '2025-06-26 18:58:38', '2025-06-26 18:58:38'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN MATERIAL', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:38.000000Z\", \"descripcion\": \"DESC MAT 1ASD\", \"fecha_registro\": \"2025-06-26\"}', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:42.000000Z\", \"descripcion\": \"DESC MAT 1\", \"fecha_registro\": \"2025-06-26\"}', 'MATERIALES', '2025-06-26', '14:58:42', '2025-06-26 18:58:42', '2025-06-26 18:58:42'),
(11, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN MATERIAL', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:35.000000Z\", \"updated_at\": \"2025-06-26T18:58:42.000000Z\", \"descripcion\": \"DESC MAT 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'MATERIALES', '2025-06-26', '14:58:45', '2025-06-26 18:58:45', '2025-06-26 18:58:45'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MATERIAL', '{\"id\": 1, \"nombre\": \"MATERIAL 1\", \"created_at\": \"2025-06-26T18:58:58.000000Z\", \"updated_at\": \"2025-06-26T18:58:58.000000Z\", \"descripcion\": \"DESC MAT 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'MATERIALES', '2025-06-26', '14:58:58', '2025-06-26 18:58:58', '2025-06-26 18:58:58'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MATERIAL', '{\"id\": 2, \"nombre\": \"MATERIAL 2\", \"created_at\": \"2025-06-26T18:59:04.000000Z\", \"updated_at\": \"2025-06-26T18:59:04.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'MATERIALES', '2025-06-26', '14:59:04', '2025-06-26 18:59:04', '2025-06-26 18:59:04'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MATERIAL', '{\"id\": 3, \"nombre\": \"MATERIAL 3\", \"created_at\": \"2025-06-26T18:59:09.000000Z\", \"updated_at\": \"2025-06-26T18:59:09.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'MATERIALES', '2025-06-26', '14:59:09', '2025-06-26 18:59:09', '2025-06-26 18:59:09'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"created_at\": \"2025-06-26T19:01:20.000000Z\", \"updated_at\": \"2025-06-26T19:01:20.000000Z\", \"descripcion\": \"DESC PRODUCTO 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'PRODUCTOS', '2025-06-26', '15:01:20', '2025-06-26 19:01:20', '2025-06-26 19:01:20'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"created_at\": \"2025-06-26T19:01:20.000000Z\", \"updated_at\": \"2025-06-26T19:01:20.000000Z\", \"descripcion\": \"DESC PRODUCTO 1\", \"fecha_registro\": \"2025-06-26\"}', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"created_at\": \"2025-06-26T19:01:20.000000Z\", \"updated_at\": \"2025-06-26T19:01:22.000000Z\", \"descripcion\": \"DESC PRODUCTO 1ASD\", \"fecha_registro\": \"2025-06-26\"}', 'PRODUCTOS', '2025-06-26', '15:01:22', '2025-06-26 19:01:22', '2025-06-26 19:01:22'),
(17, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PRODUCTO', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"created_at\": \"2025-06-26T19:01:20.000000Z\", \"updated_at\": \"2025-06-26T19:01:22.000000Z\", \"descripcion\": \"DESC PRODUCTO 1ASD\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'PRODUCTOS', '2025-06-26', '15:02:06', '2025-06-26 19:02:06', '2025-06-26 19:02:06'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"created_at\": \"2025-06-26T19:02:23.000000Z\", \"updated_at\": \"2025-06-26T19:02:23.000000Z\", \"descripcion\": \"DESCRIPCION PRODUCTO 1\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'PRODUCTOS', '2025-06-26', '15:02:23', '2025-06-26 19:02:23', '2025-06-26 19:02:23'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 2, \"nombre\": \"PRODUCTO 2\", \"created_at\": \"2025-06-26T19:02:29.000000Z\", \"updated_at\": \"2025-06-26T19:02:29.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'PRODUCTOS', '2025-06-26', '15:02:29', '2025-06-26 19:02:29', '2025-06-26 19:02:29'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"3333333\", \"id\": 3, \"dir\": \"LOS OLIVOS\", \"fono\": \"65454454\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"1\", \"ci_exp\": \"CB\", \"correo\": null, \"nombre\": \"PEDRO\", \"materno\": \"SUARES\", \"paterno\": \"MARTINEZ\", \"usuario\": \"PMARTINEZ\", \"created_at\": \"2025-06-26T19:25:45.000000Z\", \"updated_at\": \"2025-06-26T19:25:45.000000Z\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'USUARIOS', '2025-06-26', '15:25:45', '2025-06-26 19:25:45', '2025-06-26 19:25:45'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"334343\", \"id\": 4, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"foto\": \"41750965976.jpg\", \"tipo\": \"OPERARIOS\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": \"jorge@gmail.com\", \"nombre\": \"JORGE\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"usuario\": \"JGONZALES\", \"created_at\": \"2025-06-26T19:26:16.000000Z\", \"updated_at\": \"2025-06-26T19:26:16.000000Z\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'USUARIOS', '2025-06-26', '15:26:16', '2025-06-26 19:26:16', '2025-06-26 19:26:16'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"6666666\", \"id\": 5, \"dir\": \"LOS PEDREGALES\", \"fono\": \"7777777\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"ALFONSO\", \"materno\": \"CORTEZ\", \"paterno\": \"CORTEZ\", \"usuario\": \"ACORTEZ\", \"created_at\": \"2025-06-26T19:26:49.000000Z\", \"updated_at\": \"2025-06-26T19:26:49.000000Z\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'USUARIOS', '2025-06-26', '15:26:49', '2025-06-26 19:26:49', '2025-06-26 19:26:49'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"56565656\", \"id\": 6, \"dir\": \"LOS PEDREGALES\", \"fono\": \"7777777\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"ALFONSO\", \"materno\": \"CORTEZ\", \"paterno\": \"CORTEZ\", \"usuario\": \"ACORTEZ1\", \"created_at\": \"2025-06-26T19:26:53.000000Z\", \"updated_at\": \"2025-06-26T19:26:53.000000Z\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'USUARIOS', '2025-06-26', '15:26:53', '2025-06-26 19:26:53', '2025-06-26 19:26:53'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"56565656\", \"id\": 6, \"dir\": \"LOS PEDREGALES\", \"fono\": \"7777777\", \"foto\": null, \"tipo\": \"SUPERVISOR\", \"acceso\": 1, \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"ALFONSO\", \"status\": 1, \"materno\": \"CORTEZ\", \"paterno\": \"CORTEZ\", \"usuario\": \"ACORTEZ1\", \"created_at\": \"2025-06-26T19:26:53.000000Z\", \"updated_at\": \"2025-06-26T19:26:53.000000Z\", \"fecha_registro\": \"2025-06-26\"}', '{\"ci\": \"45454545\", \"id\": 6, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"foto\": null, \"tipo\": \"OPERARIOS\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CORTEZ\", \"usuario\": \"ACORTEZ1\", \"created_at\": \"2025-06-26T19:26:53.000000Z\", \"updated_at\": \"2025-06-26T19:27:25.000000Z\", \"fecha_registro\": \"2025-06-26\"}', 'USUARIOS', '2025-06-26', '15:27:25', '2025-06-26 19:27:25', '2025-06-26 19:27:25'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"65656565\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"tipo\": \"OPERARIOS\", \"acceso\": \"1\", \"ci_exp\": \"TJ\", \"correo\": null, \"nombre\": \"MARIO\", \"materno\": \"\", \"paterno\": \"CACERES\", \"usuario\": \"MCACERES\", \"created_at\": \"2025-06-26T19:28:11.000000Z\", \"updated_at\": \"2025-06-26T19:28:11.000000Z\", \"fecha_registro\": \"2025-06-26\"}', NULL, 'USUARIOS', '2025-06-26', '15:28:11', '2025-06-26 19:28:11', '2025-06-26 19:28:11'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA TAREA', '{\"id\": 7, \"codigo\": \"T1\", \"estado\": \"PENDIENTE\", \"area_id\": \"1\", \"nro_cod\": 1, \"user_id\": \"3\", \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"descripcion\": \"DESCRIPCION TAREA 1\", \"producto_id\": \"1\", \"fecha_registro\": \"2025-06-26\", \"tarea_materials\": [{\"id\": 9, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 1}, {\"id\": 10, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 2}], \"tarea_operarios\": [{\"id\": 1, \"user_id\": 4, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}, {\"id\": 2, \"user_id\": 6, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}]}', NULL, 'TAREAS', '2025-06-26', '15:59:34', '2025-06-26 19:59:34', '2025-06-26 19:59:34'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA TAREA', '{\"id\": 8, \"codigo\": \"T2\", \"estado\": \"PENDIENTE\", \"area_id\": \"2\", \"nro_cod\": 2, \"user_id\": \"5\", \"created_at\": \"2025-06-26T20:19:59.000000Z\", \"updated_at\": \"2025-06-26T20:19:59.000000Z\", \"descripcion\": \"DESC TAREA 2\", \"producto_id\": \"2\", \"fecha_registro\": \"2025-06-26\", \"tarea_materials\": [{\"id\": 11, \"tarea_id\": 8, \"created_at\": \"2025-06-26T20:19:59.000000Z\", \"updated_at\": \"2025-06-26T20:19:59.000000Z\", \"material_id\": 3}, {\"id\": 12, \"tarea_id\": 8, \"created_at\": \"2025-06-26T20:19:59.000000Z\", \"updated_at\": \"2025-06-26T20:19:59.000000Z\", \"material_id\": 2}], \"tarea_operarios\": [{\"id\": 3, \"user_id\": 7, \"tarea_id\": 8, \"created_at\": \"2025-06-26T20:19:59.000000Z\", \"updated_at\": \"2025-06-26T20:19:59.000000Z\"}, {\"id\": 4, \"user_id\": 4, \"tarea_id\": 8, \"created_at\": \"2025-06-26T20:19:59.000000Z\", \"updated_at\": \"2025-06-26T20:19:59.000000Z\"}]}', NULL, 'TAREAS', '2025-06-26', '16:19:59', '2025-06-26 20:19:59', '2025-06-26 20:19:59'),
(28, 3, 'MODIFICACIÓN', 'EL USUARIO PMARTINEZ ACTUALIZÓ UNA TAREA', '{\"id\": 7, \"codigo\": \"T1\", \"estado\": \"PENDIENTE\", \"area_id\": 1, \"nro_cod\": 1, \"user_id\": 3, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"descripcion\": \"DESCRIPCION TAREA 1\", \"producto_id\": 1, \"fecha_registro\": \"2025-06-26\", \"tarea_materials\": [{\"id\": 9, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 1}, {\"id\": 10, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 2}], \"tarea_operarios\": [{\"id\": 1, \"user_id\": 4, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}, {\"id\": 2, \"user_id\": 6, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}]}', '{\"id\": 7, \"codigo\": \"T1\", \"estado\": \"INICIADO\", \"area_id\": \"1\", \"nro_cod\": 1, \"user_id\": \"3\", \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T20:23:30.000000Z\", \"descripcion\": \"DESCRIPCION TAREA 1\", \"producto_id\": \"1\", \"fecha_registro\": \"2025-06-26\", \"tarea_materials\": [{\"id\": 9, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 1}, {\"id\": 10, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\", \"material_id\": 2}], \"tarea_operarios\": [{\"id\": 1, \"user_id\": 4, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}, {\"id\": 2, \"user_id\": 6, \"tarea_id\": 7, \"created_at\": \"2025-06-26T19:59:34.000000Z\", \"updated_at\": \"2025-06-26T19:59:34.000000Z\"}]}', 'TAREAS', '2025-06-26', '16:23:30', '2025-06-26 20:23:30', '2025-06-26 20:23:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materials`
--

CREATE TABLE `materials` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(800) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `materials`
--

INSERT INTO `materials` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'MATERIAL 1', 'DESC MAT 1', '2025-06-26', '2025-06-26 18:58:58', '2025-06-26 18:58:58'),
(2, 'MATERIAL 2', '', '2025-06-26', '2025-06-26 18:59:04', '2025-06-26 18:59:04'),
(3, 'MATERIAL 3', '', '2025-06-26', '2025-06-26 18:59:09', '2025-06-26 18:59:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_31_165641_create_configuracions_table', 1),
(2, '2024_11_02_153317_create_users_table', 1),
(3, '2024_11_02_153318_create_historial_accions_table', 1),
(4, '2025_06_09_183140_create_areas_table', 2),
(5, '2025_06_09_183147_create_materials_table', 2),
(6, '2025_06_09_183153_create_productos_table', 2),
(7, '2025_06_09_183200_create_tareas_table', 2),
(8, '2025_06_09_184051_create_tarea_materials_table', 2),
(9, '2025_06_09_184055_create_tarea_operarios_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(800) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'PRODUCTO 1', 'DESCRIPCION PRODUCTO 1', '2025-06-26', '2025-06-26 19:02:23', '2025-06-26 19:02:23'),
(2, 'PRODUCTO 2', '', '2025-06-26', '2025-06-26 19:02:29', '2025-06-26 19:02:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_cod` bigint NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `codigo`, `nro_cod`, `descripcion`, `area_id`, `producto_id`, `user_id`, `estado`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(7, 'T.1', 1, 'DESCRIPCION TAREA 1', 1, 1, 3, 'INICIADO', '2025-06-26', '2025-06-26 19:59:34', '2025-06-26 20:23:30'),
(8, 'T.2', 2, 'DESC TAREA 2', 2, 2, 5, 'PENDIENTE', '2025-06-26', '2025-06-26 20:19:59', '2025-06-26 20:19:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_materials`
--

CREATE TABLE `tarea_materials` (
  `id` bigint UNSIGNED NOT NULL,
  `tarea_id` bigint UNSIGNED NOT NULL,
  `material_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tarea_materials`
--

INSERT INTO `tarea_materials` (`id`, `tarea_id`, `material_id`, `created_at`, `updated_at`) VALUES
(9, 7, 1, '2025-06-26 19:59:34', '2025-06-26 19:59:34'),
(10, 7, 2, '2025-06-26 19:59:34', '2025-06-26 19:59:34'),
(11, 8, 3, '2025-06-26 20:19:59', '2025-06-26 20:19:59'),
(12, 8, 2, '2025-06-26 20:19:59', '2025-06-26 20:19:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_operarios`
--

CREATE TABLE `tarea_operarios` (
  `id` bigint UNSIGNED NOT NULL,
  `tarea_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tarea_operarios`
--

INSERT INTO `tarea_operarios` (`id`, `tarea_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 7, 4, '2025-06-26 19:59:34', '2025-06-26 19:59:34'),
(2, 7, 6, '2025-06-26 19:59:34', '2025-06-26 19:59:34'),
(3, 8, 7, '2025-06-26 20:19:59', '2025-06-26 20:19:59'),
(4, 8, 4, '2025-06-26 20:19:59', '2025-06-26 20:19:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `password`, `acceso`, `tipo`, `foto`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', '', '0', '', '', NULL, '', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 1, 'ADMINISTRADOR', NULL, '2025-06-09', 1, NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', 'LOS OLIVOS', 'juan@gmail.com', '777777', '$2y$12$9CN0hoy7ziWSHaLrj0e8LOSCdI/NXxdaX2tT/CdwLid0Kb2RwYbqu', 1, 'ADMINISTRADOR', NULL, '2025-06-09', 1, '2025-06-09 22:30:27', '2025-06-09 22:30:27'),
(3, 'PMARTINEZ', 'PEDRO', 'MARTINEZ', 'SUARES', '3333333', 'CB', 'LOS OLIVOS', NULL, '65454454', '$2y$12$s9IJp34ZoRKIvSYS.gICA.7Rs4SVImi2o1Yw/RPwg3AM9cY9c9T6q', 1, 'SUPERVISOR', NULL, '2025-06-26', 1, '2025-06-26 19:25:45', '2025-06-26 19:25:45'),
(4, 'JGONZALES', 'JORGE', 'GONZALES', '', '334343', 'LP', 'LOS PEDREGALES', 'jorge@gmail.com', '67676767', '$2y$12$amjNML06aPUPEt.e71TaLeixvcqGbzH0COde2W1DQV5W2yHEIPyE2', 1, 'OPERARIOS', '41750965976.jpg', '2025-06-26', 1, '2025-06-26 19:26:16', '2025-06-26 19:26:16'),
(5, 'ACORTEZ', 'ALFONSO', 'CORTEZ', 'CORTEZ', '6666666', 'LP', 'LOS PEDREGALES', NULL, '7777777', '$2y$12$VXf.0G3x8MLVeZEQYfBVfeknbRn7vNs4M1GDHAlM14QlgIEFvK/0m', 1, 'SUPERVISOR', NULL, '2025-06-26', 1, '2025-06-26 19:26:49', '2025-06-26 19:26:49'),
(6, 'ACORTEZ1', 'ALEX', 'CORTEZ', '', '45454545', 'LP', 'LOS PEDREGALES', NULL, '67676767', '$2y$12$6hQ5itbGTqHQzAXkPpQ2Z.9q2qeMMySf5Ma5U7xD3xk3qOEJbYBwC', 1, 'OPERARIOS', NULL, '2025-06-26', 1, '2025-06-26 19:26:53', '2025-06-26 20:27:13'),
(7, 'MCACERES', 'MARIO', 'CACERES', '', '65656565', 'TJ', 'LOS PEDREGALES', NULL, '67676767', '$2y$12$K8eASLjNMVGVEsMQ6gScju7SFxqVhZ3Y4fcwx5sUxTMiUt3yLQs9e', 1, 'OPERARIOS', NULL, '2025-06-26', 1, '2025-06-26 19:28:11', '2025-06-26 19:28:11');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_accions_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tareas_codigo_unique` (`codigo`),
  ADD UNIQUE KEY `tareas_nro_cod_unique` (`nro_cod`),
  ADD KEY `tareas_area_id_foreign` (`area_id`),
  ADD KEY `tareas_producto_id_foreign` (`producto_id`),
  ADD KEY `tareas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `tarea_materials`
--
ALTER TABLE `tarea_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tarea_materials_tarea_id_foreign` (`tarea_id`),
  ADD KEY `tarea_materials_material_id_foreign` (`material_id`);

--
-- Indices de la tabla `tarea_operarios`
--
ALTER TABLE `tarea_operarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tarea_operarios_tarea_id_foreign` (`tarea_id`),
  ADD KEY `tarea_operarios_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `materials`
--
ALTER TABLE `materials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tarea_materials`
--
ALTER TABLE `tarea_materials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tarea_operarios`
--
ALTER TABLE `tarea_operarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD CONSTRAINT `historial_accions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `tareas_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `tareas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tarea_materials`
--
ALTER TABLE `tarea_materials`
  ADD CONSTRAINT `tarea_materials_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`),
  ADD CONSTRAINT `tarea_materials_tarea_id_foreign` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`);

--
-- Filtros para la tabla `tarea_operarios`
--
ALTER TABLE `tarea_operarios`
  ADD CONSTRAINT `tarea_operarios_tarea_id_foreign` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`),
  ADD CONSTRAINT `tarea_operarios_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
