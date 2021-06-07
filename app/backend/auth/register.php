<?php
    require_once 'app/backend/core/init.php';
?>

<?php
    if (isset($_POST['register-button'])){
        $username=$_POST['username'];
        $password=$_POST['password'];
        $name=$_POST['name'];
        $email=$_POST['email'];
        $phone=$_POST['phone'];

        $query = "CALL CHECK_EMAIL(\"$email\");";
        $query .= "CALL CHECK_PHONE(\"$phone\")";
        mysqli_multi_query($conn, $query);
        $validate_email = "";
        $validate_phone = "";

        // Check mail:  If validate_mail == '1' =>  Valid email
        $result = mysqli_store_result($conn);

        if(mysqli_num_rows($result) > 0){
            while($row = mysqli_fetch_row($result)){
                $validate_email = $row[0];
            }
        }

        mysqli_free_result($result);

        // Check phone:  If validate_phone == '1' =>  Valid phone
        while(mysqli_next_result($conn)){
            if($result = mysqli_store_result($conn)){   
                if (mysqli_num_rows($result) > 0){
                    while($row = mysqli_fetch_row($result)){
                        $validate_phone = $row[0];
                    }
                }
               
            }
        }

        // Create user
        if($validate_email == '1' && $validate_phone == '1'){
            $query = "CALL CREATE_USER('$username', '$password', '$name', '$phone', '$email')";
            $result = mysqli_query($conn, $query);
            if(!$result){
                echo ("Tên đăng nhập đã tồn tại, vui lòng sử dụng tên khác");
            }
            else{
                header('Location: login.php');
            }
        }
        elseif($validate_email == '0' && $validate_phone == '1'){
            echo ("Email này đã được sử dụng");
        }
        elseif($validate_email == '1' && $validate_phone == '0'){
            echo ("Số điện thoại này đã được sử dụng");
        }
        else{
            echo ("Email và Số điện thoại này đã được sử dụng");
        }
    }
?>
