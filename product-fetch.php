<?php
require_once 'app/backend/core/init.php';
if (isset($_POST['viewproducts'])){
    $data="";
    $sql = "SELECT bid,name, price,image FROM book";
    $result = mysqli_query($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {

            $data.=
                '<div class="box">
                    <a href="./product-detail.php?id='.$row['bid'].'">
                    <img src="'.$row["image"].'" alt="#" class="img-box">
                    <div class="text">
                        <span class="five_star">
                            <img src="images/star.png" alt="">
                            <img src="images/star.png" alt="">
                            <img src="images/star.png" alt="">
                            <img src="images/star.png" alt="">
                            <img src="images/star.png" alt="">
                            <span>4.8</span>
                        </span>
                        <h3>'.$row['name'].'</h3>
                        <p><span class="off-price">'.$row['price'].'VND</span>
                        </p>
                    </div>
                    </a>
                </div>';
        }
    } else {
        echo "0 result found";
    }

    echo $data;
}
?>