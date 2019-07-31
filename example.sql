-- Select by card name
SELECT * FROM CARDS WHERE LOWER(NAME) LIKE '%dragon%';
SELECT * FROM CARDS WHERE LOWER(NAME) LIKE '%angel%';

-- Select by color
-- Select only for any cards with black as a color
SELECT * FROM CARDS WHERE LOWER(COLOR) LIKE '%b%';
-- Select only for any cards with blue as a color
SELECT * FROM CARDS WHERE LOWER(COLOR) LIKE '%u%';
-- Select only for any cards with blue and black colors
SELECT * FROM CARDS WHERE LOWER(COLOR) LIKE '%u%' and LOWER(COLOR) LIKE '%b%';
-- Select only for cards with blue color or black color but not blue and black
SELECT * FROM CARDS WHERE LOWER(COLOR) LIKE '%u%' and LOWER(COLOR) LIKE '%b%';
-- Select only for cards that are only black and not any other color
SELECT * FROM CARDS WHERE LOWER(COLOR) LIKE '%b%' AND LOWER(COLOR) NOT LIKE '%u%' AND LOWER(COLOR) NOT LIKE '%g%' AND LOWER(COLOR) NOT LIKE '%r%' AND LOWER(COLOR) NOT LIKE '%w%';
-- Select by Text
-- Any word from text
SELECT * FROM CARDS WHERE LOWER(TEXT) LIKE '%tap%';
-- Look for the tap effect
SELECT * FROM CARDS WHERE LOWER(TEXT) LIKE '%{T}%';
-- Keyword selection from text
SELECT * FROM CARDS WHERE LOWER(TEXT) LIKE '%flying%';
-- Grab by type
SELECT * FROM CARDS WHERE TYPE = 'Instant';
-- Select by power and toughness
-- Short circuiting lets us get around *
SELECT * FROM CARDS WHERE NOT REGEXP_LIKE(POWER, '[^0-9]+') AND CAST(POWER AS INT) > 2;
-- Get all power and toughness greather than 6 with no * or .
SELECT * FROM CARDS WHERE NOT REGEXP_LIKE(POWER, '[^0-9]+') AND CAST(POWER AS INT) > 6 AND NOT REGEXP_LIKE(TOUGHNESS, '[^0-9]+') AND CAST(TOUGHNESS AS INT) > 6;

-- Find Card prices for a specific card
SELECT * FROM CARDS JOIN PRICE ON CARDS.UUID=PRICE.UUID WHERE name = 'Llanowar Elves' ORDER BY LISTING_DATE;


-- Add users into the database
INSERT INTO USERS (username, password, name, email) VALUES ('robert', '123456', 'robert', 'robert@gmail.com');

-- PL
-- Add cards into deck

CREATE OR REPLACE PROCEDURE INSERTCARD 
(CARD_UUID IN cards.uuid%type, USER_USERNAME IN users.username%type)
AS 
    current_copies deck.copies%type;
BEGIN
    SELECT copies INTO current_copies 
    FROM 
        DECK 
    WHERE uuid=card_uuid AND username=user_username;
    DBMS_OUTPUT.PUT_LINE( '|| copies||');

    IF current_copies < 4 THEN
        UPDATE DECK SET uuid=card_uuid, username=user_username, copies=current_copies + 1;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        INSERT INTO DECK (uuid, username, copies) VALUES (card_uuid, user_username, 1);

END INSERTCARD;


-- Run the stored procedure
EXECUTE INSERTCARD('8f9a35d5-a3a2-556b-88da-6686da3aaa34', 'robert');

-- Remove card from deck

CREATE OR REPLACE PROCEDURE REMOVECARD 
(CARD_UUID IN cards.uuid%type, USER_USERNAME IN users.username%type)
AS 
    current_copies deck.copies%type;
BEGIN
 SELECT copies INTO current_copies 
    FROM 
        DECK 
    WHERE uuid=card_uuid AND username=user_username;
    IF current_copies = 0 THEN
        DBMS_OUTPUT.PUT_LINE( '0 copies found');
    ELSE
        UPDATE DECK SET uuid=card_uuid, username=user_username, copies=current_copies - 1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        DBMS_OUTPUT.PUT_LINE( 'No copies found');
END REMOVECARD;

--Remove Card run stored procedure
EXECUTE REMOVECARD('8f9a35d5-a3a2-556b-88da-6686da3aaa34', 'robert');

-- Getting Decks based on what the person added
SELECT DECK.COPIES, CARDS.* FROM DECK JOIN CARDS ON DECK.UUID=CARDS.UUID WHERE USERNAME='robert';

