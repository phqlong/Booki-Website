-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 08, 2021 at 05:47 PM
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
DROP DATABASE IF EXISTS `booki`;
CREATE DATABASE IF NOT EXISTS `booki` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `booki`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `ADD_BOOK`$$
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

DROP PROCEDURE IF EXISTS `ADD_ORDER_ITEM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_ORDER_ITEM` (IN `_oid` INT, IN `_bid` INT, IN `_amount` INT)  BEGIN 
    INSERT INTO `order_item`(oid, bid, amount)
    VALUES (_oid, _bid, _amount);

END$$

DROP PROCEDURE IF EXISTS `ADD_OR_UPDATE_BOOK`$$
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

DROP PROCEDURE IF EXISTS `ADD_REVIEW`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_REVIEW` (IN `_uid` INT, IN `_bid` INT, IN `_rating` INT, IN `_comment` TEXT)  BEGIN
    INSERT INTO `review` (uid, bid, rating, comment)
    VALUES (_uid, _bid, _rating, _comment);
END$$

DROP PROCEDURE IF EXISTS `ADD_TO_CART`$$
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

DROP PROCEDURE IF EXISTS `CHANGE_ORDER_STATUS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CHANGE_ORDER_STATUS` (IN `_oid` INT, IN `_status` VARCHAR(11) COLLATE utf8mb4_unicode_ci)  BEGIN
    UPDATE `order`
    SET status = _status
    WHERE oid = _oid;
END$$

DROP PROCEDURE IF EXISTS `CHANGE_ROLE_STATUS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CHANGE_ROLE_STATUS` (IN `_uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_role` VARCHAR(9) COLLATE utf8mb4_unicode_ci, IN `_active` TINYINT(1))  BEGIN 
    UPDATE `user` 
    SET 
        role = _role,
        active = _active
    WHERE username = _uname; 
END$$

DROP PROCEDURE IF EXISTS `CHECK_EMAIL`$$
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

DROP PROCEDURE IF EXISTS `CHECK_PHONE`$$
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

DROP PROCEDURE IF EXISTS `CREATE_ORDER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_ORDER` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `_checkoutTime` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN 
    DECLARE maxid INT;
    DECLARE _uid INT;
    SET _uid = (SELECT uid FROM `user` WHERE username = usn);

    SET maxid = (SELECT COUNT(oid)
                FROM `order`);

    INSERT INTO `order`(oid, uid, checkoutTime, status)
    VALUES (maxid, _uid, _checkoutTime, 'Đã đặt');

    SELECT maxid as oid;
END$$

DROP PROCEDURE IF EXISTS `CREATE_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_USER` (IN `uname` VARCHAR(15), IN `psswd` VARCHAR(30), IN `name` VARCHAR(50), IN `phone` VARCHAR(10), IN `email` TEXT)  BEGIN
    INSERT INTO `user`(username, password, name, phone, email, role)
    VALUES (uname, PASSWORD(psswd), name, phone, email, 'customer');
END$$

DROP PROCEDURE IF EXISTS `GET_ALL_BOOKS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_BOOKS` ()  BEGIN 
	SELECT bid,name, author, publisher, amount, description, price, image
    FROM `book`;
END$$

DROP PROCEDURE IF EXISTS `GET_ALL_ORDERS`$$
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

DROP PROCEDURE IF EXISTS `GET_ALL_USERS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_USERS` ()  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` ;
END$$

