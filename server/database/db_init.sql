-- Create Database
CREATE DATABASE [Travel_App];
-- Use Appropriate Database
USE [Travel_App];

/**
 * Create Database Tables
 **/

-- Table Kota
CREATE TABLE [Kota] (
    IdKota INT NOT NULL UNIQUE,
    NamaKota VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdKota)
);
-- Table FotoWisata
CREATE TABLE [FotoWisata] (
    IdFotoWisata CHAR(6) NOT NULL,
    FotoWisata VARCHAR(500) NOT NULL,
    PRIMARY KEY (IdFotoWisata),
    CONSTRAINT Check_IdFotoWisata CHECK (IdFotoWisata LIKE ('FW[0-9][0-9][0-9][0-9]'))
);
-- Table Wisata
CREATE TABLE [Wisata] (
    IdWisata CHAR(6) NOT NULL,
    NamaWisata VARCHAR(50) NOT NULL,
    DeskripsiWisata VARCHAR(300),
    IdFotoWisata CHAR(6) NOT NULL,
    IdKota INT NOT NULL,
    PRIMARY KEY (IdWisata),
    FOREIGN KEY (IdFotoWisata) REFERENCES FotoWisata(IdFotoWisata) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdKota) REFERENCES Kota(IdKota) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdWisata CHECK (IdWisata LIKE ('WS[0-9][0-9][0-9][0-9]'))
);
-- Table DestinasiPaket
CREATE TABLE [DestinasiPaket] (
    IdDestinasi CHAR(6) NOT NULL,
    IdWisata CHAR(6) NOT NULL,
    PRIMARY KEY (IdDestinasi),
    FOREIGN KEY (IdWisata) REFERENCES Wisata(IdWisata) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdDestinasi CHECK (IdDestinasi LIKE ('DS[0-9][0-9][0-9][0-9]'))
);
-- Table FasilitasPaket
CREATE TABLE [FasilitasPaket] (
    IdFasilitas CHAR(6) NOT NULL,
    NamaFasilitas VARCHAR(50) NOT NULL,
    DeskripsiFasilitas VARCHAR(300),
    PRIMARY KEY (IdFasilitas),
    CONSTRAINT Check_IdFasilitas CHECK (IdFasilitas LIKE ('FS[0-9][0-9][0-9][0-9]'))
);
-- Table Paket
CREATE TABLE [Paket] (
    IdPaket CHAR(6) NOT NULL,
    NamaPaket VARCHAR(50) NOT NULL,
    HargaPaket INT NOT NULL,
    KetersediaanPaket INT NOT NULL,
    RatingPaket DECIMAL(1, 1),
    IdDestinasi CHAR(6) NOT NULL,
    IdFasilitas CHAR(6) NOT NULL,
    IdWisata CHAR(6) NOT NULL,
    PRIMARY KEY (IdPaket),
    FOREIGN KEY (IdDestinasi) REFERENCES DestinasiPaket(IdDestinasi) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdFasilitas) REFERENCES FasilitasPaket(IdFasilitas) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdPaket CHECK (IdPaket LIKE ('PK[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_RatingPaket CHECK (RatingPaket > 0.0 AND RatingPaket < 5.0)
);
-- Table Agen
CREATE TABLE [Agen] (
    IdAgen CHAR(6) NOT NULL,
    NamaAgen VARCHAR(50) NOT NULL,
    LogoAgen VARCHAR(500),
    BannerAgen VARCHAR(500),
    DeskripsiAgen VARCHAR(300),
    VerifiedAgen INT NOT NULL,
    IdKota INT NOT NULL,
    IdPaket CHAR(6) NOT NULL,
    PRIMARY KEY (IdAgen),
    FOREIGN KEY (IdKota) REFERENCES Kota(IdKota) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdPaket) REFERENCES Paket(IdPaket) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT Check_IdAgen CHECK (IdAgen LIKE ('AG[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_LogoAgen CHECK (LogoAgen LIKE ('http://%') OR LogoAgen LIKE ('https://%')),
    CONSTRAINT Check_BannerAgen CHECK (BannerAgen LIKE ('http://%') OR BannerAgen LIKE ('https://%'))
);
-- Table Guide
CREATE TABLE [Guide] (
    IdGuide CHAR(6) NOT NULL,
    NamaGuide VARCHAR(50) NOT NULL,
    HargaGuide INT NOT NULL,
    RatingGuide DECIMAL(1, 1),
    VerifiedGuide INT NOT NULL,
    CertifiedGuide INT NOT NULL,
    IdKota INT NOT NULL,
    PRIMARY KEY (IdGuide),
    FOREIGN KEY (IdKota) REFERENCES Kota(IdKota) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdGuide CHECK (IdGuide LIKE ('GU[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_RatingGuide CHECK (RatingGuide > 0.0 AND RatingGuide < 5.0)
);
-- Table TrainingDetail
CREATE TABLE [TrainingDetail] (
    IdTrainingDetail CHAR(6) NOT NULL,
    TrainingName VARCHAR(50) NOT NULL,
    TrainingDetail VARCHAR(300),
    DateCompletion DATE
    PRIMARY KEY (IdTrainingDetail),
    CONSTRAINT Check_IdTrainingDetail CHECK (IdTrainingDetail LIKE ('TD[0-9][0-9][0-9][0-9]'))
);
-- Table GuideTraining
CREATE TABLE [GuideTraining] (
    IdTraining CHAR(6) NOT NULL,
    TrainingStatus CHAR(20) NOT NULL,
    DateCompletion DATE,
    IdGuide CHAR(6) NOT NULL,
    IdTrainingDetail CHAR(6) NOT NULL,
    PRIMARY KEY (IdTraining),
    FOREIGN KEY (IdGuide) REFERENCES Guide(IdGuide) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdTrainingDetail) REFERENCES TrainingDetail(IdTrainingDetail) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdTraining CHECK (IdTraining LIKE ('TN[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_TrainingStatus CHECK (TrainingStatus IN ('Selesai', 'Belum Selesai'))
);
-- Table Pembeli
CREATE TABLE [Pembeli] (
    IdPembeli CHAR(6) NOT NULL,
    NamaPembeli VARCHAR(100) NOT NULL,
    JenisKelamin CHAR(1) NOT NULL,
    UsiaPembeli INT NOT NULL,
    NomorPembeli INT NOT NULL,
    FotoDokumen VARCHAR(200) NOT NULL,
    PRIMARY KEY (IdPembeli),
    CONSTRAINT Check_IdPembeli CHECK (IdPembeli LIKE ('CU[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_JenisKelamin CHECK (JenisKelamin IN ('L', 'P')),
    CONSTRAINT Check_FotoDokumen CHECK (FotoDokumen LIKE ('http://%') OR FotoDokumen LIKE ('https://%'))
);
-- Table DetailTransaksi
CREATE TABLE [DetailTransaksi] (
    IdDetailTransaksi CHAR(6) NOT NULL,
    IdTransaksiPaket CHAR(6) NOT NULL,
    IdTransaksiGuide CHAR(6) NOT NULL,
    PRIMARY KEY (IdDetailTransaksi),
    FOREIGN KEY (IdTransaksiPaket) REFERENCES Paket(IdPaket) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (IdTransaksiGuide) REFERENCES Guide(IdGuide) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT Check_IdDetailTransaksi CHECK (IdDetailTransaksi LIKE ('DT[0-9][0-9][0-9][0-9]'))
);
-- Table Transaksi
CREATE TABLE [Transaksi] (
    IdTransaksi CHAR(6) NOT NULL,
    TanggalTransaksi DATE NOT NULL,
    JenisTransaksi VARCHAR(50) NOT NULL,
    StatusTransaksi CHAR(50) NOT NULL,
    IdDetailTransaksi CHAR(6) NOT NULL,
    IdPembeli CHAR(6) NOT NULL,
    PRIMARY KEY (IdTransaksi),
    FOREIGN KEY (IdDetailTransaksi) REFERENCES DetailTransaksi(IdDetailTransaksi) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdPembeli) REFERENCES Pembeli(IdPembeli) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdTransaksi CHECK (IdTransaksi LIKE ('TR[0-9][0-9][0-9][0-9]')),
    CONSTRAINT Check_JenisTransaksi CHECK (JenisTransaksi IN ('Credit', 'Tunai')),
    CONSTRAINT Check_StatusTransaksi CHECK (StatusTransaksi IN ('Belum Dibayar', 'Menunggu Konfirmasi Agen', 'Dibatalkan Oleh Agen', 'Dibatalkan Oleh Pembeli', 'Pesanan Dikonfirmasi'))
);
-- Table RecordTransaksi
CREATE TABLE [RecordTransaksi] (
    IdRecord CHAR(6) NOT NULL,
    IdTransaksi CHAR(6) NOT NULL,
    PRIMARY KEY (IdRecord),
    FOREIGN KEY (IdTransaksi) REFERENCES Transaksi(IdTransaksi) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Check_IdRecord CHECK (IdRecord LIKE ('RC[0-9][0-9][0-9][0-9]'))
);
-- Table ProfileAkun
CREATE TABLE [ProfileAkun] (
    IdProfile CHAR(6) NOT NULL,
    IdAgen CHAR(6) NOT NULL,
    IdGuide CHAR(6) NOT NULL,
    PRIMARY KEY (IdProfile),
    FOREIGN KEY (IdAgen) REFERENCES Agen(IdAgen) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (IdGuide) REFERENCES Guide(IdGuide) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT Check_IdProfile CHECK (IdProfile LIKE ('PR[0-9][0-9][0-9][0-9]'))
);
-- Table AkunAdmin
CREATE TABLE [AkunAdmin] (
    IdUser INT NOT NULL UNIQUE,
    EmailUser VARCHAR(100) NOT NULL,
    PasswordUser VARCHAR(100) NOT NULL,
    IdProfile CHAR(6) NOT NULL,
    PRIMARY KEY (IdUser),
    FOREIGN KEY (IdProfile) REFERENCES ProfileAkun(IdProfile) ON DELETE CASCADE ON UPDATE CASCADE
);