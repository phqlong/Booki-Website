<?php
    require_once 'app/backend/core/init.php';
    $bid = "";
    $name = $author = $publisher = $description = $amount = $price = $imageName = "";
    if($_SERVER["REQUEST_METHOD"] == "GET"):
        if(isset($_GET["bid"])):
            $bid = $_GET["bid"];
            $query = "CALL GET_BOOK(\"$bid\")";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result)): 
                $name = $row["name"];
                $author = $row["author"];
                $publisher = $row["publisher"];
                $description = $row["description"];
                $amount = $row["amount"];
                $price = $row["price"];
                $imageName = $row["image"];
            endwhile;        
        
        elseif(isset($_GET["deleteBid"])):
            $bid = $_GET["deleteBid"];
            $query = "CALL REMOVE_BOOK(\"$bid\")";
            mysqli_query($conn, $query);
            unset($_GET["deleteBid"]);
            header("Location: admin-product.php");
        endif;
    endif;

    if($_SERVER['REQUEST_METHOD'] == 'POST'){
        if($_POST['updated'] == 'confirm'){
            $name = $_POST['name'];
            $author = $_POST['author'];
            $publisher = $_POST['publisher'];  
            $description = $_POST['description'];
            $amount = $_POST['amount'];
            $price = $_POST['price'];
            $image = $_POST["image"];
            $imageName = './images/'.$_POST['image-name'];
            
            var_dump($image);
        }
    }
?>
            