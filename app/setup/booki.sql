-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 08, 2021 at 01:06 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booki`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_BOOK` (IN `_name` TEXT, IN `_author` TEXT, IN `_publisher` TEXT, IN `_description` TEXT, IN `_image` TEXT, IN `_amount` INT, IN `_price` INT)  BEGIN 
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_ORDER_ITEM` (IN `_oid` INT, IN `_bid` INT, IN `_amount` INT)  BEGIN 
    INSERT INTO `order_item`(oid, bid, amount)
    VALUES (_oid, _bid, _amount);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_OR_UPDATE_BOOK` (IN `_bid` INT, IN `_name` TEXT COLLATE utf8mb4_unicode_ci, IN `_author` TEXT COLLATE utf8mb4_unicode_ci, IN `_publisher` TEXT COLLATE utf8mb4_unicode_ci, IN `_description` TEXT COLLATE utf8mb4_unicode_ci, IN `_image` TEXT COLLATE utf8mb4_unicode_ci, IN `_amount` INT, IN `_price` INT)  BEGIN 
    IF(_bid = -1) THEN
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
    ELSE
        UPDATE `book`
        SET 
            name = _name,
            author = _author,
            publisher = _publisher,
            description = _description,
            image = _image,
            amount = _amount,
            price = _price

        WHERE bid = _bid;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_REVIEW` (IN `_uid` INT, IN `_bid` INT, IN `_rating` INT, IN `_comment` TEXT)  BEGIN
    INSERT INTO `review` (uid, bid, rating, comment)
    VALUES (_uid, _bid, _rating, _comment);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_TO_CART` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_bid` INT, IN `_amount` INT)  BEGIN 
    SET @uid = (SELECT uid FROM `user` WHERE username = usn);

    IF EXISTS(
        SELECT uid 
        FROM `cart`
        WHERE uid = @uid AND bid = _bid
    ) 
    THEN
        UPDATE `cart`
        SET amount = amount + _amount
        WHERE uid = @uid AND bid = _bid;
    ELSE 
        INSERT INTO `cart`(uid, bid, amount)
        VALUES(@uid, _bid, _amount);
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CHANGE_ORDER_STATUS` (IN `_oid` INT, IN `_status` VARCHAR(11) COLLATE utf8mb4_unicode_ci)  BEGIN
    UPDATE `order`
    SET status = _status
    WHERE oid = _oid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CHANGE_ROLE_STATUS` (IN `_uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_role` VARCHAR(9) COLLATE utf8mb4_unicode_ci, IN `_active` TINYINT(1))  BEGIN 
    UPDATE `user` 
    SET 
        role = _role,
        active = _active
    WHERE username = _uname; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CHECK_EMAIL` (IN `_email` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CHECK_PHONE` (IN `_phone` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_ORDER` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_checkoutTime` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN 
    DECLARE maxid INT;
    DECLARE _uid INT;
    SET _uid = (SELECT uid FROM `user` WHERE username = usn);

    SET maxid = (SELECT COUNT(oid)
                FROM `order`);

    INSERT INTO `order`(oid, uid, checkoutTime, status)
    VALUES (maxid, _uid, _checkoutTime, '???? ?????t');

    SELECT maxid as oid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_USER` (IN `uname` VARCHAR(15), IN `psswd` VARCHAR(30), IN `name` VARCHAR(50), IN `phone` VARCHAR(10), IN `email` TEXT)  BEGIN
    INSERT INTO `user`(username, password, name, phone, email, role)
    VALUES (uname, PASSWORD(psswd), name, phone, email, 'customer');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_BOOKS` ()  BEGIN 
	SELECT bid,name, author, publisher, amount, description, price, image
    FROM `book`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_ORDERS` (IN `_username` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_status` VARCHAR(11) COLLATE utf8mb4_unicode_ci)  BEGIN
    DECLARE _uid INT;
    SET _uid = (SELECT uid FROM `user` where username = _username);

    IF(_username = '') THEN
        IF(_status = '') THEN
            SELECT oid, order.uid, username, name, checkoutTime, status
            FROM `order`, `user`
            WHERE order.uid = user.uid;
        ELSE
            SELECT oid, order.uid, username, name, checkoutTime, status 
            FROM `order`, `user`
            WHERE 
                status = _status
                AND order.uid = user.uid;

        END IF;
    ELSE
        IF(_status = '') THEN
            SELECT oid, order.uid, username, name, checkoutTime, status 
            FROM `order`, `user`
            WHERE 
                order.uid = _uid
                AND order.uid = user.uid;
        ELSE
            SELECT oid, order.uid, username, name, checkoutTime, status 
            FROM `order`, `user`
            WHERE 
                order.uid = _uid 
                AND order.uid = user.uid
                AND status = _status;
        END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_USERS` ()  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_BOOK` (IN `id` INT)  BEGIN 
	SELECT bid, name, author, publisher, amount, description, price, image
    FROM `book` 
    WHERE bid = id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_BOOK_REVIEWS` (IN `_bid` INT)  BEGIN 
	SELECT user.name, rating, comment
    FROM user, book, review
    WHERE
        review.bid = _bid
        AND book.bid = review.bid
        AND user.uid = review.uid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ORDER_ITEMS` (IN `_oid` INT)  BEGIN
    SELECT book.bid, book.name, book.price, order_item.amount, book.price*order_item.amount as total_price, order.status
    FROM `order_item`, `order`, `book`
    WHERE
        order_item.oid = _oid
        AND order_item.oid = order.oid
        AND order_item.bid = book.bid ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_RATING` (IN `_bid` INT)  BEGIN 
    SELECT FORMAT(AVG(rating), 2) AS rating 
    FROM user, book, review 
    WHERE 
        review.bid = _bid 
        AND book.bid = review.bid; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_ID` (IN `id` INT)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE uid = id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_USN` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE username = usn; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_ALL_CART_ITEM` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
    SET @uid = (SELECT uid FROM `user` WHERE username = usn);
    DELETE FROM `cart` WHERE uid = @uid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_BOOK` (IN `_bid` INT)  BEGIN 
	DELETE FROM `book`
    WHERE bid = _bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_CART_ITEM` (IN `_uid` INT, IN `_bid` INT)  BEGIN 
    DELETE FROM `cart`
    WHERE uid = _uid AND bid = _bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SHOW_CART_ITEMS` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
    DECLARE _uid INT;
    SET _uid = (SELECT uid FROM `user` WHERE username = usn);

	SELECT book.bid as bid, book.name as bname, cart.amount as quantity, book.price as bprice, book.image as bimg
    FROM `book`, `cart`
    WHERE
        cart.uid = _uid 
        AND cart.bid = book.bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_BOOK_INFO` (IN `id` INT, IN `_name` TEXT COLLATE utf8mb4_unicode_ci, IN `_author` TEXT COLLATE utf8mb4_unicode_ci, IN `_publisher` TEXT COLLATE utf8mb4_unicode_ci, IN `_description` TEXT COLLATE utf8mb4_unicode_ci, IN `_image` TEXT COLLATE utf8mb4_unicode_ci, IN `_amount` INT, IN `_price` INT)  BEGIN 
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_CART_ITEM` (IN `_uid` INT, IN `_bid` INT, IN `_amount` INT)  BEGIN 
    UPDATE `cart`
    SET amount = _amount
    WHERE uid = _uid AND bid = _bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_INFO` (IN `uname` VARCHAR(15), IN `psswd` VARCHAR(30), IN `_name` VARCHAR(50), IN `_phone` VARCHAR(10), IN `_email` TEXT)  BEGIN
    IF(psswd = '' OR (psswd IS NULL)) THEN
        UPDATE `user`
        SET
            name = _name,
            phone = _phone,
            email = _email
        WHERE
    	    username = uname;
    ELSE
        UPDATE `user`
        SET
    	    password = PASSWORD(psswd),
            name = _name,
            phone = _phone,
            email = _email
        WHERE
    	    username = uname;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VALIDATE_LOGIN` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `psswd` VARCHAR(30) COLLATE utf8mb4_unicode_ci, IN `_role` VARCHAR(9) COLLATE utf8mb4_unicode_ci)  BEGIN
	
	DECLARE id INT;
    IF(EXISTS(
        SELECT uid FROM `user` 
        WHERE 
        	username = usn
        	AND password = PASSWORD(psswd)
        	AND role = _role
    )) THEN
    
    	IF(EXISTS(
			SELECT uid FROM `user`
            WHERE username = usn
            AND active = 1
        )) THEN
    		SET id = (SELECT uid FROM `user` WHERE username=usn);
        ELSE
        	SET id = -2;
            SET usn = '-2';
            SET _role = '-2';
        END IF;
    ELSE
    	SET id = -1;
        SET usn = '-1';
        SET _role = '-1';
        
    END IF;
    SELECT id as uid, usn as username, _role as role;       
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `bid` int(11) NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `publisher` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`bid`, `name`, `description`, `amount`, `price`, `image`, `author`, `publisher`) VALUES
(1, 'Black Clover - T???p 22: H???ng ????ng', 'C??ng v???i Lemiel - Ma ph??p ????? ?????u ti??n v?? t???c tr?????ng Licht c???a t???c Elf, m???t v??i Elf v?? c??c ma ph??p k??? s?? ???? c??ng nhau ch???ng l???i ??c ma trong cu???c t???ng c??ng k??ch v?????t kh??ng gian.  Tr?????c s???c m???nh kh?? l?????ng c???a ??c ma, s??? ph???n c???a cu???c chi???n r??i v??o tay Asta v?? Yuno b???i hai ng?????i kh??ng ng???ng ti???n b??? khi tr???n ?????u ng??y m???t kh???c li???t. Mong sao h??? c?? th??? ch???m d???t n???i ??au kh??? v?? h???n th?? k??o d??i h??ng tr??m n??m!!\r\n\r\nGood faith??? ???hope??? ???love???is hidden in the leaf of the clover each.\r\n\r\n???Good luck??? dwells in the fourth leaf.\r\n\r\n???The Devil??? lives in the fifth leaf.\r\n\r\nYuki Tabata\r\n\r\n???T??i c?? con r???iii!!! Kh??ng ng??? m???t ng?????i nh?? t??i c??ng c?? ng??y ???????c l??m cha???  Ch??n th??nh c???m ??n ng?????i v??? ???? c??? g???ng h???t m??nh v?? c?? con g??i v???a ch??o ?????i c???a t??i!!???', 100, 22500, './images/black_clover.jpg', 'Yuki Tanaba', 'NXB Kim ?????ng'),
(3, 'Yu-Gi-Oh! - T???p 37', 'Yu-Gi-Oh! - T???p 37\r\n\r\nC??ch ????y ????ng 16 n??m, Yu-Gi-Oh! hay c??n ???????c bi???t ?????n v???i t??n Vua Tr?? Ch??i l?? b??? truy???n tranh ???? t???o n??n &quot;hi???n t?????ng xu???t b???n&quot; t???i Nh???t v?? Vi???t Nam, thu h??t l?????ng fan h??ng h???u tr??n c??? n?????c. Ng?????i ta nh??? ?????n Yugi v???i nh???ng tr???n ?????u b??i chi???n thu???t (Hay b??i ma thu???t, b??i Magic ????i h???i t?? duy, s??? t??nh to??n v?? tr?? tu??? c???a ng?????i ch??i) ?????y h???p d???n v?? k???ch t??nh, k??o theo l?? c??n s???t ch??i b??i ??? ngo??i ?????i th???c, v???i h??ng tr??m tri???u qu??n b??i ???????c b??n ra tr??n to??n th??? gi???i, c??ng v???i nh???ng gi???i ?????u qu???c t??? nh???n ???????c r???t nhi???u s??? quan t??m c???a c???ng ?????ng &quot;b??i th???&quot; ??? c??c qu???c gia. Trong l???n tr??? l???i n??y, &quot;huy???n tho???i&quot; Yu-Gi-0h! s??? ???????c ch???n chu l???i v??? c??? n???i dung v?? h??nh th???c ????? ????p ???ng s??? k?? v???ng c???a ?????c gi???.', 100, 19000, './images/yu-gi-oh_37.jpg', 'Kazuki Takahashi', 'NXB Kim ?????ng'),
(4, 'Horimiya - T???p 1', 'C??u chuy???n thanh xu??n nh??? nh??ng, gi???n ????n m?? th?? v???!\r\nHori, n??? sinh c???p ba nh??n qua t?????ng ??i???u ???? nh??ng th???t ra l???i gi???n d???, ?????m ??ang vi???c nh??. \r\nMiyamura, anh ch??ng b???n m???t t???m th?????ng khi ??? tr?????ng, nh??ng ra ngo??i th?? ?????p trai ng???i ng???i, khuy??n ??eo ?????y ng?????i. \r\nHai ng?????i v???a tr??i ng?????c v???a t????ng ?????ng, chuy???n g?? s??? x???y ra khi h??? g???p nhau!?  M???i c??c b???n th?????ng th???c t???p ?????u ti??n c???a b??? truy???n h???c ???????ng ng???t s??u r??ng!', 100, 40000, './images/horimiya_1.jpg', 'HERO, Hagiwara Daisuke', 'IPM'),
(5, 'Your Name. Another Side: Earthbound', 'Your Name Another Side: Earthbound\r\nN??n ?????c cu???n truy???n n??y c??ng Your Name.\r\nYour Name. l?? c??u chuy???n n???i ti???ng v?? ?????t ???????c nhi???u k??? l???c ??? c??? hai b???n phim v?? truy???n, xoay quanh m???t thi???u ni??n v?? m???t thi???u n??? ho??n ?????i linh h???n v???i nhau, s???ng d???y ??? m??i tr?????ng ho??n to??n kh??c bi???t v?? t??? th??ch ???ng theo b???n n??ng. S??? ho??n ?????i ???? kh??ng ????n thu???n ????? ??em ?????n tr???ng th??i h??a h???p v??? t??nh c???m, k??? l???i m???t chuy???n t??nh ly k?? l??m l??ng ta h???i h???p r???i khu??y kh???a, m?? g??y ???n t?????ng h??n, l?? l??u ?? ch??ng ta v??? ?????nh m???nh h??nh th??nh t??? nh???ng h??nh vi nh??? nh???t nh???t, v??? ?? ngh??a s??u xa ti???m ???n trong t???ng s??? v???t b?? b???ng nh???t, nh?? s???i d??y t???t, nh?? r?????u c??ng th???n, nh?? v??? tr?? v?? h??nh vi c???a t???ng ng?????i trong su???t d??ng th???i gian bi???n ?????ng.\r\n\r\nSau khi ?????c xong n??, n??n ?????c sang cu???n n??y. V?? Your Name. Another Side: Earthbound ch??nh l?? m???t d???ng ???Your Name. chuy???n ch??a k??????, l?? t??c ph???m b??? sung ho??n h???o v?? ?????y tham v???ng cho cu???n ti???u thuy???t l???i ??t ?? nhi???u ???y. Ho??n h???o ??? ch??? r???t nhi???u t??nh ti???t v?? di???n bi???n t??m l?? t???n t???i d?????i d???ng b?? hi???m ho???c g??y th???c m???c trong Your Name. (c??? phim l???n truy???n) sang cu???n s??ch n??y ?????u ???????c tr???i ra l???p lang v?? r???ch r??i.\r\n\r\nTham v???ng ??? ch???, t??? b???i c???nh v?? m??? ?????u-k???t th??c ???? ?????nh tr?????c, Another Side Earthbound t??? ph??t tri???n cho m??nh m???t h??nh th???c v?? c??ch di???n gi???i ri??ng, ch??? ra quan h??? nh??n qu??? gi???a gi???a qu?? kh???-hi???n t???i, gi???a thi??n tai-t???p qu??n, gi???a v??n h??a-th???n tho???i, gi???a ph?? h???y-say m?????\r\n\r\nN??i c??ch kh??c, Your Name. Another Side: Earthbound l?? th??nh t??? l??m m???t Your Name. m?? b???n ???? bi???t tr??? n??n ?????y ?????n, s??u s???c, v?? tr??n v???n.', 100, 60000, './images/yourname_another.jpg', 'Kanoh Arata', 'NXB V??n h???c'),
(11, ' Ng?????i L??? B??n B??? Bi???n - B???n ?????c Bi???t', 'Ng?????i L??? B??n B??? Bi???n\r\n\r\nAnh cha??ng nha?? va??n tre?? Shun ??a?? ti??nh co???? ba????t ga????p hi??nh bo??ng co?? ??o??n cu??a ca????u ho??c sinh ca????p ba Mio trong khi ca????u be?? ??ang nga????m bie????n mo????t mi??nh. Shun lie????n quye????t ??i??nh ba????t chuye????n vo????i ca????u nhu??ng cha????ng la??u sau, Mio buo????c pha??i ro????i kho??i ho??n ??a??o no??i hai ngu??o????i ho?? sinh so????ng. Ba na??m sau, Mio nay ??a?? tru??o????ng tha??nh va?? quay tro???? ve????, ca????u be?? na??m na??o tho???? lo???? ti??nh ca??m cu??a mi??nh vo????i Shun nhu??ng la??i kho??ng ??u??o????c ??o????i phu??o??ng cha????p nha????n. Ro????t cuo????c ly?? do cu??a Shun la?? gi?? va?? lie????u ca??u chuye????n ti??nh tre??n ho??n ??a??o nho?? thuo????c ti??nh Okinawa se?? ke????t thu??c ra sao?\r\n\r\nAmak xin ??u??o????c mang ??e????n vo????i ca??c ba??n cuo????n manga the???? loa??i BL, &quot;Ngu??o????i la?? be??n bo???? bie????n/Umibe no E??tranger&quot;, ta??c pha????m mo???? ??a????u cho series &quot;L\'e??tranger&quot; no????i tie????ng cu??a ta??c gia?? Kii Kanna ??a?? ??u??o????c chuye????n the???? tha??nh anime va?? nha????n ??u??o????c nhie????u lo????i khen ngo????i tu???? phi??a ngu??o????i ha??m mo????. Ha??y cu??ng cha??o ??o??n ca????p ??o??i Shun x Mio c??c b???n nhe??!', 100, 74800, './images/nguoila.jpeg', 'Kii Kanna', 'NXB H?? N???i'),
(16, 'Love Live! School idol diary - Toujou Nozomi', 'Love Live! School idol diary - Toujou Nozomi\r\n\r\n??????????????????????????????????????????! ????????????????????????????????????????????????????????\'s?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????\'s?????????????????????????????????????????????????????????', 10, 200000, './images/love_live.jpg', '????????????', 'KADOKAWA/???????????????????????????????????????'),
(17, 'Boy Meets Maria', 'Boy Meets Maria\r\n\r\nTaiga lu??n m?? ?????c ???????c tr??? th??nh ANH H??NG t??? khi c??n nh???, v?? c???u ???? g???p ???????c c?? g??i c???a ?????i m??nh sau khi thi ????? v??o c???p 3. Ng?????i ???? l?? Madonna c???a c??u l???c b??? k???ch ngh???, hay c??n ???????c g???i l?? ???Maria???.\r\n\r\nTaiga ???? y??u n??ng Maria n???i b???t gi???a s??n kh???u ???y t??? ??nh m???t ?????u ti??n.\r\n\r\nNgay trong ng??y ?????u g???p g???, c???u b??y t??? hy v???ng mu???n Maria tr??? th??nh N??? CH??NH C???A ?????I M??NH v?? ???? hy sinh v?? c??ng anh d??ng.\r\n\r\nNh??ng m??? nh??n n???i ti???ng ???? h??a ra l???i l?? XXX XXXX.\r\n\r\n????n ?????c BOY MEETS MARIA, cu???n manga BL n???m trong Top 10 B???ng x???p h???ng MANGA M???I c???a BL AWARD 2019.', 100, 86130, './images/boy_meets_maria.jpeg', 'Peyo', 'NXB H?? N???i'),
(18, 'Chuy???n T??nh Thanh Xu??n Bi H??i C???a T??i Qu??? Nhi??n L?? Sai L???m - T???p 12', 'Chuy???n T??nh Thanh Xu??n Bi H??i C???a T??i Qu??? Nhi??n L?? Sai L???m - T???p 12\r\n\r\nChuy???n t??nh thanh xu??n bi h??i c???a t??i qu??? nhi??n l?? sai l???m. (t??n g???c: Yahari Ore no Seishun Rabukome wa Machigatteiru., g???i t???t l?? Oregairu), l?? m???t trong nh???ng series light novel ??n kh??ch nh???t trong v??ng 20 n??m tr??? l???i ????y, b??? truy???n ???????c vi???t b???i t??c gi??? tr??? Wataru WATARI, do h???a s?? Ponkan8 v??? minh h???a v?? ???????c xu???t b???n b???i NXB n???i ti???ng Shogakukan.\r\n\r\nChuy???n t??nh thanh xu??n bi h??i c???a t??i qu??? nhi??n l?? sai l???m. ???? d??nh gi???i light novel hay nh???t c???a b???ng x???p h???ng uy t??n Kono light novel ga sugoi! trong 3 n??m li??n ti???p l?? 2014, 2015 v?? 2016. B??n c???nh ????, nam ch??nh v?? n??? ch??nh c???a series n??y l?? Hachiman v?? Yokin oshita c??ng ??o???t gi???i nam n??? ch??nh ???????c y??u th??ch nh???t trong c??c n??m ????. H???a s?? minh h???a Ponkan8 v???i nh???ng b???c tranh minh h???a ?????p v?? sinh ?????ng c???a m??nh c??ng ???????c b??nh ch???n l?? h???a s?? minh h???a ???????c y??u th??ch nh???t trong n??m 2015. ?????n th???i ??i???m hi???n t???i, series ???? k???t th??c v???i 14 t???p, nh??ng s??? s??ch b??n ra ???? v?????t m???c 10 tri???u b???n.\r\n\r\nSau s??? ki???n ng??y valentine v?? ng??y tuy???t r??i ??? thu??? cung, nh??m Hachiman ???? quy???t ?????nh b?????c ??i c???a m??nh. G???n m???t n??m ???? qua k??? t??? l???n ?????u Hachiman b?????c qua c??nh c???a ph??ng c??u l???c b???, r???i Yuigamaha t???i, c??ng nhau h??? ???? tr???i qua bi???t bao k??? ni???m ??i k??m v???i r???c r???i. Sau t???t c??? m???i chuy???n ???? x???y ra, h??? ???? c?? th??? coi nhau nh?? nh???ng ng?????i b???n th??n, ????? bi???t th??m v??? c??u chuy???n ri??ng c???a ?????i ph????ng c??ng nh?? k??? ra c??u chuy???n ri??ng c???a ch??nh m??nh? Kh??ng th??? ch???p nh???n c??? m??i d???ng l???i v?? ch???i b??? v???n ?????, Hachiman ???? ??i t???i quy???t ?????nh trong ng??y tuy???t r??i ???y v?? l???i h???a c??ng ???? ???????c ????a ra.\r\n\r\nM???t y??u c???u l???n c??ng ???????c g???i t???i cho c??u l???c b??? t??nh nguy???n. V???i y??u c???u n??y, c??u tr??? l???i ?????y quy???t t??m m?? Yukino ???? ????a ra l????? D?? cho c?? ph???i h???i ti???c v??? l???a ch???n ???y ??i ch??ng n???a??? ????? tr?????ng th??nh, ng?????i ta ph???i t??? b??? ??i r???t nhi???u th???. Yukino ???? quy???t ?????nh t??? b??? ??i???u ???y ????? c?? th??? tr?????ng th??nh v?? t??? m??nh b?????c ti???p trong t????ng lai. Tuy nhi??n, b???t k??? l??c n??o, tr?????c m???t ch??ng ta c??ng ch??? c?? duy nh???t ???hi???n t???i??? m?? th??i. V???i nh???ng suy ngh?? c???a m???i ng?????i ??u???c gi??? ch???t trong ng???c, ???c??u tr??? l???i??? m?? Hachiman, Yukino v?? Yui l???a ch???n s??? l?? g?? ????y?\r\n\r\nB??? ti???u thuy???t v??? thanh xu??n s???ng ?????ng ?????y m???i m??? n??y ??ang ??i ?????n nh???ng ch????ng cu???i c??ng.', 101, 149990, './images/oregairu.jpg', 'Wataru WATARI', 'NXB H?? N???i'),
(19, 'Another S/0', 'Another S/0\r\n\r\nAnother S/0 l?? b??? truy???n g???m hai cu???n: ti???u thuy???t Another S v?? manga Another 0, l???n l?????t n???m v??o hai th???i ??i???m sau v?? tr?????c Another.\r\n\r\nL???y ??i???m r??i l?? l??c Sakakibara ???? t??m ra ?????i s??ch ????? ch???m d???t ???hi???n t?????ng???, tr??? k??? ???? ch???t v??? cho Th???n Ch???t, Another S d??i theo b?????c ch??n c???a Misaki ?????n bi???t th??? b??? bi???n c??ch ???? kh?? xa. T?????ng ???? ???????c ngh??? ng??i sau m???t n??m s??ng gi?? b??? xung quanh coi l?? ng?????i c??i ??m, n??o ng??? ??? ????y c?? l???i g???p m???t ti???n b???i kh??a tr??n, ng?????i ???? th??o ch???y kh???i B???c Yomi ????? tr???n tr??nh tai ????ng, nh??ng cu???i c??ng v???n kh??ng tho??t ???????c v???t loang ?????nh m???nh.\r\n\r\nR???t cu???c th?? b??n tay ??en c???a ???hi???n t?????ng??? B???c Yomi c?? th??? lan xa ?????n ????u, sau khi ???? s???ng l??u ?????n hai m????i m???y n??m nh?? th????\r\n\r\nAnother 0 l???i ch???n ??i???m r??i l?? tr?????c ng??y Sakakibara ?????n B???c Yomi, ?????t ch??n v??o m???ng nh???n tai ????ng c???a tr?????ng, v???i c??c chi ti???t ?????m t??nh b??o hi???u ??i???m g???, t??? m???t g??c nh??n m?? sau n??y ta m???i nh???n ra l?? r???t ????ng th????ng. Another 0 v???n l?? ph???n kh??ng xu???t b???n ri??ng ??? Nh???t, m?? ???????c ????nh k??m ????a anime Another, nay ???????c IPM in g???p v??o b??? S/0 n??y ????? ?????c gi??? c?? c??i nh??n ho??n ch???nh v??? ba th???i ??i???m tr?????c/trong/sau c???a v??? bi k???ch v?? t??nh m?? th??nh t???i t??nh c???a c??c h???c sinh B???c Yomi, khi c??? n??u k??o ng?????i ???? ch???t ??? l???i th??? gi???i kh??ng c??n ph?? h???p v???i h???.\r\n\r\n?????y t??nh chi??m nghi???m v?? ??i???m b??o, Another S/0 c??n m??? ???????ng cho Another 2001, khi tai ????ng tr??? l???i v???i B???c Yomi v??o n??m 2001???', 200, 75000, './images/another.jpg', 'Yukito Ayatsuji, Hiro Kiyohara', 'NXB H???ng ?????c'),
(20, 'Ba ng??y h???nh ph??c', 'Th???t v?? v???ng khi th??ch m???t ng?????i kh??ng c??n tr??n th??? gian n??y.\r\n\r\nXem ra t??? nay v??? sau ch???ng c?? m???t ??i???u t???t l??nh n??o ?????n v???i cu???c ?????i t??i. Ch??nh v?? th??? m?? m???i n??m sinh m???nh c???a t??i ch??? ????ng gi?? 10.000 y??n. Qu?? bi quan v??? t????ng lai, t??i ???? b??n ??i g???n h???t sinh m???nh c???a m??nh. D?? c?? c??? l??m g?? ????? ???????c h???nh ph??c trong qu??ng ?????i ng???n ng???i c??n l???i, th?? t??i c??ng ch??? nh???n ???????c k???t qu??? tr??i ng?????c. Trong khi t??i ??ang ti???p t???c s???ng v?? ?????nh th?? ???ng?????i gi??m s??t??? Miyagi v???n ????m ????m nh??n t??i v???i ??nh m???t ??i???m t??nh.\r\n\r\nT??i ???? m???t th??m hai th??ng cu???c ?????i ????? nh???n ra r???ng t??i h???nh ph??c nh???t khi s???ng v?? c?? ???y.\r\n\r\nT???p truy???n n???i ti???ng tr??n web n??y, cu???i c??ng c??ng ???????c xu???t b???n!\r\n\r\n(T??n ban ?????u c???a n?? l?? T??i ???? b??n sinh m???nh c???a m??nh. M???i n??m 10.000 y??n.)', 1000, 64600, './images/ba_ngay_hp.jpg', 'Miaki Sugaru', 'NXB H???ng ?????c'),
(21, 'Con G??i C???a Ba - T???p 3', 'Con G??i C???a Ba - T???p 3\r\n\r\nHai ch??ng t??i hai k??? c?? ????n,\r\n\r\nc??ng b???t ?????u m???t t??nh ph??? t???.\r\n\r\nMasamune Kazama l?? m???t anh ch??ng 23 tu???i ?????c th??n l??m vi???c t???i m???t studio ch???p h??nh.  M???t ng??y n???, anh ph??t hi???n ra ng?????i y??u c?? t??? th???i c???p III c??ch ????y 6 n??m c???a m??nh - Yoko - ???? qua ?????i v?? ????? l???i m???t c?? con g??i 5 tu???i. ??i???u Kazama kh??ng ng??? nh???t ch??nh l?? c?? b?? ???? l???i l?? con g??i anh, ???????c Yoko b?? m???t nu??i d???y m???t m??nh sau khi hai ng?????i chia tay. T??? khi Koharu xu???t hi???n, cu???c s???ng th?????ng ng??y c???a Kazama b???t ?????u d???n d???n thay ?????i???\r\n\r\nM???i c??c b???n c??ng kh??m ph?? nh???ng s???c m??u cu???c s???ng th?????ng ng??y v?? d??i theo h??nh tr??nh ?????y ???p y??u th????ng c???a Kazama c??ng c?? b?? Koharu qua n??t v??? nh??? nh??ng v?? ?????y tinh t??? c???a n??? t??c gi??? r???t ???????c y??u m???n: Sahara Mizu trong Con g??i c???a ba.', 50, 19800, './images/con_gai_cua_ba_tap_3.jpg', 'Sahara Mizu', 'NXB Kim ?????ng');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `oid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `checkoutTime` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`oid`, `uid`, `checkoutTime`, `status`) VALUES
(0, 1, '06-06-2021 17:00:00', '??ang giao'),
(1, 8, '06-06-2021 17:00:00', '??ang giao'),
(2, 1, '06-06-2021 17:01:00', 'Th??nh c??ng'),
(3, 1, '2021-06-08 10:33:10', '???? h???y'),
(4, 8, '2021-06-08 12:28:28', '???? ?????t'),
(5, 9, '2021-06-08 12:30:26', '???? ?????t');

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `oid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`oid`, `bid`, `amount`) VALUES
(0, 1, 10),
(0, 3, 10),
(1, 3, 10),
(1, 4, 1),
(2, 1, 3),
(2, 5, 5),
(3, 1, 1),
(4, 1, 1),
(4, 11, 1),
(4, 16, 1),
(4, 19, 1),
(5, 1, 1),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`rid`, `uid`, `bid`, `rating`, `comment`) VALUES
(1, 1, 1, 4, 'Truy???n hay m?? b??a b??i nh??i qu?? :))'),
(3, 8, 1, 5, 'Truy???n ????ng ?????ng ti???n b??t g???o :))'),
(4, 9, 1, 1, 'Tui ??ang ?????c c??i g?? v???y? :))'),
(5, 1, 1, 4, 'Hay:)))'),
(6, 8, 16, 5, 'Simp!!! <3'),
(7, 1, 16, 5, 'H??ng You Watanabe. :3'),
(8, 9, 18, 4, 'B??a ?????p, nh??ng m?? shipper kh??ng ??eo kh???u trang n??n tr??? 1 ??i???m thanh l???ch. :))))');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `username`, `password`, `name`, `phone`, `email`, `role`, `active`) VALUES
(1, 'hoanduy', '*3060F61EB5671C11A3605E847AF27763E555374A', 'Duy', '0123456789', 'hoanduy@mail.to', 'customer', 1),
(8, 'hieule', '*8C869A400A96A09D7483D88A490701C56D474BF1', 'Hi???u ?????p Trai', '0969969696', 'hieulengoc@outlook.com', 'customer', 1),
(9, 'longpham', '*F55C3F419C97BDEEBAD764C2DFF8BE3B4990D9CE', 'Long Pham', '0378823356', 'longpham@gmail.com', 'customer', 1),
(10, 'dungmeo', '*FFCB7EF476F95690D1FFB871DEA274343CD9C284', 'D??ng ????nh Rumble', '0345123456', 'dungdinh@gmail.com', 'customer', 0),
(11, 'booki', '*962A88555204B46D42F282DCF09A9584CC9203B5', 'Booki', '0324192276', 'booki@gmail.com', 'admin', 1),
(12, 'cobooki', '*A0CC5E06B104C2FF9CC2FA7E6115BFF928AF2AE8', 'Co-Booki', '0327219029', 'cobooki@gmail.com', 'admin', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`oid`),
  ADD KEY `oid` (`oid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`oid`,`bid`),
  ADD KEY `oid` (`oid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`rid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `uid` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `order` (`oid`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
