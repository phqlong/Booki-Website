<?php
    require_once 'app/backend/core/init.php';
?>
<?php
    $warning = "";
    if(isset($_POST['login'])){    
        $username = $_POST['username'];
        $password = $_POST['password'];
        $role = $_POST['role'];

        $query = "CALL VALIDATE_LOGIN(\"$username\", \"$password\", \"$role\");";
        $query .= "CALL SHOW_CART_ITEMS(\"$username\")";

        mysqli_multi_query($conn, $query);

        $result = mysqli_store_result($conn);
        while($row = mysqli_fetch_assoc($result)){
            $username = $row['username'];
            $role = $row['role'];
            
        }
        mysqli_free_result($result);

        if($username == '-1'){
            $warning = "Sai tên đăng nhập hoặc mật khẩu";
        }
        else{
            $_SESSION['username'] = $username;
            $_SESSION['role'] = $role;

            if ($role == 'customer') {
                $_SESSION["shopping_cart"] = array();

                while (mysqli_next_result($conn)) {
                    if($result = mysqli_store_result($conn)){
                        if (mysqli_num_rows($result) > 0) {
                            while($row = mysqli_fetch_assoc($result)){
                                $item_array = array(
                                    'item_id'       =>  $row["bid"],
                                    'item_name'     =>  $row["bname"],
                                    'item_price'    =>  $row["bprice"],
                                    'item_quantity' =>  $row["quantity"],
                                    'item_image'    =>  $row["bimg"]
                                );
                                array_Push($_SESSION["shopping_cart"], $item_array);    
                            }
                        }
                        mysqli_free_result($result);
                    }
                }
            }

            header('Location: index.php');
        }
    }
?>