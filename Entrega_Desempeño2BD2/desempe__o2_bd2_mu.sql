-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-11-2022 a las 19:47:53
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `desempeño2_bd2_mu`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `f_totped` (`p_pid` INT) RETURNS DECIMAL(10,2)  BEGIN
DECLARE v_ret DEC(10,2) DEFAULT 0.00;
 SELECT SUM(detcan* detpreuni ) INTO v_ret
 FROM factdet 
WHERE detitem = p_pid;
 RETURN v_ret;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Nombre_Clientes` (`id` INT) RETURNS VARCHAR(100) CHARSET utf8 DETERMINISTIC RETURN 
    (SELECT clnom FROM clientes WHERE id = clid)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `clid` int(11) NOT NULL,
  `clnom` varchar(100) DEFAULT NULL,
  `clcuit` varchar(50) DEFAULT NULL,
  `cltel` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`clid`, `clnom`, `clcuit`, `cltel`) VALUES
(1, 'Juan Cáceres', '21-35060543-4', '3515234533'),
(2, 'Fernando Augusto', '20-463295842-0', '3513245678'),
(3, 'Ramon Fernández ', '45-46756457-6', '3513879652'),
(4, 'Jorge Montiel', '30-46324567-2', '3519234561'),
(5, 'Maximiliano Berro', '31-41098345-0', '3511234567'),
(6, 'Fernando Gago', '34-56098763-0', '3510987654'),
(7, 'Lucas Gil', '32-546098734-0', '3514309823'),
(8, 'Emilia Borges', '20-34781234-0', '3510532984'),
(9, 'Johana Gracia', '20-54321238-7', '3517892345'),
(10, 'Noelia Baja', '21-343567823-4', '3515234545');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factcab`
--

CREATE TABLE `factcab` (
  `facid` int(11) NOT NULL,
  `factipo` varchar(2) DEFAULT NULL,
  `facnro` int(11) DEFAULT NULL,
  `facfech` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `factcab`
--

INSERT INTO `factcab` (`facid`, `factipo`, `facnro`, `facfech`) VALUES
(11, 'A', 111, '2022-11-01'),
(12, 'A', 112, '2022-11-02'),
(13, 'A', 113, '2022-11-03'),
(14, 'A', 114, '2022-11-04'),
(15, 'A', 115, '2022-11-05'),
(16, 'B', 116, '2022-11-06'),
(17, 'B', 117, '2022-11-07'),
(18, 'B', 118, '2022-11-08'),
(19, 'C', 119, '2022-11-09'),
(20, 'C', 120, '2022-11-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factdet`
--

CREATE TABLE `factdet` (
  `detitem` int(11) NOT NULL,
  `detcan` int(11) DEFAULT NULL,
  `detpreuni` decimal(10,2) DEFAULT NULL,
  `id_pro` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `factdet`
--

INSERT INTO `factdet` (`detitem`, `detcan`, `detpreuni`, `id_pro`) VALUES
(1, 3, '4500.00', 123),
(2, 10, '3600.00', 1234),
(3, 25, '1300.00', 12345),
(4, 3, '5500.00', 123456),
(5, 25, '900.00', 1234567),
(6, 4, '600.00', 12345678),
(7, 56, '2200.00', 123456789),
(8, 375, '500.00', 112),
(9, 17, '1450.00', 1123),
(10, 20, '7000.00', 11234);

--
-- Disparadores `factdet`
--
DELIMITER $$
CREATE TRIGGER `before_actualizar_stock` BEFORE INSERT ON `factdet` FOR EACH ROW begin

   update productos 
	set prstock = productos.prstock-new.detcan
     where new.id_pro=productos.prcod; 

 end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `prid` int(11) NOT NULL,
  `prcod` varchar(20) DEFAULT NULL,
  `prnom` varchar(200) DEFAULT NULL,
  `prpu` decimal(10,2) DEFAULT NULL,
  `prstock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`prid`, `prcod`, `prnom`, `prpu`, `prstock`) VALUES
(1, '123', 'Acolchado', '4500.00', 6),
(2, '1234', 'Sabanas', '3600.00', 5),
(3, '12345', 'Almohadas ', '1300.00', 15),
(4, '123456', 'Cortinas', '5500.00', 10),
(5, '1234567', 'Mantel', '900.00', 45),
(6, '12345678', 'Cubre Cama', '500.00', 41),
(7, '123456789', 'Toallas', '2200.00', 14),
(8, '112', 'Funda Almohada ', '600.00', 125),
(9, '1123', 'Funda Sillón ', '1450.00', 28),
(10, '11234', 'Alfombra', '7000.00', 30);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`clid`);

--
-- Indices de la tabla `factcab`
--
ALTER TABLE `factcab`
  ADD PRIMARY KEY (`facid`);

--
-- Indices de la tabla `factdet`
--
ALTER TABLE `factdet`
  ADD PRIMARY KEY (`detitem`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`prid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
