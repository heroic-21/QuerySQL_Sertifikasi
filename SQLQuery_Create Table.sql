--Membuat Tabel Aktivitas
CREATE TABLE Aktivitas (
    [AktivitasId] INT IDENTITY(1,1) NOT NULL,
    [TipeAktivitas] INT NOT NULL, -- Enum disimpan sebagai angka
    [Deskripsi] NVARCHAR(225) NOT NULL,
    [Waktu] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [StaffId] INT NOT NULL,
    
    CONSTRAINT [PK_Aktivitas] PRIMARY KEY ([AktivitasId]),-- Menentukan Primary Key
    CONSTRAINT [FK_Staff_Aktivitas] FOREIGN KEY ([StaffId]) --Menentukan Foreign Key
        REFERENCES [Staff] ([StaffId])
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--Membuat Tabel Aktivitas
--(M)
-- |
--(1)
--Membuat Tabel Staff
CREATE TABLE Staff (
    [StaffId] INT IDENTITY(1,1) NOT NULL,
    [Username] NVARCHAR(50) NOT NULL,
    [Pin] INT NOT NULL,
    [Shift] NVARCHAR(50) NOT NULL,
    [RoleUser] INT NOT NULL, -- Enum UserRole disimpan sebagai angka
    [Status] INT NOT NULL,   -- Enum UserStatus disimpan sebagai angka
    
    CONSTRAINT [PK_Staff] PRIMARY KEY ([StaffId]) -- Menentukan Primary Key
);
--Membuat Tabel Staff

--Membuat Tabel Meja
CREATE TABLE Meja (
    [MejaId] INT IDENTITY(1,1) NOT NULL,
    [KodeMeja] NVARCHAR(10) NOT NULL,
    [StatusMeja] INT NOT NULL, -- Enum TableStatus disimpan sebagai angka
    
    CONSTRAINT [PK_Meja] PRIMARY KEY ([MejaId]) -- Menentukan Primary Key
);
--Membuat Tabel Meja
--(1)
-- |
--(M)
--Membuat Tabel Order
CREATE TABLE [Order] (
    [OrderId] INT IDENTITY(1,1) NOT NULL,
    [NamaKustomer] NVARCHAR(100) NOT NULL,
    [NomorAntrian] INT NOT NULL,
    [Status] INT NOT NULL,           -- Enum OrderStatus disimpan sebagai angka
    [TipeOrder] INT NOT NULL,        -- Enum OrderType disimpan sebagai angka
    [CreatedAt] DATETIME2 NOT NULL,
    [Catatan] NVARCHAR(225) NULL,    -- Boleh NULL karena di C# bertipe string?
    [MetodePembayaran] INT NOT NULL, -- Enum PaymentMethods disimpan sebagai angka
    [MejaId] INT NULL,               -- Boleh NULL untuk pesanan Take Away
    
    CONSTRAINT [PK_Order] PRIMARY KEY ([OrderId]), -- Menentukan Primary Key
    CONSTRAINT [FK_Meja_Order] FOREIGN KEY ([MejaId]) -- Menentukan Foreign Key (1toM)
        REFERENCES [Meja] ([MejaId])
        ON DELETE SET NULL -- Jika meja dihapus, order tetap ada tetapi MejaId menjadi NULL
        ON UPDATE CASCADE
);
--Membuat Tabel Order
--(1)
-- |
--(M)
--Membuat Tabel Struk
CREATE TABLE Struk (
    [StrukId] INT IDENTITY(1,1) NOT NULL,
    [Jumlah] INT NOT NULL,
    [HargaOrder] DECIMAL(18,2) NOT NULL,
    [OrderId] INT NOT NULL,
    [MenuId] INT NOT NULL,
    
    CONSTRAINT [PK_Struk] PRIMARY KEY ([StrukId]), -- Menentukan Primary Key
    CONSTRAINT [FK_Order_Struk] FOREIGN KEY ([OrderId]) -- Menentukan Foreign Key ke Order
        REFERENCES [Order] ([OrderId])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT [FK_Menu_Struk] FOREIGN KEY ([MenuId]) -- Menentukan Foreign Key ke Menu
        REFERENCES [Menu] ([MenuId])
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--Membuat Tabel Struk
--(M)
-- |
--(1)
--Membuat Tabel Menu
CREATE TABLE Menu (
    [MenuId] INT IDENTITY(1,1) NOT NULL,
    [NamaMenu] NVARCHAR(150) NOT NULL,
    [HargaAsli] DECIMAL(18,2) NOT NULL,
    [Gambar] NVARCHAR(225) NOT NULL,
    [Stok] INT NOT NULL,
    [KategoriId] INT NOT NULL,
    
    CONSTRAINT [PK_Menu] PRIMARY KEY ([MenuId]), -- Menentukan Primary Key
    CONSTRAINT [FK_Kategori_Menu] FOREIGN KEY ([KategoriId]) -- Menentukan Foreign Key
        REFERENCES [Kategori] ([KategoriId])
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--Membuat Tabel Menu
--(M)
-- |
--(1)
--Membuat Tabel Kategori
CREATE TABLE Kategori (
    [KategoriId] INT IDENTITY(1,1) NOT NULL,
    [NamaKategori] NVARCHAR(100) NOT NULL,
    [Icon] NVARCHAR(50) NOT NULL,
    
    CONSTRAINT [PK_Kategori] PRIMARY KEY ([KategoriId]) -- Menentukan Primary Key
);
--Membuat Tabel Kategori

--Membuat Tabel PengaturanToko
CREATE TABLE PengaturanToko (
    [PengaturanTokoId] INT IDENTITY(1,1) NOT NULL,
    [NamaToko] NVARCHAR(100) NOT NULL,
    [NomorTelepon] INT NOT NULL, -- Disimpan sebagai angka (integer)
    [Alamat] NVARCHAR(225) NOT NULL,
    [Pajak] DECIMAL(5,2) NOT NULL,
    [ServiceCharge] DECIMAL(5,2) NOT NULL,
    [PesanHeaderStruk] NVARCHAR(225) NOT NULL,
    [PesanFooterStruk] NVARCHAR(225) NOT NULL,
    
    CONSTRAINT [PK_PengaturanToko] PRIMARY KEY ([PengaturanTokoId]) -- Menentukan Primary Key
);
--Membuat Tabel PengaturanToko

------------------------------
-- Menambah Kolom Baru
ALTER TABLE Aktivitas 
ADD Request VARCHAR(20);

-- Mengubah Tipe Data Kolom
ALTER TABLE Pelanggan 
ALTER COLUMN NamaLengkap VARCHAR(150) NOT NULL;

-- Menghapus Indeks
DROP INDEX Nama_Indeks ON Pelanggan;

-- Menghapus Tabel
DROP TABLE Menu;

-- Hapus Data Dalam Tabel
TRUNCATE TABLE Pelanggan;
------------------------------