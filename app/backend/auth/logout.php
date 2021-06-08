<?php
    if(isset($_SESSION['username']))
        $username = $_SESSION['username'];
        
    if ($_SESSION['role'] == 'customer') {
        $query = "CALL REMOVE_ALL_CART_ITEM(\"$username\")";
        
        if (mysqli_query($conn, $query)) {
            foreach($_SESSION["cart"] as $keys => $values)
            {
                $bid = $values["item_id"];
                $bamount = $values["item_quantity"];
                $query = "CALL ADD_TO_CART(\"$username\", \"$bid\",  \"$bamount\")";

                mysqli_query($conn, $query);
            }
        } else {
            echo "Error deleting record: " . mysqli_error($conn);
        }
        unset($_SESSION['cart']);
    }

    unset($_SESSION['cart']);
    unset($_SESSION['username']);
    unset($_SESSION['role']);
?>