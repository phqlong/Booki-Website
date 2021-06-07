$('#admin-order-search').submit((e)=>{
    e.preventDefault();
    fetch_order();
});
$('#admin-order-search-btn').click(()=>{
    fetch_order();
});

var fetch_order = () => {
    var username = $('#admin-order-search-usn').val();
    var status = $('#admin-order-search-status').val();
    $.ajax({
        type: "get",
        url: "admin-edit-order.php",
        data: {
            username: username,
            status: status
        },
        dataType: "html",
        success: function (response) {
            if(response){
                $('#admin-order-no-record').fadeOut(0);
                $('#admin-order-result').html(response);
                 
                $('#admin-order-result').fadeIn(200);
                $('#admin-order-result-head').fadeIn(200);

            }
            else{
                $('#admin-order-result-head').fadeOut(100); 
                $('#admin-order-result').fadeOut(100);
                $('#admin-order-no-record').fadeIn(0);         
            }
            
            
        }
    });
}