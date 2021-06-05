<div class="cart">
    <div class="container">
        
        <h2 class="text-center">Giỏ hàng</h2>
        <table class="table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody class="detail-cart">
                <?php
                if (!empty($_SESSION["shopping_cart"])) {
                    $total = 0;
                    $data ="";
                    foreach ($_SESSION["shopping_cart"] as $keys => $values) {
                    $data .='
                        <tr>
                            <td><img src='.$values['item_image'].'>'.$values["item_name"].'</td>
                            <td>'.$values['item_price'].' đ</td>
                            <td><input type="number" value="'.$values["item_quantity"].'" name="quantity" min="1" onchange="changeQuatity('.$values['item_id'].',this.value)"></td>
                            <td>'.($values["item_quantity"] * $values["item_price"]).' đ</td>
                            <td><a href="cart.php?action=delete&id='.$values["item_id"].'" class="btn btn-danger">Delete</a</td>
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
                <!-- <tr>
                    <td><img src="images/black_clover.jpg">BlackClover</td>
                    <td>25000đ</td>
                    <td><input type="number" value="1" name="quantity"></td>
                    <td>50000đ</td>
                    <td><button type="submit" class="btn btn-danger">Delete</button></td>
                </tr>-->

            </tbody>
        </table>
        <div class="text-center">
        <button class="btn btn-success" > Đặt hàng </button>
        <!-- To do -->
        </div>
    </div>
</div>