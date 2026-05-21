-- Create SalesData table
CREATE TABLE SalesData (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    City VARCHAR(50) NOT NULL,
    PurchaseAmount DECIMAL(10, 2) NOT NULL,
    PurchaseDate DATE NOT NULL
);

-- Insert 10,000 rows of random data
-- Using a stored procedure for efficient bulk insertion
DELIMITER $$

CREATE PROCEDURE InsertSalesData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_age INT;
    DECLARE random_purchase DECIMAL(10, 2);
    DECLARE random_days INT;
    DECLARE random_city VARCHAR(50);
    DECLARE random_name VARCHAR(100);
    
    -- List of first names
    DECLARE first_names VARCHAR(1000) DEFAULT 'John,Mary,Robert,Patricia,Michael,Jennifer,William,Linda,David,Barbara,Richard,Susan,Joseph,Jessica,Thomas,Sarah,Charles,Karen,Christopher,Lisa,Donald,Nancy,Matthew,Betty,Mark,Margaret,Donald,Sandra,Steven,Ashley,Paul,Kimberly,Andrew,Emily,Joshua,Donna,Kenneth,Michelle,Kevin,Carol,Brian,Amanda,George,Melissa,Edward,Deborah,Ronald,Stephanie,Anthony,Rebecca,Frank,Sharon,Ryan,Laura,Gary,Cynthia,Nicholas,Kathleen,Eric,Amy,Jonathan,Shirley,Stephen,Angela,Larry,Helen,Justin,Anna,Scott,Brenda,Brandon,Pamela,Benjamin,Emma,Samuel,Nicole,Raymond,Helen,Gregory,Samantha,Jerry,Katherine,Dennis,Christine,Walter,Debra,Patrick,Rachel,Peter,Catherine,Harold,Carolyn,Douglas,Janet,Henry,Ruth,Carl,Katherine,Arthur,Sophia,Ryan,Alice,Billy,Judith,Bruce,Rose,Ralph,Jean,Roy,Abigail,Russell,Alice,Louis,Judy,Joe,Sophia,Bill,Grace,Dale,Denise,Clyde,Marilyn,Henry,Amber,Chester,Violet,Cecil,Danielle,Daryl,Brittany';
    DECLARE last_names VARCHAR(1000) DEFAULT 'Smith,Johnson,Williams,Brown,Jones,Garcia,Miller,Davis,Rodriguez,Martinez,Hernandez,Lopez,Gonzalez,Wilson,Anderson,Thomas,Taylor,Moore,Jackson,Martin,Lee,Perez,Thompson,White,Harris,Sanchez,Clark,Ramirez,Lewis,Robinson,Young,Stroud,Allen,King,Wright,Gutierrez,Hill,Fulton,Mills,Vincent,Greene,Obryant,Cain,Humphrey,Barker,Hines,Dickson,Reeves,Pace,Stokes,Atkins,Mullen,Gilmore,Eastman,Crosby,Kaufman,Malone,Wolfe,Deleon,Sosa,Booker,Wilkins,Sumner,Forrest,Hamburg,Larson,Frazier,Draper,Vickers,Sears,Prince,Stewart,Singleton,Ellison,Sloan,Juarez,Campos,Gaines,Duran,Mccarty,Parrott,Rodriquez,Parks,Dawson,Santiago,Norris,Hardy,Mccoy,Farley,Doherty,Crowell,Conley,Davenport,Day,Mcinniss,Melvin,Epperson,Sellers,Delgado,Colon,Parham,Mahoney,Dominguez,Landry,Pitts,Middleton,Summers,Mcgill,Winters,Ramos,Phelps,Mccarthy,Graves,Pryor,Kirk,Mcginnis,Rossi,Ritter,Creamer,Dalton,Conner,Vogel,Ledford,Mccullough,Bowers,Oconnor,Waller,Felder,Roberson,Underwood,Terrell,Seals,Selfridge,Spence,Shelton,Mccreary,Walls,Irvine,Shepherd,Manning,Shoemaker,Stocks,Scarborough,Posey,Massey,Stephenson,Branch,Masterson,Leach,Levine,Segura,Stafford,Teague,Mcarthur,Judd,Robison,Morales';
    DECLARE cities_list VARCHAR(1000) DEFAULT 'New York,Los Angeles,Chicago,Houston,Phoenix,Philadelphia,San Antonio,San Diego,Dallas,San Jose,Austin,Jacksonville,Fort Worth,Columbus,Charlotte,San Francisco,Indianapolis,Seattle,Denver,Washington,Boston,El Paso,Nashville,Detroit,Oklahoma City,Portland,Las Vegas,Memphis,Louisville,Baltimore,Milwaukee,Albuquerque,Tucson,Fresno,Bakersfield,Tampa,Aurora,Anaheim,New Orleans,Arlington,Saint Paul,Corpus Christi,Riverside,Stockton,Cincinnati,Saint Louis,Lexington,Henderson,Pittsburgh,Plano,Atlanta,Long Beach,Glendale,Irving,Garland,Gilbert,Hialeah,Laredo,Madison,Chandler,Scottsdale,Irvine,Baton Rouge,Moreno Valley,Fontana,Brownsville,Providence,Birmingham,Salt Lake City,Jackson,Huntsville,Tallahassee,Shreveport,Grand Prairie,Des Moines,Mobile,San Bernardino,Akron,Reno,Spokane,Montgomery,Modesto,Durango,Durham,Lubbock,Boise,Laredo';
    
    START TRANSACTION;
    
    WHILE i <= 10000 DO
        -- Generate random age (18-80)
        SET random_age = FLOOR(18 + (RAND() * 62));
        
        -- Generate random purchase amount (10.00 - 5000.00)
        SET random_purchase = ROUND(10 + (RAND() * 4990), 2);
        
        -- Generate random days offset from today (-365 to 0)
        SET random_days = FLOOR(-365 + (RAND() * 365));
        
        -- Extract a random name (simplified approach)
        SET random_name = CONCAT(
            ELT(FLOOR(1 + RAND() * 100), 'John','Mary','Robert','Patricia','Michael','Jennifer','William','Linda','David','Barbara','Richard','Susan','Joseph','Jessica','Thomas','Sarah','Charles','Karen','Christopher','Lisa','Donald','Nancy','Matthew','Betty','Mark','Margaret','Donald','Sandra','Steven','Ashley','Paul','Kimberly','Andrew','Emily','Joshua','Donna','Kenneth','Michelle','Kevin','Carol','Brian','Amanda','George','Melissa','Edward','Deborah','Ronald','Stephanie','Anthony','Rebecca','Frank','Sharon','Ryan','Laura','Gary','Cynthia','Nicholas','Kathleen','Eric','Amy','Jonathan','Shirley','Stephen','Angela','Larry','Helen','Justin','Anna','Scott','Brenda','Brandon','Pamela','Benjamin','Emma','Samuel','Raymond','Gregory','Jerry','Dennis','Walter','Patrick','Peter','Harold','Douglas','Henry','Carl','Arthur','Ryan','Billy','Bruce','Ralph','Roy','Russell','Louis','Joe','Bill','Dale','Clyde','Henry','Chester','Cecil','Daryl'),
            ' ',
            ELT(FLOOR(1 + RAND() * 100), 'Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Rodriguez','Martinez','Hernandez','Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Moore','Jackson','Martin','Lee','Perez','Thompson','White','Harris','Sanchez','Clark','Ramirez','Lewis','Robinson','Young','Stroud','Allen','King','Wright','Gutierrez','Hill','Fulton','Mills','Vincent','Greene','Obryant','Cain','Humphrey','Barker','Hines','Dickson','Reeves','Pace','Stokes','Atkins','Mullen','Gilmore','Eastman','Crosby','Kaufman','Malone','Wolfe','Deleon','Sosa','Booker','Wilkins','Sumner','Forrest','Hamburg','Larson','Frazier','Draper','Vickers','Sears','Prince','Stewart','Singleton','Ellison','Sloan','Juarez','Campos','Gaines','Duran','Mccarty','Parrott','Rodriquez','Parks','Dawson','Santiago','Norris','Hardy','Mccoy','Farley','Doherty')
        );
        
        -- Extract a random city
        SET random_city = ELT(FLOOR(1 + RAND() * 50), 'New York','Los Angeles','Chicago','Houston','Phoenix','Philadelphia','San Antonio','San Diego','Dallas','San Jose','Austin','Jacksonville','Fort Worth','Columbus','Charlotte','San Francisco','Indianapolis','Seattle','Denver','Washington','Boston','El Paso','Nashville','Detroit','Oklahoma City','Portland','Las Vegas','Memphis','Louisville','Baltimore','Milwaukee','Albuquerque','Tucson','Fresno','Bakersfield','Tampa','Aurora','Anaheim','New Orleans','Arlington','Saint Paul','Corpus Christi','Riverside','Stockton','Cincinnati','Saint Louis','Lexington','Henderson','Pittsburgh','Plano','Atlanta');
        
        INSERT INTO SalesData (Name, Age, City, PurchaseAmount, PurchaseDate)
        VALUES (random_name, random_age, random_city, random_purchase, DATE_ADD(CURDATE(), INTERVAL random_days DAY));
        
        SET i = i + 1;
        
        -- Commit every 1000 rows for better performance
        IF i % 1000 = 0 THEN
            COMMIT;
            START TRANSACTION;
        END IF;
    END WHILE;
    
    COMMIT;
END$$

DELIMITER ;

-- Execute the stored procedure
CALL InsertSalesData();

-- Verify the data
SELECT COUNT(*) AS TotalRows FROM SalesData;
SELECT * FROM SalesData LIMIT 10;