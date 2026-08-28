-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-08-2026 a las 00:58:28
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `usgpcommerce`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin_permisos`
--

CREATE TABLE `admin_permisos` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admin_permisos`
--

INSERT INTO `admin_permisos` (`id`, `user_id`, `modulo`, `creado_en`) VALUES
(1, 1, 'banners', '2026-06-15 18:28:11'),
(2, 1, 'productos', '2026-06-15 18:28:11'),
(3, 1, 'contactos', '2026-06-15 18:28:11'),
(4, 1, 'compras', '2026-06-15 18:28:11'),
(5, 1, 'usuarios', '2026-06-15 18:28:11'),
(6, 1, 'reportes', '2026-06-15 18:28:11'),
(7, 1, 'configuracion', '2026-06-15 18:28:11'),
(8, 2, 'banners', '2026-06-15 18:28:11'),
(9, 2, 'productos', '2026-06-15 18:28:11'),
(10, 2, 'contactos', '2026-06-15 18:28:11'),
(11, 2, 'compras', '2026-06-15 18:28:11'),
(12, 2, 'usuarios', '2026-06-15 18:28:11'),
(13, 2, 'reportes', '2026-06-15 18:28:11'),
(14, 2, 'configuracion', '2026-06-15 18:28:11'),
(15, 3, 'banners', '2026-06-15 19:11:57'),
(16, 3, 'productos', '2026-06-15 19:11:57'),
(17, 3, 'contactos', '2026-06-15 19:11:57'),
(18, 3, 'compras', '2026-06-15 19:11:57'),
(19, 3, 'usuarios', '2026-06-15 19:11:57'),
(20, 3, 'reportes', '2026-06-15 19:11:57'),
(21, 3, 'configuracion', '2026-06-15 19:11:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin_sessions`
--

CREATE TABLE `admin_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `expira_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_compras`
--

CREATE TABLE `carrito_compras` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `producto_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `variante_id` varchar(50) NOT NULL DEFAULT '0',
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito_compras`
--

INSERT INTO `carrito_compras` (`id`, `user_id`, `producto_id`, `variante_id`, `cantidad`, `creado_en`, `actualizado_en`) VALUES
(107, 3, '3d155bff-3c63-40b9-a3b1-718f306d1709', '54edae2f-9053-11f1-9ffd-0a002700000d', 2, '2026-08-27 20:11:31', '2026-08-27 21:22:42'),
(109, 3, '9b29d722-446a-4e8d-b5ba-2309c55334e1', '9cdd45c9-9054-11f1-9ffd-0a002700000d', 1, '2026-08-27 22:27:02', '2026-08-27 22:27:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` enum('ROPA','PAPELERIA','HOGAR','OTROS','ACCESORIOS') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `creado_en`) VALUES
(1, 'ROPA', 'Ropa y Accesorios institucionales', '2026-06-15 18:28:11'),
(2, 'PAPELERIA', 'Útiles de oficina y papelería', '2026-06-15 18:28:11'),
(3, 'HOGAR', 'Artículos decorativos y de hogar', '2026-06-15 18:28:11'),
(4, 'OTROS', 'Otros productos varios', '2026-06-15 18:28:11'),
(5, 'ACCESORIOS', 'Accesorios y complementos', '2026-06-22 19:38:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `valor` text DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`, `descripcion`) VALUES
(1, 'about_us_text', 'Texto inicial de ejemplo para la sección Nosotros.', 'Texto mostrado en la sección Nosotros'),
(2, 'about_us_image', 'uploads/site/about_us_1782096225.png', 'Imagen mostrada en la sección Nosotros'),
(3, 'offer_text', 'Oferta 1', NULL),
(4, 'offer_image', 'uploads/site/offer_1782158336.jpg', NULL),
(5, 'offer_items', '[{\"text\":\"asas\",\"image\":\"uploads\\/site\\/offer_1782159002_0.jpg\"},{\"text\":\"fffr\",\"image\":\"uploads\\/site\\/offer_1782159019_1.jpg\"}]', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `id` int(11) NOT NULL,
  `tipo` enum('email','telefono') NOT NULL,
  `valor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contactos`
--

INSERT INTO `contactos` (`id`, `tipo`, `valor`) VALUES
(1, 'telefono', '099999999');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE `fotos` (
  `id` int(11) NOT NULL,
  `tipo` enum('USUARIO','PRODUCTO','BANNER') NOT NULL DEFAULT 'PRODUCTO',
  `user_uuid` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `producto_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `ruta` varchar(500) NOT NULL,
  `nombre_archivo` varchar(255) DEFAULT NULL,
  `es_perfil` tinyint(1) DEFAULT 0,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `peso_kb` int(11) DEFAULT NULL,
  `tipo_mime` varchar(80) DEFAULT 'image/jpeg',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fotos`
--

INSERT INTO `fotos` (`id`, `tipo`, `user_uuid`, `producto_id`, `ruta`, `nombre_archivo`, `es_perfil`, `activo`, `peso_kb`, `tipo_mime`, `creado_en`) VALUES
(5, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a24a46ecb.jpg', 'layout-01.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:47:38'),
(6, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a2504c8ba.jpg', 'layout-02.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:47:44'),
(7, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a2562472e.jpg', 'layout-03.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:47:50'),
(8, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a25a3e672.jpg', 'layout-04.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:47:54'),
(9, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a25ee7799.jpg', 'layout-05.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:47:58'),
(10, 'BANNER', NULL, NULL, 'uploads/banners/banner_6a38a263ac93c.jpg', 'layout-06.jpg', 0, 1, NULL, 'image/jpeg', '2026-06-22 02:48:03'),
(16, 'PRODUCTO', NULL, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'uploads/productos/camisa-ama_1782355412.png', 'camisa-ama_1782355412.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 02:43:32'),
(18, 'PRODUCTO', NULL, '22f276ce-b462-4283-86b5-6f783571e365', 'uploads/productos/bolso-tote_1782358475.png', 'bolso-tote_1782358475.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 03:34:35'),
(19, 'PRODUCTO', NULL, '1c2f6a14-7776-4e4d-8789-711e417c254b', 'uploads/productos/forro-de-celular-_1782358534.png', 'forro-de-celular-_1782358534.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 03:35:34'),
(20, 'PRODUCTO', NULL, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'uploads/productos/libreta_1782358609.png', 'libreta_1782358609.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 03:36:49'),
(21, 'PRODUCTO', NULL, '9c605718-2871-45a6-a506-3550a9fb04d2', 'uploads/productos/taza-de-cafe-_1782358706.png', 'taza-de-cafe-_1782358706.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 03:38:26'),
(22, 'PRODUCTO', NULL, '942c044b-c4e0-4812-b11c-a18c5f8d4f45', 'uploads/productos/tazas_1782358843.png', 'tazas_1782358843.png', 1, 1, NULL, 'image/jpeg', '2026-06-25 03:40:43'),
(23, 'PRODUCTO', NULL, 'a438271c-dc16-43be-90a5-f009fecc738e', 'uploads/productos/mochila_1784494103.png', 'mochila_1784494103.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:48:23'),
(24, 'PRODUCTO', NULL, 'ac38d22c-8ee7-4b1b-8358-48cacca00bdf', 'uploads/productos/termo_1784494145.png', 'termo_1784494145.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:49:05'),
(25, 'PRODUCTO', NULL, '230df793-1464-4d83-821c-1f2b0ab8a6e5', 'uploads/productos/paper-cup_1784494200.png', 'paper-cup_1784494200.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:50:00'),
(26, 'PRODUCTO', NULL, 'b97b0566-2576-4475-acb2-d081dbb5fd7e', 'uploads/productos/mochila-negra-_1784494517.png', 'mochila-negra-_1784494517.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:55:17'),
(27, 'PRODUCTO', NULL, 'b78b35d9-2bf8-4090-af6d-60923d44ce39', 'uploads/productos/bolso-tote-blanco-_1784494610.png', 'bolso-tote-blanco-_1784494610.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:56:50'),
(28, 'PRODUCTO', NULL, '5396fd02-7a4e-4c14-bfbf-b05b89e3edc0', 'uploads/productos/mochila-roja-_1784494687.png', 'mochila-roja-_1784494687.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 20:58:07'),
(29, 'PRODUCTO', NULL, 'ba723b62-dff8-4480-9229-a01d963c7171', 'uploads/productos/mochila-naranja-_1784494922.png', 'mochila-naranja-_1784494922.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 21:02:02'),
(31, 'PRODUCTO', NULL, '6b32a1c2-6f92-4574-833f-d2b65821e17a', 'uploads/productos/forro-de-celular-naranja-_1784500138.png', 'forro-de-celular-naranja-_1784500138.png', 1, 1, NULL, 'image/jpeg', '2026-07-19 22:28:58'),
(32, 'PRODUCTO', NULL, 'd01d9652-66b8-4737-9a8a-686fa2352891', 'uploads/productos/bolso_1785777215.png', 'bolso_1785777215.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:13:35'),
(33, 'PRODUCTO', NULL, 'af23a140-bcf6-430a-9c14-0aff74b8c44c', 'uploads/productos/calcetin_1785777580.png', 'calcetin_1785777580.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:19:40'),
(34, 'PRODUCTO', NULL, '2ed1d679-e76b-4014-b248-db8ce5e40407', 'uploads/productos/calcetin-naranja-_1785777683.png', 'calcetin-naranja-_1785777683.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:21:23'),
(35, 'PRODUCTO', NULL, 'ee67a570-74bd-4e7c-8e1e-568af4d07f4d', 'uploads/productos/gorra-blanca-_1785777769.png', 'gorra-blanca-_1785777769.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:22:49'),
(36, 'PRODUCTO', NULL, 'e7f5849b-8960-4504-b9f8-04af307b8199', 'uploads/productos/sandalias-naranja-_1785777833.png', 'sandalias-naranja-_1785777833.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:23:53'),
(37, 'PRODUCTO', NULL, '2e933dd8-6525-419e-a4c7-a29c278ebc82', 'uploads/productos/gorra-dise-o-rojo-_1785778017.png', 'gorra-dise-o-rojo-_1785778017.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:26:57'),
(38, 'PRODUCTO', NULL, '44d51d12-1be1-45d9-8d27-d70ee2d1f1f5', 'uploads/productos/gorra-dise-o-celeste-_1785778055.png', 'gorra-dise-o-celeste-_1785778055.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:27:35'),
(39, 'PRODUCTO', NULL, '8c9c8b66-c638-4152-8d65-f873168c0874', 'uploads/productos/gorra-naraja-_1785778101.png', 'gorra-naraja-_1785778101.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:28:21'),
(40, 'PRODUCTO', NULL, '50143ea8-6725-455c-91dd-16ab8b90a72b', 'uploads/productos/gorra-dise-o-negro-_1785778245.png', 'gorra-dise-o-negro-_1785778245.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:30:45'),
(41, 'PRODUCTO', NULL, 'de28cdb9-03a3-4476-809c-49db7635b0b2', 'uploads/productos/sombrero-cyan-_1785778412.png', 'sombrero-cyan-_1785778412.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:33:32'),
(42, 'PRODUCTO', NULL, '978b0b4d-5767-4075-bec9-49a68b75b8ca', 'uploads/productos/zapatos-blanco-_1785778488.png', 'zapatos-blanco-_1785778488.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:34:48'),
(43, 'PRODUCTO', NULL, '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', 'uploads/productos/zapatos-naranja-_1785778558.png', 'zapatos-naranja-_1785778558.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:35:58'),
(44, 'PRODUCTO', NULL, 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', 'uploads/productos/zapatos-dise-o_1785778614.png', 'zapatos-dise-o_1785778614.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:36:54'),
(45, 'PRODUCTO', NULL, '56845b85-3802-446a-9b56-577d4c323ee3', 'uploads/productos/b-xer-rojo-_1785779348.png', 'b-xer-rojo-_1785779348.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:49:08'),
(46, 'PRODUCTO', NULL, '33521519-836d-424c-ab61-2d56f98734d2', 'uploads/productos/calcetin-dise-o-celeste-_1785779440.png', 'calcetin-dise-o-celeste-_1785779440.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:50:40'),
(47, 'PRODUCTO', NULL, 'a3c00857-c740-459e-9282-e6825378f36c', 'uploads/productos/calcetin-dise-o-naranja-_1785779602.png', 'calcetin-dise-o-naranja-_1785779602.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:53:22'),
(48, 'PRODUCTO', NULL, '9d851f64-fa97-487b-93f0-71652b5510cc', 'uploads/productos/gorra-dise-o-amarillo-_1785779655.png', 'gorra-dise-o-amarillo-_1785779655.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:54:15'),
(49, 'PRODUCTO', NULL, '01212cd6-fd6f-438d-a12a-820d9a54b934', 'uploads/productos/vestido-blanco-_1785779774.png', 'vestido-blanco-_1785779774.png', 1, 1, NULL, 'image/jpeg', '2026-08-03 17:56:14'),
(50, 'PRODUCTO', NULL, 'faea617d-7bf6-4ecc-b89c-753be8496be7', 'uploads/productos/interior-rojo-_1785874710.png', 'interior-rojo-_1785874710.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:18:13'),
(51, 'PRODUCTO', NULL, 'dda40585-91e2-4855-bb7e-3e8eb6935cb2', 'uploads/productos/toalla_1785875024.png', 'toalla_1785875024.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:23:44'),
(52, 'PRODUCTO', NULL, '702a379a-5abf-4114-8a0a-95825eac9af7', 'uploads/productos/taz-n_1785875166.png', 'taz-n_1785875166.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:26:06'),
(53, 'PRODUCTO', NULL, '5f9bd21b-7347-480e-9d5a-64985f738ebe', 'uploads/productos/cinturon_1785875249.png', 'cinturon_1785875249.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:27:29'),
(54, 'PRODUCTO', NULL, 'ef1da512-7f70-415c-bb29-6ffb4585824b', 'uploads/productos/borrador-rojo-_1785875356.png', 'borrador-rojo-_1785875356.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:29:16'),
(55, 'PRODUCTO', NULL, 'e4c83b4a-1ab5-4804-97d0-3d67bf4dea89', 'uploads/productos/taz-n-naranja-_1785875448.png', 'taz-n-naranja-_1785875448.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:30:48'),
(56, 'PRODUCTO', NULL, '37320382-9645-40c6-bc85-11cc5b7a741d', 'uploads/productos/gorra-rojo-_1785875538.png', 'gorra-rojo-_1785875538.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:32:18'),
(57, 'PRODUCTO', NULL, 'af3554c6-8efb-440a-83ba-0278693f9cab', 'uploads/productos/gorra-dise-o-blanco-_1785875587.png', 'gorra-dise-o-blanco-_1785875587.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:33:07'),
(58, 'PRODUCTO', NULL, '96bf0cfe-072d-4942-8c75-d29e483924ae', 'uploads/productos/gorra-dise-o-naranja-_1785875635.png', 'gorra-dise-o-naranja-_1785875635.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:33:55'),
(59, 'PRODUCTO', NULL, '4ff7c00b-c984-43d0-8a3c-6d1eab936907', 'uploads/productos/marcador-verde-_1785875689.png', 'marcador-verde-_1785875689.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:34:49'),
(60, 'PRODUCTO', NULL, 'e0bcee6b-b5b3-4b65-9ccc-61aae229936c', 'uploads/productos/marcador-naranja-_1785875734.png', 'marcador-naranja-_1785875734.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:35:34'),
(61, 'PRODUCTO', NULL, 'da763043-589d-4820-a826-934f4ce479af', 'uploads/productos/marcador-rojo-_1785875757.png', 'marcador-rojo-_1785875757.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:35:57'),
(62, 'PRODUCTO', NULL, '40c55268-0784-4615-9b37-d9b1e40f6bc8', 'uploads/productos/bikini-blanco-_1785876615.png', 'bikini-blanco-_1785876615.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:50:15'),
(63, 'PRODUCTO', NULL, 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', 'uploads/productos/sandalias-blanco-_1785876684.png', 'sandalias-blanco-_1785876684.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:51:24'),
(64, 'PRODUCTO', NULL, '563e57d3-e458-4971-a69d-83ce07da33e9', 'uploads/productos/vestido-dise-o_1785876780.png', 'vestido-dise-o_1785876780.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:53:00'),
(65, 'PRODUCTO', NULL, '643a4d05-77d4-4461-b206-79e9bd415448', 'uploads/productos/polo-blanco-_1785876841.png', 'polo-blanco-_1785876841.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:54:01'),
(66, 'PRODUCTO', NULL, '1deb32a9-9b91-4b97-aa02-80774f11fed6', 'uploads/productos/toalla-rojo-_1785876909.png', 'toalla-rojo-_1785876909.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:55:09'),
(67, 'PRODUCTO', NULL, '5b379542-4c51-4605-bf07-a307d63dae1a', 'uploads/productos/zapatos-dise-o-naranja-_1785876952.png', 'zapatos-dise-o-naranja-_1785876952.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:55:52'),
(68, 'PRODUCTO', NULL, '8fa4713e-90ef-4a92-8490-07ba0b2b87a5', 'uploads/productos/cinturon-rojo-_1785877008.png', 'cinturon-rojo-_1785877008.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:56:48'),
(69, 'PRODUCTO', NULL, 'fe99dd2b-adef-4808-9abe-346a61aafb8f', 'uploads/productos/b-xer-naranja-_1785877082.png', 'b-xer-naranja-_1785877082.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:58:02'),
(70, 'PRODUCTO', NULL, '52222611-6c0c-4267-aedd-c43052cdae8c', 'uploads/productos/b-xer-dise-o-blanco-_1785877125.png', 'b-xer-dise-o-blanco-_1785877125.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:58:45'),
(71, 'PRODUCTO', NULL, '27b1d566-65db-4e44-8c8d-85fb1a28d1f9', 'uploads/productos/interior-dise-o_1785877171.png', 'interior-dise-o_1785877171.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 20:59:31'),
(72, 'PRODUCTO', NULL, '04512eaf-af7e-415c-b238-a21eff90bf64', 'uploads/productos/taz-n-blanco-_1785877224.png', 'taz-n-blanco-_1785877224.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:00:24'),
(73, 'PRODUCTO', NULL, 'b59aafae-6d05-4f26-9740-5fa364c93f8d', 'uploads/productos/taz-n-rojo-_1785877244.png', 'taz-n-rojo-_1785877244.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:00:44'),
(74, 'PRODUCTO', NULL, 'ec54c48d-dac0-491e-a813-24860028c62e', 'uploads/productos/gorra-dise-o_1785877292.png', 'gorra-dise-o_1785877292.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:01:32'),
(75, 'PRODUCTO', NULL, 'a559fa9f-31d0-4b69-840c-0e6353894968', 'uploads/productos/jean-dise-o-naranja-_1785877513.png', 'jean-dise-o-naranja-_1785877513.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:05:13'),
(76, 'PRODUCTO', NULL, '4c826e64-f706-4e53-842a-700c5d0ed2f8', 'uploads/productos/jean-dise-o_1785877549.png', 'jean-dise-o_1785877549.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:05:49'),
(77, 'PRODUCTO', NULL, '6f4f0fda-d2c4-4c80-babb-d65d1098a28e', 'uploads/productos/coj-n_1785878510.png', 'coj-n_1785878510.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:21:50'),
(78, 'PRODUCTO', NULL, '355b13b2-5e53-425b-a4c7-a6a5e5371de8', 'uploads/productos/vestido-dise-o-2_1785879026.png', 'vestido-dise-o-2_1785879026.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:30:26'),
(79, 'PRODUCTO', NULL, 'c6b9b46a-6054-4517-8374-262bd553b62f', 'uploads/productos/pluma-dise-o-rojo-_1785879067.png', 'pluma-dise-o-rojo-_1785879067.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:31:07'),
(80, 'PRODUCTO', NULL, '9223df29-691e-4d06-8188-456c514cdb4d', 'uploads/productos/sueter-naranja-_1785879160.png', 'sueter-naranja-_1785879160.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:32:40'),
(81, 'PRODUCTO', NULL, 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', 'uploads/productos/zapatos-dise-o-2_1785879219.png', 'zapatos-dise-o-2_1785879219.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:33:39'),
(82, 'PRODUCTO', NULL, 'e66e0b61-15f7-4bdf-9d4f-d39285176006', 'uploads/productos/cinturon-naranja-_1785879254.png', 'cinturon-naranja-_1785879254.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:34:14'),
(83, 'PRODUCTO', NULL, 'e375d378-99da-474c-b907-ba64eb95ac0e', 'uploads/productos/b-xer-dise-o-rojo-_1785879302.png', 'b-xer-dise-o-rojo-_1785879302.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:35:02'),
(84, 'PRODUCTO', NULL, '2eec60ba-6dd8-46e0-8024-62cfff9a6017', 'uploads/productos/b-xer-dise-o-azul-_1785879364.png', 'b-xer-dise-o-azul-_1785879364.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:36:04'),
(85, 'PRODUCTO', NULL, 'ead2f1bc-ba66-4d55-b420-182018db35c4', 'uploads/productos/borrador_1785879430.png', 'borrador_1785879430.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:37:10'),
(86, 'PRODUCTO', NULL, '389d94db-6608-4e89-b0b9-180efa5ee4a7', 'uploads/productos/gorra-dise-o-azul-_1785879469.png', 'gorra-dise-o-azul-_1785879469.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:37:49'),
(87, 'PRODUCTO', NULL, 'fc49b184-d85d-4e62-8c37-c63b2e1e3720', 'uploads/productos/gorra-dise-o-verde-_1785879499.png', 'gorra-dise-o-verde-_1785879499.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:38:19'),
(88, 'PRODUCTO', NULL, '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', 'uploads/productos/jean-dise-o-2_1785879540.png', 'jean-dise-o-2_1785879540.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:39:00'),
(89, 'PRODUCTO', NULL, 'dddea19b-9787-44e5-96d4-cd28c94dc255', 'uploads/productos/jean-dise-o-rojo-_1785879578.png', 'jean-dise-o-rojo-_1785879578.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:39:38'),
(90, 'PRODUCTO', NULL, 'd2263ca3-b76d-46c4-8119-8d97a7510436', 'uploads/productos/jean-dise-o-3_1785879601.png', 'jean-dise-o-3_1785879601.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:40:01'),
(91, 'PRODUCTO', NULL, '20a72eba-a2cb-49c4-8af2-b73f6c125e92', 'uploads/productos/sombrero-blanco-_1785879819.png', 'sombrero-blanco-_1785879819.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:43:39'),
(92, 'PRODUCTO', NULL, 'acb0e7d2-bd26-4452-b61a-3309f7c357ac', 'uploads/productos/sombrero-dise-o-blanco-_1785879886.png', 'sombrero-dise-o-blanco-_1785879886.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:44:46'),
(93, 'PRODUCTO', NULL, '3506fe33-aed0-4459-ad3e-ebf5ff2b6754', 'uploads/productos/vestido-naranja-_1785879940.png', 'vestido-naranja-_1785879940.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:45:40'),
(94, 'PRODUCTO', NULL, 'edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', 'uploads/productos/sueter-rojo-_1785880047.png', 'sueter-rojo-_1785880047.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:47:27'),
(95, 'PRODUCTO', NULL, '5ad5c94e-def5-45e0-877d-d3cceef352a6', 'uploads/productos/sueter-dise-o_1785880090.png', 'sueter-dise-o_1785880090.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:48:10'),
(96, 'PRODUCTO', NULL, '0915c030-b8f7-41e1-bbfe-5773cdf0f17f', 'uploads/productos/sueter-dise-o-naranja-_1785880169.png', 'sueter-dise-o-naranja-_1785880169.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:49:29'),
(97, 'PRODUCTO', NULL, 'c58490a0-20db-4281-8818-e9be64097858', 'uploads/productos/interior-naranja-_1785880362.png', 'interior-naranja-_1785880362.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:52:42'),
(98, 'PRODUCTO', NULL, 'f3a99e28-9629-4652-b7fa-f5d76e97d897', 'uploads/productos/interior-blanco-_1785880403.png', 'interior-blanco-_1785880403.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:53:23'),
(99, 'PRODUCTO', NULL, '8a8e6130-1fd0-497a-ab70-6739cc2d14d1', 'uploads/productos/cinturon-dise-o_1785880437.png', 'cinturon-dise-o_1785880437.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:53:57'),
(100, 'PRODUCTO', NULL, '4fdcd069-633a-42dc-9f8c-2c7af4931d39', 'uploads/productos/cinturon-dise-o-naranja-_1785880463.png', 'cinturon-dise-o-naranja-_1785880463.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:54:23'),
(101, 'PRODUCTO', NULL, 'ceaf751c-821d-44b6-845f-68b2a907bbb6', 'uploads/productos/zapatos-dise-o-3_1785880539.png', 'zapatos-dise-o-3_1785880539.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:55:39'),
(102, 'PRODUCTO', NULL, '642ac18b-a895-4c0a-a5a1-fdf97de9cdf8', 'uploads/productos/borrador-naranja-_1785880574.png', 'borrador-naranja-_1785880574.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:56:14'),
(103, 'PRODUCTO', NULL, '153daf91-d453-461f-aaf6-b9a406eea824', 'uploads/productos/taz-n-dise-o_1785880637.png', 'taz-n-dise-o_1785880637.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 21:57:17'),
(104, 'PRODUCTO', NULL, 'ac2271a9-c9c4-4c36-8ae1-c5d4f57d2262', 'uploads/productos/marcador-dise-o-amarillo-_1785880862.png', 'marcador-dise-o-amarillo-_1785880862.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:01:02'),
(105, 'PRODUCTO', NULL, '4f100296-3f25-47cb-8ce6-30c8cb60efa8', 'uploads/productos/sandalias-dise-o_1785880902.png', 'sandalias-dise-o_1785880902.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:01:42'),
(106, 'PRODUCTO', NULL, '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', 'uploads/productos/sandalias-dise-o-blanco-_1785880993.png', 'sandalias-dise-o-blanco-_1785880993.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:03:13'),
(107, 'PRODUCTO', NULL, '85308d07-3d88-42a8-9d5e-0f279a48105a', 'uploads/productos/sombrero-naranja-_1785881065.png', 'sombrero-naranja-_1785881065.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:04:25'),
(108, 'PRODUCTO', NULL, 'd3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', 'uploads/productos/vestido-rojo-_1785881110.png', 'vestido-rojo-_1785881110.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:05:10'),
(109, 'PRODUCTO', NULL, 'ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', 'uploads/productos/polo-dise-o-2_1785881243.png', 'polo-dise-o-2_1785881243.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:07:23'),
(110, 'PRODUCTO', NULL, '2dcc5728-5066-458d-aabd-284d16fe7bb9', 'uploads/productos/sueter-blanco-_1785881317.png', 'sueter-blanco-_1785881317.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:08:37'),
(111, 'PRODUCTO', NULL, '12b9b863-0859-4370-a904-bf1ef2017765', 'uploads/productos/marcador-morado-_1785881339.png', 'marcador-morado-_1785881339.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:08:59'),
(112, 'PRODUCTO', NULL, '0574113f-1a00-4c89-99e7-b2418d043470', 'uploads/productos/bikini-rojo-_1785881390.png', 'bikini-rojo-_1785881390.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:09:50'),
(113, 'PRODUCTO', NULL, 'f070ad64-a3cb-4684-bc43-c360fe233c29', 'uploads/productos/coj-n-dise-o_1785881423.png', 'coj-n-dise-o_1785881423.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:10:23'),
(114, 'PRODUCTO', NULL, '9017eeef-d12b-4e98-bd6b-7d21025ce303', 'uploads/productos/coj-n-naranja-_1785881458.png', 'coj-n-naranja-_1785881458.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:10:58'),
(115, 'PRODUCTO', NULL, '2307e893-a3e3-4c5d-bbed-4139bbd72f57', 'uploads/productos/coj-n-blanco-_1785881517.png', 'coj-n-blanco-_1785881517.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:11:57'),
(116, 'PRODUCTO', NULL, 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', 'uploads/productos/sandalias-rojo-_1785881645.png', 'sandalias-rojo-_1785881645.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:14:05'),
(117, 'PRODUCTO', NULL, '892794d2-42ac-4374-9d58-5cb6f993f2f7', 'uploads/productos/sombrero-dise-o-2_1785881820.png', 'sombrero-dise-o-2_1785881820.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:17:00'),
(118, 'PRODUCTO', NULL, 'c541a995-dd76-4d9a-90de-55a9d26d6a20', 'uploads/productos/pluma-naranja_1785881868.png', 'pluma-naranja_1785881868.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:17:48'),
(119, 'PRODUCTO', NULL, '4013d611-3f3c-4ad9-85c6-b5be6903cbc5', 'uploads/productos/pluma-dise-o-verde-_1785881886.png', 'pluma-dise-o-verde-_1785881886.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:18:06'),
(120, 'PRODUCTO', NULL, 'd9d93671-c7be-4edd-9388-66fa9feb1fb6', 'uploads/productos/polo-dise-o-_1785881956.png', 'polo-dise-o-_1785881956.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:19:16'),
(121, 'PRODUCTO', NULL, '3e07fac8-c6e6-43ce-a7a8-0ea89132680f', 'uploads/productos/polo-dise-o-invertido-_1785881992.png', 'polo-dise-o-invertido-_1785881992.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:19:52'),
(122, 'PRODUCTO', NULL, 'b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', 'uploads/productos/polo-dise-o-rojo-_1785882057.png', 'polo-dise-o-rojo-_1785882057.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:20:57'),
(123, 'PRODUCTO', NULL, 'a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', 'uploads/productos/polo-dise-o-naranja-_1785882168.png', 'polo-dise-o-naranja-_1785882168.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:22:48'),
(124, 'PRODUCTO', NULL, '13b3e49e-c0e0-4eae-8dfc-da3cef5653db', 'uploads/productos/polo-naranja-_1785882244.png', 'polo-naranja-_1785882244.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:24:04'),
(125, 'PRODUCTO', NULL, '3d155bff-3c63-40b9-a3b1-718f306d1709', 'uploads/productos/toalla-naranja-_1785882300.png', 'toalla-naranja-_1785882300.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:25:00'),
(126, 'PRODUCTO', NULL, 'adb59b98-b707-46b8-85b1-6e3493b8993b', 'uploads/productos/zapatos-dise-o-rojo-_1785882414.png', 'zapatos-dise-o-rojo-_1785882414.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:26:54'),
(127, 'PRODUCTO', NULL, 'afc01428-f9fb-4146-9cd8-67dbf89edb14', 'uploads/productos/bikini-naranja-_1785882562.png', 'bikini-naranja-_1785882562.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:29:22'),
(128, 'PRODUCTO', NULL, 'df1092ca-5732-4b4c-bea4-3f1994eb6856', 'uploads/productos/borrador-blanco-_1785882633.png', 'borrador-blanco-_1785882633.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:30:33'),
(129, 'PRODUCTO', NULL, '278ef192-3226-4647-9f56-3575427f4963', 'uploads/productos/borrador-dise-o_1785882657.png', 'borrador-dise-o_1785882657.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:30:57'),
(130, 'PRODUCTO', NULL, 'e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', 'uploads/productos/bikini-dise-o_1785882777.png', 'bikini-dise-o_1785882777.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:32:57'),
(131, 'PRODUCTO', NULL, '9d9ca103-54ba-43e2-a482-f1996292af65', 'uploads/productos/bikini-dise-o-naranja-_1785882815.png', 'bikini-dise-o-naranja-_1785882815.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:33:35'),
(132, 'PRODUCTO', NULL, '9b29d722-446a-4e8d-b5ba-2309c55334e1', 'uploads/productos/bikini-dise-o-2_1785882850.png', 'bikini-dise-o-2_1785882850.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:34:10'),
(133, 'PRODUCTO', NULL, '1c663a48-885e-4b18-9436-3b08796a1b62', 'uploads/productos/organizador-dise-o-rojo-_1785882936.png', 'organizador-dise-o-rojo-_1785882936.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:35:36'),
(134, 'PRODUCTO', NULL, '3615a52c-4477-4c45-bf79-fc8296cc7546', 'uploads/productos/organizador-dise-o-2_1785882979.png', 'organizador-dise-o-2_1785882979.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:36:19'),
(135, 'PRODUCTO', NULL, '24471ffb-7af2-4325-9b51-9c171eea21dc', 'uploads/productos/organizador-amarillo-_1785883039.png', 'organizador-amarillo-_1785883039.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:37:19'),
(136, 'PRODUCTO', NULL, '5db642fe-f806-4c5c-a52e-c1428ae1dbcf', 'uploads/productos/organizador-dise-o-3_1785883085.png', 'organizador-dise-o-3_1785883085.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:38:05'),
(137, 'PRODUCTO', NULL, '870ef8e6-38ca-44f9-be26-5a837e6a58e0', 'uploads/productos/organizador-dise-o-celeste-_1785883106.png', 'organizador-dise-o-celeste-_1785883106.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:38:26'),
(138, 'PRODUCTO', NULL, '8896976e-5971-4275-80d8-1d6a556ab999', 'uploads/productos/pluma-dise-o-2_1785883160.png', 'pluma-dise-o-2_1785883160.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:39:20'),
(139, 'PRODUCTO', NULL, '184edb2e-37f0-43e1-9a40-a0be2b707dc9', 'uploads/productos/pluma-dise-o-_1785883184.png', 'pluma-dise-o-_1785883184.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:39:44'),
(140, 'PRODUCTO', NULL, '4c44f76b-4f5a-4d57-849a-214cfb2398d8', 'uploads/productos/toalla-dise-o_1785883210.png', 'toalla-dise-o_1785883210.png', 1, 1, NULL, 'image/jpeg', '2026-08-04 22:40:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory_movements`
--

CREATE TABLE `inventory_movements` (
  `id` int(11) NOT NULL,
  `producto_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `tipo` enum('INGRESO','SALIDA','AJUSTE') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `nota` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_uuid` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estado` enum('PENDIENTE','PAGADO','ENVIADO','COMPLETADO','CANCELADO') NOT NULL DEFAULT 'PENDIENTE',
  `direccion_envio` text DEFAULT NULL,
  `telefono_envio` varchar(50) DEFAULT NULL,
  `metodo_pago` varchar(80) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `paypal_order_id` varchar(255) DEFAULT NULL,
  `paypal_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `order_uuid`, `user_id`, `total`, `estado`, `direccion_envio`, `telefono_envio`, `metodo_pago`, `creado_en`, `actualizado_en`, `paypal_order_id`, `paypal_status`) VALUES
(8, 'ORD-6a545c4dc8103', 3, 4.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-13 03:32:29', '2026-07-13 03:32:29', NULL, NULL),
(9, 'ORD-6a545c5eee223', 3, 4.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-13 03:32:46', '2026-07-13 03:32:46', NULL, NULL),
(10, 'ORD-6a545d07a96c3', 3, 10.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-13 03:35:35', '2026-07-13 03:35:35', NULL, NULL),
(11, 'ORD-6a545fa6f1d1a', 3, 10.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-13 03:46:46', '2026-07-13 03:46:46', NULL, NULL),
(12, 'ORD-6a5461fe3c79d', 3, 10.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'CONTRA_ENTREGA', '2026-07-13 03:56:46', '2026-07-13 03:57:10', NULL, NULL),
(14, 'ORD-6a5462f6eb1eb', 3, 13.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-13 04:00:54', '2026-07-13 04:01:13', NULL, NULL),
(15, 'ORD-6a5d4590edaec', 3, 20.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-19 21:45:52', '2026-07-19 21:48:55', NULL, NULL),
(16, 'ORD-6a5d47433a174', 3, 5.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-19 21:53:07', '2026-07-19 21:54:31', '2S897806LC3421250', 'CREATED'),
(17, 'ORD-6a5d48236e6d3', 3, 10.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'CONTRA_ENTREGA', '2026-07-19 21:56:51', '2026-07-19 21:56:58', NULL, NULL),
(18, 'ORD-6a5d4db4980b7', 3, 40.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-19 22:20:36', '2026-07-19 22:22:02', NULL, NULL),
(19, 'ORD-6a5d4ebf29245', 3, 20.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-19 22:25:03', '2026-07-19 22:25:16', NULL, NULL),
(20, 'ORD-6a602c366f6af', 3, 3.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-22 02:34:30', '2026-07-22 02:34:30', NULL, NULL),
(21, 'ORD-6a60e002f2cbf', 3, 3.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-22 15:21:38', '2026-07-22 15:22:27', NULL, NULL),
(22, 'ORD-6a60ef569b20a', 3, 10.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-07-22 16:27:02', '2026-07-22 16:28:32', NULL, NULL),
(23, 'ORD-6a62fca23d852', 3, 3.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-24 05:48:18', '2026-07-24 05:48:18', NULL, NULL),
(24, 'ORD-6a638ed35a1d9', 3, 8.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-24 16:12:03', '2026-07-24 16:12:03', NULL, NULL),
(25, 'ORD-6a638ef2bd082', 3, 8.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-07-24 16:12:34', '2026-07-24 16:12:34', NULL, NULL),
(26, 'ORD-6a70b2224ab3c', 3, 10.00, 'ENVIADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-08-03 15:22:10', '2026-08-03 15:38:54', NULL, NULL),
(27, 'ORD-6a7270a1bac25', 3, 5.00, 'PAGADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-08-04 23:07:13', '2026-08-04 23:09:05', NULL, NULL),
(28, 'ORD-6a8356767151c', 3, 10.00, 'ENVIADO', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', 'PAYPAL', '2026-08-17 18:44:06', '2026-08-17 18:47:28', NULL, NULL),
(29, 'ORD-6a90b78728529', 3, 16.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-08-27 22:17:43', '2026-08-27 22:17:43', NULL, NULL),
(30, 'ORD-6a90b8aa4603e', 3, 16.00, 'PENDIENTE', '{\"calle_principal\":\"Calle 24 de Mayo y Vi PASS\",\"provincia\":\"Manabí\",\"canton\":\"Portoviejo\",\"parroquia\":\"Portoviejo\",\"calle_secundaria\":\"Terminal\",\"departamento\":\"123\",\"referencia\":\"saa\",\"tipo\":\"Residencial\",\"recibe_nombre\":\"jose\",\"recibe_telefono\":\"09999999999\"}', '09999999999', NULL, '2026-08-27 22:22:34', '2026-08-27 22:22:34', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `producto_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `nombre_producto` varchar(250) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `producto_id`, `nombre_producto`, `precio_unitario`, `cantidad`, `subtotal`) VALUES
(8, 8, '942c044b-c4e0-4812-b11c-a18c5f8d4f45', 'TAZAS', 4.00, 1, 4.00),
(9, 9, '942c044b-c4e0-4812-b11c-a18c5f8d4f45', 'TAZAS', 4.00, 1, 4.00),
(10, 10, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(11, 11, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(12, 12, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(14, 14, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(15, 14, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(16, 15, 'b78b35d9-2bf8-4090-af6d-60923d44ce39', 'BOLSO TOTE (BLANCO)', 20.00, 1, 20.00),
(17, 16, '9c605718-2871-45a6-a506-3550a9fb04d2', 'TAZA DE CAFÉ', 5.00, 1, 5.00),
(18, 17, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(19, 18, 'ba723b62-dff8-4480-9229-a01d963c7171', 'Mochila (Naranja)', 20.00, 2, 40.00),
(20, 19, 'ba723b62-dff8-4480-9229-a01d963c7171', 'Mochila (Naranja)', 20.00, 1, 20.00),
(21, 20, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(22, 21, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(23, 22, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 2, 6.00),
(24, 22, '942c044b-c4e0-4812-b11c-a18c5f8d4f45', 'TAZAS', 4.00, 1, 4.00),
(25, 23, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(26, 24, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(27, 24, '6b32a1c2-6f92-4574-833f-d2b65821e17a', 'FORRO DE CELULAR (Naranja)', 5.00, 1, 5.00),
(28, 25, '2f4b1c46-e582-4585-b0a2-198701233ff0', 'LIBRETA', 3.00, 1, 3.00),
(29, 25, '6b32a1c2-6f92-4574-833f-d2b65821e17a', 'FORRO DE CELULAR (Naranja)', 5.00, 1, 5.00),
(30, 26, 'd2024cef-5dec-42e8-89ec-6a350a026742', 'CAMISA ama', 10.00, 1, 10.00),
(31, 27, '5f9bd21b-7347-480e-9d5a-64985f738ebe', 'Cinturon (Blanco)', 5.00, 1, 5.00),
(32, 28, '9d9ca103-54ba-43e2-a482-f1996292af65', 'Bikini Diseño (Naranja)', 10.00, 1, 10.00),
(33, 29, '3d155bff-3c63-40b9-a3b1-718f306d1709', 'Toalla (Naranja)', 8.00, 2, 16.00),
(34, 30, '3d155bff-3c63-40b9-a3b1-718f306d1709', 'Toalla (Naranja)', 8.00, 2, 16.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `sku` varchar(60) DEFAULT NULL,
  `nombre` varchar(200) NOT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `material` varchar(150) DEFAULT NULL,
  `dimensiones` varchar(150) DEFAULT NULL,
  `medidas_json` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `categoria_id` int(11) DEFAULT NULL,
  `subcategorias` varchar(255) DEFAULT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  `stock_total` int(11) NOT NULL DEFAULT 0,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `sku`, `nombre`, `slug`, `descripcion`, `material`, `dimensiones`, `medidas_json`, `precio`, `categoria_id`, `subcategorias`, `disponible`, `stock_total`, `creado_en`, `actualizado_en`) VALUES
('01212cd6-fd6f-438d-a12a-820d9a54b934', NULL, 'Vestido (Blanco)', 'vestido-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"5\",\"m2\":\"6\"},\"M\":{\"m1\":\"7\",\"m2\":\"8\"},\"L\":{\"m1\":\"9\",\"m2\":\"10\"},\"XL\":{\"m1\":\"11\",\"m2\":\"12\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 14.00, 1, 'vestimenta', 1, 0, '2026-08-03 17:56:14', '2026-08-03 17:56:14'),
('04512eaf-af7e-415c-b238-a21eff90bf64', NULL, 'Tazón (Blanco)', 'taz-n-blanco-', '-', '-', '-', NULL, 2.00, 3, 'cocina', 1, 0, '2026-08-04 21:00:24', '2026-08-04 21:00:24'),
('0574113f-1a00-4c89-99e7-b2418d043470', NULL, 'Bikini (Rojo)', 'bikini-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'interior', 1, 0, '2026-08-04 22:09:50', '2026-08-04 22:09:50'),
('0915c030-b8f7-41e1-bbfe-5773cdf0f17f', NULL, 'Sueter Diseño (Naranja)', 'sueter-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'accesorios', 1, 0, '2026-08-04 21:49:29', '2026-08-04 21:49:29'),
('0cf34e99-1c1f-4ea4-81bd-65167a44a6df', NULL, 'Sandalias Diseño (Blanco)', 'sandalias-dise-o-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-04 22:03:13', '2026-08-04 22:03:13'),
('12b9b863-0859-4370-a904-bf1ef2017765', NULL, 'Marcador (Morado)', 'marcador-morado-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:08:59', '2026-08-04 22:08:59'),
('13b3e49e-c0e0-4eae-8dfc-da3cef5653db', NULL, 'Polo (Naranja)', 'polo-naranja-', 'Camisa con diseño', 'Algodón', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:24:04', '2026-08-17 19:49:29'),
('153daf91-d453-461f-aaf6-b9a406eea824', NULL, 'Tazón Diseño', 'taz-n-dise-o', '-', '-', '-', NULL, 2.00, 3, 'cocina', 1, 0, '2026-08-04 21:57:17', '2026-08-04 21:57:17'),
('184edb2e-37f0-43e1-9a40-a0be2b707dc9', NULL, 'Pluma Diseño ', 'pluma-dise-o-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:39:44', '2026-08-04 22:39:44'),
('1c2f6a14-7776-4e4d-8789-711e417c254b', NULL, 'FORRO DE CELULAR ', 'forro-de-celular-', '-------------------------------', '---------------------', '---------------------------', NULL, 5.00, 5, 'forros', 1, 0, '2026-06-25 03:35:34', '2026-07-19 20:37:05'),
('1c663a48-885e-4b18-9436-3b08796a1b62', NULL, 'Organizador Diseño (Rojo)', 'organizador-dise-o-rojo-', '-', '-', '-', NULL, 2.00, 2, 'organizador', 1, 0, '2026-08-04 22:35:36', '2026-08-04 22:35:36'),
('1deb32a9-9b91-4b97-aa02-80774f11fed6', NULL, 'Toalla (Rojo)', 'toalla-rojo-', '-', '-', '-', NULL, 8.00, 3, 'baño', 1, 0, '2026-08-04 20:55:09', '2026-08-04 20:55:09'),
('20a72eba-a2cb-49c4-8af2-b73f6c125e92', NULL, 'Sombrero (Blanco)', 'sombrero-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 21:43:39', '2026-08-04 21:43:39'),
('22f276ce-b462-4283-86b5-6f783571e365', NULL, 'BOLSO TOTE', 'bolso-tote', '---------------------------------------------------------------------------', '---------------------', '---------------------------', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-06-25 03:34:35', '2026-07-19 20:37:10'),
('2307e893-a3e3-4c5d-bbed-4139bbd72f57', NULL, 'Cojín (Blanco)', 'coj-n-blanco-', '-', '-', '-', NULL, 3.00, 3, 'sala', 1, 0, '2026-08-04 22:11:57', '2026-08-04 22:11:57'),
('230df793-1464-4d83-821c-1f2b0ab8a6e5', NULL, 'Paper Cup', 'paper-cup', '--------------', '------------------------', '', NULL, 5.00, 5, 'otros', 1, 0, '2026-07-19 20:50:00', '2026-07-19 20:50:00'),
('24471ffb-7af2-4325-9b51-9c171eea21dc', NULL, 'Organizador (Amarillo)', 'organizador-amarillo-', '-', '-', '-', NULL, 3.00, 2, 'organizador', 1, 0, '2026-08-04 22:37:19', '2026-08-04 22:37:19'),
('278ef192-3226-4647-9f56-3575427f4963', NULL, 'Borrador Diseño', 'borrador-dise-o', '-', '-', '-', NULL, 0.50, 2, 'escritura', 1, 0, '2026-08-04 22:30:57', '2026-08-04 22:30:57'),
('27b1d566-65db-4e44-8c8d-85fb1a28d1f9', NULL, 'Interior Diseño', 'interior-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 20:59:31', '2026-08-04 20:59:31'),
('2dcc5728-5066-458d-aabd-284d16fe7bb9', NULL, 'Sueter (Blanco)', 'sueter-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'accesorios', 1, 0, '2026-08-04 22:08:37', '2026-08-04 22:08:37'),
('2e933dd8-6525-419e-a4c7-a29c278ebc82', NULL, 'Gorra Diseño (Rojo)', 'gorra-dise-o-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:26:57', '2026-08-03 17:29:23'),
('2ed1d679-e76b-4014-b248-db8ce5e40407', NULL, 'Calcetin (Naranja)', 'calcetin-naranja-', '-', 'Porcelana', '38', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 3.00, 1, 'calzado', 1, 0, '2026-08-03 17:21:23', '2026-08-03 17:21:23'),
('2eec60ba-6dd8-46e0-8024-62cfff9a6017', NULL, 'Bóxer Diseño (Azul)', 'b-xer-dise-o-azul-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 21:36:04', '2026-08-04 21:36:04'),
('2f4b1c46-e582-4585-b0a2-198701233ff0', NULL, 'LIBRETA', 'libreta', '-----------------------------------------------------', '---------------------', '---------------------------', NULL, 3.00, 2, 'libretas', 1, 0, '2026-06-25 03:36:49', '2026-08-17 18:10:02'),
('33521519-836d-424c-ab61-2d56f98734d2', NULL, 'Calcetin Diseño (Celeste)', 'calcetin-dise-o-celeste-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-03 17:50:40', '2026-08-03 17:50:40'),
('3506fe33-aed0-4459-ad3e-ebf5ff2b6754', NULL, 'Vestido (Naranja)', 'vestido-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 14.00, 1, 'vestimenta', 1, 0, '2026-08-04 21:45:40', '2026-08-04 21:45:40'),
('355b13b2-5e53-425b-a4c7-a6a5e5371de8', NULL, 'Vestido Diseño 2', 'vestido-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 14.00, 1, 'vestimenta', 1, 0, '2026-08-04 21:30:26', '2026-08-04 21:30:26'),
('3615a52c-4477-4c45-bf79-fc8296cc7546', NULL, 'Organizador Diseño 2', 'organizador-dise-o-2', '-', '-', '-', NULL, 2.00, 2, 'organizador', 1, 0, '2026-08-04 22:36:19', '2026-08-04 22:36:19'),
('37320382-9645-40c6-bc85-11cc5b7a741d', NULL, 'Gorra (Rojo)', 'gorra-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 20:32:18', '2026-08-04 20:32:18'),
('389d94db-6608-4e89-b0b9-180efa5ee4a7', NULL, 'Gorra Diseño (Azul)', 'gorra-dise-o-azul-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 21:37:49', '2026-08-04 21:37:49'),
('3d155bff-3c63-40b9-a3b1-718f306d1709', NULL, 'Toalla (Naranja)', 'toalla-naranja-', '-', '-', '-', NULL, 8.00, 3, 'baño', 1, 0, '2026-08-04 22:25:00', '2026-08-04 22:25:00'),
('3e07fac8-c6e6-43ce-a7a8-0ea89132680f', NULL, 'Polo Diseño (Invertido)', 'polo-dise-o-invertido-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:19:52', '2026-08-04 22:19:52'),
('4013d611-3f3c-4ad9-85c6-b5be6903cbc5', NULL, 'Pluma Diseño (Verde)', 'pluma-dise-o-verde-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:18:06', '2026-08-04 22:18:06'),
('40c55268-0784-4615-9b37-d9b1e40f6bc8', NULL, 'Bikini (Blanco)', 'bikini-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'interior', 1, 0, '2026-08-04 20:50:15', '2026-08-04 20:50:15'),
('44d51d12-1be1-45d9-8d27-d70ee2d1f1f5', NULL, 'Gorra Diseño (Celeste)', 'gorra-dise-o-celeste-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:27:35', '2026-08-03 17:29:36'),
('4c44f76b-4f5a-4d57-849a-214cfb2398d8', NULL, 'Toalla Diseño', 'toalla-dise-o', '-', '-', '-', NULL, 8.00, 5, 'baño', 1, 0, '2026-08-04 22:40:10', '2026-08-04 22:40:10'),
('4c826e64-f706-4e53-842a-700c5d0ed2f8', NULL, 'Jean Diseño', 'jean-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'pantalones', 1, 0, '2026-08-04 21:05:49', '2026-08-04 21:05:49'),
('4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', NULL, 'Zapatos (Naranja)', 'zapatos-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-03 17:35:58', '2026-08-03 17:35:58'),
('4f100296-3f25-47cb-8ce6-30c8cb60efa8', NULL, 'Sandalias Diseño', 'sandalias-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-04 22:01:42', '2026-08-04 22:01:42'),
('4fdcd069-633a-42dc-9f8c-2c7af4931d39', NULL, 'Cinturon Diseño (Naranja)', 'cinturon-dise-o-naranja-', '-', '-', '-', NULL, 3.00, 5, 'cinturones', 1, 0, '2026-08-04 21:54:23', '2026-08-04 21:54:23'),
('4ff7c00b-c984-43d0-8a3c-6d1eab936907', NULL, 'Marcador (Verde)', 'marcador-verde-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 20:34:49', '2026-08-04 20:34:49'),
('50143ea8-6725-455c-91dd-16ab8b90a72b', NULL, 'Gorra Diseño (Negro)', 'gorra-dise-o-negro-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:30:45', '2026-08-03 17:30:45'),
('52222611-6c0c-4267-aedd-c43052cdae8c', NULL, 'Bóxer Diseño (Blanco)', 'b-xer-dise-o-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 20:58:45', '2026-08-04 20:58:45'),
('5396fd02-7a4e-4c14-bfbf-b05b89e3edc0', NULL, 'Mochila (Roja)', 'mochila-roja-', '----------------', '---------------------', '---------------------------', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-07-19 20:58:07', '2026-07-19 20:58:07'),
('563e57d3-e458-4971-a69d-83ce07da33e9', NULL, 'Vestido Diseño', 'vestido-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 14.00, 1, 'vestimenta', 1, 0, '2026-08-04 20:53:00', '2026-08-04 20:53:00'),
('56845b85-3802-446a-9b56-577d4c323ee3', NULL, 'Bóxer (Rojo)', 'b-xer-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"2\",\"largo\":\"5\"},\"30\":{\"cintura\":\"3\",\"largo\":\"6\"},\"32\":{\"cintura\":\"4\",\"largo\":\"7\"},\"34\":{\"cintura\":\"5\",\"largo\":\"8\"},\"36\":{\"cintura\":\"6\",\"largo\":\"9\"}}', 5.00, 1, 'interior', 1, 0, '2026-08-03 17:49:08', '2026-08-03 17:49:08'),
('5ad5c94e-def5-45e0-877d-d3cceef352a6', NULL, 'Sueter Diseño', 'sueter-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'accesorios', 1, 0, '2026-08-04 21:48:10', '2026-08-04 21:48:10'),
('5b379542-4c51-4605-bf07-a307d63dae1a', NULL, 'Zapatos Diseño (Naranja)', 'zapatos-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-04 20:55:52', '2026-08-04 20:55:52'),
('5db642fe-f806-4c5c-a52e-c1428ae1dbcf', NULL, 'Organizador Diseño 3', 'organizador-dise-o-3', '-', '-', '-', NULL, 3.00, 2, 'organizador', 1, 0, '2026-08-04 22:38:05', '2026-08-04 22:38:05'),
('5f9bd21b-7347-480e-9d5a-64985f738ebe', NULL, 'Cinturon (Blanco)', 'cinturon', '-', '-', '-', NULL, 5.00, 5, 'cinturones', 1, 0, '2026-08-04 20:27:29', '2026-08-04 21:18:28'),
('642ac18b-a895-4c0a-a5a1-fdf97de9cdf8', NULL, 'Borrador (Naranja)', 'borrador-naranja-', '-', '-', '-', NULL, 0.50, 2, 'escritura', 1, 0, '2026-08-04 21:56:14', '2026-08-04 21:56:14'),
('643a4d05-77d4-4461-b206-79e9bd415448', NULL, 'Polo (Blanco)', 'polo-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 20:54:01', '2026-08-04 20:54:01'),
('6b32a1c2-6f92-4574-833f-d2b65821e17a', NULL, 'FORRO DE CELULAR (Naranja)', 'forro-de-celular-naranja-', '----------', '---------------------', '---------------------------', NULL, 5.00, 5, 'forros', 1, 0, '2026-07-19 22:28:58', '2026-07-19 22:28:58'),
('6f4f0fda-d2c4-4c80-babb-d65d1098a28e', NULL, 'Cojín', 'coj-n', '-', '-', '-', NULL, 3.00, 3, 'sala', 1, 0, '2026-08-04 21:21:50', '2026-08-04 21:21:50'),
('702a379a-5abf-4114-8a0a-95825eac9af7', NULL, 'Tazón', 'taz-n', '-', '-', '-', NULL, 2.00, 3, 'cocina', 1, 0, '2026-08-04 20:26:06', '2026-08-04 20:26:06'),
('85308d07-3d88-42a8-9d5e-0f279a48105a', NULL, 'Sombrero (Naranja)', 'sombrero-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 22:04:25', '2026-08-04 22:04:25'),
('870ef8e6-38ca-44f9-be26-5a837e6a58e0', NULL, 'Organizador Diseño (Celeste)', 'organizador-dise-o-celeste-', '-', '-', '-', NULL, 3.00, 2, 'organizador', 1, 0, '2026-08-04 22:38:26', '2026-08-04 22:38:26'),
('87ceb74c-20b7-4ffe-a74e-d6667f3158bb', NULL, 'Jean Diseño 2', 'jean-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'pantalones', 1, 0, '2026-08-04 21:38:59', '2026-08-04 21:38:59'),
('8896976e-5971-4275-80d8-1d6a556ab999', NULL, 'Pluma Diseño 2', 'pluma-dise-o-2', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:39:20', '2026-08-04 22:39:20'),
('892794d2-42ac-4374-9d58-5cb6f993f2f7', NULL, 'Sombrero Diseño 2', 'sombrero-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 22:17:00', '2026-08-04 22:17:00'),
('8a8e6130-1fd0-497a-ab70-6739cc2d14d1', NULL, 'Cinturon Diseño', 'cinturon-dise-o', '-', '-', '-', NULL, 3.00, 5, 'cinturones', 1, 0, '2026-08-04 21:53:57', '2026-08-04 21:53:57'),
('8c9c8b66-c638-4152-8d65-f873168c0874', NULL, 'Gorra (Naraja)', 'gorra-naraja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:28:21', '2026-08-03 17:29:44'),
('8fa4713e-90ef-4a92-8490-07ba0b2b87a5', NULL, 'Cinturon (Rojo)', 'cinturon-rojo-', '-', '-', '-', NULL, 5.00, 5, 'cinturones', 1, 0, '2026-08-04 20:56:48', '2026-08-04 21:18:21'),
('9017eeef-d12b-4e98-bd6b-7d21025ce303', NULL, 'Cojín (Naranja)', 'coj-n-naranja-', '-', '-', '-', NULL, 3.00, 3, 'sala', 1, 0, '2026-08-04 22:10:58', '2026-08-04 22:10:58'),
('9223df29-691e-4d06-8188-456c514cdb4d', NULL, 'Sueter (Naranja)', 'sueter-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'accesorios', 1, 0, '2026-08-04 21:32:40', '2026-08-04 21:32:40'),
('942c044b-c4e0-4812-b11c-a18c5f8d4f45', NULL, 'TAZAS', 'tazas', '----------------------------------------------------------', '---------------------', '---------------------------', NULL, 4.00, 3, NULL, 1, 0, '2026-06-25 03:40:43', '2026-06-25 03:40:43'),
('96bf0cfe-072d-4942-8c75-d29e483924ae', NULL, 'Gorra Diseño (Naranja)', 'gorra-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 20:33:55', '2026-08-04 20:33:55'),
('978b0b4d-5767-4075-bec9-49a68b75b8ca', NULL, 'Zapatos (Blanco)', 'zapatos-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-03 17:34:48', '2026-08-03 17:34:48'),
('9b29d722-446a-4e8d-b5ba-2309c55334e1', NULL, 'Bikini Diseño 2', 'bikini-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 22:34:10', '2026-08-04 22:34:10'),
('9c605718-2871-45a6-a506-3550a9fb04d2', NULL, 'TAZA DE CAFÉ', 'taza-de-cafe-', '-----------------------------------------------------------------------', '---------------------', '---------------------------', NULL, 5.00, 3, NULL, 1, 0, '2026-06-25 03:38:26', '2026-06-25 03:38:26'),
('9d851f64-fa97-487b-93f0-71652b5510cc', NULL, 'Gorra Diseño (Amarillo)', 'gorra-dise-o-amarillo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:54:15', '2026-08-03 17:54:15'),
('9d9ca103-54ba-43e2-a482-f1996292af65', NULL, 'Bikini Diseño (Naranja)', 'bikini-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'interior', 1, 0, '2026-08-04 22:33:35', '2026-08-04 22:33:35'),
('a3c00857-c740-459e-9282-e6825378f36c', NULL, 'Calcetin Diseño (Naranja)', 'calcetin-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"5\",\"m2\":\"6\"},\"M\":{\"m1\":\"6\",\"m2\":\"7\"},\"L\":{\"m1\":\"7\",\"m2\":\"8\"},\"XL\":{\"m1\":\"8\",\"m2\":\"9\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-03 17:53:22', '2026-08-03 17:53:22'),
('a438271c-dc16-43be-90a5-f009fecc738e', NULL, 'Mochila', 'mochila', '-----------', 'Tela', '', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-07-19 20:48:23', '2026-07-19 20:48:23'),
('a559fa9f-31d0-4b69-840c-0e6353894968', NULL, 'Jean Diseño (Naranja)', 'jean-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'pantalones', 1, 0, '2026-08-04 21:05:13', '2026-08-04 21:05:13'),
('a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', NULL, 'Polo Diseño (Naranja)', 'polo-dise-o-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:22:48', '2026-08-04 22:22:48'),
('ac2271a9-c9c4-4c36-8ae1-c5d4f57d2262', NULL, 'Marcador Diseño (Amarillo)', 'marcador-dise-o-amarillo-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:01:02', '2026-08-04 22:01:02'),
('ac38d22c-8ee7-4b1b-8358-48cacca00bdf', NULL, 'Termo', 'termo', '---------', 'Metal', '---------------------------', NULL, 4.00, 5, 'otros', 1, 0, '2026-07-19 20:49:05', '2026-07-19 20:49:05'),
('acb0e7d2-bd26-4452-b61a-3309f7c357ac', NULL, 'Sombrero Diseño (Blanco)', 'sombrero-dise-o-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 21:44:46', '2026-08-04 21:44:46'),
('adb59b98-b707-46b8-85b1-6e3493b8993b', NULL, 'Zapatos Diseño (Rojo)', 'zapatos-dise-o-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-04 22:26:54', '2026-08-04 22:26:54'),
('af23a140-bcf6-430a-9c14-0aff74b8c44c', NULL, 'Calcetin (Rojo)', 'calcetin', '--', 'Porcelana', '', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 3.00, 1, 'calzado', 1, 0, '2026-08-03 17:19:40', '2026-08-04 20:20:33'),
('af3554c6-8efb-440a-83ba-0278693f9cab', NULL, 'Gorra Diseño (Blanco)', 'gorra-dise-o-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 20:33:07', '2026-08-04 20:33:07'),
('afc01428-f9fb-4146-9cd8-67dbf89edb14', NULL, 'Bikini (Naranja)', 'bikini-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 22:29:00', '2026-08-04 22:29:00'),
('b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', NULL, 'Polo Diseño (Rojo)', 'polo-dise-o-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:20:57', '2026-08-04 22:20:57'),
('b59aafae-6d05-4f26-9740-5fa364c93f8d', NULL, 'Tazón (Rojo)', 'taz-n-rojo-', '-', '-', '-', NULL, 5.00, 3, 'cocina', 1, 0, '2026-08-04 21:00:44', '2026-08-04 21:00:44'),
('b78b35d9-2bf8-4090-af6d-60923d44ce39', NULL, 'BOLSO TOTE (BLANCO)', 'bolso-tote-blanco-', '--------------', '---------------------', '---------------------------', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-07-19 20:56:50', '2026-07-19 20:56:50'),
('b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', NULL, 'Zapatos Diseño', 'zapatos-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-03 17:36:54', '2026-08-03 17:36:54'),
('b97b0566-2576-4475-acb2-d081dbb5fd7e', NULL, 'Mochila (Negra)', 'mochila-negra-', '------------', '---------------------', '---------------------------', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-07-19 20:55:17', '2026-07-19 20:55:17'),
('ba723b62-dff8-4480-9229-a01d963c7171', NULL, 'Mochila (Naranja)', 'mochila-naranja-', '------------', '---------------------', '---------------------------', NULL, 20.00, 5, 'bolsos', 1, 0, '2026-07-19 21:02:02', '2026-07-22 02:20:02'),
('bf7cd869-0804-4fc5-b0b5-f0334db7aae7', NULL, 'Zapatos Diseño 2', 'zapatos-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-04 21:33:39', '2026-08-04 21:33:39'),
('c541a995-dd76-4d9a-90de-55a9d26d6a20', NULL, 'Pluma Naranja', 'pluma-naranja', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 22:17:48', '2026-08-04 22:17:48'),
('c58490a0-20db-4281-8818-e9be64097858', NULL, 'Interior (Naranja)', 'interior-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 21:52:42', '2026-08-04 21:52:42'),
('c6b9b46a-6054-4517-8374-262bd553b62f', NULL, 'Pluma Diseño (Rojo)', 'pluma-dise-o-rojo-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 21:31:07', '2026-08-04 21:31:07'),
('ceaf751c-821d-44b6-845f-68b2a907bbb6', NULL, 'Zapatos Diseño 3', 'zapatos-dise-o-3', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 20.00, 1, 'calzado', 1, 0, '2026-08-04 21:55:39', '2026-08-04 21:55:39'),
('d01d9652-66b8-4737-9a8a-686fa2352891', NULL, 'Bolso', 'bolso', '', 'Porcelana', '---------------------------', NULL, 5.00, 5, 'bolsos', 1, 0, '2026-08-03 17:13:35', '2026-08-03 17:13:35'),
('d2024cef-5dec-42e8-89ec-6a350a026742', NULL, 'CAMISA ama', 'camisa-ama', '--------------------------------------------------------------------------------------------------------------------------------------', 'Porcelana', '---------------------------', '{\"S\":{\"m1\":\"5\",\"m2\":\"4\"},\"M\":{\"m1\":\"6\",\"m2\":\"6\"},\"L\":{\"m1\":\"7\",\"m2\":\"7\"},\"XL\":{\"m1\":\"8\",\"m2\":\"8\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'vestimenta', 1, 0, '2026-06-25 02:43:32', '2026-07-19 20:35:45'),
('d2263ca3-b76d-46c4-8119-8d97a7510436', NULL, 'Jean Diseño 3', 'jean-dise-o-3', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'pantalones', 1, 0, '2026-08-04 21:40:01', '2026-08-04 21:40:01'),
('d3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', NULL, 'Vestido (Rojo)', 'vestido-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 14.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:05:10', '2026-08-04 22:05:10'),
('d45484ec-87ab-4a0a-ab4a-9cb23016c363', NULL, 'Sandalias (Rojo)', 'sandalias-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-04 22:14:05', '2026-08-04 22:14:05'),
('d9d93671-c7be-4edd-9388-66fa9feb1fb6', NULL, 'Polo Diseño ', 'polo-dise-o-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:19:16', '2026-08-04 22:19:16'),
('da763043-589d-4820-a826-934f4ce479af', NULL, 'Marcador (Rojo)', 'marcador-rojo-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 20:35:57', '2026-08-04 20:35:57'),
('dda40585-91e2-4855-bb7e-3e8eb6935cb2', NULL, 'Toalla', 'toalla', '-', '-', '-', NULL, 8.00, 3, 'baño', 1, 0, '2026-08-04 20:23:44', '2026-08-04 20:23:44'),
('dddea19b-9787-44e5-96d4-cd28c94dc255', NULL, 'Jean Diseño (Rojo)', 'jean-dise-o-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'pantalones', 1, 0, '2026-08-04 21:39:38', '2026-08-04 21:39:38'),
('de28cdb9-03a3-4476-809c-49db7635b0b2', NULL, 'Sombrero (Cyan)', 'sombrero-cyan-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:33:32', '2026-08-03 17:33:32'),
('df1092ca-5732-4b4c-bea4-3f1994eb6856', NULL, 'Borrador (Blanco)', 'borrador-blanco-', '-', '-', '-', NULL, 0.50, 2, 'escritura', 1, 0, '2026-08-04 22:30:33', '2026-08-04 22:30:33'),
('e0bcee6b-b5b3-4b65-9ccc-61aae229936c', NULL, 'Marcador (Naranja)', 'marcador-naranja-', '-', '-', '-', NULL, 1.00, 2, 'escritura', 1, 0, '2026-08-04 20:35:34', '2026-08-04 20:35:34'),
('e375d378-99da-474c-b907-ba64eb95ac0e', NULL, 'Bóxer Diseño (Rojo)', 'b-xer-dise-o-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 21:35:02', '2026-08-04 21:35:02'),
('e4c83b4a-1ab5-4804-97d0-3d67bf4dea89', NULL, 'Tazón (Naranja)', 'taz-n-naranja-', '-', '-', '-', NULL, 2.00, 3, 'cocina', 1, 0, '2026-08-04 20:30:48', '2026-08-04 20:30:48'),
('e66e0b61-15f7-4bdf-9d4f-d39285176006', NULL, 'Cinturon (Naranja)', 'cinturon-naranja-', '-', '-', '-', NULL, 3.00, 5, 'cinturones', 1, 0, '2026-08-04 21:34:14', '2026-08-04 21:34:14'),
('e7f5849b-8960-4504-b9f8-04af307b8199', NULL, 'Sandalias (Naranja)', 'sandalias-naranja-', '-', '-', '38', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-03 17:23:53', '2026-08-03 17:23:53'),
('e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', NULL, 'Bikini Diseño', 'bikini-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'interior', 1, 0, '2026-08-04 22:32:43', '2026-08-04 22:32:43'),
('ead2f1bc-ba66-4d55-b420-182018db35c4', NULL, 'Borrador', 'borrador', '-', '-', '-', NULL, 0.50, 2, 'escritura', 1, 0, '2026-08-04 21:37:10', '2026-08-04 21:37:10'),
('ec54c48d-dac0-491e-a813-24860028c62e', NULL, 'Gorra Diseño', 'gorra-dise-o', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 21:01:32', '2026-08-04 21:01:32'),
('ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', NULL, 'Polo Diseño 2', 'polo-dise-o-2', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'vestimenta', 1, 0, '2026-08-04 22:07:23', '2026-08-04 22:07:23'),
('edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', NULL, 'Sueter (Rojo)', 'sueter-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 10.00, 1, 'accesorios', 1, 0, '2026-08-04 21:47:02', '2026-08-04 21:47:02'),
('ee67a570-74bd-4e7c-8e1e-568af4d07f4d', NULL, 'Gorra (Blanca)', 'gorra-blanca-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-03 17:22:49', '2026-08-03 17:29:53'),
('ef1da512-7f70-415c-bb29-6ffb4585824b', NULL, 'Borrador (Rojo)', 'borrador-rojo-', '-', '-', '-', NULL, 0.50, 2, 'escritura', 1, 0, '2026-08-04 20:29:16', '2026-08-04 20:29:16'),
('f070ad64-a3cb-4684-bc43-c360fe233c29', NULL, 'Cojín Diseño', 'coj-n-dise-o', '-', '-', '-', NULL, 3.00, 3, 'sala', 1, 0, '2026-08-04 22:10:23', '2026-08-04 22:10:23'),
('f3a99e28-9629-4652-b7fa-f5d76e97d897', NULL, 'Interior (Blanco)', 'interior-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 21:53:23', '2026-08-04 21:53:23'),
('f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', NULL, 'Sandalias (Blanco)', 'sandalias-blanco-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'calzado', 1, 0, '2026-08-04 20:51:24', '2026-08-04 20:51:24'),
('faea617d-7bf6-4ecc-b89c-753be8496be7', NULL, 'Interior (Rojo)', 'interior-rojo-', '-', '-', '-', '{\"S\":{\"m1\":\"34\",\"m2\":\"30\"},\"M\":{\"m1\":\"36\",\"m2\":\"32\"},\"L\":{\"m1\":\"38\",\"m2\":\"34\"},\"XL\":{\"m1\":\"40\",\"m2\":\"36\"},\"28\":{\"cintura\":\"60\",\"largo\":\"66\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Cadera (cm)\",\"Cintura (cm)\"]}', 4.00, 1, 'interior', 1, 0, '2026-08-04 20:18:13', '2026-08-04 20:18:13'),
('fc49b184-d85d-4e62-8c37-c63b2e1e3720', NULL, 'Gorra Diseño (Verde)', 'gorra-dise-o-verde-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"}}', 5.00, 1, 'accesorios', 1, 0, '2026-08-04 21:38:19', '2026-08-04 21:38:19'),
('fe99dd2b-adef-4808-9abe-346a61aafb8f', NULL, 'Bóxer (Naranja)', 'b-xer-naranja-', '-', '-', '-', '{\"S\":{\"m1\":\"\",\"m2\":\"\"},\"M\":{\"m1\":\"\",\"m2\":\"\"},\"L\":{\"m1\":\"\",\"m2\":\"\"},\"XL\":{\"m1\":\"\",\"m2\":\"\"},\"28\":{\"cintura\":\"\",\"largo\":\"\"},\"30\":{\"cintura\":\"\",\"largo\":\"\"},\"32\":{\"cintura\":\"\",\"largo\":\"\"},\"34\":{\"cintura\":\"\",\"largo\":\"\"},\"36\":{\"cintura\":\"\",\"largo\":\"\"},\"nombres\":[\"Ancho (cm)\",\"Largo (cm)\"]}', 5.00, 1, 'interior', 1, 0, '2026-08-04 20:58:02', '2026-08-04 20:58:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `uuid` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `nombres` varchar(150) NOT NULL,
  `apellidos` varchar(150) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
  `estado_cuenta` enum('NO_CREADA','CREADA','BLOQUEADA') NOT NULL DEFAULT 'NO_CREADA',
  `telefono` varchar(30) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `recuperacion_token` varchar(10) DEFAULT NULL,
  `recuperacion_expira` datetime DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `uuid`, `cedula`, `nombres`, `apellidos`, `email`, `password_hash`, `role`, `estado_cuenta`, `telefono`, `provincia`, `ciudad`, `fecha_nacimiento`, `recuperacion_token`, `recuperacion_expira`, `creado_en`, `actualizado_en`) VALUES
(1, 'f71e6f34-68e7-11f1-a65b-0a0027000028', NULL, 'Ceress', 'Admin', 'thepinwin79@gmail.com', 'CAMBIAR_LUEGO', 'ADMIN', 'CREADA', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-15 18:28:11', '2026-06-15 18:28:11'),
(2, 'f71f7e2e-68e7-11f1-a65b-0a0027000028', NULL, 'DUDU', '', 'msornoza7034@utm.edu.ec', '$2y$10$Uz8GCOBx5CSgkCw.TRjPYe8pg2pAX3dPMlpHKTzDmTaU0HZItz6LS', 'ADMIN', 'CREADA', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-15 18:28:11', '2026-06-15 18:28:11'),
(3, 'b7d7467d-68ed-11f1-beb8-0a0027000028', NULL, 'Jose', 'Navarrete', 'jnavarrete8251@utm.edu.ec', '$2y$10$AQgbCOVY8psTJ8ZMqHrjxevyjwMsWLWbe47kcn.JGyKL.T6hXEq/O', 'ADMIN', 'CREADA', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-15 19:09:22', '2026-06-15 19:09:22'),
(4, '0cee7773-876e-11f1-9d08-0a002700000d', NULL, 'Jose', 'Navarrete', 'ramonjose928@gmail.com', '$2y$10$dYxvxNiH8poulcbG3QXbvOm2QdwkwIzunVKe.ciUwiouAkcunsSr6', 'USER', 'CREADA', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-24 14:43:35', '2026-07-24 14:43:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variantes`
--

CREATE TABLE `variantes` (
  `id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `producto_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `talla` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `variantes`
--

INSERT INTO `variantes` (`id`, `producto_id`, `talla`, `stock`) VALUES
('0503d979-904c-11f1-9ffd-0a002700000d', '9223df29-691e-4d06-8188-456c514cdb4d', 'S', 10),
('05040084-904c-11f1-9ffd-0a002700000d', '9223df29-691e-4d06-8188-456c514cdb4d', 'M', 10),
('05043f5a-904c-11f1-9ffd-0a002700000d', '9223df29-691e-4d06-8188-456c514cdb4d', 'L', 10),
('05047794-904c-11f1-9ffd-0a002700000d', '9223df29-691e-4d06-8188-456c514cdb4d', 'XL', 10),
('05891bf3-904a-11f1-9ffd-0a002700000d', '8fa4713e-90ef-4a92-8490-07ba0b2b87a5', 'ÚNICA', 20),
('0650dfe1-9053-11f1-9ffd-0a002700000d', 'a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', 'S', 20),
('06513dbd-9053-11f1-9ffd-0a002700000d', 'a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', 'M', 2),
('06517b78-9053-11f1-9ffd-0a002700000d', 'a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', 'L', 20),
('0651aa0b-9053-11f1-9ffd-0a002700000d', 'a5c9f8c1-d4f3-4f93-b31b-19b2083264a7', 'XL', 2),
('094d28dd-904a-11f1-9ffd-0a002700000d', '5f9bd21b-7347-480e-9d5a-64985f738ebe', 'ÚNICA', 19),
('0ac3d71d-9051-11f1-9ffd-0a002700000d', '2dcc5728-5066-458d-aabd-284d16fe7bb9', 'S', 20),
('0ac450f6-9051-11f1-9ffd-0a002700000d', '2dcc5728-5066-458d-aabd-284d16fe7bb9', 'M', 2),
('0ac478db-9051-11f1-9ffd-0a002700000d', '2dcc5728-5066-458d-aabd-284d16fe7bb9', 'L', 2),
('0ac4a1a2-9051-11f1-9ffd-0a002700000d', '2dcc5728-5066-458d-aabd-284d16fe7bb9', 'XL', 20),
('0b812979-9044-11f1-9ffd-0a002700000d', 'e0bcee6b-b5b3-4b65-9ccc-61aae229936c', 'ÚNICA', 10),
('0c679c66-904d-11f1-9ffd-0a002700000d', 'd2263ca3-b76d-46c4-8119-8d97a7510436', '28', 10),
('0c680097-904d-11f1-9ffd-0a002700000d', 'd2263ca3-b76d-46c4-8119-8d97a7510436', '30', 10),
('0c682888-904d-11f1-9ffd-0a002700000d', 'd2263ca3-b76d-46c4-8119-8d97a7510436', '32', 10),
('0c684ee9-904d-11f1-9ffd-0a002700000d', 'd2263ca3-b76d-46c4-8119-8d97a7510436', '34', 10),
('0c687711-904d-11f1-9ffd-0a002700000d', 'd2263ca3-b76d-46c4-8119-8d97a7510436', '36', 10),
('0d8a4e9c-9055-11f1-9ffd-0a002700000d', '24471ffb-7af2-4325-9b51-9c171eea21dc', 'ÚNICA', 20),
('0dae565e-904f-11f1-9ffd-0a002700000d', '4fdcd069-633a-42dc-9f8c-2c7af4931d39', 'ÚNICA', 10),
('0f4473a9-8f61-11f1-a80c-0a002700000d', '50143ea8-6725-455c-91dd-16ab8b90a72b', 'ÚNICA', 10),
('1355a98c-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '38', 10),
('1355e328-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '39', 10),
('13562a14-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '40', 1),
('13567734-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '41', 10),
('1356bcca-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '42', 1),
('1356f18c-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '43', 10),
('13572563-9050-11f1-9ffd-0a002700000d', '4f100296-3f25-47cb-8ce6-30c8cb60efa8', '44', 10),
('15f3c6fe-904e-11f1-9ffd-0a002700000d', 'edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', 'S', 10),
('15f425bb-904e-11f1-9ffd-0a002700000d', 'edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', 'M', 10),
('15f478e5-904e-11f1-9ffd-0a002700000d', 'edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', 'L', 10),
('15f4b295-904e-11f1-9ffd-0a002700000d', 'edc2c4b3-e30e-4d3b-b1e0-62a58b220f91', 'XL', 10),
('1845ab6b-9046-11f1-9ffd-0a002700000d', '40c55268-0784-4615-9b37-d9b1e40f6bc8', 'S', 10),
('184611ea-9046-11f1-9ffd-0a002700000d', '40c55268-0784-4615-9b37-d9b1e40f6bc8', 'M', 10),
('184658ae-9046-11f1-9ffd-0a002700000d', '40c55268-0784-4615-9b37-d9b1e40f6bc8', 'L', 10),
('184693c7-9046-11f1-9ffd-0a002700000d', '40c55268-0784-4615-9b37-d9b1e40f6bc8', 'XL', 10),
('18636ddb-9051-11f1-9ffd-0a002700000d', '12b9b863-0859-4370-a904-bf1ef2017765', 'ÚNICA', 10),
('19359478-9044-11f1-9ffd-0a002700000d', 'da763043-589d-4820-a826-934f4ce479af', 'ÚNICA', 30),
('1985e4a8-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '38', 10),
('1986e48f-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '39', 10),
('19879b4a-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '40', 10),
('1987fb7c-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '41', 10),
('198861be-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '42', 10),
('1988f251-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '43', 10),
('19896fed-8f60-11f1-a80c-0a002700000d', 'e7f5849b-8960-4504-b9f8-04af307b8199', '44', 10),
('1bade3f2-9054-11f1-9ffd-0a002700000d', 'df1092ca-5732-4b4c-bea4-3f1994eb6856', 'ÚNICA', 20),
('25eda513-83b4-11f1-aeec-0a002700000d', 'b97b0566-2576-4475-acb2-d081dbb5fd7e', 'ÚNICA', 5),
('2851d248-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '38', 1),
('2851fc0f-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '39', 1),
('28527ff2-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '40', 1),
('2852cd73-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '41', 1),
('28530c15-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '42', 10),
('28533d40-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '43', 10),
('285370ac-904c-11f1-9ffd-0a002700000d', 'bf7cd869-0804-4fc5-b0b5-f0334db7aae7', '44', 1),
('28f47e92-9055-11f1-9ffd-0a002700000d', '5db642fe-f806-4c5c-a52e-c1428ae1dbcf', 'ÚNICA', 15),
('29f550f5-9054-11f1-9ffd-0a002700000d', '278ef192-3226-4647-9f56-3575427f4963', 'ÚNICA', 2),
('2a22d35c-9043-11f1-9ffd-0a002700000d', 'ef1da512-7f70-415c-bb29-6ffb4585824b', 'ÚNICA', 50),
('2ea6a999-9047-11f1-9ffd-0a002700000d', 'fe99dd2b-adef-4808-9abe-346a61aafb8f', 'S', 10),
('2ea71a95-9047-11f1-9ffd-0a002700000d', 'fe99dd2b-adef-4808-9abe-346a61aafb8f', 'M', 10),
('2ea75ac2-9047-11f1-9ffd-0a002700000d', 'fe99dd2b-adef-4808-9abe-346a61aafb8f', 'L', 10),
('2ea7ab49-9047-11f1-9ffd-0a002700000d', 'fe99dd2b-adef-4808-9abe-346a61aafb8f', 'XL', 10),
('2ebb2bd9-83b3-11f1-aeec-0a002700000d', 'a438271c-dc16-43be-90a5-f009fecc738e', 'ÚNICA', 5),
('2f9ec970-904e-11f1-9ffd-0a002700000d', '5ad5c94e-def5-45e0-877d-d3cceef352a6', 'S', 10),
('2f9efa78-904e-11f1-9ffd-0a002700000d', '5ad5c94e-def5-45e0-877d-d3cceef352a6', 'M', 10),
('2f9f5966-904e-11f1-9ffd-0a002700000d', '5ad5c94e-def5-45e0-877d-d3cceef352a6', 'L', 10),
('2f9f9b1f-904e-11f1-9ffd-0a002700000d', '5ad5c94e-def5-45e0-877d-d3cceef352a6', 'XL', 10),
('2fb13693-9048-11f1-9ffd-0a002700000d', 'a559fa9f-31d0-4b69-840c-0e6353894968', '28', 10),
('2fb1ae97-9048-11f1-9ffd-0a002700000d', 'a559fa9f-31d0-4b69-840c-0e6353894968', '30', 10),
('2fb1e764-9048-11f1-9ffd-0a002700000d', 'a559fa9f-31d0-4b69-840c-0e6353894968', '32', 10),
('2fb22190-9048-11f1-9ffd-0a002700000d', 'a559fa9f-31d0-4b69-840c-0e6353894968', '34', 10),
('2fb254f1-9048-11f1-9ffd-0a002700000d', 'a559fa9f-31d0-4b69-840c-0e6353894968', '36', 10),
('3592d52f-9055-11f1-9ffd-0a002700000d', '870ef8e6-38ca-44f9-be26-5a837e6a58e0', 'ÚNICA', 10),
('36b8671b-9052-11f1-9ffd-0a002700000d', '892794d2-42ac-4374-9d58-5cb6f993f2f7', 'ÚNICA', 10),
('36b8db71-9051-11f1-9ffd-0a002700000d', '0574113f-1a00-4c89-99e7-b2418d043470', 'S', 10),
('36b91bd3-9051-11f1-9ffd-0a002700000d', '0574113f-1a00-4c89-99e7-b2418d043470', 'M', 10),
('36b96b4c-9051-11f1-9ffd-0a002700000d', '0574113f-1a00-4c89-99e7-b2418d043470', 'L', 10),
('36b9c6b8-9051-11f1-9ffd-0a002700000d', '0574113f-1a00-4c89-99e7-b2418d043470', 'XL', 10),
('382c3738-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '38', 10),
('382c5f19-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '39', 10),
('382c8cce-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '40', 10),
('382cb9e3-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '41', 10),
('382d0180-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '42', 10),
('382d4ed5-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '43', 10),
('382d786d-8f64-11f1-a80c-0a002700000d', 'a3c00857-c740-459e-9282-e6825378f36c', '44', 10),
('3b542531-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '38', 10),
('3b5457c3-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '39', 1),
('3b54a861-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '40', 10),
('3b54f9b2-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '41', 10),
('3b553261-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '42', 1),
('3b55677d-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '43', 10),
('3b55a71b-904f-11f1-9ffd-0a002700000d', 'ceaf751c-821d-44b6-845f-68b2a907bbb6', '44', 10),
('3c1f5f61-83c1-11f1-aeec-0a002700000d', '6b32a1c2-6f92-4574-833f-d2b65821e17a', 'ÚNICA', 10),
('3d909d5e-904c-11f1-9ffd-0a002700000d', 'e66e0b61-15f7-4bdf-9d4f-d39285176006', 'ÚNICA', 50),
('415c8ec2-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '38', 10),
('415cfc9a-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '39', 10),
('415d6209-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '40', 10),
('415daec6-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '41', 10),
('415e0a5e-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '42', 10),
('415e7154-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '43', 10),
('415eb332-9046-11f1-9ffd-0a002700000d', 'f4301d5d-7a9b-4ebb-a9c5-550f00dc0f66', '44', 10),
('447ec761-9a74-11f1-8833-0a002700000d', '9d9ca103-54ba-43e2-a482-f1996292af65', 'S', 10),
('448018ae-9a74-11f1-8833-0a002700000d', '9d9ca103-54ba-43e2-a482-f1996292af65', 'M', 10),
('44807e05-9a74-11f1-8833-0a002700000d', '9d9ca103-54ba-43e2-a482-f1996292af65', 'L', 10),
('4480c8fb-9a74-11f1-8833-0a002700000d', '9d9ca103-54ba-43e2-a482-f1996292af65', 'XL', 10),
('45433336-9048-11f1-9ffd-0a002700000d', '4c826e64-f706-4e53-842a-700c5d0ed2f8', '28', 10),
('4543a6a5-9048-11f1-9ffd-0a002700000d', '4c826e64-f706-4e53-842a-700c5d0ed2f8', '30', 10),
('454445b4-9048-11f1-9ffd-0a002700000d', '4c826e64-f706-4e53-842a-700c5d0ed2f8', '32', 10),
('4544af19-9048-11f1-9ffd-0a002700000d', '4c826e64-f706-4e53-842a-700c5d0ed2f8', '34', 10),
('4544e738-9048-11f1-9ffd-0a002700000d', '4c826e64-f706-4e53-842a-700c5d0ed2f8', '36', 10),
('47e809b3-83b3-11f1-aeec-0a002700000d', 'ac38d22c-8ee7-4b1b-8358-48cacca00bdf', 'ÚNICA', 7),
('483032a5-9047-11f1-9ffd-0a002700000d', '52222611-6c0c-4267-aedd-c43052cdae8c', 'S', 10),
('48307076-9047-11f1-9ffd-0a002700000d', '52222611-6c0c-4267-aedd-c43052cdae8c', 'M', 10),
('4830ea81-9047-11f1-9ffd-0a002700000d', '52222611-6c0c-4267-aedd-c43052cdae8c', 'L', 10),
('4831157c-9047-11f1-9ffd-0a002700000d', '52222611-6c0c-4267-aedd-c43052cdae8c', 'XL', 10),
('4a202ba0-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '38', 10),
('4a2063b8-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '39', 10),
('4a2094c6-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '40', 10),
('4a20f967-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '41', 10),
('4a214bad-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '42', 10),
('4a217f3d-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '43', 10),
('4a21b71e-9050-11f1-9ffd-0a002700000d', '0cf34e99-1c1f-4ea4-81bd-65167a44a6df', '44', 10),
('4a6664ad-9051-11f1-9ffd-0a002700000d', 'f070ad64-a3cb-4684-bc43-c360fe233c29', 'ÚNICA', 10),
('5064e28d-904f-11f1-9ffd-0a002700000d', '642ac18b-a895-4c0a-a5a1-fdf97de9cdf8', 'ÚNICA', 40),
('532565ac-7047-11f1-be2b-0a0027000028', '9c605718-2871-45a6-a506-3550a9fb04d2', 'ÚNICA', 5),
('53285622-9052-11f1-9ffd-0a002700000d', 'c541a995-dd76-4d9a-90de-55a9d26d6a20', 'ÚNICA', 10),
('54edae2f-9053-11f1-9ffd-0a002700000d', '3d155bff-3c63-40b9-a3b1-718f306d1709', 'ÚNICA', 21),
('554ece23-9055-11f1-9ffd-0a002700000d', '8896976e-5971-4275-80d8-1d6a556ab999', 'ÚNICA', 20),
('57bf4a30-8f64-11f1-a80c-0a002700000d', '9d851f64-fa97-487b-93f0-71652b5510cc', 'ÚNICA', 15),
('59f44c26-904c-11f1-9ffd-0a002700000d', 'e375d378-99da-474c-b907-ba64eb95ac0e', 'S', 10),
('59f47fdc-904c-11f1-9ffd-0a002700000d', 'e375d378-99da-474c-b907-ba64eb95ac0e', 'M', 10),
('59f4a707-904c-11f1-9ffd-0a002700000d', 'e375d378-99da-474c-b907-ba64eb95ac0e', 'L', 10),
('59f4ccc0-904c-11f1-9ffd-0a002700000d', 'e375d378-99da-474c-b907-ba64eb95ac0e', 'XL', 10),
('5d361951-83b4-11f1-aeec-0a002700000d', 'b78b35d9-2bf8-4090-af6d-60923d44ce39', 'ÚNICA', 10),
('5e1dc0c5-9052-11f1-9ffd-0a002700000d', '4013d611-3f3c-4ad9-85c6-b5be6903cbc5', 'ÚNICA', 20),
('5e89ff60-904e-11f1-9ffd-0a002700000d', '0915c030-b8f7-41e1-bbfe-5773cdf0f17f', 'S', 10),
('5e8a4374-904e-11f1-9ffd-0a002700000d', '0915c030-b8f7-41e1-bbfe-5773cdf0f17f', 'M', 10),
('5e8a9c86-904e-11f1-9ffd-0a002700000d', '0915c030-b8f7-41e1-bbfe-5773cdf0f17f', 'L', 10),
('5e8aecd8-904e-11f1-9ffd-0a002700000d', '0915c030-b8f7-41e1-bbfe-5773cdf0f17f', 'XL', 10),
('5f3bf5e7-9051-11f1-9ffd-0a002700000d', '9017eeef-d12b-4e98-bd6b-7d21025ce303', 'ÚNICA', 20),
('60a586d8-9043-11f1-9ffd-0a002700000d', 'e4c83b4a-1ab5-4804-97d0-3d67bf4dea89', 'ÚNICA', 20),
('638a4866-9055-11f1-9ffd-0a002700000d', '184edb2e-37f0-43e1-9a40-a0be2b707dc9', 'ÚNICA', 20),
('63f2f217-9047-11f1-9ffd-0a002700000d', '27b1d566-65db-4e44-8c8d-85fb1a28d1f9', 'S', 10),
('63f3376a-9047-11f1-9ffd-0a002700000d', '27b1d566-65db-4e44-8c8d-85fb1a28d1f9', 'M', 10),
('63f38d03-9047-11f1-9ffd-0a002700000d', '27b1d566-65db-4e44-8c8d-85fb1a28d1f9', 'L', 10),
('63f3c43b-9047-11f1-9ffd-0a002700000d', '27b1d566-65db-4e44-8c8d-85fb1a28d1f9', 'XL', 10),
('641351d0-9042-11f1-9ffd-0a002700000d', 'dda40585-91e2-4855-bb7e-3e8eb6935cb2', 'ÚNICA', 25),
('68d581f9-83b3-11f1-aeec-0a002700000d', '230df793-1464-4d83-821c-1f2b0ab8a6e5', 'ÚNICA', 7),
('6aefcd1a-83b1-11f1-aeec-0a002700000d', 'd2024cef-5dec-42e8-89ec-6a350a026742', 'S', 5),
('6af084c4-83b1-11f1-aeec-0a002700000d', 'd2024cef-5dec-42e8-89ec-6a350a026742', 'M', 4),
('6af0dab7-83b1-11f1-aeec-0a002700000d', 'd2024cef-5dec-42e8-89ec-6a350a026742', 'L', 4),
('6af11948-83b1-11f1-aeec-0a002700000d', 'd2024cef-5dec-42e8-89ec-6a350a026742', 'XL', 0),
('711e24b9-9054-11f1-9ffd-0a002700000d', 'e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', 'S', 10),
('711e645f-9054-11f1-9ffd-0a002700000d', 'e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', 'M', 10),
('711eb0c8-9054-11f1-9ffd-0a002700000d', 'e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', 'L', 10),
('711ef990-9054-11f1-9ffd-0a002700000d', 'e9180bfe-1ea0-4e9d-ba53-8a53eea83dc4', 'XL', 1),
('72a2acff-8f61-11f1-a80c-0a002700000d', 'de28cdb9-03a3-4476-809c-49db7635b0b2', 'ÚNICA', 10),
('73969fc9-9055-11f1-9ffd-0a002700000d', '4c44f76b-4f5a-4d57-849a-214cfb2398d8', 'ÚNICA', 10),
('749ac375-9050-11f1-9ffd-0a002700000d', '85308d07-3d88-42a8-9d5e-0f279a48105a', 'ÚNICA', 10),
('75d0e2cd-904f-11f1-9ffd-0a002700000d', '153daf91-d453-461f-aaf6-b9a406eea824', 'ÚNICA', 20),
('7ae19b8a-9046-11f1-9ffd-0a002700000d', '563e57d3-e458-4971-a69d-83ce07da33e9', 'S', 10),
('7ae1e6d2-9046-11f1-9ffd-0a002700000d', '563e57d3-e458-4971-a69d-83ce07da33e9', 'M', 10),
('7ae22e04-9046-11f1-9ffd-0a002700000d', '563e57d3-e458-4971-a69d-83ce07da33e9', 'L', 10),
('7ae25d9d-9046-11f1-9ffd-0a002700000d', '563e57d3-e458-4971-a69d-83ce07da33e9', 'XL', 10),
('7ee939a8-904c-11f1-9ffd-0a002700000d', '2eec60ba-6dd8-46e0-8024-62cfff9a6017', 'S', 10),
('7ee967c5-904c-11f1-9ffd-0a002700000d', '2eec60ba-6dd8-46e0-8024-62cfff9a6017', 'M', 10),
('7ee9afdf-904c-11f1-9ffd-0a002700000d', '2eec60ba-6dd8-46e0-8024-62cfff9a6017', 'L', 10),
('7ee9fa5c-904c-11f1-9ffd-0a002700000d', '2eec60ba-6dd8-46e0-8024-62cfff9a6017', 'XL', 10),
('82088fd1-904a-11f1-9ffd-0a002700000d', '6f4f0fda-d2c4-4c80-babb-d65d1098a28e', 'ÚNICA', 50),
('826b0c80-9051-11f1-9ffd-0a002700000d', '2307e893-a3e3-4c5d-bbed-4139bbd72f57', 'ÚNICA', 10),
('836df811-9047-11f1-9ffd-0a002700000d', '04512eaf-af7e-415c-b238-a21eff90bf64', 'ÚNICA', 20),
('87c1196a-9052-11f1-9ffd-0a002700000d', 'd9d93671-c7be-4edd-9388-66fa9feb1fb6', 'S', 10),
('87c13e57-9052-11f1-9ffd-0a002700000d', 'd9d93671-c7be-4edd-9388-66fa9feb1fb6', 'M', 10),
('87c170ce-9052-11f1-9ffd-0a002700000d', 'd9d93671-c7be-4edd-9388-66fa9feb1fb6', 'L', 10),
('87c19964-9052-11f1-9ffd-0a002700000d', 'd9d93671-c7be-4edd-9388-66fa9feb1fb6', 'XL', 10),
('8b32a03c-83b4-11f1-aeec-0a002700000d', '5396fd02-7a4e-4c14-bfbf-b05b89e3edc0', 'ÚNICA', 20),
('8de2cb5b-904d-11f1-9ffd-0a002700000d', '20a72eba-a2cb-49c4-8af2-b73f6c125e92', 'ÚNICA', 11),
('8f6b225a-9047-11f1-9ffd-0a002700000d', 'b59aafae-6d05-4f26-9740-5fa364c93f8d', 'ÚNICA', 10),
('8fa104fd-9050-11f1-9ffd-0a002700000d', 'd3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', 'S', 10),
('8fa13255-9050-11f1-9ffd-0a002700000d', 'd3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', 'M', 10),
('8fa15f78-9050-11f1-9ffd-0a002700000d', 'd3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', 'L', 10),
('8fa188ff-9050-11f1-9ffd-0a002700000d', 'd3c1c5b9-71b6-4251-9cd3-ae4e5c7f83e1', 'XL', 20),
('96aa17e0-9043-11f1-9ffd-0a002700000d', '37320382-9645-40c6-bc85-11cc5b7a741d', 'ÚNICA', 20),
('98d42617-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '38', 10),
('98d4a8f2-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '39', 10),
('98d50b48-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '40', 10),
('98d572a6-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '41', 10),
('98d5f710-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '42', 10),
('98d64a10-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '43', 10),
('98d6a5a3-9053-11f1-9ffd-0a002700000d', 'adb59b98-b707-46b8-85b1-6e3493b8993b', '44', 10),
('9ac1635f-83b1-11f1-aeec-0a002700000d', '1c2f6a14-7776-4e4d-8789-711e417c254b', 'ÚNICA', 10),
('9cdcf494-9054-11f1-9ffd-0a002700000d', '9b29d722-446a-4e8d-b5ba-2309c55334e1', 'S', 10),
('9cdd45c9-9054-11f1-9ffd-0a002700000d', '9b29d722-446a-4e8d-b5ba-2309c55334e1', 'M', 10),
('9cdd9d29-9054-11f1-9ffd-0a002700000d', '9b29d722-446a-4e8d-b5ba-2309c55334e1', 'L', 10),
('9cdddaca-9054-11f1-9ffd-0a002700000d', '9b29d722-446a-4e8d-b5ba-2309c55334e1', 'XL', 10),
('9d5faa09-9052-11f1-9ffd-0a002700000d', '3e07fac8-c6e6-43ce-a7a8-0ea89132680f', 'S', 10),
('9d5ff763-9052-11f1-9ffd-0a002700000d', '3e07fac8-c6e6-43ce-a7a8-0ea89132680f', 'M', 10),
('9d60244d-9052-11f1-9ffd-0a002700000d', '3e07fac8-c6e6-43ce-a7a8-0ea89132680f', 'L', 10),
('9d604d0b-9052-11f1-9ffd-0a002700000d', '3e07fac8-c6e6-43ce-a7a8-0ea89132680f', 'XL', 10),
('9e0317d1-83b1-11f1-aeec-0a002700000d', '22f276ce-b462-4283-86b5-6f783571e365', 'ÚNICA', 5),
('9e813621-8f64-11f1-a80c-0a002700000d', '01212cd6-fd6f-438d-a12a-820d9a54b934', 'S', 10),
('9e81ec9d-8f64-11f1-a80c-0a002700000d', '01212cd6-fd6f-438d-a12a-820d9a54b934', 'M', 10),
('9e8223fd-8f64-11f1-a80c-0a002700000d', '01212cd6-fd6f-438d-a12a-820d9a54b934', 'L', 10),
('9e824ccb-8f64-11f1-a80c-0a002700000d', '01212cd6-fd6f-438d-a12a-820d9a54b934', 'XL', 10),
('9f287a08-9046-11f1-9ffd-0a002700000d', '643a4d05-77d4-4461-b206-79e9bd415448', 'S', 20),
('9f28beed-9046-11f1-9ffd-0a002700000d', '643a4d05-77d4-4461-b206-79e9bd415448', 'M', 20),
('9f28f605-9046-11f1-9ffd-0a002700000d', '643a4d05-77d4-4461-b206-79e9bd415448', 'L', 20),
('9f2948a4-9046-11f1-9ffd-0a002700000d', '643a4d05-77d4-4461-b206-79e9bd415448', 'XL', 20),
('9fc92f55-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '38', 10),
('9fc96993-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '39', 10),
('9fc99a37-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '40', 10),
('9fc9c805-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '41', 10),
('9fca05e0-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '42', 10),
('9fca433a-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '43', 10),
('9fca6fb5-8f61-11f1-a80c-0a002700000d', '978b0b4d-5767-4075-bec9-49a68b75b8ca', '44', 10),
('a0f48740-8f63-11f1-a80c-0a002700000d', '56845b85-3802-446a-9b56-577d4c323ee3', '28', 10),
('a0f4b446-8f63-11f1-a80c-0a002700000d', '56845b85-3802-446a-9b56-577d4c323ee3', '30', 10),
('a0f4dfe3-8f63-11f1-a80c-0a002700000d', '56845b85-3802-446a-9b56-577d4c323ee3', '32', 10),
('a0f50980-8f63-11f1-a80c-0a002700000d', '56845b85-3802-446a-9b56-577d4c323ee3', '34', 10),
('a0f531e4-8f63-11f1-a80c-0a002700000d', '56845b85-3802-446a-9b56-577d4c323ee3', '36', 10),
('a4b2db67-7047-11f1-be2b-0a0027000028', '942c044b-c4e0-4812-b11c-a18c5f8d4f45', 'ÚNICA', 4),
('a614a145-904c-11f1-9ffd-0a002700000d', 'ead2f1bc-ba66-4d55-b420-182018db35c4', 'ÚNICA', 5),
('a88e834f-9041-11f1-9ffd-0a002700000d', 'faea617d-7bf6-4ecc-b89c-753be8496be7', 'S', 10),
('a88ece4c-9041-11f1-9ffd-0a002700000d', 'faea617d-7bf6-4ecc-b89c-753be8496be7', 'M', 10),
('a88f0aad-9041-11f1-9ffd-0a002700000d', 'faea617d-7bf6-4ecc-b89c-753be8496be7', 'L', 10),
('a88fe0e0-9041-11f1-9ffd-0a002700000d', 'faea617d-7bf6-4ecc-b89c-753be8496be7', 'XL', 10),
('a930d010-8f5e-11f1-a80c-0a002700000d', 'd01d9652-66b8-4737-9a8a-686fa2352891', 'ÚNICA', 10),
('ac29824f-9047-11f1-9ffd-0a002700000d', 'ec54c48d-dac0-491e-a813-24860028c62e', 'ÚNICA', 10),
('b3d4ee3a-9043-11f1-9ffd-0a002700000d', 'af3554c6-8efb-440a-83ba-0278693f9cab', 'ÚNICA', 10),
('b5b82ce0-904b-11f1-9ffd-0a002700000d', '355b13b2-5e53-425b-a4c7-a6a5e5371de8', 'S', 10),
('b5b85d6f-904b-11f1-9ffd-0a002700000d', '355b13b2-5e53-425b-a4c7-a6a5e5371de8', 'M', 10),
('b5b8a30d-904b-11f1-9ffd-0a002700000d', '355b13b2-5e53-425b-a4c7-a6a5e5371de8', 'L', 10),
('b5b8cad6-904b-11f1-9ffd-0a002700000d', '355b13b2-5e53-425b-a4c7-a6a5e5371de8', 'XL', 11),
('b5ccf5ae-904d-11f1-9ffd-0a002700000d', 'acb0e7d2-bd26-4452-b61a-3309f7c357ac', 'ÚNICA', 10),
('b8a45813-9042-11f1-9ffd-0a002700000d', '702a379a-5abf-4114-8a0a-95825eac9af7', 'ÚNICA', 50),
('bd31ee36-904c-11f1-9ffd-0a002700000d', '389d94db-6608-4e89-b0b9-180efa5ee4a7', 'ÚNICA', 10),
('c062f37c-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '38', 5),
('c06359a5-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '39', 5),
('c0639e2e-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '40', 5),
('c063f2b5-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '41', 5),
('c0648ab1-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '42', 5),
('c0651b3e-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '43', 5),
('c065b057-8f5f-11f1-a80c-0a002700000d', '2ed1d679-e76b-4014-b248-db8ce5e40407', '44', 5),
('c24293f7-9a74-11f1-8833-0a002700000d', '13b3e49e-c0e0-4eae-8dfc-da3cef5653db', 'S', 10),
('c242e951-9a74-11f1-8833-0a002700000d', '13b3e49e-c0e0-4eae-8dfc-da3cef5653db', 'M', 10),
('c2438cd3-9a74-11f1-8833-0a002700000d', '13b3e49e-c0e0-4eae-8dfc-da3cef5653db', 'L', 10),
('c244b662-9a74-11f1-8833-0a002700000d', '13b3e49e-c0e0-4eae-8dfc-da3cef5653db', 'XL', 10),
('c3ed9dcb-9052-11f1-9ffd-0a002700000d', 'b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', 'S', 10),
('c3ee1829-9052-11f1-9ffd-0a002700000d', 'b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', 'M', 10),
('c3ee5144-9052-11f1-9ffd-0a002700000d', 'b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', 'L', 10),
('c3ee8b69-9052-11f1-9ffd-0a002700000d', 'b3e8e380-d518-4ebe-b89a-5357fcbbdf5b', 'XL', 10),
('c74c7fe6-9046-11f1-9ffd-0a002700000d', '1deb32a9-9b91-4b97-aa02-80774f11fed6', 'ÚNICA', 50),
('c9e547ff-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '38', 10),
('c9e583a8-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '39', 10),
('c9e5af71-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '40', 10),
('c9e5dc4e-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '41', 10),
('c9e6083e-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '42', 10),
('c9e6439e-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '43', 10),
('c9e690a1-8f61-11f1-a80c-0a002700000d', '4e867cd3-0f29-4ff6-bc1a-e13baaf1cdcd', '44', 10),
('cda99d29-904b-11f1-9ffd-0a002700000d', 'c6b9b46a-6054-4517-8374-262bd553b62f', 'ÚNICA', 10),
('ce4f710e-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '38', 10),
('ce4f9974-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '39', 10),
('ce4fbdc2-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '40', 10),
('ce5000f0-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '41', 10),
('ce504570-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '42', 10),
('ce508831-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '43', 10),
('ce50ae90-9051-11f1-9ffd-0a002700000d', 'd45484ec-87ab-4a0a-ab4a-9cb23016c363', '44', 10),
('cf83c8c2-904c-11f1-9ffd-0a002700000d', 'fc49b184-d85d-4e62-8c37-c63b2e1e3720', 'ÚNICA', 10),
('d001021b-9054-11f1-9ffd-0a002700000d', '1c663a48-885e-4b18-9436-3b08796a1b62', 'ÚNICA', 20),
('d021ef08-9043-11f1-9ffd-0a002700000d', '96bf0cfe-072d-4942-8c75-d29e483924ae', 'ÚNICA', 20),
('d1b27d69-904e-11f1-9ffd-0a002700000d', 'c58490a0-20db-4281-8818-e9be64097858', 'S', 1),
('d1b2cbd4-904e-11f1-9ffd-0a002700000d', 'c58490a0-20db-4281-8818-e9be64097858', 'M', 10),
('d1b30ecd-904e-11f1-9ffd-0a002700000d', 'c58490a0-20db-4281-8818-e9be64097858', 'L', 10),
('d1b34b46-904e-11f1-9ffd-0a002700000d', 'c58490a0-20db-4281-8818-e9be64097858', 'XL', 10),
('d609d9b8-904d-11f1-9ffd-0a002700000d', '3506fe33-aed0-4459-ad3e-ebf5ff2b6754', 'S', 20),
('d60a110f-904d-11f1-9ffd-0a002700000d', '3506fe33-aed0-4459-ad3e-ebf5ff2b6754', 'M', 20),
('d60a492f-904d-11f1-9ffd-0a002700000d', '3506fe33-aed0-4459-ad3e-ebf5ff2b6754', 'L', 20),
('d60a7ad4-904d-11f1-9ffd-0a002700000d', '3506fe33-aed0-4459-ad3e-ebf5ff2b6754', 'XL', 20),
('d75d8e32-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '38', 10),
('d75dc907-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '39', 10),
('d75e19d9-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '40', 10),
('d75ea835-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '41', 10),
('d75eeb89-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '42', 10),
('d75f7784-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '43', 10),
('d75fd067-8f63-11f1-a80c-0a002700000d', '33521519-836d-424c-ab61-2d56f98734d2', '44', 10),
('d8948a7b-8573-11f1-aea1-0a002700000d', 'ba723b62-dff8-4480-9229-a01d963c7171', 'ÚNICA', 4),
('ddb68784-9a66-11f1-8de4-0a002700000d', '2f4b1c46-e582-4585-b0a2-198701233ff0', 'ÚNICA', 12),
('de8d530c-8f60-11f1-a80c-0a002700000d', '2e933dd8-6525-419e-a4c7-a29c278ebc82', 'ÚNICA', 10),
('deabf3cc-9050-11f1-9ffd-0a002700000d', 'ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', 'S', 10),
('deac4325-9050-11f1-9ffd-0a002700000d', 'ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', 'M', 10),
('deac7be0-9050-11f1-9ffd-0a002700000d', 'ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', 'L', 10),
('deaca6a6-9050-11f1-9ffd-0a002700000d', 'ed9de3bb-7bf9-4b6c-b9a9-09d7c06611b3', 'XL', 10),
('e1203db6-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '38', 10),
('e1207b98-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '39', 10),
('e120c619-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '40', 10),
('e1212078-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '41', 10),
('e1217459-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '42', 10),
('e121bdd9-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '43', 10),
('e1220fba-9046-11f1-9ffd-0a002700000d', '5b379542-4c51-4605-bf07-a307d63dae1a', '44', 10),
('e5dfe218-8f60-11f1-a80c-0a002700000d', '44d51d12-1be1-45d9-8d27-d70ee2d1f1f5', 'ÚNICA', 10),
('e7813e8b-904c-11f1-9ffd-0a002700000d', '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', '28', 10),
('e781a201-904c-11f1-9ffd-0a002700000d', '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', '30', 10),
('e781f4eb-904c-11f1-9ffd-0a002700000d', '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', '32', 10),
('e7826a59-904c-11f1-9ffd-0a002700000d', '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', '34', 10),
('e782c3fe-904c-11f1-9ffd-0a002700000d', '87ceb74c-20b7-4ffe-a74e-d6667f3158bb', '36', 10),
('e96dd372-9054-11f1-9ffd-0a002700000d', '3615a52c-4477-4c45-bf79-fc8296cc7546', 'ÚNICA', 20),
('ea021568-904e-11f1-9ffd-0a002700000d', 'f3a99e28-9629-4652-b7fa-f5d76e97d897', 'S', 10),
('ea025a65-904e-11f1-9ffd-0a002700000d', 'f3a99e28-9629-4652-b7fa-f5d76e97d897', 'M', 10),
('ea02a395-904e-11f1-9ffd-0a002700000d', 'f3a99e28-9629-4652-b7fa-f5d76e97d897', 'L', 10),
('ea02e682-904e-11f1-9ffd-0a002700000d', 'f3a99e28-9629-4652-b7fa-f5d76e97d897', 'XL', 1),
('eaab4e92-8f60-11f1-a80c-0a002700000d', '8c9c8b66-c638-4152-8d65-f873168c0874', 'ÚNICA', 10),
('eb092213-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '38', 10),
('eb09a680-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '39', 10),
('eb09f1ad-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '40', 10),
('eb0a6238-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '41', 10),
('eb0a9d1d-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '42', 10),
('eb0ac9ee-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '43', 10),
('eb0af3fa-8f61-11f1-a80c-0a002700000d', 'b86c313c-4a3b-4aa1-9c2c-ffb58bd558f7', '44', 10),
('f02e5f45-9043-11f1-9ffd-0a002700000d', '4ff7c00b-c984-43d0-8a3c-6d1eab936907', 'ÚNICA', 10),
('f07dc6a4-8f60-11f1-a80c-0a002700000d', 'ee67a570-74bd-4e7c-8e1e-568af4d07f4d', 'ÚNICA', 10),
('f13f6f36-9053-11f1-9ffd-0a002700000d', 'afc01428-f9fb-4146-9cd8-67dbf89edb14', 'S', 10),
('f14040a5-9053-11f1-9ffd-0a002700000d', 'afc01428-f9fb-4146-9cd8-67dbf89edb14', 'M', 10),
('f1408063-9053-11f1-9ffd-0a002700000d', 'afc01428-f9fb-4146-9cd8-67dbf89edb14', 'L', 1),
('f140d139-9053-11f1-9ffd-0a002700000d', 'afc01428-f9fb-4146-9cd8-67dbf89edb14', 'XL', 10),
('f25b8beb-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '38', 5),
('f25c2a1c-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '39', 5),
('f25cd4e3-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '40', 5),
('f25d108e-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '41', 5),
('f25d5ae2-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '42', 5),
('f25d9b2d-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '43', 5),
('f25ddd42-9041-11f1-9ffd-0a002700000d', 'af23a140-bcf6-430a-9c14-0aff74b8c44c', '44', 5),
('fb7fc55a-904f-11f1-9ffd-0a002700000d', 'ac2271a9-c9c4-4c36-8ae1-c5d4f57d2262', 'ÚNICA', 20),
('fe46d1af-904c-11f1-9ffd-0a002700000d', 'dddea19b-9787-44e5-96d4-cd28c94dc255', '28', 10),
('fe471199-904c-11f1-9ffd-0a002700000d', 'dddea19b-9787-44e5-96d4-cd28c94dc255', '30', 10),
('fe475e24-904c-11f1-9ffd-0a002700000d', 'dddea19b-9787-44e5-96d4-cd28c94dc255', '32', 10),
('fe47a18b-904c-11f1-9ffd-0a002700000d', 'dddea19b-9787-44e5-96d4-cd28c94dc255', '34', 10),
('fe47d89a-904c-11f1-9ffd-0a002700000d', 'dddea19b-9787-44e5-96d4-cd28c94dc255', '36', 10),
('febb1c98-904e-11f1-9ffd-0a002700000d', '8a8e6130-1fd0-497a-ab70-6739cc2d14d1', 'ÚNICA', 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin_permisos`
--
ALTER TABLE `admin_permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `admin_sessions`
--
ALTER TABLE `admin_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_item` (`user_id`,`producto_id`,`variante_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `nombre_2` (`nombre`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `idx_fotos_useruuid` (`user_uuid`);

--
-- Indices de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_uuid` (`order_uuid`),
  ADD KEY `idx_orders_user` (`user_id`);

--
-- Indices de la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_productos_categoria` (`categoria_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_cedula` (`cedula`);

--
-- Indices de la tabla `variantes`
--
ALTER TABLE `variantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin_permisos`
--
ALTER TABLE `admin_permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `admin_sessions`
--
ALTER TABLE `admin_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `fotos`
--
ALTER TABLE `fotos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admin_permisos`
--
ALTER TABLE `admin_permisos`
  ADD CONSTRAINT `admin_permisos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `admin_sessions`
--
ALTER TABLE `admin_sessions`
  ADD CONSTRAINT `admin_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD CONSTRAINT `carrito_compras_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fotos_ibfk_2` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Filtros para la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD CONSTRAINT `inventory_movements_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `variantes`
--
ALTER TABLE `variantes`
  ADD CONSTRAINT `variantes_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
