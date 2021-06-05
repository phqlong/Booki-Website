



<form method="post" action="product-detail.php?id=<?php echo $_GET["id"]; ?>">
    <div class="container product-detail">

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
        </div>


    </div>
</form>