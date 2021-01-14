-- Check All Table View
CREATE VIEW [DB_TableList] AS
    SELECT  TABLE_NAME, COLUMN_NAME, IS_NULLABLE, DATA_TYPE
    FROM    INFORMATION_SCHEMA.COLUMNS;

GO;

-- Select All Agen with All its Details View
CREATE VIEW [Agen_DetailList] AS
    SELECT  *
    FROM    Agen
    JOIN    Kota ON Agen.IdKota = Kota.IdKota
    JOIN    Paket ON Agen.IdPaket = Paket.IdPaket;

GO;

-- Select All Travel Package
CREATE VIEW [PaketList] AS
    SELECT  *
    FROM    Paket;

GO;

-- Select All Tour Guide
CREATE VIEW [TourGuideList] AS
    SELECT  *
    FROM    Guide;

GO;

-- Select Top 4 Travel Package
CREATE VIEW [Top_PaketList] AS
    SELECT      TOP 4 *
    FROM        Paket
    ORDER BY    RatingPaket;

GO;

-- Select Top 4 Tour Guide
CREATE VIEW [Top_TourGuideList] AS
    SELECT      TOP 4 *
    FROM        Guide
    ORDER BY    RatingGuide;

GO;

-- Select All Guide's Training for Certification
CREATE VIEW [Guide_TrainingList] AS
    SELECT      *
    FROM        GuideTraining
    JOIN        TrainingDetail ON TrainingDetail.IdTrainingDetail = GuideTraining.IdTrainingDetail
    GROUP BY    GuideTraining.TrainingStatus
    ORDER BY    GuideTraining.TrainingStatus DESC

GO;

-- Select All Transaction Record with its Details
CREATE VIEW [Transaction_Record] AS
    SELECT      *
    FROM        RecordTransaksi
    JOIN        Transaksi ON Transaksi.IdTransaksi = RecordTransaksi.IdTransaksi
    GROUP BY    Transaksi.IdPembeli
    ORDER BY    Transaksi.IdPembeli DESC

GO;

-- Select All Transaction with its detail
CREATE VIEW [AllTransaction_List] AS
    SELECT  *
    FROM    Transaksi
    JOIN    Pembeli ON Pembeli.IdPembeli = Transaksi.IdPembeli
    JOIN    DetailTransaksi ON DetailTransaksi.IdDetailTransaksi = Transaksi.IdDetailTransaksi

GO;