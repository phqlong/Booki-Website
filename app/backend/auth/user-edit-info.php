<?php
    require_once 'app/backend/core/init.php';
?>

<?php
$warning = "";
$usn = getUsername();
$role = getRole();

if (isset($_POST["user-edit-info-button"])) {
	$name = $_POST["name"];
    $phone = $_POST["phone"];
	$email = $_POST["email"]; 
    $oldPassword = $_POST["oldPassword"];
    $newPassword = $_POST["newPassword"];
    $validate_email = "";
    $validate_phone = "";
    
    $query = "CALL CHECK_EMAIL(\"$email\");";
    $query .= "CALL CHECK_PHONE(\"$phone\");";
    $query .= "CALL VALIDATE_LOGIN(\"$usn\", \"$oldPassword\", \"$role\")";

    mysqli_multi_query($conn, $query);
    $validator = array();
    do {
        if($result = mysqli_store_result($conn)){   
            if (mysqli_num_rows($result) > 0){
                while($row = mysqli_fetch_row($result)){
                    $validator[]= $row[0];
                }
            }
            mysqli_free_result($result);
        }
        
    } 
    while(mysqli_next_result($conn));
    if (count($validator) == 3) {
        if ($validator[2] == '-1'){
            $warning = "Sai mật khẩu";
        }
        elseif($validator[0] == '0'){
            $warning = "Email đã được sử dụng";
        }
        elseif($validator[1] == '0'){
            $warning = "Số điện thoại đã được sử dụng";
        }
        else{
            $query = "CALL UPDATE_INFO(\"$usn\", \"$newPassword\", \"$name\", \"$phone\", \"$email\")";
            mysqli_query($conn, $query);
            header('Location: user-info.php');
        }
    }

   
}
?>



