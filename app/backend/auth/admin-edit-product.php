<?php
    require_once 'app/backend/core/init.php';
    
    if($_SERVER["REQUEST_METHOD"] == "GET"){
        if($_GET["edit_rq"] == "show_info"){

            $bid = $_GET["bid"];
            $query = "CALL GET_BOOK(\"$bid\")";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result)): 
                $name = htmlspecialchars_decode($row["name"]);
                $author = htmlspecialchars_decode($row["author"]);
                $publisher = htmlspecialchars_decode($row["publisher"]);
                $description = htmlspecialchars_decode($row["description"]);
                $amount = $row["amount"];
                $price =  $row["price"];
                $imageName = htmlspecialchars_decode($row["image"]);
                if($imageName == NULL){
                    $imageName = "";
                }

            endwhile;     
            echo json_encode(array(
                'name' => $name,
                'author' => $author,
                'publisher' => $publisher,
                'description' => $description,
                'amount' => $amount,
                'price' => $price,
                'imageName' => $imageName
            ));
        }
        
        else if(($_GET["edit_rq"] == "delete")){
            $bid = $_GET["bid"];
            $query = "CALL REMOVE_BOOK(\"$bid\")";
            mysqli_query($conn, $query);
        }
    }

    else if($_SERVER['REQUEST_METHOD'] == 'POST'){ 
        $bid = $_POST['bid'];
        $name = htmlspecialchars($_POST['name']);
        $author = htmlspecialchars($_POST['author']);
        $publisher = htmlspecialchars($_POST['publisher']);
        $description = htmlspecialchars($_POST['description']);
        $amount = $_POST['amount'];
        $price = $_POST['price'];
        $image = $_POST["image"];
        $imageName = htmlspecialchars('./images/'.$_POST['image-name']);
        
        $query = "CALL ADD_OR_UPDATE_BOOK(
            $bid,
            \"$name\",
            \"$author\",
            \"$publisher\",
            \"$description\",
            \"$imageName\", 
            $amount,
            $price
        )";
        echo mysqli_query($conn, $query);
        
            
    }
?>
            