 -- Mempercepat Pencarian Di Kolom KodeMeja
CREATE UNIQUE INDEX IdKodeMeja ON Meja (KodeMeja);

-- Menampilkan Data Berdasarkan KodeMeja
SELECT * FROM Meja WHERE KodeMeja = 'A10';

-- Menampilkan Semua Data
SELECT * FROM Meja;

-- Menambahkan Data Baru
INSERT INTO Meja (StatusMeja, KodeMeja)
VALUES 
(0, 'A1'),  (0, 'A2'),  (0, 'A3'),  (0, 'A4'),  (0, 'A5'), 
(0, 'A6'),  (0, 'A7'),  (0, 'A8'),  (0, 'A9'),  (0, 'A10'),
(0, 'A11'), (0, 'A12'), (0, 'A13'), (0, 'A14'), (0, 'A15'), 
(0, 'A16'), (0, 'A17'), (0, 'A18'), (0, 'A19'), (0, 'A20');

-- Melakukan Update Data
UPDATE Meja
SET StatusMeja = 1
WHERE KodeMeja = 'A1';

-- Menghapus Data
DELETE Meja WHERE MejaId = 3;