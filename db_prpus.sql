-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2025 at 11:29 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_prpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_buku` (`pIdBuku` INT)   BEGIN  
    DELETE FROM buku WHERE id = pIdBuku;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_peminjaman` (`pIdPeminjaman` INT)   BEGIN  
    DELETE FROM peminjaman WHERE id = pIdPeminjaman;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_siswa` (`pIdSiswa` INT)   BEGIN  
    DELETE FROM siswa WHERE id = pIdSiswa;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_buku` (`pJudul` VARCHAR(50), `pPenulis` VARCHAR(50), `pKategori` VARCHAR(50), `pStok` INT)   BEGIN
    INSERT INTO buku (judul_buku, penulis, kategori, stok) VALUES (pJudul, pPenulis, pKategori, pStok);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pinjaman` (`pIdsiswa` INT, `pIdbuku` INT, `pTglpinjaman` DATE, `pTglkembali` DATE, `pStatus` VARCHAR(50))   BEGIN
    INSERT INTO pinjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) 
    VALUES (pIdsiswa, pIdbuku, pTglpinjaman, pTglkembali, pStatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_siswa` (`pNama` VARCHAR(50), `pKelas` VARCHAR(50))   BEGIN
    INSERT INTO siswa (Nama, Kelas) VALUES (pNama, pKelas);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembalikanBuku` (`pIdPeminjaman` INT)   BEGIN
    UPDATE peminjaman
    SET status = 'Dikembalikan', tglKembali = CURRENT_DATE
    WHERE idPeminjaman = pIdPeminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllBuku` ()   BEGIN
    SELECT
        b.idBuku as 'ID Buku',
        b.judulBuku as 'Judul Buku',
        b.penulis as 'Penulis',
        b.kategori as 'Kategori',
        b.stok as 'Stok',
        IFNULL(p.idPeminjaman, 'Belum dipinjam') AS 'ID Peminjaman',
        IFNULL(p.tglPinjam, 'Belum dipinjam') as 'Tanggal Pinjam',
        IFNULL(p.statusPinjam, 'Belum dipinjam') as 'Status'
    FROM buku b
    LEFT JOIN peminjaman p ON b.idBuku = p.idBuku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllSiswaBaru` ()   BEGIN
    SELECT s.idSiswa AS 'ID Siswa',
           s.nama AS 'Nama',
           s.kelas AS 'Kelas',
           IFNULL(p.idPeminjaman, 'Belum Meminjam') AS 'ID Peminjaman',
           IFNULL(p.tglPinjam, 'Belum Meminjam') as 'Tanggal Pinjam',
           IFNULL(p.tglKembali, 'Belum Meminjam') as 'Tanggal Kembali',
           IFNULL(p.statusPinjam, 'Belum Meminjam') as 'Status'
    FROM siswa s
    LEFT JOIN peminjaman p ON s.idSiswa = p.idSiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_buku` ()   BEGIN  
    SELECT idPeminjaman AS 'ID Peminjaman',  
           idSiswa AS 'ID Siswa',  
           idBuku AS 'ID Buku',  
           tglPinjam AS 'Tanggal Pinjam',  
           tglKembali AS 'Tanggal Kembali',  
           statusPinjam AS 'Status'  
    FROM peminjaman;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_buku` (`pIdBuku` INT, `pJudulBuku` VARCHAR(50), `pPengarangBuku` VARCHAR(50), `pKategoriBuku` VARCHAR(50), `pStokBuku` INT)   BEGIN  
    UPDATE buku  
    SET judul = pJudulBuku, pengarang = pPengarangBuku, kategori = pKategoriBuku, stok = pStokBuku  
    WHERE id = pIdBuku;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_peminjaman` (`pIdPeminjaman` INT, `pIdBuku` INT, `pIdSiswa` INT, `pTanggalPinjam` DATE, `pTanggalKembali` DATE, `pStatusPinjam` VARCHAR(50))   BEGIN  
    UPDATE peminjaman  
    SET id_buku = pIdBuku, id_siswa = pIdSiswa, tanggal_pinjam = pTanggalPinjam, tanggal_kembali = pTanggalKembali, status = pStatusPinjam  
    WHERE id = pIdPeminjaman;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_siswa` (`pIdSiswa` INT, `pNamaSiswa` VARCHAR(50), `pKelasSiswa` VARCHAR(50))   BEGIN  
    UPDATE siswa  
    SET nama = pNamaSiswa, kelas = pKelasSiswa  
    WHERE id = pIdSiswa;  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(50) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan pemrograman', 'Andi wijaya', 'teknologi', 5),
(2, 'Dasar dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Distrik', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `pinjaman`
--

CREATE TABLE `pinjaman` (
  `id_pinjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(50) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `statusPinjam` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pinjaman`
--

INSERT INTO `pinjaman` (`id_pinjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`, `statusPinjam`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam', NULL),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan', NULL),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam', NULL),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan', NULL),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan', NULL),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam', NULL),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan', NULL),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam', NULL),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan', NULL),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam', NULL);

--
-- Triggers `pinjaman`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pinjaman` AFTER INSERT ON `pinjaman` FOR EACH ROW BEGIN  
    IF NEW.statusPinjam = 'Dipinjam' THEN  
        UPDATE buku  
        SET stok = stok - 1  
        WHERE id = NEW.id_buku;  
    END IF;  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_pinjaman` AFTER UPDATE ON `pinjaman` FOR EACH ROW BEGIN  
    IF NEW.statusPinjam = 'Dikembalikan' AND OLD.statusPinjam = 'Dipinjam' THEN  
        UPDATE buku  
        SET stok = stok + 1  
        WHERE id = NEW.id_Buku;  
    END IF;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Kelas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `Nama`, `Kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `pinjaman`
--
ALTER TABLE `pinjaman`
  ADD PRIMARY KEY (`id_pinjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pinjaman`
--
ALTER TABLE `pinjaman`
  MODIFY `id_pinjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
