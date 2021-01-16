INSERT INTO [Kota] (IdKota, NamaKota)
VALUES
	(1, 'Bali')

INSERT INTO [FotoWisata] (IdFotoWisata, FotoWisata)
VALUES
	('FP001', 'https://travel.tribunnews.com/2019/08/14/info-rute-dan-harga-tiket-masuk-pantai-pandawa-bali-tahun-2019')
	
INSERT INTO [Wisata] (IdWisata, NamaWisata, DeskripsiWisata, IdFotoWisata, IdKota)
VALUES
	('WI001', 'Pantai Pandawa', 'Pantai yang indah', 'FP001', 1)  	

INSERT INTO [DestinasiPaket] (IdDestinasi, IdWisata)
VALUES
	('DT001', 'WI001')
 
INSERT INTO [FasilitasPaket] (IdFasilitas, NamaFasilitas, DeskripsiFasilitas)
VALUES
	('FA001','Hotel', 'Mendapatkan penginapan dan makan pagi')

INSERT INTO [Paket] (IdPaket, NamaPaket, HargaPaket, KetersediaanPaket, RatingPaket, IdDestinasi, IdFasilitas)
VALUES
	('PA001', 'PengenLiburan', 1500000, 0, 4.9, 'DT001', 'FA001') 	

INSERT INTO [Agen] (IdAgen, NamaAgen, LogoAgen, BannerAgen, DeskripsiAgen, VerifiedAgen, IdKota, IdPaket)
VALUES
	('AG001', 'Lipai Simanjeng', 'https://play.google.com/store/apps/details?id=com.versatech.atris.fishtourtravel&hl=in', 'https://' ,'Siap Mengantarkan Kemana saja', 0, 1, 'PA001')

INSERT INTO [Guide] (IdGuide, NamaGuide, HargaGuide, RatingGuide, VerifiedGuide, CertificateGuide, IdKota)
VALUES
	('GU001', 'Sepi', 400000, 4.8, 0, 1, 1)

INSERT INTO [TrainingDetail] (IdTrainingDetail, TrainingName, TrainingDetail, DateCompletion)
VALUES
	('TR001', 'Berbicara', 'LatihanBerbicara', NULL)

INSERT INTO [GuideTraining] (IdTraining, TrainingStatus, DateCompletion, IdGuide, IdTrainingDetail)
VALUES
	('TI001', 1, NULL, 'GU001', 'TR001')

INSERT INTO [Pembeli] (IdPembeli, NamaPembeli, JenisKelamin, UsiaPembeli, NomorPembeli, FotoDokumen)
VALUES
	('PE001', 'Sukiman', 'L', 27, '081', 'https://www.tribunnewswiki.com/2019/07/11/kasino-hadiwibowo-kasino-warkop-dki')

INSERT INTO [DetailTransaksi] (IdDetailTransaksi, IdTransaksiPaket, IdTrasnaksiGuide)
VALUES
	('DE001', 'DP001', NULL)

INSERT INTO [Transaksi] (IdTransaksi, TanggalTransaksi, JenisTransaksi, StatusTransaksi, IdDetailTransaksi, IdPembeli)
VALUES
	('TP001', '9/1/2021', 'Tunai', 'Pesanan Dikonfirmasi', 'DE001', 'PE001')

INSERT INTO [RecordTransaksi] (IdRecord, IdTransaksi)
VALUES
	('RE001', 'TP001')

INSERT INTO [AkunAdmin] (IdUser, EmailUser, PasswordUser, IdProfile)
VALUES
	('US001', 'lipaisimanjeng@gmail.com', 'lipaigans', 'PR001')

INSERT INTO [Profile Akun] (IdProfile,IdAgen, IdGuide)
VALUES
	('PR001', 'AG001', NULL)