-- Create table with its columns and data types
CREATE TABLE IF NOT EXISTS AnniversaryAttendees (
    CustomerID INT NOT NULL,
    PartySize INT NOT NULL
);

-- Show created columns
SHOW COLUMNS FROM AnniversaryAttendees;