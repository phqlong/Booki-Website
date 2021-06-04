 $(document).ready(viewProducts());

function viewProducts() {
    $.ajax({
        url: 'product-fetch.php',
        type: "post",
        data: {
            viewproducts: 'viewproducts'
        },
        success: function (data, status) {
            $('#main-content').html(data);
        }
    });
}