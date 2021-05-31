-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2020 at 06:59 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lina`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `uid` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`uid`, `user_id`, `product_id`, `amount`) VALUES
(1, 20, 7, 0),
(2, 20, 9, 0),
(10, 20, 19, 0),
(12, 20, 22, 0),
(13, 20, 20, 0),
(14, 20, 21, 0),
(15, 20, 5, 0),
(16, 20, 18, 5),
(17, 31, 7, 0),
(18, 31, 20, 0),
(19, 31, 21, 0),
(23, 20, 2, 0),
(25, 20, 3, 6),
(26, 33, 2, 4),
(27, 33, 5, 4),
(28, 33, 18, 5),
(29, 33, 15, 4),
(30, 34, 3, 2),
(31, 34, 4, 1),
(37, 34, 9, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `uid` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `description` text COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `price` int(11) NOT NULL,
  `image` text COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `type` text COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT 'service',
  `amount` int(11) NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`uid`, `name`, `description`, `price`, `image`, `type`, `amount`) VALUES
(2, 'Điều Trị Mụn Lưng', 'Mụn lưng xuất hiện và tái đi tái lại chính là nỗi ám ảnh của nhiều người, đặc biệt là vào mùa hè thời tiết nắng nóng. Đừng để mụn lưng trở thành nguyên nhân ngăn cản bạn diện những bộ cánh “mát mẻ” yêu thích! Hãy cùng tìm hiểu ngay liệu trình điều trị mụn lưng tận gốc tại Lina Spa để giải quyết dứt điểm tình trạng này nhé!', 245000, 'images/lung.jpg', 'service', 15),
(3, 'Liệu Trình Chăm Sóc Da Luxury', 'Với phụ nữ khuôn mặt luôn là “mặt tiền” sáng giá nhất trên cơ thể họ, là tài sản vô giá mà phái đẹp được quyền nâng niu trau chuốt mỗi ngày. Thế nhưng, tạo hóa vốn không sinh ra những vẻ đẹp vĩnh cửu, vậy nên theo thời gian, làn da mặt chúng ta sẽ bị xuống cấp trầm trọng, kém tươi tắn, bị sạm màu và nhăn nheo nếu như không được chăm sóc đúng cách. Liệu trình chăm sóc da mặt chuyên nghiệp tại Lina Spa sẽ giúp bạn khắc phục hiệu quả vấn đề này!', 290000, './images/luxury.jpg', 'service', 12),
(4, 'Liệu Trình Carboxyl Thải Độc Da', 'Carboxyl thải độc da là phương pháp đưa CO2 – loại khí thải quen thuộc trong tự nhiên làm bước đệm nhằm kích thích các mao mạch hoạt động hết công suất. Quá trình này giúp đào thải độc tố và chất bẩn có trong da cũng như thanh lọc da sâu, đem lại bầu khí quyển trong lành cho da.', 290000, './images/cacbon.jpg', 'service', 10),
(5, 'Hút Chì Thải Độc', 'Có rất nhiều nguyên nhân khiến da của bạn bị nhiễm chì. Môi trường, bụi bẩn, công việc, thoái quen sinh hoạt là những yếu tố ảnh hưởng trực tiếp. Chất độc sẽ tích tụ dần trên da và lâu ngày sẽ gây ra các vấn đề về da. Bạn nên đi spa hút chì thải độc đều đặn 2 lần/tháng để đảm bảo da bạn luôn sạch và khỏe mạnh.', 260000, './images/hutchi.jpg', 'service', 10),
(7, 'Kem chống nắng nám Laaskin', 'Kem chống nắng nám Laaskin chứa thành phần kẽm oxit giúp khuếch tán và phản xạ lại tia UV. Sản phẩm có thành phần 100% từ khoáng chất tự nhiên rất an toàn và dịu nhẹ cho da. Kem chống nắng có kết cấu lỏng nhẹ nên sẽ không gây bết dính hay làm tắc lỗ chân lông. Ngoài việc chống các tác hại từ tia UV, sản phẩm còn giúp chống lại bức xạ hồng ngoại, ô nhiễm môi trường và nhất là ánh sáng xanh từ màn hình máy tính, điện thoại.', 350000, '/images/laaskin.jpg', 'product', 8),
(9, 'Mặt nạ tràm trà Laaskin', 'Mặt nạ tràm trà Laaskin với tinh chất từ thiên nhiên chính là “bí quyết vàng” giúp chị em phụ nữ sở hữu làm da căng mướt như sương mai. Không chỉ đem đến vẻ ngoài ấn tượng, mặt nạ còn giúp phụ nữ thêm trẻ trung, tràn đầy sự tự tin và cuốn hút.', 1200000, './images/tram.jpg', 'product', 11),
(13, 'Trị Mụn Huyết Thanh Tảo Biển', 'Một trong những làn da có vấn đề khiến các bạn gái e ngại nhất hiện nay là: làn da bị Mụn. Mụn dường như luôn là mỗi nỗi khổ tâm rất lớn. Gây ảnh hưởng không chỉ đến yếu tố thẩm mỹ mà nó còn tác động lớn đến tâm lý bạn gái bởi nỗi mặc cảm và tự ti. Có hàng ngàn lí do để khiến da bạn bị mụn. Nên thôi, chúng ta không bàn lí do nữa, hãy chú ý hơn đến điều này rằng có một tinh hoa nghiên cứu mới của các nhà khoa học trên thế giới đã ra đời và sẽ là “THẦN DƯỢC” của làn da bị mụn – Huyết thanh trị mụn.', 195000, './images/huyetthanh.jpg', 'service', 10),
(15, 'Masssage thảo mộc', 'Hiện nay, massage được đa số chúng ta quan tâm hơn giúp cải thiện tinh thần cũng như làm đẹp. Đặc biệt massage thảo dược được sử dụng nhiều hơn cả bởi những ưu điểm khác biệt của chính nó. Trong 1 không gian yên tĩnh, mát mẻ tạo cho  bạn một cảm giác được sự thư thái, cơ thể cùng hòa nhịp với việc chuyển động uyển chuyển của đôi tay khéo léo & túi thảo dược ấm nóng. Massage với túi thảo dược là phương pháp chữa lành vết thương cả cơ thể và tinh hồn cho bạn.', 200000, 'https://cdn.spafinder.com/2015/08/swedish-massage.jpg', 'service', 10),
(18, 'Điều Trị Nám Da', 'Phương pháp tác động nhanh thường áp dụng cho những khách hàng có độ nám lâu năm hay nám do nội tiết. Ưu điểm của phương pháp này là kết quả cao, nhanh trong thời gian ngắn 4 đến 6 tuần, nhưng ngược lại trong thời gian hỗ trợ điều trị da khách hàng sẽ có hiện tượng bong tróc và sẽ đỏ hơn bình thường.', 245000, './images/nam.jpg', 'service', 16),
(19, 'Gel tẩy tế bào chết Laaskin', 'Gel tẩy tế bào chết Laaskin (cam kết hàng chính hãng). Công dụng: dưỡng ẩm, làm sạch tế bào chết. Cách dùng: lấy 1 lượng vừa đủ massage nhẹ nhàng trên da từ 3-5p. Rửa mặt sạch lại vs nước lạnh. Nên dùng 1-2lần/1 tuần. #tâytebaochetlaaskin', 350000, './images/tay.jpg', 'product', 10),
(20, 'Sữa tắm trà xanh Laaskin', 'Với đặc điểm lành tính, giải nhiệt tốt, trà xanh đem đến những tác dụng quan trọng cho làn da. Việc dùng sữa tắm trà xanh không chỉ tạo nên mùi thơm đặc trưng mà nó còn thu nhỏ lỗ chân lông, làm sạch từ sâu bên trong, ngăn ngừa sự xâm nhập của các tác nhân gây hại.  Sữa tắm Laaskin trở thành lựa chọn tuyệt vời giúp đông đảo chị em phụ nữ có được làn da đẹp ấn tượng.', 215000, './images/stam.jpg', 'product', 10),
(21, 'Serum tái tạo da Laaskin', 'Serum Laaskin được xem như vị cứu tinh dành cho những làn da bị kích ứng, tổn thương. Serum tái tạo da giúp phục hồi làn da bị tổn thương, nuôi dưỡng da trắng sáng, mịn màng. Sản phẩm có thành phần bao gồm các dưỡng chất thiết yếu cho da, giúp ngăn ngừa lão hóa và cấp ẩm hiệu quả.  Sản phẩm có thành phần vô cùng lành tính và an toàn, do đó bạn có thể an tâm khi sử dụng  Đây là một trong những thương hiệu mỹ phẩm thiên nhiên Hàn Quốc có thành phần vô cùng lành tính và an toàn, do đó bạn có thể an tâm khi sử dụng.', 415000, './images/serum.jpg', 'product', 10),
(22, 'Xịt khoáng nha đam Laaskin (Aloe Mineral Spray)', 'Có nhiều những loại xịt khoáng khác nhau, tuy nhiên xịt khoáng Laaskin vẫn luôn được đông đảo chị em lựa chọn. Không chỉ trợ phục hồi những làn da nóng rát, khô sần, ửng đỏ, dòng sản phẩm này còn tăng cường dưỡng ẩm cho làn da, tạo nên cảm giác thoải mái và dễ chịu cho người dùng. Với những người thường xuyên trang điểm và mong muốn được giữ cho lớp ngoài được lâu hơn, loại xịt khoáng này cũng phát huy hiệu quả những tác dụng mà nó mang lại.', 255000, './images/nha.jpg', 'product', 10);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `uid` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`uid`, `name`, `permissions`) VALUES
(1, 'Standard User', '{\"user\": 1}'),
(2, 'Administrator', '{\"admin\": 1,\r\n\"moderator\" :1, \"user\": 1}');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `_key` text COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `value` text COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`_key`, `value`) VALUES
('address', 'Meli Spa & Beauty Clinic 234 Huỳnh Văn Bánh, Phường 11, Tân Bình, dĩ an'),
('email', '1612115@hcmut.edu.vn'),
('phone', '0931637301'),
('website', 'http://github.com/namgold');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `joined` datetime NOT NULL,
  `role` int(11) NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `username`, `password`, `name`, `joined`, `role`, `email`, `address`, `phone`) VALUES
(20, 'namgold', '$2y$10$A6QittDzHKpxDFxZIau/2eZeAaond7gbbS8I9Ubkm00adiY3AOYkG', 'namgold', '2020-07-08 17:02:37', 2, 'abc@abc.abc', 'Bên trái nhà bên phải, bên phải nhà bên trái', 'Số đẹp nhất vùng này'),
(21, 'linhhy2', '$2y$10$Bn9bb79OXmZwzuhNcB50ies8pMymeNokB2odS.5lW7W74nGz8a09.', 'Hy Phạm Ngọc Linh', '2020-07-08 18:00:05', 1, '', '', ''),
(23, 'linhhy', '$2y$10$XJWQQ7pr2i3hfXobduJRfOt9wuSJev3LtG.1knp2.hrxECavsbbDC', 'Linh admin', '2020-07-09 08:20:41', 2, '', '', ''),
(25, 'ádadasdasd', '$2y$10$ohVGYfBALEjAUWYRdHp7YuaxYZl31h./Um0n7sdRFvhFnSRJBzqNG', 'đáasd', '2020-07-09 08:24:18', 1, '', '', ''),
(27, '123123', '$2y$10$IbRn6sd7R9wRIHF2OrILnO8OQyvKlcAo9VJu0XCPJ0rV2ZaNsLcZa', '123123', '2020-07-09 10:49:33', 1, '', '', ''),
(29, 'nam123', '$2y$10$xsth89wdShqK091xQpROOeIxOV1ZFS4tetCKPey1ix7h.GMNyv5zK', 'Nam Nguyễn', '2020-07-09 15:30:41', 1, '', '', ''),
(30, 'thamne', '$2y$10$cd4BQ3ooNy/5g2P9TWK1UuVNCvLG8f5JAAnEe54yKL7mA.cwy/vAO', 'Thắm Nè', '2020-07-09 18:28:41', 1, '', '', ''),
(31, 'chumahune', '$2y$10$B9WIuoa1MjIHL9jd/ND.BuCzeulFtZsHNfP4RZeDr/6PcaBeUWfqS', 'Chúa Hề', '2020-07-09 19:05:45', 2, '1612115@hcmut.edu.vn9', 'eli Spa & Beauty Clinic 234 Huỳnh Văn Bánh, Phường 11, Phú Nhuận, Hồ Chí Minh, Vietnam', '09316373059'),
(32, 'meomeo', '$2y$10$6H6zoO5E7pRlsgolCkCGSOXyulQiDzbujE.hHeo8B0WDG1k5HBrtu', 'Bông Lan Trứng Muối', '2020-07-09 21:06:57', 1, '', '', ''),
(33, 'nam', '$2y$10$Y5LFbR6fMyC68gPteN/tC.BJGYYAlluvU0X5MU8S06bA159L1FVx.', 'Nam Nguyễn', '2020-07-10 03:33:33', 1, '', '', ''),
(34, 'linhuser', '$2y$10$Vrj/Tc8TMFyG1ovT.XTkv.SpX3j3drzxwg7/QisLbx7NbqJo9i7mq', 'Linh User', '2020-07-10 03:47:28', 1, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `users_session`
--

CREATE TABLE `users_session` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`_key`(256));

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `users_session`
--
ALTER TABLE `users_session`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `users_session`
--
ALTER TABLE `users_session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