DROP PROCEDURE IF EXISTS `GET_BOOK`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_BOOK` (IN `id` INT)  BEGIN 
	SELECT bid, name, author, publisher, amount, description, price, image
    FROM `book` 
    WHERE bid = id; 
END$$

DROP PROCEDURE IF EXISTS `GET_BOOK_REVIEWS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_BOOK_REVIEWS` (IN `_bid` INT)  BEGIN 
	SELECT user.name, rating, comment
    FROM user, book, review
    WHERE
        review.bid = _bid
        AND book.bid = review.bid
        AND user.uid = review.uid;
END$$

DROP PROCEDURE IF EXISTS `GET_ORDER_ITEMS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ORDER_ITEMS` (IN `_oid` INT)  BEGIN
    SELECT book.bid, book.name, book.price, order_item.amount, book.price*order_item.amount as total_price, order.status
    FROM `order_item`, `order`, `book`
    WHERE
        order_item.oid = _oid
        AND order_item.oid = order.oid
        AND order_item.bid = book.bid ;
END$$

DROP PROCEDURE IF EXISTS `GET_RATING`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_RATING` (IN `_bid` INT)  BEGIN 
    SELECT FORMAT(AVG(rating), 2) AS rating 
    FROM user, book, review 
    WHERE 
        review.bid = _bid 
        AND book.bid = review.bid; 
END$$

DROP PROCEDURE IF EXISTS `GET_USER_BY_ID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_ID` (IN `id` INT)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE uid = id; 
END$$

DROP PROCEDURE IF EXISTS `GET_USER_BY_USN`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_USER_BY_USN` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
	SELECT name, username, phone, email, role, active
    FROM `user` 
    WHERE username = usn; 
END$$

DROP PROCEDURE IF EXISTS `REMOVE_ALL_CART_ITEM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_ALL_CART_ITEM` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
    SET @uid = (SELECT uid FROM `user` WHERE username = usn);
    DELETE FROM `cart` WHERE uid = @uid;
END$$

DROP PROCEDURE IF EXISTS `REMOVE_BOOK`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_BOOK` (IN `_bid` INT)  BEGIN 
	DELETE FROM `book`
    WHERE bid = _bid;
END$$

DROP PROCEDURE IF EXISTS `REMOVE_CART_ITEM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_CART_ITEM` (IN `_uid` INT, IN `_bid` INT)  BEGIN 
    DELETE FROM `cart`
    WHERE uid = _uid AND bid = _bid;
END$$

DROP PROCEDURE IF EXISTS `SHOW_CART_ITEMS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SHOW_CART_ITEMS` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci)  BEGIN 
    DECLARE _uid INT;
    SET _uid = (SELECT uid FROM `user` WHERE username = usn);

	SELECT book.bid as bid, book.name as bname, cart.amount as quantity, book.price as bprice, book.image as bimg
    FROM `book`, `cart`
    WHERE
        cart.uid = _uid 
        AND cart.bid = book.bid;
END$$

DROP PROCEDURE IF EXISTS `UPDATE_BOOK_INFO`$$
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

DROP PROCEDURE IF EXISTS `UPDATE_CART_ITEM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_CART_ITEM` (IN `_uid` INT, IN `_bid` INT, IN `_amount` INT)  BEGIN 
    UPDATE `cart`
    SET amount = _amount
    WHERE uid = _uid AND bid = _bid;
END$$

