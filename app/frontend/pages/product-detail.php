
    <div class="container product-detail">
    <form method="post" action="product-detail.php?id=<?php echo $_GET["id"]; ?>">
        <div class="row">
            <div class="col-12 col-md-5 text-center">
                <div class="img-detail">
                    <?php
                    require_once 'app/backend/core/init.php';
                    if (isset($_GET['id'])) {
                        $sql = "SELECT bid,name, price,image FROM book WHERE bid=" . $_GET['id'];
                        $result = mysqli_query($conn, $sql);
                        if (mysqli_num_rows($result) > 0) {
                            while ($row = mysqli_fetch_assoc($result)) {
                                echo '<img src="' . $row["image"] . '" alt="#" class="img-box">
                            <input type="submit" name="buy_now"  class="btn btn-primary buy-item" value="Mua ngay">
                            <input type="submit" name="add_to_cart" class="btn btn-warning addtocart-item" value="Thêm vào giỏ">';
                            }
                        } else {
                            echo "0 result found";
                        }
                    }
                    ?>
                </div>

            </div>
            <div class="col-12 col-md-7">
                <div class="description">
                    <!-- <h3><b>Yotaro</b></h3>
    
                        <p>Lodem sit amet Lodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit ametLodem sit amet</p>
                        <p>Tác giả:<b>Xuất bản kim đồng</b> <br>
                        Nhà cung cấp:<b>Xuất bản kim đồng</b> </p>
                        <p class="price">25.000đ</p> -->
                    <?php

                    if (isset($_GET['id'])) {
                        $data = "";
                        $sql = "SELECT bid,name, description, price, author,image, publisher FROM book WHERE bid=" . $_GET['id'];
                        $result = mysqli_query($conn, $sql);
                        if (mysqli_num_rows($result) > 0) {
                            while ($row = mysqli_fetch_assoc($result)) {
                                echo '<h3><b>' . $row['name'] . '</b></h3>
                            <p>' . $row['description'] . '</p>
                            <p>Tác giả: <b>' . $row['author'] . '</b> <br>
                            Nhà cung cấp: <b>' . $row['publisher'] . '</b> </p>
                            <p class="price">' . $row['price'] . ' đ</p>
                            <p>Số lượng: <input type="number" name="quantity" class="form-control" value="1" min="1"></p>
                            <input type="hidden" name="hidden_name" value="' . $row['name'] . '">
                            <input type="hidden" name="hidden_price" value="' . $row['price'] . '">
                            <input type="hidden" name="hidden_image" value="' . $row['image'] . '">';
                            }
                        } else {
                            echo "0 result found";
                        }
                    }
                    ?>

                </div>

            </div>
            </form>
        </div>


        <div class="customer-cmt">
            <h2>Đánh giá- nhận xét từ khách hàng</h2>
            <div class="add-cmt">

                <form method="post" action="product-detail.php?id=<?php echo $_GET["id"]; ?>">
                    <b><?php echo getUsername(); ?></b><br>
                    <div class="radio">
                        <label><input type="radio" value="5" name="rate" checked><span class="five_star">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                            </span></label>
                    </div>
                    <div class="radio">
                        <label><input type="radio" value="4" name="rate"> <span class="five_star">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <i class="fas fa-star"></i>
                            </span></label>
                    </div>

                    <div class="radio">
                        <label><input type="radio" value="3" name="rate"><span class="five_star">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>

                            </span></label>
                    </div>
                    <div class="radio">
                        <label><input type="radio" value="2" name="rate"> <span class="five_star">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <a href="#"><i class="fas fa-star"></i></a>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </span></label>
                    </div>
                    <div class="radio">
                        <label><input type="radio" value="1" name="rate"><span class="five_star">
                                <a href="#"><i class="fas fa-star"></i></a>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </span></label>
                    </div>
                    <div class="form-row">
                        <div class="col-10">
                            <textarea class="form-control" placeholder="Write comment here" name="cmt" required></textarea>
                        </div>
                        <div class="col-2">
                            <input type="submit" name="comment-submit"  class="btn btn-info" value="Đánh giá">
                        </div>
                    </div>
                </form>
            </div>
            <div class="list-cmt" id="list-cmt">
                <?php

                if (isset($_GET['id'])) {
                    $data = "";
                    $sql = 'CALL GET_BOOK_REVIEWS(' . $_GET['id'] . ')';
                    $result = mysqli_query($conn, $sql);
                    if (mysqli_num_rows($result) > 0) {
                        while ($row = mysqli_fetch_assoc($result)) {
                            echo '
                        <div class="cmt">
                            <b>' . $row['name'] . '</b>
                                <span class="five_star">';
                            for ($i = 0; $i < 5; $i++) {
                                if ($i < $row['rating']) {
                                    echo '<a href="#"><i class="fas fa-star"></i></a>';
                                } else {
                                    echo '<i class="fas fa-star"></i>';
                                }
                            }
                            echo '</span></br>
                            <p class="detail-cmt">' . $row['comment'] . '</p>
                        </div>';
                        }
                    } else {
                        echo "We has no comments";
                    }
                }
                ?>
            </div>
        </div>
    </div>
