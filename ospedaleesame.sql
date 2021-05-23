-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 23, 2021 alle 15:44
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ospedaleesame`
--
/*
DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Punto1` (IN `tipo` VARCHAR(20))  begin
drop temporary table if exists temp;
create temporary table temp(id_paziente varchar(20), paziente varchar(20), id_camera varchar(20), id_chirurgo varchar(20), chirurgo varchar(20) );
insert into temp SELECT p.id_paziente as id_pazienti, p.nomeP as nominativo, c.id_camera, o.chirurgo, ch.nomeC
FROM paziente p, camera c, opera o, chirurgo ch
where p.Tipo= tipo  and p.id_paziente = c.paziente and o.chirurgo=ch.id_chirurgo and o.chirurgo in
(SELECT o.chirurgo from opera o where o.paziente = p.id_paziente) group by nomeP;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Punto2` (IN `anno1` INTEGER, `anno2` INTEGER)  begin
drop temporary table if exists temp2;
create temporary table temp2(id_chirurgo varchar(20),nome_chirurgo varchar(20),id_ospedale varchar(20), data_inizio date,
data_fine date, ospedale_id varchar(20), inizio date, id_reparto varchar(20), nome_reparto varchar(20));
insert into temp2 select v.*, r.id_reparto, r.nome as nome_reparto from vistaPunto2 v, reparto r  
where Year(v.dataInizio)>= anno1 and Year(v.dataFine)<=anno2 and r.id_reparto in(select r.id_reparto from reparto r  where v.id_chirurgo=r.chirurgo)
group by v.chirurgo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Punto3` (IN `g1` INTEGER, `g2` INTEGER)  begin
update Camera
set giorni_in_piu =
case 
when  datediff(data_uscita, data_ricovero) = g1
then giorni_in_piu + 1
when  datediff(data_uscita, data_ricovero) = g2
then giorni_in_piu +2
else giorni_in_piu
end;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Punto4` (IN `num` VARCHAR(20))  begin
drop temporary table if exists temp4;
create temporary table temp4(numero_operazioni varchar(20), id_chirurgo varchar(20));
insert into temp4 select count(sa.id_sala) as numero_operazioni, o.chirurgo 
from salaoperatoria sa, opera o
where sa.id_sala = o.sala_operatoria and sa.id_sala in(select sa.id_sala from salaoperatoria sa where sa.id_sala=num) group by chirurgo;
end$$

DELIMITER ;
*/
-- --------------------------------------------------------

--
-- Struttura della tabella `camera`
--

CREATE TABLE `camera` (
  `id_camera` varchar(20) NOT NULL,
  `data_ricovero` date DEFAULT NULL,
  `data_uscita` date DEFAULT NULL,
  `paziente` varchar(20) NOT NULL,
  `giorni_in_piu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `camera`
--

INSERT INTO `camera` (`id_camera`, `data_ricovero`, `data_uscita`, `paziente`, `giorni_in_piu`) VALUES
('CE114', '2019-02-26', '2019-03-08', 'P121', 2),
('E3', '2017-10-18', '2017-10-23', 'P122', 0),
('E34', '2016-11-10', '2016-11-16', 'P162', 0),
('L11', '2017-05-05', '2017-05-13', 'P19', 0),
('L21', '2019-10-06', '2019-10-14', 'P332', 0),
('P43', '2016-01-20', '2016-01-29', 'P152', 1),
('R44', '2018-06-22', '2018-07-02', 'P12', 2),
('R44', '2016-12-12', '2016-12-21', 'P321', 1),
('RR4', '2017-11-04', '2017-11-10', 'P182', 0),
('T4', '2019-12-15', '2019-12-21', 'P62', 0),
('V11', '2019-04-14', '2019-04-23', 'P221', 1),
('W34', '2020-01-10', '2020-01-19', 'P442', 1);


