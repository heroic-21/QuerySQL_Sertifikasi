-- Mempercepat Pencarian Di Kolom NamaMenu
CREATE UNIQUE INDEX IdxNamaMenu ON Menu (NamaMenu);

-- Menampilkan Data Berdasarkan NamaMenu
SELECT * FROM Menu WHERE NamaMenu = N'Nasi Goreng Special';

-- Menampilkan Semua Data
SELECT * FROM Menu;

-- Menambahkan Data Baru (Menu Restoran & Cafe)
INSERT INTO Menu (NamaMenu, HargaAsli, Gambar, Stok, KategoriId)
VALUES 
(N'Nasi Goreng Spesial', 25000.00, 'nasi-goreng.jpg', 50, 1),
(N'Mie Goreng Jawa', 22000.00, 'mie-goreng.jpg', 40, 1),
(N'Capcay Ayam', 20000.00, 'capcay.jpg', 30, 1),
(N'Kwetiau Goreng Sapi', 26000.00, 'kwetiau.jpg', 35, 1),
(N'Es Jeruk Peras', 8000.00, 'es-jeruk.jpg', 80, 2),
(N'Lemon Tea Dingin', 10000.00, 'lemon-tea.jpg', 75, 2),
(N'Jus Alpukat Kerok', 15000.00, 'jus-alpukat.jpg', 40, 2),
(N'Milkshake Cokelat', 16000.00, 'milkshake.jpg', 50, 2),
(N'Cireng Bumbu Rujak', 12000.00, 'cireng.jpg', 45, 3),
(N'Tempe Mendoan', 10000.00, 'mendoan.jpg', 60, 3),
(N'Singkong Goreng Keju', 12000.00, 'singkong.jpg', 30, 3),
(N'Puding Cokelat Lumer', 10000.00, 'puding.jpg', 25, 4),
(N'Es Krim Vanilla Oreo', 12000.00, 'ice-cream.jpg', 35, 4),
(N'Kopi Susu Gula Aren', 18000.00, 'kopi-susu.jpg', 60, 5),
(N'Espresso Double Shot', 15000.00, 'espresso.jpg', 100, 5),
(N'Cappuccino Hot', 20000.00, 'cappuccino.jpg', 45, 5),
(N'Matcha Latte Ice', 22000.00, 'matcha.jpg', 40, 5),
(N'Es Teh Manis', 5000.00, 'es-teh.jpg', 120, 6),
(N'Teh Tarik Hangat', 10000.00, 'teh-tarik.jpg', 50, 6),
(N'Sup Ayam Jamur', 20000.00, 'sup-ayam.jpg', 20, 7),
(N'Sup Buntut Sapi', 45000.00, 'sup-buntut.jpg', 15, 7),
(N'Fruit Salad Jumbo', 18000.00, 'fruit-salad.jpg', 15, 8),
(N'Blue Ocean Mocktail', 22000.00, 'blue-ocean.jpg', 30, 9),
(N'Croissant Keju', 18000.00, 'croissant.jpg', 15, 10),
(N'Cumi Goreng Tepung', 30000.00, 'cumi-tepung.jpg', 25, 11),
(N'Udang Saus Padang', 35000.00, 'udang-padang.jpg', 20, 11),
(N'Iga Bakar Madu', 45000.00, 'iga-bakar.jpg', 15, 12),
(N'Gado-Gado Betawi', 15000.00, 'gado-gado.jpg', 30, 13),
(N'Paket Geprek + Es Teh', 20000.00, 'paket-geprek.jpg', 40, 14),
(N'Kentang Goreng Krispi', 15000.00, 'kentang.jpg', 50, 15),
(N'Onion Rings', 12000.00, 'onion-rings.jpg', 35, 15),
(N'Garlic Bread Keju', 15000.00, 'garlic-bread.jpg', 20, 16);

-- Melakukan Update Data
UPDATE Menu
SET Stok = 0
WHERE NamaMenu = N'Nasi Goreng Spesial';

-- Menghapus Data
DELETE FROM Menu WHERE MenuId = 3;