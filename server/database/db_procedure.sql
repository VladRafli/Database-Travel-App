-- Select All Tour Guide for each City
CREATE PROCEDURE [Show_City_TourGuideList] @city VARCHAR(50), @lowRating DECIMAL(1, 1), @highRating DECIMAL(1, 1) AS
    BEGIN
        DECLARE [Search_City] CURSOR
            FOR
                SELECT  NamaKota
                FROM    Kota
                WHERE   NamaKota = @city

        DECLARE @searched_city VARCHAR(50)

        OPEN [Search_City]

        FETCH NEXT FROM [Search_City] INTO @searched_city

        IF @@FETCH_STATUS <> 0
            PRINT 'City that you find not available! Or there is Fetch Error...'
        
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SELECT  *
                FROM    Kota
                JOIN    Guide ON Guide.IdKota = Kota.IdKota
                WHERE   Kota.NamaKota = @searched_city
                AND     Guide.RatingGuide BETWEEN @lowRating AND @highRating
            END
    END

GO;

-- Select All Travel Package for each City
CREATE PROCEDURE [Show_City_PackageList] @city VARCHAR(50), @lowRating DECIMAL(1, 1), @highRating DECIMAL(1, 1) AS
    BEGIN
        DECLARE [Search_City] CURSOR
            FOR
                SELECT  NamaKota
                FROM    Kota
                WHERE   NamaKota = @city

        DECLARE @searched_city VARCHAR(50)

        OPEN [Search_City]

        FETCH NEXT FROM [Search_City] INTO @searched_city

        IF @@FETCH_STATUS <> 0
            PRINT 'City that you find not available! Or there is Fetch Error...'
        
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SELECT  IdPaket
                        NamaPaket,
                        HargaPaket,
                        KetersediaanPaket,
                        RatingPaket
                FROM    Kota
                JOIN    Agen ON Agen.IdKota = Kota.IdKota
                JOIN    Paket ON Paket.IdAgen = Agen.IdAgen
                WHERE   Kota.NamaKota = @searched_city
                AND     Paket.RatingPaket BETWEEN @lowRating AND @highRating
            END
    END

GO;

-- Select Spesific Travel Package with its Details

CREATE PROCEDURE [PaketDetail] @IdPaket CHAR(6) AS
    BEGIN
        SELECT      *
        FROM        Paket
        JOIN        DestinasiPaket ON DestinasiPaket.IdDestinasi = Paket.IdDestinasi
        JOIN        FasilitasPaket ON FasilitasPaket.IdFasilitas = Paket.IdFasilitas
        JOIN        Wisata ON Wisata.IdWisata = DestinasiPaket.IdWisata
        WHERE       IdPaket = @IdPaket
    END

GO;

-- Select Spesific Destination Package with its Details

CREATE PROCEDURE [DetailWisata] @IdWisata CHAR(6) AS
    BEGIN
        SELECT      *
        FROM        Wisata
        JOIN        FotoWisata ON FotoWisata.IdFotoWisata = Wisata.IdFotoWisata
        JOIN        Kota ON Kota.IdKota = Wisata.IdKota
        WHERE       IdWisata = @IdWisata
    END

GO;

-- Select specific Admin Account by Email for Verification

CREATE PROCEDURE [Admin_Account] @email VARCHAR(50) AS
    BEGIN
        DECLARE [Search_Account] CURSOR
            FOR
                SELECT  EmailUser
                FROM    AkunAdmin
                WHERE   EmailUser = @email

        DECLARE @searched_account VARCHAR(50)

        FETCH NEXT FROM [Search_Account] INTO @searched_account

        IF @@FETCH_STATUS <> 0
            PRINT 'Account that you find not available! Or there is Fetch Error...'
        
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SELECT      EmailUser,
                            PasswordUser
                FROM        AkunAdmin
                WHERE       EmailUser = @searched_account
            END
    END

GO;

-- Select Admin Profile Details

CREATE PROCEDURE [Admin_Profile] @IdUser CHAR(6) AS
    BEGIN
        -- I'm a bit lazy, so i join both all the table
        SELECT      *
        FROM        AkunAdmin
        JOIN        Profile ON Profile.IdProfile = AkunAdmin.IdProfile
        JOIN        Agen ON Agen.IdAgen = Profile.IdAgen
        JOIN        Guide ON Guide.IdGuide = Profile.IdGuide
        WHERE       AkunAdmin.IdUser = @IdUser
    END