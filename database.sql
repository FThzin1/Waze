-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.22-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela waze.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `user_id` int(11) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.bans: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.gs_safebox
CREATE TABLE IF NOT EXISTS `gs_safebox` (
  `gang` varchar(25) NOT NULL,
  `dinheiro` int(11) NOT NULL DEFAULT 0,
  `dinheirosujo` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando estrutura para tabela waze.waze_carkeys
CREATE TABLE IF NOT EXISTS `waze_carkeys` (
  `user_id` smallint(6) NOT NULL,
  `placa` tinytext NOT NULL DEFAULT '',
  KEY `user_id` (`user_id`),
  KEY `placa` (`placa`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.waze_carkeys: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `waze_carkeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `waze_carkeys` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.waze_dominas
CREATE TABLE IF NOT EXISTS `waze_dominas` (
  `material` varchar(50) NOT NULL,
  `qtd` int(255) DEFAULT 0,
  PRIMARY KEY (`material`),
  KEY `qtd` (`qtd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.waze_dominas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `waze_dominas` DISABLE KEYS */;
/*!40000 ALTER TABLE `waze_dominas` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.waze_maisgaragem
CREATE TABLE IF NOT EXISTS `waze_maisgaragem` (
  `user_id` int(11) NOT NULL,
  `vagas` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.waze_maisgaragem: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `waze_maisgaragem` DISABLE KEYS */;
/*!40000 ALTER TABLE `waze_maisgaragem` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.waze_relacionamento
CREATE TABLE IF NOT EXISTS `waze_relacionamento` (
  `user_id` int(11) NOT NULL,
  `relacionamento` int(11) NOT NULL,
  `relacionamentoCom` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.waze_relacionamento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `waze_relacionamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `waze_relacionamento` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_adminlist
CREATE TABLE IF NOT EXISTS `vrp_adminlist` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.vrp_adminlist: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_adminlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_adminlist` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_estoque
CREATE TABLE IF NOT EXISTS `vrp_estoque` (
  `vehicle` varchar(100) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_estoque: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_estoque` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_estoque` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_homes_permissions
CREATE TABLE IF NOT EXISTS `vrp_homes_permissions` (
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(50) NOT NULL,
  `garage` int(11) NOT NULL,
  `home` varchar(24) NOT NULL DEFAULT '',
  `tax` varchar(100) NOT NULL DEFAULT '',
  `vault` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_homes_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_homes_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_homes_permissions` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_mdt
CREATE TABLE IF NOT EXISTS `vrp_mdt` (
  `slot` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `officer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`slot`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_mdt: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_mdt` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_pontuacaocorrida
CREATE TABLE IF NOT EXISTS `vrp_pontuacaocorrida` (
  `IdCorrida` int(11) NOT NULL,
  `IdDoMelhor` int(11) NOT NULL DEFAULT -1,
  `MelhorTempo` int(11) NOT NULL,
  PRIMARY KEY (`IdCorrida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela waze.vrp_pontuacaocorrida: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_pontuacaocorrida` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_pontuacaocorrida` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_priority
CREATE TABLE IF NOT EXISTS `vrp_priority` (
  `user_id` smallint(3) NOT NULL,
  `apelido` varchar(50) DEFAULT 'APELIDO',
  `steam` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT 'steam:',
  `priority` smallint(3) NOT NULL DEFAULT 1,
  PRIMARY KEY (`steam`) USING BTREE,
  KEY `SECONDARY KEY` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_priority: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_priority` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_priority` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_srv_data: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_srv_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_srv_data` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `garagem` int(11) NOT NULL DEFAULT 5,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_users` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `dvalue` (`dvalue`(3072))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_user_data: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_data` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_user_identities
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela waze.vrp_user_identities: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_identities` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_user_ids: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_ids` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_user_moneys
CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `paypal` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_user_moneys: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_moneys` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_moneys` ENABLE KEYS */;

-- Copiando estrutura para tabela waze.vrp_user_vehicles
CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT 0,
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `ipva` varchar(24) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela waze.vrp_user_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
