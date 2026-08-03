SELECT * FROM Struk
WHERE HargaOrder = (
    SELECT MIN(HargaOrder) FROM Struk
);
SELECT * FROM Struk
WHERE Jumlah = (
    SELECT MAX(Jumlah) FROM Struk
);
SELECT 
    OrderId, 
    NamaKustomer,
    (
        SELECT SUM(Jumlah * HargaOrder) 
        FROM Struk 
        WHERE Struk.OrderId = [Order].OrderId
    ) AS TotalBelanja
FROM [Order];

-- Menamhahkan Data Struk
INSERT INTO Struk (Jumlah, HargaOrder, OrderId, MenuId)
VALUES 
(1, 25000.00, 31, 1),
(1, 8000.00, 31, 5),
(2, 22000.00, 32, 2),
(2, 5000.00, 32, 18),
(1, 20000.00, 3, 3),
(1, 10000.00, 3, 6), 
(1, 26000.00, 4, 4),
(1, 15000.00, 4, 7),
(1, 12000.00, 4, 9),
(1, 15000.00, 5, 15),
(2, 18000.00, 6, 14),
(1, 10000.00, 6, 12),
(1, 30000.00, 7, 25),
(1, 10000.00, 7, 6),
(1, 45000.00, 8, 27),
(1, 22000.00, 8, 17),
(2, 15000.00, 9, 28),
(2, 5000.00, 9, 18),
(3, 20000.00, 10, 29),
(1, 15000.00, 11, 30),
(1, 8000.00, 11, 5),
(1, 12000.00, 12, 31),
(1, 15000.00, 13, 32),
(1, 16000.00, 13, 8),
(2, 25000.00, 14, 1),
(1, 35000.00, 15, 26),
(1, 5000.00, 15, 18),
(1, 20000.00, 16, 20),
(1, 20000.00, 16, 16),
(2, 18000.00, 17, 23),
(1, 22000.00, 18, 24),
(1, 18000.00, 18, 10),
(1, 15000.00, 19, 30),
(1, 10000.00, 19, 19),
(1, 10000.00, 20, 10),
(1, 5000.00, 20, 18),
(1, 25000.00, 21, 1),
(1, 8000.00, 22, 5),
(2, 12000.00, 23, 11),
(1, 45000.00, 24, 21),
(1, 18000.00, 25, 23),
(2, 5000.00, 26, 18),
(1, 45000.00, 27, 27),
(2, 10000.00, 28, 12),
(1, 12000.00, 29, 31),
(1, 20000.00, 30, 20);
GO

CREATE VIEW vw_LaporanPenjualanDetail_ AS
SELECT 
    o.OrderId,
    o.NamaKustomer,
    o.NomorAntrian,
    o.TipeOrder,
    o.CreatedAt AS WaktuOrder,
    m.KodeMeja,
    mn.NamaMenu,
    s.Jumlah AS JumlahBeli,
    s.HargaOrder,
    (s.Jumlah * s.HargaOrder) AS SubTotal
FROM [Order] o
LEFT JOIN Meja m ON o.MejaId = m.MejaId
INNER JOIN Struk s ON o.OrderId = s.OrderId
INNER JOIN Menu mn ON s.MenuId = mn.MenuId;
GO

SELECT * FROM vw_LaporanPenjualanDetail;
GO

-- 1. Jalankan pembuatan Function
CREATE FUNCTION fn_HitungTotalOrder (@OrderId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2) = 0.00;
    DECLARE @Jumlah INT;
    DECLARE @HargaOrder DECIMAL(18,2);

    DECLARE ItemCursor CURSOR FOR 
        SELECT Jumlah, HargaOrder 
        FROM Struk 
        WHERE OrderId = @OrderId;

    OPEN ItemCursor;
    FETCH NEXT FROM ItemCursor INTO @Jumlah, @HargaOrder;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Total = @Total + (@Jumlah * @HargaOrder);
        FETCH NEXT FROM ItemCursor INTO @Jumlah, @HargaOrder;
    END;

    CLOSE ItemCursor;
    DEALLOCATE ItemCursor;

    RETURN @Total;
END;
GO

-- 2. Jalankan pembuatan Trigger
CREATE TRIGGER trg_KurangiStokMenu
ON Struk
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Menu
    SET Stok = Menu.Stok - inserted.Jumlah
    FROM Menu
    INNER JOIN inserted ON Menu.MenuId = inserted.MenuId;

    IF EXISTS (SELECT 1 FROM Menu WHERE Stok = 0)
    BEGIN
        RAISERROR ('Transaksi dibatalkan! Stok menu tidak mencukupi.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- 3. Jalankan pembuatan Stored Procedure
CREATE PROCEDURE sp_BuatOrderBaru
    @NamaKustomer NVARCHAR(100),
    @NomorAntrian INT,
    @TipeOrder INT,
    @MetodePembayaran INT,
    @MejaId INT,
    @MenuId INT,
    @JumlahBeli INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @NewOrderId INT;
        INSERT INTO [Order] (NamaKustomer, NomorAntrian, Status, TipeOrder, CreatedAt, Catatan, MetodePembayaran, MejaId)
        VALUES (@NamaKustomer, @NomorAntrian, 0, @TipeOrder, GETDATE(), NULL, @MetodePembayaran, @MejaId);

        SET @NewOrderId = SCOPE_IDENTITY();

        INSERT INTO Struk (Jumlah, HargaOrder, OrderId, MenuId)
        VALUES (
            @JumlahBeli, 
            (SELECT HargaAsli FROM Menu WHERE MenuId = @MenuId), 
            @NewOrderId, 
            @MenuId
        );

        COMMIT TRANSACTION;
        PRINT 'Order baru berhasil dibuat!';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Contoh: Ingin melihat total harga untuk Order dengan ID = 5
SELECT dbo.fn_HitungTotalOrder(5) AS TotalHargaOrder;

-- Saat Anda memasukkan data baru ke tabel Struk seperti ini:
INSERT INTO Struk (Jumlah, HargaOrder, OrderId, MenuId)
VALUES (2, 15000, 10, 1);
-- Secara otomatis, trigger akan langsung:
-- 1. Mengurangi stok Menu dengan MenuId = 3 sebanyak 2 buah di tabel Menu.
-- 2. Mengecek apakah stoknya minus. Jika ya, transaksi dibatalkan.

EXEC sp_BuatOrderBaru 
    @NamaKustomer = 'Safri', 
    @NomorAntrian = 12, 
    @TipeOrder = 1,          -- Contoh: 1 untuk Dine-In
    @MetodePembayaran = 2,   -- Contoh: 2 untuk QRIS/Transfer
    @MejaId = 5,             -- Nomor meja
    @MenuId = 3,             -- Menu yang dibeli (misal: Chicken Katsu)
    @JumlahBeli = 2;         -- Jumlah pesanan

SELECT * FROM [ORDER] WHERE NamaKustomer = 'Safri'

SELECT * FROM STRUK WHERE MenuId = 3

SELECT *  FROM [Order] o
INNER JOIN Struk s ON o.OrderId = s.OrderId
WHERE o.NamaKustomer = 'Safri'