-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2021 at 09:16 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ksiegarnia`
--

-- --------------------------------------------------------

--
-- Table structure for table `klienci`
--

CREATE TABLE `klienci` (
  `KlientID` int(11) NOT NULL,
  `Nazwisko` varchar(15) NOT NULL,
  `Adres` varchar(50) NOT NULL,
  `Miejscowosc` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `klienci`
--

INSERT INTO `klienci` (`KlientID`, `Nazwisko`, `Adres`, `Miejscowosc`) VALUES
(1, 'Kowalski', 'Tuwima 24', 'Łódź'),
(2, 'Tomaszewski', 'Piłsudskiego 120', 'Łódź'),
(3, 'Kryś', 'Inflancka 40', 'Łódź'),
(4, 'Krysiak', 'Płaska 3', 'Brzeziny'),
(5, 'Balcerczyk', 'Widna 2', 'Brzeziny'),
(6, 'Brzozowski', 'Widna 5', 'Brzeziny'),
(7, 'Misiak', 'Tuwima 24', 'Łódź'),
(8, 'Misicki', 'Tuwima 24', 'Łódź'),
(9, 'Wrogowski', 'Płaska 10', 'Brzeziny'),
(10, 'Kot', 'Wysoka 1', 'Pabianice'),
(11, 'Wielicki', 'Wysoka 2', 'Pabianice'),
(12, 'Marsiński', 'Znanegoczłowieka 11', 'Pabianice'),
(13, 'Wrocki', 'Twojegobrata 9', 'Nibymiasto'),
(14, 'Gryzmacki', 'Twojegobrata 9', 'Nibymiasto'),
(15, 'Poliszewski', 'Targowa 27', 'Łódź'),
(16, 'Bucki', 'Okólna 27', 'Łódź'),
(17, 'Ciesik', 'Takrótka 1', 'Nibymiasto'),
(18, 'Smutkowski', 'Tadługa 80', 'Nibymiasto'),
(19, 'Wysisicki', 'Tadluga 90', 'Nibymiasto'),
(20, 'Ticz', 'Krzywa 6', 'Nibymiasto');

-- --------------------------------------------------------

--
-- Table structure for table `ksiazki`
--

CREATE TABLE `ksiazki` (
  `ISBN` varchar(20) NOT NULL,
  `Autor` varchar(50) DEFAULT NULL,
  `Tytul` varchar(50) DEFAULT NULL,
  `Cena` float(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ksiazki`
--

INSERT INTO `ksiazki` (`ISBN`, `Autor`, `Tytul`, `Cena`) VALUES
('978-83-080-4889-4', 'Bajki robotów', 'Stanisław Lem', 29.90),
('978-83-080-7054-3', 'Opowieści o pilocie Pirxie', 'Stanisław Lem', 44.90),
('978-83-240-5528-9', 'Jacek Giedrojć', 'Pułapka', 49.90),
('978-83-246-8050-4', 'Adam Zaremba', 'Giełda. Podstawy Inwestowania', 39.90),
('978-83-283-2464-0', 'Maciej Dutko', 'Biblia e-biznesu 2. Nowy Testament', 129.00),
('978-83-287-0364-3', 'Marsjanin', 'Andy Weir', 39.99),
('978-83-287-0650-7', 'Rok 1984', 'George Orwell', 12.99),
('978-83-287-0830-3', 'Nowy wspaniały świat', 'Aldous Huxley', 26.90),
('978-83-287-1533-2', 'Carlos Ruiz Zafon', 'Marina', 34.90),
('978-83-633-9110-2', 'Gary Armstrong', 'Marketing Wprowadzenie', 129.00),
('978-83-653150-5-2', 'Metro 2035', 'Dmitry Glukhovsky', 39.99),
('978-83-654-9955-4', 'Wehikuł czasu', 'Herbert George Wells', 25.60),
('978-83-66234-00-0', 'Amit Goswani', 'Kwantowy Świat', 39.90),
('978-83-748-0922-1', '451 stopni Fahrenheita', 'Ray Bradbury', 29.00),
('978-83-773-1341-1', 'Coś', 'John W Campbell', 35.90),
('978-83-7785-767-0', 'Stephen Hawking', 'Krótka Historia Czasu', 34.00),
('978-83-811-6539-6', 'Pierścień', 'Larry Niven', 45.00),
('978-83-818-8081-7', 'Narodziny Fundacji', 'Isaac Asimov', 49.90),
('978-83-818-8155-5', 'Człowiek z wysokiego zamku', 'Philip K Dick', 54.90),
('978-83-818-8257-6', 'Przez ciemne zwierciadło', 'Philip K Dick', 59.90);

