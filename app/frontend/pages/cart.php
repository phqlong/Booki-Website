<div class="cart">
    <div class="container">
        
        <h2 class="text-center mt-4">Giỏ hàng</h2>
        <table class="table table-hover ">
            <thead class="thead-dark">
                <tr>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th></th>
                </tr>
            </thead>

            <tbody class="detail-cart">
                <?php
                if (!empty($_SESSION["cart"])) {
                    $total = 0;
                    $data ="";
                    foreach ($_SESSION["cart"] as $keys => $values) {
                        $data .='
                            <tr>
                                <td><p class="text-left"><img src='.$values['item_image'].'><a href="product-detail.php?id='.$values["item_id"].'">'.$values["item_name"].'</a></p></td>
                                <td>'.$values['item_price'].' đ</td>
                                <td><input type="number" value="'.$values["item_quantity"].'" name="quantity" min="1" onchange="changeQuatity('.$values['item_id'].',this.value)"></td>
                                <td>'.($values["item_quantity"] * $values["item_price"]).' VND</td>
                                <td><button type="button" class="btn btn-danger" onclick="changeQuatity('.$values['item_id'].',0)">Xóa</button></td>
                            </tr>';
                        $total +=  ($values["item_quantity"] * $values["item_price"]);
                    }
                    $data .='
                        <tr>
                            <td colspan="3">Tổng cộng</td>
                            <td>'.$total.' đ</td>
                            <td></td>
                        </tr>';
                    echo $data;
                }
                ?>
            </tbody>
        </table>
        <div class="text-center">
            <a href="checkout.php" class="btn btn-primary py-3 px-3
                <?php if (count($_SESSION['cart']) == 0) echo "disabled"; ?>"> 
                Thanh toán 
            </a>
            <a href="product.php"  class="btn btn-secondary py-2 px-2" > Tiếp tục mua hàng </a>
        </div>
    </div>
</div>