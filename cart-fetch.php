<?php
session_start();
if (isset($_POST['update_quantity'])){
    foreach($_SESSION["shopping_cart"] as $keys => $values)
		{
			if($values["item_id"] == $_POST["id"])
			{
				$new_quantity = $_POST["update_quantity"];
				if ($new_quantity > 0) {
					$_SESSION["shopping_cart"][$keys]["item_quantity"] = $new_quantity;
				}
				else {
					unset($_SESSION["shopping_cart"][$keys]);
				}
				echo 'success';
			}
		}    
    echo 'error';
}
?>