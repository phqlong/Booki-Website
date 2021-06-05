function changeQuatity(id,quantity) {
    $.ajax({
        url: 'cart-fetch.php',
        type: 'post',
        data: {
            changeQuantity:"changeQuantity",
            id: id,
            quantity: quantity
        },
        success: function(data, status) {
            window.location="cart.php";
        }
    });

}