DROP PROCEDURE IF EXISTS `UPDATE_INFO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_INFO` (IN `uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `psswd` VARCHAR(30), IN `_name` VARCHAR(50) COLLATE utf8mb4_unicode_ci, IN `_phone` VARCHAR(10) COLLATE utf8mb4_unicode_ci, IN `_email` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN
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

DROP PROCEDURE IF EXISTS `VALIDATE_LOGIN`$$
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

DROP TABLE IF EXISTS `book`;
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
(1, 'Black Clover - Tập 22: Hừng Đông', 'Cùng với Lemiel - Ma pháp đế đầu tiên và tộc trưởng Licht của tộc Elf, một vài Elf và các ma pháp kị sĩ đã cùng nhau chống lại ác ma trong cuộc tổng công kích vượt không gian.  Trước sức mạnh khó lường của ác ma, số phận của cuộc chiến rơi vào tay Asta và Yuno bởi hai người không ngừng tiến bộ khi trận đấu ngày một khốc liệt. Mong sao họ có thể chấm dứt nỗi đau khổ và hận thù kéo dài hàng trăm năm!!\r\n\r\nGood faith” “hope” “love”is hidden in the leaf of the clover each.\r\n\r\n“Good luck” dwells in the fourth leaf.\r\n\r\n“The Devil” lives in the fifth leaf.\r\n\r\nYuki Tabata\r\n\r\n“Tôi có con rồiii!!! Không ngờ một người như tôi cũng có ngày được làm cha…  Chân thành cảm ơn người vợ đã cố gắng hết mình và cô con gái vừa chào đời của tôi!!”', 100, 22500, './images/black_clover.jpg', 'Yuki Tanaba', 'NXB Kim Đồng'),
(3, 'Yu-Gi-Oh! - Tập 37', 'Yu-Gi-Oh! - Tập 37\r\n\r\nCách đây đúng 16 năm, Yu-Gi-Oh! hay còn được biết đến với tên Vua Trò Chơi là bộ truyện tranh đã tạo nên &quot;hiện tượng xuất bản&quot; tại Nhật và Việt Nam, thu hút lượng fan hùng hậu trên cả nước. Người ta nhớ đến Yugi với những trận đấu bài chiến thuật (Hay bài ma thuật, bài Magic đòi hỏi tư duy, sự tính toán và trí tuệ của người chơi) đầy hấp dẫn và kịch tính, kéo theo là cơn sốt chơi bài ở ngoài đời thực, với hàng trăm triệu quân bài được bán ra trên toàn thế giới, cùng với những giải đấu quốc tế nhận được rất nhiều sự quan tâm của cộng đồng &quot;bài thủ&quot; ở các quốc gia. Trong lần trở lại này, &quot;huyền thoại&quot; Yu-Gi-0h! sẽ được chỉn chu lại về cả nội dung và hình thức để đáp ứng sự kì vọng của độc giả.', 100, 19000, './images/yu-gi-oh_37.jpg', 'Kazuki Takahashi', 'NXB Kim Đồng'),
(4, 'Horimiya - Tập 1', 'Câu chuyện thanh xuân nhẹ nhàng, giản đơn mà thú vị!\r\nHori, nữ sinh cấp ba nhìn qua tưởng điệu đà nhưng thật ra lại giản dị, đảm đang việc nhà. \r\nMiyamura, anh chàng bốn mắt tầm thường khi ở trường, nhưng ra ngoài thì đẹp trai ngời ngời, khuyên đeo đầy người. \r\nHai người vừa trái ngược vừa tương đồng, chuyện gì sẽ xảy ra khi họ gặp nhau!?  Mời các bạn thưởng thức tập đầu tiên của bộ truyện học đường ngọt sâu răng!', 100, 40000, './images/horimiya_1.jpg', 'HERO, Hagiwara Daisuke', 'IPM'),
(5, 'Your Name. Another Side: Earthbound', 'Your Name Another Side: Earthbound\r\nNên đọc cuốn truyện này cùng Your Name.\r\nYour Name. là câu chuyện nổi tiếng và đạt được nhiều kỉ lục ở cả hai bản phim và truyện, xoay quanh một thiếu niên và một thiếu nữ hoán đổi linh hồn với nhau, sống dậy ở môi trường hoàn toàn khác biệt và tự thích ứng theo bản năng. Sự hoán đổi đó không đơn thuần để đem đến trạng thái hòa hợp về tình cảm, kể lại một chuyện tình ly kì làm lòng ta hồi hộp rồi khuây khỏa, mà gây ấn tượng hơn, là lưu ý chúng ta về định mệnh hình thành từ những hành vi nhỏ nhặt nhất, về ý nghĩa sâu xa tiềm ẩn trong từng sự vật bé bỏng nhất, như sợi dây tết, như rượu cúng thần, như vị trí và hành vi của từng người trong suốt dòng thời gian biến động.\r\n\r\nSau khi đọc xong nó, nên đọc sang cuốn này. Vì Your Name. Another Side: Earthbound chính là một dạng “Your Name. chuyện chưa kể”, là tác phẩm bổ sung hoàn hảo và đầy tham vọng cho cuốn tiểu thuyết lời ít ý nhiều ấy. Hoàn hảo ở chỗ rất nhiều tình tiết và diễn biến tâm lý tồn tại dưới dạng bí hiểm hoặc gây thắc mắc trong Your Name. (cả phim lẫn truyện) sang cuốn sách này đều được trải ra lớp lang và rạch ròi.\r\n\r\nTham vọng ở chỗ, từ bối cảnh và mở đầu-kết thúc đã định trước, Another Side Earthbound tự phát triển cho mình một hình thức và cách diễn giải riêng, chỉ ra quan hệ nhân quả giữa giữa quá khứ-hiện tại, giữa thiên tai-tập quán, giữa văn hóa-thần thoại, giữa phá hủy-say mê…\r\n\r\nNói cách khác, Your Name. Another Side: Earthbound là thành tố làm một Your Name. mà bạn đã biết trở nên đầy đặn, sâu sắc, và tròn vẹn.', 100, 60000, './images/yourname_another.jpg', 'Kanoh Arata', 'NXB Văn học'),
(11, ' Người Lạ Bên Bờ Biển - Bản Đặc Biệt', 'Người Lạ Bên Bờ Biển\r\n\r\nAnh chàng nhà văn trẻ Shun đã tình cờ bắt gặp hình bóng cô đơn của cậu học sinh cấp ba Mio trong khi cậu bé đang ngắm biển một mình. Shun liền quyết định bắt chuyện với cậu nhưng chẳng lâu sau, Mio buộc phải rời khỏi hòn đảo nơi hai người họ sinh sống. Ba năm sau, Mio nay đã trưởng thành và quay trở về, cậu bé năm nào thổ lộ tình cảm của mình với Shun nhưng lại không được đối phương chấp nhận. Rốt cuộc lý do của Shun là gì và liệu câu chuyện tình trên hòn đảo nhỏ thuộc tỉnh Okinawa sẽ kết thúc ra sao?\r\n\r\nAmak xin được mang đến với các bạn cuốn manga thể loại BL, &quot;Người lạ bên bờ biển/Umibe no Étranger&quot;, tác phẩm mở đầu cho series &quot;L\'étranger&quot; nổi tiếng của tác giả Kii Kanna đã được chuyển thể thành anime và nhận được nhiều lời khen ngợi từ phía người hâm mộ. Hãy cùng chào đón cặp đôi Shun x Mio các bạn nhé!', 100, 74800, './images/nguoila.jpeg', 'Kii Kanna', 'NXB Hà Nội'),
(16, 'Love Live! School idol diary - Toujou Nozomi', 'Love Live! School idol diary - Toujou Nozomi\r\n\r\n公野櫻子が贈る、「ラブライブ! 」のオリジナルストーリーを単行本化。μ\'sのメンバーたちが、自分たちのスクールアイドル活動を、お当番制で毎日書き綴っている「μ\'s活動日誌」を、毎月お届けしていきます。', 10, 200000, './images/love_live.jpg', '公野櫻子', 'KADOKAWA/アスキー・メディアワークス'),
(17, 'Boy Meets Maria', 'Boy Meets Maria\r\n\r\nTaiga luôn mơ ước được trở thành ANH HÙNG từ khi còn nhỏ, và cậu đã gặp được cô gái của đời mình sau khi thi đỗ vào cấp 3. Người đó là Madonna của câu lạc bộ kịch nghệ, hay còn được gọi là “Maria”.\r\n\r\nTaiga đã yêu nàng Maria nổi bật giữa sân khấu ấy từ ánh mắt đầu tiên.\r\n\r\nNgay trong ngày đầu gặp gỡ, cậu bày tỏ hy vọng muốn Maria trở thành NỮ CHÍNH CỦA ĐỜI MÌNH và đã hy sinh vô cùng anh dũng.\r\n\r\nNhưng mỹ nhân nổi tiếng đó hóa ra lại là XXX XXXX.\r\n\r\nĐón đọc BOY MEETS MARIA, cuốn manga BL nằm trong Top 10 Bảng xếp hạng MANGA MỚI của BL AWARD 2019.', 100, 86130, './images/boy_meets_maria.jpeg', 'Peyo', 'NXB Hà Nội'),
(18, 'Chuyện Tình Thanh Xuân Bi Hài Của Tôi Quả Nhiên Là Sai Lầm - Tập 12', 'Chuyện Tình Thanh Xuân Bi Hài Của Tôi Quả Nhiên Là Sai Lầm - Tập 12\r\n\r\nChuyện tình thanh xuân bi hài của tôi quả nhiên là sai lầm. (tên gốc: Yahari Ore no Seishun Rabukome wa Machigatteiru., gọi tắt là Oregairu), là một trong những series light novel ăn khách nhất trong vòng 20 năm trở lại đây, bộ truyện được viết bởi tác giả trẻ Wataru WATARI, do họa sĩ Ponkan8 vẽ minh họa và được xuất bản bởi NXB nổi tiếng Shogakukan.\r\n\r\nChuyện tình thanh xuân bi hài của tôi quả nhiên là sai lầm. đã dành giải light novel hay nhất của bảng xếp hạng uy tín Kono light novel ga sugoi! trong 3 năm liên tiếp là 2014, 2015 và 2016. Bên cạnh đó, nam chính và nữ chính của series này là Hachiman và Yokin oshita cũng đoạt giải nam nữ chính được yêu thích nhất trong các năm đó. Họa sĩ minh họa Ponkan8 với những bức tranh minh họa đẹp và sinh động của mình cũng được bình chọn là họa sĩ minh họa được yêu thích nhất trong năm 2015. Đến thời điểm hiện tại, series đã kết thúc với 14 tập, nhưng số sách bán ra đã vượt mốc 10 triệu bản.\r\n\r\nSau sự kiện ngày valentine và ngày tuyết rơi ở thuỷ cung, nhóm Hachiman đã quyết định bước đi của mình. Gần một năm đã qua kể từ lần đầu Hachiman bước qua cánh cửa phòng câu lạc bộ, rồi Yuigamaha tới, cùng nhau họ đã trải qua biết bao kỷ niệm đi kèm với rắc rối. Sau tất cả mọi chuyện đã xảy ra, họ đã có thể coi nhau như những người bạn thân, để biết thêm về câu chuyện riêng của đối phương cũng như kể ra câu chuyện riêng của chính mình? Không thể chấp nhận cứ mãi dừng lại và chối bỏ vấn đề, Hachiman đã đi tới quyết định trong ngày tuyết rơi ấy và lời hứa cũng đã được đưa ra.\r\n\r\nMột yêu cầu lớn cũng được gửi tới cho câu lạc bộ tình nguyện. Với yêu cầu này, câu trả lời đầy quyết tâm mà Yukino đã đưa ra là… Dù cho có phải hối tiếc về lựa chọn ấy đi chăng nữa… Để trưởng thành, người ta phải từ bỏ đi rất nhiều thứ. Yukino đã quyết định từ bỏ điều ấy để có thể trưởng thành và tự mình bước tiếp trong tương lai. Tuy nhiên, bất kể lúc nào, trước mặt chúng ta cũng chỉ có duy nhất “hiện tại” mà thôi. Với những suy nghĩ của mỗi người đuọc giữ chặt trong ngực, “câu trả lời” mà Hachiman, Yukino và Yui lựa chọn sẽ là gì đây?\r\n\r\nBộ tiểu thuyết về thanh xuân sống động đầy mới mẻ này đang đi đến những chương cuối cùng.', 101, 149990, './images/oregairu.jpg', 'Wataru WATARI', 'NXB Hà Nội'),
(19, 'Another S/0', 'Another S/0\r\n\r\nAnother S/0 là bộ truyện gồm hai cuốn: tiểu thuyết Another S và manga Another 0, lần lượt nằm vào hai thời điểm sau và trước Another.\r\n\r\nLấy điểm rơi là lúc Sakakibara đã tìm ra đối sách để chấm dứt “hiện tượng”, trả kẻ đã chết về cho Thần Chết, Another S dõi theo bước chân của Misaki đến biệt thự bờ biển cách đó khá xa. Tưởng đã được nghỉ ngơi sau một năm sóng gió bị xung quanh coi là người cõi âm, nào ngờ ở đây cô lại gặp một tiền bối khóa trên, người đã tháo chạy khỏi Bắc Yomi để trốn tránh tai ương, nhưng cuối cùng vẫn không thoát được vệt loang định mệnh.\r\n\r\nRốt cuộc thì bàn tay đen của “hiện tượng” Bắc Yomi có thể lan xa đến đâu, sau khi đã sống lâu đến hai mươi mấy năm như thế?\r\n\r\nAnother 0 lại chọn điểm rơi là trước ngày Sakakibara đến Bắc Yomi, đặt chân vào mạng nhện tai ương của trường, với các chi tiết đậm tính báo hiệu điềm gở, từ một góc nhìn mà sau này ta mới nhận ra là rất đáng thương. Another 0 vốn là phần không xuất bản riêng ở Nhật, mà được đính kèm đĩa anime Another, nay được IPM in gộp vào bộ S/0 này để độc giả có cái nhìn hoàn chỉnh về ba thời điểm trước/trong/sau của vở bi kịch vô tình mà thành tội tình của các học sinh Bắc Yomi, khi cố níu kéo người đã chết ở lại thế giới không còn phù hợp với họ.\r\n\r\nĐầy tính chiêm nghiệm và điềm báo, Another S/0 còn mở đường cho Another 2001, khi tai ương trở lại với Bắc Yomi vào năm 2001…', 200, 75000, './images/another.jpg', 'Yukito Ayatsuji, Hiro Kiyohara', 'NXB Hồng Đức'),
(20, 'Ba ngày hạnh phúc', 'Thật vô vọng khi thích một người không còn trên thế gian này.\r\n\r\nXem ra từ nay về sau chẳng có một điều tốt lành nào đến với cuộc đời tôi. Chính vì thế mà mỗi năm sinh mệnh của tôi chỉ đáng giá 10.000 yên. Quá bi quan về tương lai, tôi đã bán đi gần hết sinh mệnh của mình. Dù có cố làm gì để được hạnh phúc trong quãng đời ngắn ngủi còn lại, thì tôi cũng chỉ nhận được kết quả trái ngược. Trong khi tôi đang tiếp tục sống vô định thì “người giám sát” Miyagi vẫn đăm đăm nhìn tôi với ánh mắt điềm tĩnh.\r\n\r\nTôi đã mất thêm hai tháng cuộc đời để nhận ra rằng tôi hạnh phúc nhất khi sống vì cô ấy.\r\n\r\nTập truyện nổi tiếng trên web này, cuối cùng cũng được xuất bản!\r\n\r\n(Tên ban đầu của nó là Tôi đã bán sinh mệnh của mình. Mỗi năm 10.000 yên.)', 1000, 64600, './images/ba_ngay_hp.jpg', 'Miaki Sugaru', 'NXB Hồng Đức'),
(21, 'Con Gái Của Ba - Tập 3', 'Con Gái Của Ba - Tập 3\r\n\r\nHai chúng tôi hai kẻ cô đơn,\r\n\r\ncùng bắt đầu một tình phụ tử.\r\n\r\nMasamune Kazama là một anh chàng 23 tuổi độc thân làm việc tại một studio chụp hình.  Một ngày nọ, anh phát hiện ra người yêu cũ từ thời cấp III cách đây 6 năm của mình - Yoko - đã qua đời và để lại một cô con gái 5 tuổi. Điều Kazama không ngờ nhất chính là cô bé đó lại là con gái anh, được Yoko bí mật nuôi dạy một mình sau khi hai người chia tay. Từ khi Koharu xuất hiện, cuộc sống thường ngày của Kazama bắt đầu dần dần thay đổi…\r\n\r\nMời các bạn cùng khám phá những sắc màu cuộc sống thường ngày và dõi theo hành trình đầy ắp yêu thương của Kazama cùng cô bé Koharu qua nét vẽ nhẹ nhàng và đầy tinh tế của nữ tác giả rất được yêu mến: Sahara Mizu trong Con gái của ba.', 50, 19800, './images/con_gai_cua_ba_tap_3.jpg', 'Sahara Mizu', 'NXB Kim Đồng');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cid`, `uid`, `bid`, `amount`) VALUES
(17, 1, 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
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
(0, 1, '06-06-2021 17:00:00', 'Đang giao'),
(1, 8, '06-06-2021 17:00:00', 'Đang giao'),
(2, 1, '06-06-2021 17:01:00', 'Thành công'),
(3, 1, '2021-06-08 10:33:10', 'Đã hủy'),
(4, 8, '2021-06-08 12:28:28', 'Đã đặt'),
(5, 9, '2021-06-08 12:30:26', 'Đã đặt'),
(6, 1, '2021-06-08 15:49:00', 'Đã hủy'),
(7, 1, '2021-06-08 15:54:41', 'Đã đặt'),
(8, 8, '2021-06-08 15:55:28', 'Đã đặt');

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
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
(5, 5, 1),
(6, 20, 1),
(7, 16, 1),
(7, 17, 1),
(8, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
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
(1, 1, 1, 4, 'Truyện hay mà bìa bùi nhùi quá :))'),
(3, 8, 1, 5, 'Truyện đáng đồng tiền bát gạo :))'),
(4, 9, 1, 1, 'Tui đang đọc cái gì vậy? :))'),
(5, 1, 1, 4, 'Hay:)))'),
(6, 8, 16, 5, 'Simp!!! <3'),
(7, 1, 16, 5, 'Hóng You Watanabe. :3'),
(8, 9, 18, 4, 'Bìa đẹp, nhưng mà shipper không đeo khẩu trang nên trừ 1 điểm thanh lịch. :))))'),
(9, 1, 21, 5, 'Fan trung thành của Sahara-sensei. <3');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
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
(1, 'hoanduy', '*3060F61EB5671C11A3605E847AF27763E555374A', 'Nguyễn Trần Hoàn Duy', '0372819728', 'hoanduy27@gmail.com', 'customer', 1),
(8, 'hieule', '*8C869A400A96A09D7483D88A490701C56D474BF1', 'Hiếu Đẹp Trai', '0969969696', 'hieulengoc@outlook.com', 'customer', 1),
(9, 'longpham', '*F55C3F419C97BDEEBAD764C2DFF8BE3B4990D9CE', 'Long Pham', '0378823356', 'longpham@gmail.com', 'customer', 1),
(10, 'dungmeo', '*FFCB7EF476F95690D1FFB871DEA274343CD9C284', 'Dũng Đình Rumble', '0345123456', 'dungdinh@gmail.com', 'customer', 0),
(11, 'booki', '*962A88555204B46D42F282DCF09A9584CC9203B5', 'Booki', '0324192276', 'booki@gmail.com', 'admin', 1),
(12, 'cobooki', '*A0CC5E06B104C2FF9CC2FA7E6115BFF928AF2AE8', 'Co-Booki', '0327219029', 'cobooki@gmail.com', 'admin', 1),
(13, 'duy', '*6F371CBBCCDF3D3EC8A11267817B2D4EFF3D1871', 'duy', '0123457918', 'duy@duy.duy', 'customer', 1);

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
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
