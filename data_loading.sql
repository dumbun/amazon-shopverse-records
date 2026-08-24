USE AmazonShopverseRecords;

-- POST VALIDATION checks
SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
TRUNCATE TABLE shopverse_records;

-- Loading the data
LOAD DATA LOCAL INFILE '/Users/dog/Development/sql/amazon shopverse records/amazon shopverse records.csv' -- use the your file location 
INTO TABLE shopverse_records
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- checking the data 
SELECT * FROM shopverse_records;