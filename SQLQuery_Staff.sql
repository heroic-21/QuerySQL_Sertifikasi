-- Mempercepat Pencarian Di Kolom Username
CREATE UNIQUE INDEX IdUsername ON Staff (Username);
EXEC sp_helpindex 'Staff';

-- Menampilkan Data Berdasarkan Username Untuk Searching
SELECT * FROM Staff WHERE Username = 'Yara Ananda';

-- Menampilkan Semua Data
SELECT * FROM Staff;

-- Menambahkan Data Baru
INSERT INTO Staff (Username, Pin, [Shift], RoleUser, [Status])
VALUES ('Hardi Ananda', 210704, 'Siang', 1, 0),
('Tiara Sari', 130804, 'Malam', 1, 1);

-- Melakukan Update Data
UPDATE Staff
SET RoleUser = 0
WHERE StaffId = '1';

-- Melakukan Penghapusan Data
DELETE Staff WHERE StaffId = 3;