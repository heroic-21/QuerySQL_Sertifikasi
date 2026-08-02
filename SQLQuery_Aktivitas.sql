-- Penambahan Data Aktivitas Terbaru
INSERT INTO Aktivitas (TipeAktivitas, Deskripsi, Waktu, StaffId)
VALUES 
(0, N'Staff Kasir melakukan Login ke dalam sistem', '2026-08-02 08:00:00', 1),
(2, N'Membuat pesanan baru: Order #1 (Nama: Hardi Ananda)', '2026-08-02 08:15:00', 1),
(3, N'Mengubah status Order #1 menjadi Sedang Dimasak', '2026-08-02 08:17:00', 1),
(2, N'Membuat pesanan baru: Order #2 (Nama: Siti Aminah)', '2026-08-02 08:30:00', 1),
(3, N'Mengubah status Order #1 menjadi Selesai (Delivered)', '2026-08-02 08:45:00', 1),
(3, N'Mengubah meja pada Order #2 dari Meja 1 ke Meja 3', '2026-08-02 08:50:00', 1),
(4, N'Membatalkan Order #3 karena salah input', '2026-08-02 09:10:00', 1),
(2, N'Membuat pesanan baru: Order #4 (Nama: Budi)', '2026-08-02 09:30:00', 1),
(3, N'Mengubah metode pembayaran Order #4 menjadi QRIS', '2026-08-02 09:45:00', 1),
(1, N'Staff Kasir melakukan Logout dari sistem', '2026-08-02 12:00:00', 1),
(0, N'Owner melakukan Login ke dalam sistem', '2026-08-02 13:00:00', 2),
(2, N'Menambahkan Kategori Menu baru: Makanan Berat', '2026-08-02 13:15:00', 2),
(2, N'Menambahkan Kategori Menu baru: Minuman Dingin', '2026-08-02 13:20:00', 2),
(2, N'Menambahkan Menu baru: Nasi Goreng Spesial', '2026-08-02 13:30:00', 2),
(2, N'Menambahkan Menu baru: Es Teh Manis', '2026-08-02 13:35:00', 2),
(3, N'Mengubah harga Ayam Bakar dari 25000 ke 28000', '2026-08-02 14:00:00', 2),
(3, N'Mengubah informasi alamat pada Pengaturan Toko', '2026-08-02 14:15:00', 2),
(4, N'Menghapus Menu lama: Jus Alpukat (Stok Kosong)', '2026-08-02 14:30:00', 2),
(3, N'Mengubah hak akses (Role) Staff Kasir Baru', '2026-08-02 14:45:00', 2),
(1, N'Owner melakukan Logout dari sistem', '2026-08-02 17:00:00', 2);

SELECT * FROM Aktivitas

--(INNER JOIN)
-- Hasil All Tampil Data Sistem
SELECT s.Username, a.TipeAktivitas, a.Deskripsi, a.Waktu FROM Staff s
INNER JOIN Aktivitas a ON s.StaffId = a.StaffId

--(INNER JOIN, WHERE)
-- Hasil Filter User
SELECT s.Username, a.TipeAktivitas, a.Deskripsi, a.Waktu FROM Staff s
INNER JOIN Aktivitas a ON s.StaffId = a.StaffId
WHERE s.Username = 'Tiara Sari' AND a.TipeAktivitas = 1

--(INNER JOIN, WHERE)
-- Hasil Filter Aktivitas
SELECT s.Username, a.TipeAktivitas, a.Deskripsi, a.Waktu FROM Staff s
INNER JOIN Aktivitas a ON s.StaffId = a.StaffId
WHERE a.TipeAktivitas = 3