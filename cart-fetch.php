<?php
session_start();
if (isset($_POST['changeQuantity'])){
    foreach($_SESSION["shopping_cart"] as $keys => $values)
		{
			if($values["item_id"] == $_POST["id"])
			{
				$_SESSION["shopping_cart"][$keys]["item_quantity"] =$_POST["quantity"];
			}
		}    
    echo 'success';
}
?>