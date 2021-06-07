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
        $validate_mail = "";
        $validate_phone = "";

        // Check mail:  If validate_mail == '1' =>  Valid email
        $result = mysqli_store_result($conn);

        if(mysqli_num_rows($result) > 0){
            while($row = mysqli_fetch_assoc($result)){
                $validate_mail = $row['result'];
            }
        }

        mysqli_free_result($result);
       
        // Check phone:  If validate_phone == '1' =>  Valid phone
        $result = mysqli_next_result($conn);
        
        echo $result;
        if(mysqli_num_rows($result) > 0){
            while($row = mysqli_fetch_assoc($result)){
                $validate_phone = $row['result'];
            }
        }

        mysqli_free_result($result);
        
        // Create user
        if($validate_mail == '1' && $validate_phone == '1'){
            $query = "CALL CREATE_USER('$username', '$password', '$name', '$email', '$phone')";
            $result = mysqli_query($query);
            if(!$result){
                echo ("Tên đăng nhập đã tồn tại, vui lòng sử dụng tên khác");
            }
            else{
                echo ("Chúc mừng bạn đã đăng ký thành công");
                header('Location: login.php');
            }
        }
        elseif($validate_mail == '0' && $validate_phone == '1'){
            echo ("Email này đã được sử dụng");
        }
        elseif($validate_mail == '1' && $validate_phone == '0'){
            echo ("Số điện thoại này đã được sử dụng");
        }
        else{
            echo ("Email và Số điện thoại này đã được sử dụng");
        }
        $validate_phone = 5;
        echo $validate_mail;
        echo $validate_phone;
        echo 1;
    }
?>
