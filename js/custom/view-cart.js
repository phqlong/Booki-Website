function changeQuatity(id,quantity) {
    $.ajax({
        url: 'cart.php',
        type: 'post',
        data: {
            update_quantity: quantity,
            id: id,
        },
        
        success: function(data, status) {
            $( ".cart" ).load(window.location.href + " .cart" );
        }
    });

}
