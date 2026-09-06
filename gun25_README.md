# Staj Günü 25 - Raporlama Modülü: Satış ve Stok Raporları

Bu klasör, staj kapsamında raporlama modülü üzerinde satış ve stok
bilgilerinin nasıl raporlandığına yönelik çalışmayı içerir.

> **Not:** Birleşik satış/stok raporu sorgusu üzerindeki çalışma bugün
> kısmen tamamlandı; müşteri şehrine göre filtreleme ve sayfalama gibi
> bazı bölümler ileride tamamlanmak üzere `TODO` olarak bırakıldı.

## İçerik

- **01_stok_raporu_sorgulari.sql** — Temel stok durumu, stokta olmayan
  ürünler, kritik stok seviyesi, kategoriye göre toplam stok ve
  satış/stok karşılaştırmalı raporlar için SQL sorguları.
- **02_birlesik_rapor_sorgusu.sql** — Tarih aralığı, kategori ve minimum
  satış miktarı filtrelerini birlikte kullanan parametreli, birleşik
  satış + stok raporu sorgusu (kısmen tamamlanmış, geliştirmeye açık).

> Bu sorgular Gün 3'teki `Products` ve `Orders` tabloları, Gün 19'daki
> satış raporu sorgularıyla aynı veri modeli üzerine kuruludur.

## Konu Özeti

- Satış raporu ve stok raporu farklı bilgiler gösterse de ikisi de aynı
  veritabanındaki verilerden yararlanır.
- Tarih aralığı, kategori gibi filtrelerin birlikte kullanılmasıyla daha
  detaylı sonuçlara ulaşılabilir.
- Bir raporun sadece çalışması yeterli değildir; sonuçların
  veritabanındaki gerçek kayıtlarla **tutarlı ve doğru** olduğu da ayrıca
  kontrol edilmelidir.

## Nasıl Kullanılır

1. Gün 3'teki `01_schema.sql` dosyasını çalıştırarak tabloları ve örnek
   verileri oluşturun (henüz oluşturulmadıysa).
2. `01_stok_raporu_sorgulari.sql` içindeki sorguları tek tek çalıştırarak
   farklı stok raporu türlerini inceleyin.
3. `02_birlesik_rapor_sorgusu.sql` dosyasındaki `DECLARE` değerlerini
   değiştirerek farklı filtre kombinasyonlarını test edin.