-- --------------------------------------------------------

--
-- Table structure for table `pozycje_zamowienia`
--

CREATE TABLE `pozycje_zamowienia` (
  `ZamowienieID` int(11) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Ilosc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pozycje_zamowienia`
--

INSERT INTO `pozycje_zamowienia` (`ZamowienieID`, `ISBN`, `Ilosc`) VALUES
(1, '978-83-653150-5-2', 1),
(2, '978-83-287-0364-3', 2),
(3, '978-83-246-8050-4', 5),
(3, '978-83-633-9110-2', 5),
(4, '978-83-287-0650-7', 1),
(5, '978-83-654-9955-4', 1),
(6, '978-83-773-1341-1', 1),
(7, '978-83-080-7054-3', 1),
(8, '978-83-080-7054-3', 1),
(9, '978-83-080-7054-3', 1),
(10, '978-83-080-7054-3', 1),
(10, '978-83-080-4889-4', 1),
(11, '978-83-818-8081-7', 1),
(12, '978-83-287-0830-3', 1),
(13, '978-83-287-0830-3', 1),
(14, '978-83-287-1533-2', 10),
(15, '978-83-811-6539-6', 1),
(16, '978-83-811-6539-6', 1),
(17, '978-83-7785-767-0', 1),
(17, '978-83-66234-00-0', 1),
(18, '978-83-818-8257-6', 1),
(19, '978-83-748-0922-1', 2),
(20, '978-83-287-0650-7', 1),
(20, '978-83-287-0830-3', 1);

-- --------------------------------------------------------

--
-- Table structure for table `recenzje_ksiazek`
--

CREATE TABLE `recenzje_ksiazek` (
  `ISBN` varchar(20) DEFAULT NULL,
  `Recenzja` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recenzje_ksiazek`
--

INSERT INTO `recenzje_ksiazek` (`ISBN`, `Recenzja`) VALUES
('978-83-7785-767-0', 'To świetna książka jeśli chce się zdobyć jakieś pojęcie w tematyce fizyki kwantowej.'),
('978-83-66234-00-0', 'Pomimo że to nie podręcznik, ta pozycja da ci wiele wiedzy na temat fizyki kwantowej.'),
('978-83-246-8050-4', 'Nawet jeśli nie jesteś biznesmenem, z tą książką w ręce zbijesz majątek.'),
('978-83-240-5528-9', 'Autor podejmuje niełatwy i kontrowersyjny temat o chęci zysku powstrzymującej rozwój.'),
('978-83-283-2464-0', 'Ta książka jest niezbędnikiem dla kogoś, kto chce prowadzić biznes w Internecie.'),
('978-83-633-9110-2', 'Przystępne i przydatne wprowadzenie do sztuki zdobywania klientów dla Twojego biznesu.'),
('978-83-287-1533-2', 'Historia z elementami powieści detektywistycznej i horroru, akcję dzieje się w nietypowych czasach'),
('978-83-818-8081-7', 'Część legendarnej serii od jednego z najznakiemitniejszych autorów science-fiction'),
('978-83-818-8257-6', 'Trzymająca w napięciu historia spod pióra jednego z nasławniejszych autorów science-fiction'),
('978-83-287-0650-7', 'Wprowadzjąca w przygnebienie wizja dyktatorskiego reżimu inspirowanego komunizmem'),
('978-83-748-0922-1', 'Trzymająca w napięciu historia pokazująca, że każdy może zdecydować walczyć przeciw tyranom'),
('978-83-818-8155-5', 'Tajemnicza mroczna wizja, skupiająca się na rzeczywistości, gdzie zło zwyciężyło'),
('978-83-080-4889-4', 'Popularna kolekcja historii dla czytelników w prawie każdym wieku napisana przez Stanisława Lema'),
('978-83-287-0830-3', 'Pobudzająca do myślenia historia dystopii, gdzie dla lepszej przyszłości czyni się złe rzeczy.'),
('978-83-653150-5-2', 'Wizja postapokaliptycznego świata w nietypowym środowisku - tunelach metra.'),
('978-83-654-9955-4', 'Jedna z pierwszych powieści tegu typu, stworzona przez pioniera gatunku.'),
('978-83-287-0364-3', 'Nowatorska interpretacja historii o rozbitkach- zamiast wyspy mamy planetę'),
('978-83-773-1341-1', 'Trzymający w napięciu horror, gdzie każdy może być potworem - nawet o tym nie wiedząc'),
('978-83-080-7054-3', 'Jeszcze jeden zbiór opowiastek od sławnego Polskiego autora science-fiction'),
('978-83-811-6539-6', 'Powieść science-fiction, gdzie zamiast planety bohaterowie zwiedzą megastrukturę...');

-- --------------------------------------------------------

--
-- Table structure for table `zamowienie`
--

CREATE TABLE `zamowienie` (
  `ZamowienieID` int(11) NOT NULL,
  `KlientID` int(11) DEFAULT NULL,
  `Wartosc` float(5,2) NOT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `zamowienie`
--

INSERT INTO `zamowienie` (`ZamowienieID`, `KlientID`, `Wartosc`, `Data`) VALUES
(1, 1, 39.99, '2021-01-12'),
(2, 2, 79.98, '2021-02-20'),
(3, 10, 844.50, '2016-08-26'),
(4, 7, 12.99, '2020-01-09'),
(5, 5, 25.60, '2019-02-03'),
(6, 5, 35.90, '2019-02-10'),
(7, 5, 44.90, '2019-02-17'),
(8, 3, 44.90, '2019-02-17'),
(9, 4, 44.90, '2019-02-17'),
(10, 17, 74.80, '2019-02-17'),
(11, 11, 49.90, '2019-11-29'),
(12, 8, 26.90, '2020-11-12'),
(13, 9, 26.90, '2020-11-12'),
(14, 19, 349.00, '2016-08-25'),
(15, 6, 45.00, '2018-09-15'),
(16, 12, 45.00, '2018-09-15'),
(17, 15, 73.90, '2017-10-31'),
(18, 20, 59.90, '2017-10-29'),
(19, 16, 58.00, '2020-02-17'),
(20, 13, 39.89, '2020-12-19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`KlientID`);

--
-- Indexes for table `ksiazki`
--
ALTER TABLE `ksiazki`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indexes for table `pozycje_zamowienia`
--
ALTER TABLE `pozycje_zamowienia`
  ADD KEY `ZamowienieID` (`ZamowienieID`),
  ADD KEY `ISBN` (`ISBN`);

--
-- Indexes for table `recenzje_ksiazek`
--
ALTER TABLE `recenzje_ksiazek`
  ADD KEY `ISBN` (`ISBN`);

--
-- Indexes for table `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD PRIMARY KEY (`ZamowienieID`),
  ADD KEY `KlientID` (`KlientID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `klienci`
--
ALTER TABLE `klienci`
  MODIFY `KlientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pozycje_zamowienia`
--
ALTER TABLE `pozycje_zamowienia`
  ADD CONSTRAINT `pozycje_zamowienia_ibfk_1` FOREIGN KEY (`ZamowienieID`) REFERENCES `zamowienie` (`ZamowienieID`),
  ADD CONSTRAINT `pozycje_zamowienia_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `ksiazki` (`ISBN`);

--
-- Constraints for table `recenzje_ksiazek`
--
ALTER TABLE `recenzje_ksiazek`
  ADD CONSTRAINT `recenzje_ksiazek_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `ksiazki` (`ISBN`);

--
-- Constraints for table `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD CONSTRAINT `zamowienie_ibfk_1` FOREIGN KEY (`KlientID`) REFERENCES `klienci` (`KlientID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
