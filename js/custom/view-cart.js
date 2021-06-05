function changeQuatity(id,quantity) {
    $.ajax({
        url: 'cart-fetch.php',
        type: 'post',
        data: {
            update_quantity: quantity,
            id: id,
        },
        
        success: function(data, status) {
            window.location="cart.php";
        }
    });

}