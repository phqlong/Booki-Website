<?php
if (isset($_POST['update_quantity'])){
    foreach($_SESSION["cart"] as $keys => $values)
		{
			if($values["item_id"] == $_POST["id"])
			{
				$new_quantity = $_POST["update_quantity"];
				if ($new_quantity > 0) {
					$_SESSION["cart"][$keys]["item_quantity"] = $new_quantity;
				}
				else {
					unset($_SESSION["cart"][$keys]);
				}
				echo 'success';
			}
		}    
    echo 'error';
}
?>