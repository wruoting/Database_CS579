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

