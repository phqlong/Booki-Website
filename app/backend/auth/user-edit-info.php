<?php
    require_once 'app/backend/core/init.php';
?>

<?php

$uid=$_SESSION['uid'];

if (isset($_POST["user-edit-info-button"])) {
	$name = $_POST["name"];
    $phone = $_POST['phone'];
	$email = $_POST["email"]; 

    $query = "UPDATE user SET name=$name, phone=$phone, email=$email WHERE uid='$uid'";
    $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
    echo("Cập nhật thông tin thành công");
}
?>



