<?php
    require_once 'app/backend/core/init.php';

    if($_SERVER['REQUEST_METHOD'] == 'POST'){
        $username = $_SESSION['username'];
        $timestamp = date('Y-m-d H:i:s');

        $totalPrice = $_POST['totalPrice'];

        $fullName = $_POST['fullName'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];

        $address = $_POST['address'];
        $address .= ', '.$_POST['ward'];
        $address .= ', '.$_POST['district'];
        $address .= ', '.$_POST['province'];

        $paymentMethod = $_POST['paymentMethod'];
        $shippingMethod = $_POST['shippingMethod'];

        $query = "CALL CREATE_ORDER(
            \"$username\",
            \"$timestamp\"
        );";

        $result = mysqli_query($conn, $query);
        if (mysqli_num_rows($result) > 0) {
            while ($row = mysqli_fetch_assoc($result)) {
                $oid = intval($row['oid']);
            }
            mysqli_free_result($result);
            mysqli_next_result($conn);

            foreach($_SESSION["cart"] as $keys => $values)
            {
                $bid = intval($values["item_id"]);
                $bamount = intval($values["item_quantity"]);

                $query = "CALL ADD_ORDER_ITEM($oid, $bid, $bamount);";

                $result = mysqli_query($conn, $query);

                if(!$result){
                    // echo "Error add order items: " . mysqli_error($conn);
                    echo "<script>alert('Đặt hàng thất bại, vui lòng thử lại sau!');</script>"; 
                    echo '<script>window.location="cart.php";</script>';
                    exit();
                }
            }
        } else {
            // echo "Error create order: " . mysqli_error($conn);
            echo "<script>alert('Đặt hàng thất bại, vui lòng thử lại sau!');</script>"; 
            echo '<script>window.location="cart.php";</script>';
            exit();
        }

        $_SESSION['cart'] = array();
        
        echo "<script>alert('Đặt hàng thành công!');</script>"; 
        echo '<script>window.location="index.php";</script>';
    }
?> 