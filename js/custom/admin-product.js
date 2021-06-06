changed = false;

init_preview = () => {
    $("#prv-image").attr('src', './images/' + $('#image-name').val());
    $('#prv-name').html($('#name').val());
    $('#prv-author').html($('#author').val());
    $('#prv-publisher').html($('#publisher').val());
    $('#prv-amount').html($('#amount').val());
    var price_pretty = parseInt($('#price').val()).toLocaleString();
    $('#prv-price').html(price_pretty);
}


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

$('.btn-add').click(function(){
    changed = false;
    $('#admin-edit-book').trigger('reset');
    $('#admin-edit-book').css('display', 'flex');
    
    $('#update-btn').val(-1);
    $('#update-btn').html('Thêm');

    init_preview();
});


$('.btn-edit').click(function () {
    changed = false;
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
            $('#update-btn').html('Cập nhật');

            init_preview()
        }
    });

});
