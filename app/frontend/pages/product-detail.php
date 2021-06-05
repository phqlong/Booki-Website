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
                            echo '<img src="' . $row["image"] . '" alt="#" class="img-box">';
                        }
                    } else {
                        echo "0 result found";
                    }
                }
                ?>
            </div>
            <button class="btn btn-primary buy-item">Buy Now</button>
            <button class="btn btn-warning addtocart-item">Thêm vào giỏ</button>
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
                    $sql = "SELECT bid,name, description, price, author, publisher FROM book WHERE bid=" . $_GET['id'];
                    $result = mysqli_query($conn, $sql);
                    if (mysqli_num_rows($result) > 0) {
                        while ($row = mysqli_fetch_assoc($result)) {
                            echo '<h3><b>' . $row['name'] . '</b></h3>
    
                <p>' . $row['description'] . '</p>
                <p>Tác giả: <b>' . $row['author'] . '</b> <br>
                Nhà cung cấp: <b>' . $row['publisher'] . '</b> </p>
                <p class="price">' . $row['price'] . ' đ</p>';
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