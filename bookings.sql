-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Feb 15. 23:27
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `bookings`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `bookings`
--

CREATE TABLE `bookings` (
  `customer_email` varchar(255) NOT NULL,
  `hotel_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL DEFAULT current_timestamp(),
  `end_date` date NOT NULL DEFAULT current_timestamp(),
  `adults` int(11) NOT NULL DEFAULT 1,
  `children` int(11) DEFAULT 0,
  `boylovers` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `bookings`
--

INSERT INTO `bookings` (`customer_email`, `hotel_id`, `start_date`, `end_date`, `adults`, `children`, `boylovers`) VALUES
('cyer@ilovemen.ro', 2, '2026-02-09', '2026-02-15', 1, 0, 10),
('gulyigeri@fides.ru', 2, '2026-02-13', '2026-02-15', 1, 0, 0),
('peter.takacs2@bm.gov.hu', 1, '2026-02-13', '2026-02-15', 1, 0, 2),
('random.numbers@fidesz.ru', 1, '2026-02-12', '2026-02-14', 1, 0, 2),
('zsoltibacsi@fidesz.hu', 1, '2026-02-13', '2026-02-14', 1, 0, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `customers`
--

CREATE TABLE `customers` (
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `customers`
--

INSERT INTO `customers` (`email`, `first_name`, `last_name`, `phone`, `birthday`, `image`) VALUES
('cyer@ilovemen.ro', 'József', 'Szájer', NULL, '1961-09-07', '/images/szajer.jfif'),
('elios@bff.cash.in', 'István', 'Tiborcz', '+3628799130', '1986-06-23', '/images/tiborcz.jpg'),
('gulyigeri@fides.ru', 'Gergely', 'Gulyás', NULL, '1981-09-21', '/images/gulyigeri.jpg'),
('lolo.for.gold_diggers@gas_fitter.hu', 'Lőrinc', 'Mészáros', '+3613209247', '1966-02-24', '/images/lolo.png'),
('peter.takacs2@bm.gov.hu', 'Péter', 'Takács', '+3614411000', '1979-12-14', '/images/takacspeter.jpg'),
('random.numbers@fidesz.ru', 'Márton', 'Nagy', NULL, NULL, '/images/nagymarton.jpg'),
('zsoltibacsi@fidesz.hu', 'Zsolt', 'Semjén', '107', '1962-08-08', '/images/zsoltibacsi.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hotels`
--

CREATE TABLE `hotels` (
  `id` int(10) UNSIGNED NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `stars` int(10) UNSIGNED DEFAULT NULL,
  `owner_email` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hotels`
--

INSERT INTO `hotels` (`id`, `city`, `name`, `description`, `stars`, `owner_email`, `image`) VALUES
(1, 'Fertő-tó', 'Hotel Nils am See', 'LGBT+hotel', 4, 'lolo.for.gold_diggers@gas_fitter.hu', '/images/nils.webp'),
(2, 'Budapest', 'Botaniq Elite Club Hotel', 'Narancsszerető fiúk privát klubja.', 5, 'elios@bff.cash.in', '/images/botaniq.jpg'),
(3, 'Felcsút', 'Hotel Belvedere', NULL, 5, 'lolo.for.gold_diggers@gas_fitter.hu', '/images/belvedere.jpg');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`customer_email`,`hotel_id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- A tábla indexei `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`email`);

--
-- A tábla indexei `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hotels_owner_id` (`owner_email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_email`) REFERENCES `customers` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`owner_email`) REFERENCES `customers` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
