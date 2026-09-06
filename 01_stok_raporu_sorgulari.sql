-- =========================================================
-- Stok Raporu SQL Sorguları
-- Staj Günü 25: Raporlama modülü - Stok raporları
-- Not: Products tablosu Gün 3'te oluşturulmuştur.
-- =========================================================

-- ---------------------------------------------------------
-- 1) Temel Stok Durumu Raporu
-- Tüm ürünlerin güncel stok miktarını listeler
-- ---------------------------------------------------------
SELECT
    ProductId,
    ProductName AS UrunAdi,
    Category AS Kategori,
    UnitPrice AS BirimFiyat,
    StockQty AS StokMiktari
FROM Products
ORDER BY StockQty ASC;


-- ---------------------------------------------------------
-- 2) Stokta Olmayan Ürünler
-- ---------------------------------------------------------
SELECT
    ProductId,
    ProductName AS UrunAdi,
    Category AS Kategori
FROM Products
WHERE StockQty = 0;


-- ---------------------------------------------------------
-- 3) Kritik Stok Seviyesindeki Ürünler
-- Belirlenen eşik değerin altındaki ürünleri listeler
-- (örnek eşik: 20 adet)
-- ---------------------------------------------------------
DECLARE @KritikStokEsigi INT = 20;

SELECT
    ProductId,
    ProductName AS UrunAdi,
    StockQty AS StokMiktari
FROM Products
WHERE StockQty > 0 AND StockQty <= @KritikStokEsigi
ORDER BY StockQty ASC;


-- ---------------------------------------------------------
-- 4) Kategoriye Göre Toplam Stok Miktarı
-- ---------------------------------------------------------
SELECT
    Category AS Kategori,
    COUNT(ProductId) AS UrunCesidi,
    SUM(StockQty) AS ToplamStokMiktari
FROM Products
GROUP BY Category
ORDER BY ToplamStokMiktari DESC;


-- ---------------------------------------------------------
-- 5) Belirli Bir Tarih Aralığında Stoktan Düşen Miktar
-- (Orders tablosu üzerinden, satış nedeniyle azalan stok)
-- ---------------------------------------------------------
SELECT
    p.ProductId,
    p.ProductName AS UrunAdi,
    SUM(o.Quantity) AS SatisNedeniyleDusenStok
FROM Orders o
INNER JOIN Products p ON o.ProductId = p.ProductId
WHERE o.OrderDate BETWEEN '2026-08-01' AND '2026-08-31'
GROUP BY p.ProductId, p.ProductName
ORDER BY SatisNedeniyleDusenStok DESC;


-- ---------------------------------------------------------
-- 6) Stok ve Satış Bilgisinin Bir Arada Görüldüğü Rapor
-- Bir ürünün mevcut stoğu ile belirli dönemdeki satış miktarını karşılaştırır
-- ---------------------------------------------------------
SELECT
    p.ProductId,
    p.ProductName AS UrunAdi,
    p.StockQty AS MevcutStok,
    ISNULL(SUM(o.Quantity), 0) AS DonemSatisMiktari
FROM Products p
LEFT JOIN Orders o
    ON p.ProductId = o.ProductId
    AND o.OrderDate BETWEEN '2026-08-01' AND '2026-08-31'
GROUP BY p.ProductId, p.ProductName, p.StockQty
ORDER BY DonemSatisMiktari DESC;
