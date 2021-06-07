<?php
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['checkout-btn'])){ 
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
    )";

    if ($result = mysqli_query($conn, $query)) {
        $oid = mysqli_fetch_assoc($result)['oid'];

        foreach($_SESSION["cart"] as $keys => $values)
        {
            sleep(3);
            $bid = $values["item_id"];
            $bamount = $values["item_quantity"];
            
            $query = "CALL ADD_ORDER_ITEM(\"$oid\", \"$bid\", \"$bamount\")";

            if(!mysqli_query($conn, $query)){
                // echo "Error add order items: " . mysqli_error($conn);
                echo "<script>alert('Đặt hàng thất bại, vui lòng thử lại sau!');</script>"; 
                // header('Location: cart.php');
                exit();
            }
        }
    } else {
        // echo "Error create order: " . mysqli_error($conn);
        echo "<script>alert('Đặt hàng thất bại, vui lòng thử lại sau!');</script>"; 
        header('Location: cart.php');
        exit();
    }
    mysqli_free_result($result);

    $_SESSION['cart'] = array();
    echo "<script>alert('Đặt hàng thành công!');</script>"; 
    header('Location: index.php');
}
?>