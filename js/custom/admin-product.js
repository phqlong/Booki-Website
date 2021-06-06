$('.btn-delete').click(function () {
    if (confirm('Xác nhận xóa sản phẩm')) {
        var bid = $(this).val();
        $.ajax({
            type: "get",
            url: "admin-edit-product.php",
            data: {
                "edit_rq": "delete",
                "bid": bid
            },
            success: function (response) {
                
                location.reload();
            }
        });
    }

});

$('.btn-edit').click(function () {
    var bid = $(this).val();

    $.ajax({
        type: "GET",
        url: "admin-edit-product.php",
        data: {
            edit_rq: "show_info",
            bid: bid
        },
        dataType: "JSON",
        success: function (response) {
            $('#admin-edit-book').css('display', 'flex');
            $('#name').val(response.name);
            $('#author').val(response.author);
            $('#publisher').val(response.publisher);
            $('#description').val(response.description);
            $('#amount').val(response.amount);
            $('#price').val(response.price);
        
            $('#image-name').val(response.imageName.split('/')[2]);

            $('#update-btn').val(bid);

            $("#prv-image").attr('src', response.imageName);
            $('#prv-name').html(response.name);
            $('#prv-author').html(response.author);
            $('#prv-publisher').html(response.publisher);
            $('#prv-amount').html('Số lượng: ' + response.amount);
            $('#prv-price').html('Giá: ' + response.price + ' VND');
        }
    });

});
