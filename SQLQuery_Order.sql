 -- Mempercepat Pencarian Di Kolom NamaKustomer
CREATE UNIQUE INDEX IndexNamaKustomer ON [Order] (NamaKustomer);

-- Menampilkan Data Berdasarkan NamaKustomer
SELECT * FROM [Order] WHERE NamaKustomer = 'Hardi Ananda';

-- Menampilkan Semua Data
SELECT * FROM [Order];

--INNER JOIN
-- Menampilkan Data Kustomer yang Order DineIn Dan Meja Yang Di Ambil
SELECT o.NamaKustomer, o.TipeOrder, m.KodeMeja  FROM [Order] o
INNER JOIN Meja m ON o.MejaId = m.MejaId
WHERE o.TipeOrder = 0

--(ORDER DESC)
-- Mengurutkan Pesanan Berdasarkan Antrian Terbaru
SELECT NamaKustomer, NomorAntrian
FROM [Order]
ORDER BY NomorAntrian DESC;

--(UNION, GROUP BY, COUNT)
-- Jumlah Metode Pembayaran Yang Di Lakukan Kustomer
SELECT 'Metode Pembayaran' AS Kategori, MetodePembayaran AS Detail, COUNT(MetodePembayaran) AS Jumlah
FROM [ORDER]
GROUP BY MetodePembayaran
UNION ALL
-- Jumlah Status Pesanan Kustomer
SELECT 'Status' AS Kategori, [Status] AS Detail, COUNT([Status]) AS Jumlah
FROM [ORDER]
GROUP BY [Status]
UNION ALL
-- Jumlah Tipe Order Yang Dilakukan Kustomer
SELECT 'Tipe Order' AS Kategori, TipeOrder AS Detail, COUNT(TipeOrder) AS Jumlah
FROM [ORDER]
GROUP BY TipeOrder

-- Menambahkan Data Baru
INSERT INTO [Order] (NamaKustomer, NomorAntrian, Status, TipeOrder, CreatedAt, Catatan, MetodePembayaran, MejaId)
VALUES 
('Hardi Ananda', 1, 2, 0, '2026-08-03 09:00:00', N'Jangan terlalu pedas', 0, 1),
('Siti Aminah', 2, 2, 1, '2026-08-03 09:10:00', N'Bungkus terpisah', 1, NULL),
('Budi Santoso', 3, 2, 0, '2026-08-03 09:15:00', NULL, 2, 3),
('Rina Wijaya', 4, 2, 0, '2026-08-03 09:20:00', N'Es teh manis belakangan', 0, 2),
('Andi Pratama', 5, 3, 1, '2026-08-03 09:30:00', N'Batal, kelamaan antre', 1, NULL),
('Dewi Lestari', 6, 2, 0, '2026-08-03 09:40:00', N'Minta sendok tambahan', 0, 4),
('Fajar Nugraha', 7, 2, 1, '2026-08-03 09:45:00', N'Kuah dipisah', 1, NULL),
('Eko Prasetyo', 8, 2, 0, '2026-08-03 10:00:00', NULL, 2, 5),
('Santi Rahayu', 9, 2, 0, '2026-08-03 10:15:00', N'Paha atas ayamnya', 1, 1),
('Roni Setiawan', 10, 2, 1, '2026-08-03 10:30:00', NULL, 0, NULL),
('Mega Utami', 11, 2, 0, '2026-08-03 10:45:00', N'Nasi setengah porsi', 2, 6),
('Joko Susilo', 12, 3, 1, '2026-08-03 11:00:00', N'Salah menu', 0, NULL),
('Linda Permata', 13, 2, 0, '2026-08-03 11:15:00', N'Tanpa es batu', 1, 7),
('Aditya Malik', 14, 2, 0, '2026-08-03 11:30:00', NULL, 0, 8),
('Yuni Kartika', 15, 2, 1, '2026-08-03 11:45:00', N'Pedas level 5', 1, NULL),
('Taufik Hidayat', 16, 2, 0, '2026-08-03 12:00:00', N'Meja dekat jendela', 2, 9),
('Fitri Handayani', 17, 2, 1, '2026-08-03 12:15:00', NULL, 0, NULL),
('Hendra Wijaya', 18, 2, 0, '2026-08-03 12:30:00', N'Saus sambal ekstra', 1, 10),
('Dina Mariana', 19, 2, 0, '2026-08-03 12:45:00', NULL, 2, 11),
('Bambang Hermawan', 20, 2, 1, '2026-08-03 13:00:00', N'Sendok plastik 2', 0, NULL),
('Rian Hidayat', 21, 1, 0, '2026-08-03 13:15:00', N'Sedang dimasak dapur', 1, 12),
('Citra Kirana', 22, 1, 0, '2026-08-03 13:30:00', NULL, 2, 13),
('Gilang Dirga', 23, 1, 1, '2026-08-03 13:45:00', N'Drapihkan untuk hantaran', 0, NULL),
('Wulan Guritno', 24, 0, 0, '2026-08-03 14:00:00', N'Meja VIP AC', 1, 14),
('Denny Cagur', 25, 0, 0, '2026-08-03 14:15:00', NULL, 2, 15),
('Ayu Tingting', 26, 0, 1, '2026-08-03 14:30:00', N'Kurangi gula minuman', 0, NULL),
('Raffi Ahmad', 27, 2, 0, '2026-08-03 14:45:00', N'Porsi Sultan', 1, 16),
('Nagita Slavina', 28, 2, 0, '2026-08-03 15:00:00', N'Minta piring kecil tambahan', 2, 17),
('Irwansyah', 29, 3, 1, '2026-08-03 15:15:00', N'Batal pesanan teh', 0, NULL),
('Zaskia Sungkar', NEXT VALUE FOR SeqNomorAntrian, 2, 0, '2026-08-03 15:30:00', NULL, 1, 18);

-- Melakukan Update Data
UPDATE [Order]
SET [Status] = 2,
    Catatan = N'Makanan sudah disajikan, sendok tambahan sudah diberikan'
WHERE OrderId = 1;

-- Menghapus Data
DELETE [Order] WHERE OrderId = 3;

CREATE SEQUENCE SeqNomorAntrian
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE;
GO