/***************IMPORTANT!!!!*******************
    Run booki.sql before running this script!!!
***********************************************/

/**************
REGISTER
**************/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `CREATE_USER`(
    IN `uname` VARCHAR(15), 
    IN `psswd` VARCHAR(30), 
    IN `name` VARCHAR(50), 
    IN `phone` VARCHAR(10), 
    IN `email` TEXT
)
BEGIN
    INSERT INTO `user`(username, password, name, phone, email, role)
    VALUES (uname, PASSWORD(psswd), name, phone, email, 'customer');
END$$
DELIMITER ;

/*
    Procedure: CHECK_EMAIL
    Param
        - _email: email address
    Return: table(result)
        - Email exists: result = FALSE (user cannot use this mail to register new account)
        - Otherwise: result = TRUE
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `CHECK_EMAIL`(
    IN `_email` TEXT COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE result BOOLEAN;
    IF(EXISTS(
        SELECT uid
        FROM `user`
        WHERE email= _email
    )) THEN
        SET result = FALSE;
    ELSE 
        SET result = TRUE;
    END IF;
    SELECT result;
END $$
DELIMITER ;

/*
    Procedure: CHECK_PHONE
    Param
        - _phone: phone number
    Return: table(result)
        - Phone exists: result = FALSE (user cannot use this phone number to register new account)
        - Otherwise: result = TRUE
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `CHECK_PHONE`(
    IN `_phone` TEXT COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE result BOOLEAN;
    IF(EXISTS(
        SELECT uid
        FROM `user`
        WHERE phone =_phone
    )) THEN
        SET result = FALSE;
    ELSE 
        SET result = TRUE;
    END IF;
    SELECT result;
END$$
DELIMITER ;

/**************
LOGIN
**************/

/*
	Procedure: VALIDATE_LOGIN
    Param:
    	- usn: username
        - psswd: password
        - _role: role (customer, admin)
    Return value: a table of (uid, username, role)
    	- On success: return (uid, username, role) that matches the query
    	- On failure: uid = -1, username = 'failed', role = 'failed'
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `VALIDATE_LOGIN`(
    IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, 
    IN `psswd` VARCHAR(30) COLLATE utf8mb4_unicode_ci, 
    IN `_role` VARCHAR(9) COLLATE utf8mb4_unicode_ci
)
BEGIN
	
	DECLARE id INT;
    IF(EXISTS(
        SELECT uid FROM `user` 
        WHERE 
        	username = usn
        	AND password = PASSWORD(psswd)
        	AND role = _role
    )) THEN
    	SET id = (SELECT uid FROM `user` WHERE username=usn);
    ELSE
    	SET id = -1;
        SET usn = '-1';
        SET _role = '-1';
        
    END IF;
    SELECT id as uid, usn as username, _role as role;       
END$$
DELIMITER ;


/**************
USER
**************/