/*
--
-- Trigger `camera`
--
DELIMITER $$
CREATE TRIGGER `max_estensione` AFTER UPDATE ON `camera` FOR EACH ROW begin
if (exists(select *  from camera 
where giorni_in_piu > 4)) then 
signal sqlstate '45000' set message_text=  'non possono estendere per piu di 4 giorni';
end if;
end
$$
DELIMITER ;
*/
-- --------------------------------------------------------

--
-- Struttura della tabella `chirurgo`
--

CREATE TABLE `chirurgo` (
  `id_chirurgo` varchar(20) NOT NULL,
  `nomeC` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `imageC` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `chirurgo`
--

INSERT INTO `chirurgo` (`id_chirurgo`, `nomeC`, `email`, `imageC`) VALUES
('AE34565', 'Vinci S.', 'svnc2@os.com', 'c6.png'),
('DR35235', 'Di Marco B.', 'dima1@os.com', 'c1.png'),
('E223432', 'Vinci A.', 'avinci223@os.com', 'c5.png'),
('GE32323', 'Zase D.', 'dazas45@os.com', 'c7.png'),
('POI0324', 'Vince P.', 'pvinc3@os.com', 'c4.png'),
('PTO342', 'Andronaco L.', 'adrn23@os.com', 'c0.jpg'),
('T644554', 'Mari E', 'ema23@osp2.com', 'c3.png'),
('VER564', 'Frede R.', 'rfre3@os.com', 'c2.png');

-- --------------------------------------------------------
/*
--
-- Struttura stand-in per le viste `durata_ricovero`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `durata_ricovero` (
`paziente` varchar(20)
,`id_camera` varchar(20)
,`data_ricovero` date
,`data_uscita` date
,`giorni_ricovero` int(7)
,`giorni_in_piu` int(11)
);
*/
-- --------------------------------------------------------

--
-- Struttura della tabella `lavora`
--

CREATE TABLE `lavora` (
  `dataInizio` date DEFAULT NULL,
  `chirurgo` varchar(20) NOT NULL,
  `ospedale` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `lavora`
--

INSERT INTO `lavora` (`dataInizio`, `chirurgo`, `ospedale`) VALUES
('2017-02-11', 'AE34565', 'MLN984'),
('2018-10-05', 'DR35235', 'CT232'),
('2018-03-14', 'E223432', 'CT232'),
('2015-12-14', 'GE32323', 'MLN76'),
('2017-01-06', 'POI0324', 'CTD223'),
('2016-06-06', 'PTO342', 'RMTE64'),
('2019-11-23', 'T644554', 'CT232'),
('2017-05-12', 'VER564', 'MDNS2');

-- --------------------------------------------------------

--
-- Struttura della tabella `lavorava`
--

CREATE TABLE `lavorava` (
  `dataInizio` date DEFAULT NULL,
  `dataFine` date DEFAULT NULL,
  `chirurgo` varchar(20) NOT NULL,
  `ospedale` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `lavorava`
--

INSERT INTO `lavorava` (`dataInizio`, `dataFine`, `chirurgo`, `ospedale`) VALUES
('2016-04-06', '2018-10-02', 'DR35235', 'CTD223'),
('2014-03-18', '2018-03-09', 'E223432', 'MLN76'),
('2015-08-08', '2017-05-10', 'VER564', 'FRT543');

-- --------------------------------------------------------
/*
--
-- Struttura stand-in per le viste `numi`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `numi` (
`sala_operatoria` varchar(20)
,`num_interventi` bigint(21)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `num_int`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `num_int` (
);
*/
-- --------------------------------------------------------

--
-- Struttura della tabella `opera`
--

CREATE TABLE `opera` (
  `data_operazione` date DEFAULT NULL,
  `chirurgo` varchar(20) NOT NULL,
  `sala_operatoria` varchar(20) NOT NULL,
  `paziente` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `opera`
--

INSERT INTO `opera` (`data_operazione`, `chirurgo`, `sala_operatoria`, `paziente`) VALUES
('2018-06-22', 'AE34565', 'M2', 'P12'),
('2017-11-05', 'AE34565', 'M2', 'P182'),
('2019-02-26', 'DR35235', 'S2', 'P121'),
('2019-04-14', 'DR35235', 'S2', 'P221'),
('2019-10-06', 'E223432', 'M2', 'P332'),
('2020-01-10', 'E223432', 'M2', 'P442'),
('2016-01-20', 'GE32323', 'S3', 'P152'),
('2016-11-11', 'GE32323', 'S3', 'P162'),
('2017-05-05', 'POI0324', 'S1', 'P19'),
('2016-12-12', 'PTO342', 'R2', 'P321'),
('2019-12-16', 'T644554', 'S2', 'P62'),
('2017-10-19', 'VER564', 'SO2', 'P122');


/*
--
-- Trigger `opera`
--
DELIMITER $$
CREATE TRIGGER `gestione_salaop` BEFORE INSERT ON `opera` FOR EACH ROW begin 
if(exists(select *
from opera 
where opera.sala_operatoria = new.sala_operatoria and 
new.data_operazione = data_operazione))
then 
signal sqlstate '45000' set message_text= 'impossibile aggiungere operazioni nella stessa sala operatoria nello stesso giorno';
end if;
end
$$
DELIMITER ;
*/
-- --------------------------------------------------------

--
-- Struttura della tabella `ospedale`
--

CREATE TABLE `ospedale` (
  `id_ospedale` varchar(20) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `citta` varchar(20) DEFAULT NULL,
  `indirizzo` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `ospedale`
--

INSERT INTO `ospedale` (`id_ospedale`, `nome`, `citta`, `indirizzo`, `image`) VALUES
('CT232', 'Vittorio Emanuele', 'Catania', 'Via Plebiscito, 628', 'o0.png'),
('CTD223', 'Garibaldi', 'Catania', 'Piazza Santa Maria di Gesu\', 5', 'o1.png'),
('FRT543', 'Santa Maria Nuova', 'Firenze', 'Piazza Santa Maria Nuova, 1', 'o2.png'),
('MDNS2', 'Ospedale di Modena', 'Modena', 'Via del Pozzo, 71', 'o3.png'),
('MLN76', 'S.Ambrogio', 'Milano', 'Via Luigi Giuseppe Faravelli, 16', 'o4.png'),
('MLN984', 'S.Raffaele', 'Milano', 'Via Olgettina, 60', 'o5.png'),
('RMT34', 'S.Filippo Neri', 'Roma', 'Via Giovanni Martinotti, 20', 'o6.png'),
('RMTE64', 'S.Giovanni', 'Roma', 'Via S.Giovanni in Laterano, 155', 'o7.png');

-- --------------------------------------------------------

--
-- Struttura della tabella `paziente`
--

CREATE TABLE `paziente` (
  `id_paziente` varchar(20) NOT NULL,
  `nomeP` varchar(20) DEFAULT NULL,
  `eta` int(11) DEFAULT NULL,
  `Tipo` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `paziente`
--

INSERT INTO `paziente` (`id_paziente`, `nomeP`, `eta`, `Tipo`) VALUES
('P12', 'Mani A.', 55, 'Pronto Soccorso'),
('P121', 'Di Benedetto F.', 35, 'Pronto Soccorso'),
('P122', 'Cade R.', 32, 'In Lista'),
('P152', 'Mani L.', 20, 'Pronto Soccorso'),
('P162', 'Di Mare I.', 63, 'In Lista'),
('P182', 'Fichera F.', 25, 'In Lista'),
('P19', 'Di Carmine V.', 75, 'Pronto Soccorso'),
('P221', 'DArrigo L.', 45, 'Pronto Soccorso'),
('P321', 'Colli T.', 65, 'Pronto Soccorso'),
('P332', 'Di Vinci A. ', 8, 'Pronto Soccorso'),
('P442', 'Poli P.', 80, 'Pronto Soccorso'),
('P62', 'Pesce C.', 50, 'In Lista');

-- --------------------------------------------------------

--
-- Struttura della tabella `preferiti`
--

CREATE TABLE `preferiti` (
  `id` int(11) NOT NULL,
  `utente` int(11) DEFAULT NULL,
  `chirurgo` varchar(20) DEFAULT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `nomeR` varchar(255) DEFAULT NULL,
  `ospedale` varchar(255) DEFAULT NULL,
  `citta` varchar(255) DEFAULT NULL,
  `indirizzo` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `reparto`
--

CREATE TABLE `reparto` (
  `id_reparto` varchar(20) NOT NULL,
  `nomeR` varchar(20) DEFAULT NULL,
  `chirurgo` varchar(20) NOT NULL,
  `imageR` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `reparto`
--

INSERT INTO `reparto` (`id_reparto`, `nomeR`, `chirurgo`, `imageR`) VALUES
('C3', 'cardiologia', 'DR35235', 'cardiologia.png'),
('M3', 'cardiologia', 'GE32323', 'cardiologia.png'),
('N2', 'neurochirurgia', 'E223432', 'neuro.png'),
('NN1', 'neurochirurgia', 'T644554', 'neuro.png'),
('O4', 'otorinolaringoiatria', 'VER564', 'otorino.png'),
('P2', 'neurochirurgia', 'POI0324', 'neuro.png'),
('P33', 'cardiologia', 'AE34565', 'cardiologia.png'),
('Z2', 'ortopedia', 'PTO342', 'ortopedia.png');

-- --------------------------------------------------------

--
-- Struttura della tabella `salaoperatoria`
--

CREATE TABLE `salaoperatoria` (
  `id_sala` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `salaoperatoria`
--

INSERT INTO `salaoperatoria` (`id_sala`) VALUES
('M2'),
('R2'),
('S1'),
('S2'),
('S3'),
('SO2');

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(15) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `surname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------
/*
--
-- Struttura per vista `durata_ricovero`
--
DROP TABLE IF EXISTS `durata_ricovero`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `durata_ricovero`  AS SELECT `camera`.`paziente` AS `paziente`, `camera`.`id_camera` AS `id_camera`, `camera`.`data_ricovero` AS `data_ricovero`, `camera`.`data_uscita` AS `data_uscita`, to_days(`camera`.`data_uscita`) - to_days(`camera`.`data_ricovero`) AS `giorni_ricovero`, `camera`.`giorni_in_piu` AS `giorni_in_piu` FROM `camera` ;

-- --------------------------------------------------------

--
-- Struttura per vista `numi`
--
DROP TABLE IF EXISTS `numi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `numi`  AS SELECT `o`.`sala_operatoria` AS `sala_operatoria`, count(`o`.`sala_operatoria`) AS `num_interventi` FROM `opera` AS `o` GROUP BY `o`.`sala_operatoria` ;

-- --------------------------------------------------------

--
-- Struttura per vista `num_int`
--
DROP TABLE IF EXISTS `num_int`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `num_int`  AS SELECT `i`.`numeroInterventi` AS `numeroInterventi`, `p`.`id_paziente` AS `id_paziente`, `p`.`nomeP` AS `paziente`, `p`.`eta` AS `eta`, `p`.`Tipo` AS `tipo` FROM (`interventi` `i` join `paziente` `p`) WHERE `i`.`paziente` = `p`.`id_paziente` ;

-- --------------------------------------------------------

--
-- Struttura per vista `vistapunto2`
--
DROP TABLE IF EXISTS `vistapunto2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistapunto2`  AS SELECT `l`.`chirurgo` AS `id_chirurgo`, `c`.`nomeC` AS `chirurgo`, `la`.`ospedale` AS `lavorava_prima`, `la`.`dataInizio` AS `dataInizio`, `la`.`dataFine` AS `dataFine`, `l`.`ospedale` AS `lavora_ora`, `l`.`dataInizio` AS `lavora_da` FROM (((`lavora` `l` join `lavorava` `la` on(`l`.`chirurgo` = `la`.`chirurgo`)) join `chirurgo` `c` on(`c`.`id` = `l`.`chirurgo`)) join `ospedale` `os` on(`os`.`id_ospedale` = `la`.`ospedale`)) ;
*/
--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`id_camera`,`paziente`),
  ADD KEY `new_paziente` (`paziente`);

--
-- Indici per le tabelle `chirurgo`
--
ALTER TABLE `chirurgo`
  ADD PRIMARY KEY (`id_chirurgo`);

--
-- Indici per le tabelle `lavora`
--
ALTER TABLE `lavora`
  ADD PRIMARY KEY (`chirurgo`,`ospedale`),
  ADD KEY `new_chirurgo` (`chirurgo`),
  ADD KEY `new_ospedale` (`ospedale`);

--
-- Indici per le tabelle `lavorava`
--
ALTER TABLE `lavorava`
  ADD PRIMARY KEY (`chirurgo`,`ospedale`),
  ADD KEY `new_chirurgo` (`chirurgo`),
  ADD KEY `new_ospedale` (`ospedale`);

--
-- Indici per le tabelle `opera`
--
ALTER TABLE `opera`
  ADD PRIMARY KEY (`chirurgo`,`sala_operatoria`,`paziente`),
  ADD KEY `new_chirurgo` (`chirurgo`),
  ADD KEY `new_sala` (`sala_operatoria`),
  ADD KEY `new_paziente` (`paziente`);

--
-- Indici per le tabelle `ospedale`
--
ALTER TABLE `ospedale`
  ADD PRIMARY KEY (`id_ospedale`);

--
-- Indici per le tabelle `paziente`
--
ALTER TABLE `paziente`
  ADD PRIMARY KEY (`id_paziente`);

--
-- Indici per le tabelle `preferiti`
--
ALTER TABLE `preferiti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `reparto`
--
ALTER TABLE `reparto`
  ADD PRIMARY KEY (`id_reparto`,`chirurgo`),
  ADD KEY `new_chirurgo` (`chirurgo`);

--
-- Indici per le tabelle `salaoperatoria`
--
ALTER TABLE `salaoperatoria`
  ADD PRIMARY KEY (`id_sala`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `camera`
--
ALTER TABLE `camera`
  ADD CONSTRAINT `camera_ibfk_1` FOREIGN KEY (`paziente`) REFERENCES `paziente` (`id_paziente`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `lavora`
--
ALTER TABLE `lavora`
  ADD CONSTRAINT `lavora_ibfk_1` FOREIGN KEY (`chirurgo`) REFERENCES `chirurgo` (`id_chirurgo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lavora_ibfk_2` FOREIGN KEY (`ospedale`) REFERENCES `ospedale` (`id_ospedale`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `lavorava`
--
ALTER TABLE `lavorava`
  ADD CONSTRAINT `lavorava_ibfk_1` FOREIGN KEY (`chirurgo`) REFERENCES `chirurgo` (`id_chirurgo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lavorava_ibfk_2` FOREIGN KEY (`ospedale`) REFERENCES `ospedale` (`id_ospedale`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `opera`
--
ALTER TABLE `opera`
  ADD CONSTRAINT `opera_ibfk_1` FOREIGN KEY (`chirurgo`) REFERENCES `chirurgo` (`id_chirurgo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `opera_ibfk_2` FOREIGN KEY (`sala_operatoria`) REFERENCES `salaoperatoria` (`id_sala`) ON UPDATE CASCADE,
  ADD CONSTRAINT `opera_ibfk_3` FOREIGN KEY (`paziente`) REFERENCES `paziente` (`id_paziente`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `reparto`
--
ALTER TABLE `reparto`
  ADD CONSTRAINT `reparto_ibfk_1` FOREIGN KEY (`chirurgo`) REFERENCES `chirurgo` (`id_chirurgo`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
