-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 05, 2021 at 12:50 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_REVIEW` (IN `_uid` INT, IN `_bid` INT, IN `_rating` INT, IN `_comment` TEXT)  BEGIN
    INSERT INTO `review` (uid, bid, rating, comment)
    VALUES (_uid, _bid, _rating, _comment);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_TO_CART` (IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN _bid INT, IN _amount INT)  BEGIN 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_ORDER` (IN `_uid` INT, IN `_checkoutTime` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN 
    DECLARE maxid INT;
    SET maxid = (SELECT COUNT(oid)
                FROM `order`);

    INSERT INTO `order`(oid, uid, checkoutTime, status)
    VALUES (maxid, _uid, _checkoutTime, 'Đã đặt');

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_ALL_ORDERS` (IN `_uid` INT, IN `_status` VARCHAR(11) COLLATE utf8mb4_unicode_ci)  BEGIN
    IF(_status = 'all') THEN
        SELECT oid, uid, checkoutTime, status 
        FROM `order`
        WHERE uid = _uid;
    ELSE
        SELECT oid, uid, checkoutTime, status 
        FROM `order`
        WHERE uid = _uid AND status = _status;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_BOOK` (IN `_bid` INT)  BEGIN 
	DELETE FROM `book`
    WHERE bid = _bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_CART_ITEM` (IN `_uid` INT, IN `_bid` INT)  BEGIN 
    DELETE FROM `cart`
    WHERE uid = _uid AND bid = _bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REMOVE_ALL_CART_ITEM`(IN `usn` VARCHAR(15) COLLATE utf8mb4_unicode_ci) BEGIN 
    SET @uid = (SELECT uid FROM `user` WHERE username = usn);
    DELETE FROM `cart` WHERE uid = @uid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SHOW_CART_ITEMS` (IN `_uid` INT)  BEGIN 
	SELECT book.name, cart.amount, book.price, cart.amount*book.price as total_price
    FROM `book`, `user`, `cart`
    WHERE
        cart.uid = _uid 
        AND cart.bid = book.bid
        AND cart.uid = user.uid;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_INFO` (IN `uname` VARCHAR(15) COLLATE utf8mb4_unicode_ci, IN `psswd` VARCHAR(30), IN `_name` VARCHAR(50) COLLATE utf8mb4_unicode_ci, IN `_phone` VARCHAR(10) COLLATE utf8mb4_unicode_ci, IN `_email` TEXT COLLATE utf8mb4_unicode_ci)  BEGIN 
    UPDATE `user` 
    SET password = PASSWORD(psswd), 
        name = _name, 
        phone = _phone, 
        email = _email 
    WHERE username = uname; 
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
    	SET id = (SELECT uid FROM `user` WHERE username=usn);
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
(1, 'Black Clover - Tập 22: Hừng Đông', 'Cùng với Lemiel - Ma pháp đế đầu tiên và tộc trưởng Licht của tộc Elf, một vài Elf và các ma pháp kị sĩ đã cùng nhau chống lại ác ma trong cuộc tổng công kích vượt không gian.  Trước sức mạnh khó lường của ác ma, số phận của cuộc chiến rơi vào tay Asta và Yuno bởi hai người không ngừng tiến bộ khi trận đấu ngày một khốc liệt. Mong sao họ có thể chấm dứt nỗi đau khổ và hận thù kéo dài hàng trăm năm!!\r\n\r\nGood faith” “hope” “love”is hidden in the leaf of the clover each.\r\n\r\n“Good luck” dwells in the fourth leaf.\r\n\r\n“The Devil” lives in the fifth leaf.\r\n\r\nYuki Tabata\r\n\r\n“Tôi có con rồiii!!! Không ngờ một người như tôi cũng có ngày được làm cha…  Chân thành cảm ơn người vợ đã cố gắng hết mình và cô con gái vừa chào đời của tôi!!”', 100, 22500, './images/black_clover.jpg', 'Yuki Tanaba', 'NXB Kim Đồng'),
(3, 'Yu-Gi-Oh! - Tập 37', 'Cách đây đúng 16 năm, Yu-Gi-Oh! hay còn được biết đến với tên Vua Trò Chơi là bộ truyện tranh đã tạo nên \"hiện tượng xuất bản\" tại Nhật và Việt Nam, thu hút lượng fan hùng hậu trên cả nước. Người ta nhớ đến Yugi với những trận đấu bài chiến thuật (Hay bài ma thuật, bài Magic đòi hỏi tư duy, sự tính toán và trí tuệ của người chơi) đầy hấp dẫn và kịch tính, kéo theo là cơn sốt chơi bài ở ngoài đời thực, với hàng trăm triệu quân bài được bán ra trên toàn thế giới, cùng với những giải đấu quốc tế nhận được rất nhiều sự quan tâm của cộng đồng \"bài thủ\" ở các quốc gia. Trong lần trở lại này, \"huyền thoại\" Yu-Gi-0h! sẽ được chỉn chu lại về cả nội dung và hình thức để đáp ứng sự kì vọng của độc giả.', 100, 18000, './images/yu-gi-oh_37.jpg', 'Kazuki Takahashi', 'NXB Kim Đồng'),
(4, 'Horimiya - Tập 1', 'Câu chuyện thanh xuân nhẹ nhàng, giản đơn mà thú vị!\r\nHori, nữ sinh cấp ba nhìn qua tưởng điệu đà nhưng thật ra lại giản dị, đảm đang việc nhà. \r\nMiyamura, anh chàng bốn mắt tầm thường khi ở trường, nhưng ra ngoài thì đẹp trai ngời ngời, khuyên đeo đầy người. \r\nHai người vừa trái ngược vừa tương đồng, chuyện gì sẽ xảy ra khi họ gặp nhau!?  Mời các bạn thưởng thức tập đầu tiên của bộ truyện học đường ngọt sâu răng!', 100, 40000, './images/horimiya_1.jpg', 'HERO, Hagiwara Daisuke', 'IPM'),
(5, 'Your Name. Another Side: Earthbound', 'Your Name Another Side: Earthbound\r\nNên đọc cuốn truyện này cùng Your Name.\r\nYour Name. là câu chuyện nổi tiếng và đạt được nhiều kỉ lục ở cả hai bản phim và truyện, xoay quanh một thiếu niên và một thiếu nữ hoán đổi linh hồn với nhau, sống dậy ở môi trường hoàn toàn khác biệt và tự thích ứng theo bản năng. Sự hoán đổi đó không đơn thuần để đem đến trạng thái hòa hợp về tình cảm, kể lại một chuyện tình ly kì làm lòng ta hồi hộp rồi khuây khỏa, mà gây ấn tượng hơn, là lưu ý chúng ta về định mệnh hình thành từ những hành vi nhỏ nhặt nhất, về ý nghĩa sâu xa tiềm ẩn trong từng sự vật bé bỏng nhất, như sợi dây tết, như rượu cúng thần, như vị trí và hành vi của từng người trong suốt dòng thời gian biến động.\r\n\r\nSau khi đọc xong nó, nên đọc sang cuốn này. Vì Your Name. Another Side: Earthbound chính là một dạng “Your Name. chuyện chưa kể”, là tác phẩm bổ sung hoàn hảo và đầy tham vọng cho cuốn tiểu thuyết lời ít ý nhiều ấy. Hoàn hảo ở chỗ rất nhiều tình tiết và diễn biến tâm lý tồn tại dưới dạng bí hiểm hoặc gây thắc mắc trong Your Name. (cả phim lẫn truyện) sang cuốn sách này đều được trải ra lớp lang và rạch ròi.\r\n\r\nTham vọng ở chỗ, từ bối cảnh và mở đầu-kết thúc đã định trước, Another Side Earthbound tự phát triển cho mình một hình thức và cách diễn giải riêng, chỉ ra quan hệ nhân quả giữa giữa quá khứ-hiện tại, giữa thiên tai-tập quán, giữa văn hóa-thần thoại, giữa phá hủy-say mê…\r\n\r\nNói cách khác, Your Name. Another Side: Earthbound là thành tố làm một Your Name. mà bạn đã biết trở nên đầy đặn, sâu sắc, và tròn vẹn.', 100, 60000, './images/yourname_another.jpg', 'Kanoh Arata', 'NXB Văn học'),
(9, 'Your Name. Another Side: Earthbound', 'Your Name Another Side: Earthbound\r\nNên đọc cuốn truyện này cùng Your Name.\r\nYour Name. là câu chuyện nổi tiếng và đạt được nhiều kỉ lục ở cả hai bản phim và truyện, xoay quanh một thiếu niên và một thiếu nữ hoán đổi linh hồn với nhau, sống dậy ở môi trường hoàn toàn khác biệt và tự thích ứng theo bản năng. Sự hoán đổi đó không đơn thuần để đem đến trạng thái hòa hợp về tình cảm, kể lại một chuyện tình ly kì làm lòng ta hồi hộp rồi khuây khỏa, mà gây ấn tượng hơn, là lưu ý chúng ta về định mệnh hình thành từ những hành vi nhỏ nhặt nhất, về ý nghĩa sâu xa tiềm ẩn trong từng sự vật bé bỏng nhất, như sợi dây tết, như rượu cúng thần, như vị trí và hành vi của từng người trong suốt dòng thời gian biến động.\r\n\r\nSau khi đọc xong nó, nên đọc sang cuốn này. Vì Your Name. Another Side: Earthbound chính là một dạng “Your Name. chuyện chưa kể”, là tác phẩm bổ sung hoàn hảo và đầy tham vọng cho cuốn tiểu thuyết lời ít ý nhiều ấy. Hoàn hảo ở chỗ rất nhiều tình tiết và diễn biến tâm lý tồn tại dưới dạng bí hiểm hoặc gây thắc mắc trong Your Name. (cả phim lẫn truyện) sang cuốn sách này đều được trải ra lớp lang và rạch ròi.\r\n\r\nTham vọng ở chỗ, từ bối cảnh và mở đầu-kết thúc đã định trước, Another Side Earthbound tự phát triển cho mình một hình thức và cách diễn giải riêng, chỉ ra quan hệ nhân quả giữa giữa quá khứ-hiện tại, giữa thiên tai-tập quán, giữa văn hóa-thần thoại, giữa phá hủy-say mê…\r\n\r\nNói cách khác, Your Name. Another Side: Earthbound là thành tố làm một Your Name. mà bạn đã biết trở nên đầy đặn, sâu sắc, và tròn vẹn.', 100, 60000, './images/yourname_another.jpg', 'Kanoh Arata', 'NXB Văn học'),
(10, 'Your Name. Another Side: Earthbound', 'Your Name Another Side: Earthbound\r\nNên đọc cuốn truyện này cùng Your Name.\r\nYour Name. là câu chuyện nổi tiếng và đạt được nhiều kỉ lục ở cả hai bản phim và truyện, xoay quanh một thiếu niên và một thiếu nữ hoán đổi linh hồn với nhau, sống dậy ở môi trường hoàn toàn khác biệt và tự thích ứng theo bản năng. Sự hoán đổi đó không đơn thuần để đem đến trạng thái hòa hợp về tình cảm, kể lại một chuyện tình ly kì làm lòng ta hồi hộp rồi khuây khỏa, mà gây ấn tượng hơn, là lưu ý chúng ta về định mệnh hình thành từ những hành vi nhỏ nhặt nhất, về ý nghĩa sâu xa tiềm ẩn trong từng sự vật bé bỏng nhất, như sợi dây tết, như rượu cúng thần, như vị trí và hành vi của từng người trong suốt dòng thời gian biến động.\r\n\r\nSau khi đọc xong nó, nên đọc sang cuốn này. Vì Your Name. Another Side: Earthbound chính là một dạng “Your Name. chuyện chưa kể”, là tác phẩm bổ sung hoàn hảo và đầy tham vọng cho cuốn tiểu thuyết lời ít ý nhiều ấy. Hoàn hảo ở chỗ rất nhiều tình tiết và diễn biến tâm lý tồn tại dưới dạng bí hiểm hoặc gây thắc mắc trong Your Name. (cả phim lẫn truyện) sang cuốn sách này đều được trải ra lớp lang và rạch ròi.\r\n\r\nTham vọng ở chỗ, từ bối cảnh và mở đầu-kết thúc đã định trước, Another Side Earthbound tự phát triển cho mình một hình thức và cách diễn giải riêng, chỉ ra quan hệ nhân quả giữa giữa quá khứ-hiện tại, giữa thiên tai-tập quán, giữa văn hóa-thần thoại, giữa phá hủy-say mê…\r\n\r\nNói cách khác, Your Name. Another Side: Earthbound là thành tố làm một Your Name. mà bạn đã biết trở nên đầy đặn, sâu sắc, và tròn vẹn.', 100, 60000, './images/yourname_another.jpg', 'Kanoh Arata', 'NXB Văn học');

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

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cid`, `uid`, `bid`, `amount`) VALUES
(2, 1, 1, 10),
(3, 8, 1, 1),
(4, 9, 1, 1);

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
(0, 1, '06-06-2021 17:00:00', 'Đã đặt'),
(1, 8, '06-06-2021 17:00:00', 'Đã đặt'),
(2, 1, '06-06-2021 17:01:00', 'Thành công');

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
(2, 5, 5);

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
(1, 1, 1, 4, 'Truyện hay mà bìa bùi nhùi quá :))'),
(3, 8, 1, 5, 'Truyện đáng đồng tiền bát gạo :))'),
(4, 9, 1, 1, 'Tui đang đọc cái gì vậy? :))');

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
(1, 'hoanduy', '*3060F61EB5671C11A3605E847AF27763E555374A', 'Nguyễn Trần Hoàn Duy', '0378927810', 'duy@gmail.com', 'customer', 1),
(8, 'hieule', '*8C869A400A96A09D7483D88A490701C56D474BF1', 'Hiếu Đẹp Trai', '0969969696', 'hieulengoc@outlook.com', 'customer', 1),
(9, 'longpham', '*F55C3F419C97BDEEBAD764C2DFF8BE3B4990D9CE', 'Long Pham', '0378823356', 'longpham@gmail.com', 'customer', 1),
(10, 'dungmeo', '*FFCB7EF476F95690D1FFB871DEA274343CD9C284', 'Dũng Đình Rumble', '0345123456', 'dungdinh@gmail.com', 'customer', 1),
(11, 'booki', '*962A88555204B46D42F282DCF09A9584CC9203B5', 'Booki', '0324192276', 'booki@gmail.com', 'admin', 1);

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
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
