<?php
    require_once 'app/backend/core/init.php';
?>
<?php
    $warning = "";
    if(isset($_POST['login'])){    
        $username = $_POST['username'];
        $password = $_POST['password'];
        $role = $_POST['role'];

        $query = "CALL VALIDATE_LOGIN(\"$username\", \"$password\", \"$role\")";

        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_assoc($result)){
            $username = $row['username'];
            $role = $row['role'];
            
        }
        if($username == '-1'){
            $warning = "Sai tên đăng nhập hoặc mật khẩu";
        }
        else{
            $_SESSION['username'] = $username;
            $_SESSION['role'] = $role;
            header('Location: index.php');
        }
    }
?>