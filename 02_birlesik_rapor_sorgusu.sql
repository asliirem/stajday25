-- =========================================================
-- Birleşik Satış + Stok Raporu (Çoklu Filtreli)
-- Staj Günü 25: Rapor sorgusu üzerinde yapılan çalışma
--
-- NOT: Bu sorgu üzerindeki çalışma bugün kısmen tamamlandı.
-- Tarih aralığı, kategori ve minimum satış miktarı filtreleri
-- eklendi. Müşteri şehrine göre filtreleme ve sayfalama
-- (paging) gibi bölümler üzerinde çalışmaya devam edilecek
-- (bkz. TODO notları).
-- =========================================================

DECLARE @BaslangicTarihi DATE = '2026-08-01';
DECLARE @BitisTarihi     DATE = '2026-08-31';
DECLARE @Kategori        NVARCHAR(50) = NULL;   -- NULL ise tüm kategoriler
DECLARE @MinSatisMiktari INT = NULL;             -- NULL ise filtre uygulanmaz

SELECT
    p.ProductId,
    p.ProductName AS UrunAdi,
    p.Category AS Kategori,
    p.StockQty AS MevcutStok,
    ISNULL(SUM(o.Quantity), 0) AS DonemSatisMiktari,
    ISNULL(SUM(o.Quantity * p.UnitPrice), 0) AS DonemSatisTutari
FROM Products p
LEFT JOIN Orders o
    ON p.ProductId = o.ProductId
    AND o.OrderDate BETWEEN @BaslangicTarihi AND @BitisTarihi
WHERE
    (@Kategori IS NULL OR p.Category = @Kategori)
GROUP BY p.ProductId, p.ProductName, p.Category, p.StockQty
HAVING
    (@MinSatisMiktari IS NULL OR ISNULL(SUM(o.Quantity), 0) >= @MinSatisMiktari)
ORDER BY DonemSatisMiktari DESC;

-- =========================================================
-- Kullanım örnekleri:
--
-- Sadece Elektronik kategorisindeki ürünler:
--   SET @Kategori = 'Elektronik';
--
-- Dönemde en az 5 adet satılmış ürünler:
--   SET @MinSatisMiktari = 5;
-- =========================================================

-- TODO: Müşteri şehrine göre filtreleme eklenecek
--       (Orders -> Customers JOIN'i gerektirir, bu sorguda henüz yok)
-- TODO: Sayfalama (OFFSET / FETCH NEXT) eklenerek büyük sonuç
--       kümelerinin sayfa sayfa getirilmesi sağlanacak
-- TODO: Sonuçların doğruluğunun örnek veriler üzerinde elle
--       karşılaştırılarak kontrol edilmesi (bugünkü çalışmada
--       kısmen yapıldı, tamamlanacak)
