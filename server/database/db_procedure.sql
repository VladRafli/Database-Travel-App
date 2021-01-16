-- Select All Tour Guide for each City
CREATE PROCEDURE [Show_City_TourGuideList] @city VARCHAR(50), @lowRating DECIMAL(1, 1), @highRating DECIMAL(1, 1) AS
    BEGIN
        DECLARE [Search_City] CURSOR
            FOR
                -- Using View [City_List]
                SELECT  *
                FROM    [City_List]
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
        
        CLOSE [Search_City]
        DEALLOCATE [Search_City]
    END

GO;

-- Select All Travel Package for each City
CREATE PROCEDURE [Show_City_PackageList] @city VARCHAR(50), @lowRating DECIMAL(1, 1), @highRating DECIMAL(1, 1) AS
    BEGIN
        DECLARE [Search_City] CURSOR
            FOR
                -- Using View [City_List]
                SELECT  *
                FROM    [City_List]
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
        
        CLOSE [Search_City]
        DEALLOCATE [Search_City]
    END

GO;

-- Select Spesific Travel Package with its Details

CREATE PROCEDURE [PaketDetail] @IdPaket CHAR(6) AS
    BEGIN
        -- Using View [DetailPaket]
        SELECT      *
        FROM        [DetailPaket]
        WHERE       IdPaket = @IdPaket
    END

GO;

-- Select Spesific Destination Package with its Details

CREATE PROCEDURE [DetailWisata] @IdWisata CHAR(6) AS
    BEGIN
        -- Using View [WisataDetail]
        SELECT      *
        FROM        [WisataDetail]
        WHERE       IdWisata = @IdWisata
    END

GO;

-- Select specific Admin Account by Email for Verification

CREATE PROCEDURE [Admin_Account] @email VARCHAR(50) AS
    BEGIN
        DECLARE [Search_Account] CURSOR
            FOR
                -- Using View [AkunAdminList]
                SELECT  EmailUser
                FROM    [AkunAdminList]
                WHERE   EmailUser = @email

        DECLARE @searched_account VARCHAR(50)

        FETCH NEXT FROM [Search_Account] INTO @searched_account

        IF @@FETCH_STATUS <> 0
            PRINT 'Account that you find not available! Or there is Fetch Error...'
        
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SELECT      EmailUser,
                            PasswordUser
                FROM        [AkunAdminList]
                WHERE       EmailUser = @searched_account
            END
        
        CLOSE [Search_Account]
        DEALLOCATE [Search_Account]
    END

GO;

-- Select Admin Profile Details

CREATE PROCEDURE [Admin_Profile] @IdUser CHAR(6) AS
    BEGIN
        -- I'm a bit lazy, so i join both all the table
        SELECT      *
        FROM        [DetailAkunAdmin]
        WHERE       IdUser = @IdUser
    END

GO;