/*
	Procedure: GET_USER_BY_ID
    Param:
    	- id: user id
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_USER_BY_ID`( 
    IN `id` INT 
) 
BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE uid = id; 
END $$
DELIMITER ;

/*
	Procedure: GET_USER_BY_USN
    Param:
    	- usn: username
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_USER_BY_USN`( 
    IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci
) 
BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE username = usn; 
END $$
DELIMITER ;


/*
	Procedure: GET_ALL_USERS
    Param: None
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_ALL_USERS`() 
BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` ;
END $$
DELIMITER ;

/*
	Procedure: UPDATE_INFO
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `UPDATE_INFO`(
    IN `uname` VARCHAR(15), 
    IN `psswd` VARCHAR(30), 
    IN `_name` VARCHAR(50), 
    IN `_phone` VARCHAR(10), 
    IN `_email` TEXT
)
BEGIN
    UPDATE `user`
    SET
    	password = PASSWORD(psswd),
        name = _name,
        phone = _phone,
        email = _email
    WHERE
    	username = uname;
END$$
DELIMITER ;

/*
	Procedure: UPDATE_INFO
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `UPDATE_INFO`( 
    IN `uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, 
    IN `psswd` VARCHAR(30), 
    IN `_name` VARCHAR(50) COLLATE utf8mb4_unicode_ci, 
    IN `_phone` VARCHAR(10) COLLATE utf8mb4_unicode_ci, 
    IN `_email` TEXT COLLATE utf8mb4_unicode_ci 
) 
BEGIN 
    UPDATE `user` 
    SET 
        password = PASSWORD(psswd), 
        name = _name, 
        phone = _phone, 
        email = _email 
    WHERE username = uname; 
END$$
DELIMITER ;

/**************
BOOKS
**************/
/*
	Procedure: GET_BOOK
    Param: 
        - id: Book id
    Description: Get book info by id
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_BOOK`( 
    IN `id` INT 
) 
BEGIN 
	SELECT name, author, publisher, amount, description, price
    FROM `book` 
    WHERE bid = id; 
END $$
DELIMITER ;

/*
	Procedure: GET_ALL_BOOKS
    Param: None
    Description: Get info of all books in db
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_ALL_BOOKS`()
BEGIN 
	SELECT name, author, publisher, amount, description, price
    FROM `book`;
END $$
DELIMITER ;

/*
	Procedure: UPDATE_BOOK_INFO
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `UPDATE_BOOK_INFO`(
    IN id INT,
    IN _name TEXT COLLATE utf8mb4_unicode_ci,
    IN _author TEXT COLLATE utf8mb4_unicode_ci,
    IN _publisher TEXT COLLATE utf8mb4_unicode_ci,
    IN _description TEXT COLLATE utf8mb4_unicode_ci,
    IN _image TEXT COLLATE utf8mb4_unicode_ci,
    IN _amount INT,
    IN _price INT
)
BEGIN 
	UPDATE `book`
    SET 
        name = _name,
        author = _author,
        publisher = _publisher,
        description = _description,
        image = _image,
        amount = _amount,
        price = _price

    WHERE bid = id;
END $$
DELIMITER ;

/*
	Procedure: ADD_BOOK
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `ADD_BOOK`(
    IN `_name` TEXT,
    IN `_author` TEXT,
    IN `_publisher` TEXT,
    IN `_description` TEXT,
    IN `_image` TEXT,
    IN `_amount` INT,
    IN `_price` INT
)
BEGIN 
	INSERT INTO `book` (name, description, author, publisher, image, amount, price)
    VALUES(
        _name,
        _description,
        _author,
        _publisher,
        _image,
        _amount,
        _price
    );
END $$
DELIMITER ;

/*
	Procedure: REMOVE_BOOK
    Params: _bid: book id
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `REMOVE_BOOK`(
    IN `_bid` INT
)
BEGIN 
	DELETE FROM `book`
    WHERE bid = _bid;
END $$
DELIMITER ;

/**************
REVIEWS
**************/
/*
	PROCEDURE: ADD_REVIEW
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `ADD_REVIEW`(
    IN _uid INT,
    IN _bid INT,
    IN _rating INT,
    IN _comment TEXT
)
BEGIN
    INSERT INTO `review` (uid, bid, rating, comment)
    VALUES (_uid, _bid, _rating, _comment);
END $$
DELIMITER ;

/*
	PROCEDURE: GET_BOOK_REVIEWS
    Description: Get all reviews of the book by book id
    Return: table(user.name, rating, comment) 
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `GET_BOOK_REVIEWS`(
    IN _bid INT
)
BEGIN 
	SELECT user.name, rating, comment
    FROM user, book, review
    WHERE
        review.bid = _bid
        AND book.bid = review.bid
        AND user.uid = review.uid;
END $$
DELIMITER ;

/**************
CARTS
**************/

/*
	PROCEDURE: SHOW_CART_ITEMS
    Description: Show user's cart using user id
    Param
        - _uid: user id
    Return: table(book.name, amount, unit_price, total_price)
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `SHOW_CART_ITEMS`(
    IN _uid INT
)
BEGIN 
	SELECT book.name, cart.amount, book.price, cart.amount*book.price as total_price
    FROM `book`, `user`, `cart`
    WHERE
        cart.uid = _uid 
        AND cart.bid = book.bid
        AND cart.uid = user.uid;
END $$
DELIMITER ;

/*
	PROCEDURE: ADD_TO_CART
    Description: Helper procedure when user click on 'Add to cart' button
        - Book has been in the cart: increase the current amount of this book in the cart by 1
        - Book hasn't been in the cart: add new cart item with amount = 1
    Param
        - _uid: user id
        - _bid: book id
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `ADD_TO_CART`(
    IN _uid INT,
    IN _bid INT
)
BEGIN 
    IF(EXISTS(
        SELECT uid 
        FROM `cart`
        WHERE uid = _uid AND bid = _bid
    )) THEN
        UPDATE `cart`
        SET amount = amount + 1
        WHERE uid = _uid AND bid = _bid;

    ELSE 
        INSERT INTO `cart`(uid, bid, amount)
        VALUES(_uid, _bid, 1);
    END IF;
	
END $$
DELIMITER ;


/*
	PROCEDURE: UPDATE_CART_ITEM
    Description: Update amount of book in cart
    Param
        - _uid: user id
        - _bid: book id
        - _amount: amount to update
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `UPDATE_CART_ITEM`(
    IN _uid INT,
    IN _bid INT,
    IN _amount INT
)
BEGIN 
    UPDATE `cart`
    SET amount = _amount
    WHERE uid = _uid AND bid = _bid;
END $$
DELIMITER ;

/*
	PROCEDURE: REMOVE_CART_ITEM
    Description: Remove book in cart
    Param
        - _uid: user id
        - _bid: book id
*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE `REMOVE_CART_ITEM`(
    IN _uid INT,
    IN _bid INT
)
BEGIN 
    DELETE FROM `cart`
    WHERE uid = _uid AND bid = _bid;
END $$
DELIMITER ;