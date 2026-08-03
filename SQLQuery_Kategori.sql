-- Mempercepat Pencarian Di Kolom NamaKategori
CREATE UNIQUE INDEX IndexNamaKategori ON Kategori (NamaKategori);

-- Menampilkan Data Berdasarkan NamaKategori
SELECT * FROM Kategori WHERE Icon = 'utensils';

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT * FROM Kategori WHERE NamaKategori = N'Makanan Berat';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT * FROM Kategori WHERE Icon = 'utensils';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- Menampilkan Semua Data
SELECT * FROM Kategori;

-- Menambahkan Data Baru (16 Kategori Resto/Kafe)
INSERT INTO Kategori (NamaKategori, Icon)
VALUES 
(N'Makanan Berat', 'utensils'), 
(N'Minuman Dingin', 'glass-water'),
(N'Cemilan', 'cookie'), 
(N'Pencuci Mulut', 'ice-cream'),
(N'Kopi', 'coffee'), 
(N'Teh', 'cup-togo'),
(N'Sup', 'soup'), 
(N'Salad', 'leaf'),
(N'Mocktail', 'martini'), 
(N'Pastri', 'croissant'),
(N'Seafood', 'fish'), 
(N'Barbeque', 'drumstick'),
(N'Makanan Tradisional', 'bowl-rice'), 
(N'Paket Hemat', 'box'),
(N'Makanan Sampingan', 'fries'), 
(N'Makanan Pembuka', 'egg');

-- Melakukan Update Data
UPDATE Kategori
SET Icon = 'utensils-crossed'
WHERE NamaKategori = N'Makanan Berat';

-- Menghapus Data
DELETE Kategori WHERE KategoriId = 3;