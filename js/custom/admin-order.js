window.onload = () =>{
    fetch_order();  

}

$('#admin-order-search').submit(function(e){
    e.preventDefault();
    fetch_order();
});
$('#admin-order-search-btn').click(function(){
    fetch_order();
});
$('#cancel-btn').click(function(){
    $('#admin-edit-order').fadeOut(200);
});

$("#update-btn").click(function (e) { 
    e.preventDefault();
    if(confirm("Xác nhận thay đổi?")){
        $.ajax({
            type: "post",
            url: "admin-edit-order.php",
            data: {
                oid: $("#oid").html(),
                status: $("#status-select").val()
            },
            success: function (response) {
                if(response == 1){
                    alert("Cập nhật thành công.");
                    location.reload();
                }
                else{
                    alert("Cập nhật thất bại.");
                }
            }
        });
    }
    
});

var obConf = {childList: true};

var order_observer = new MutationObserver(()=>{
    $('.edit-status-btn').click(function () { 
        var username = $(this).parents().siblings(".username").html();
        var name = $(this).parent().siblings(".name").html();
        var oid = $(this).parent().siblings(".oid").html();
        var status = $(this).siblings("span").html();

        $('#username').html(username);
        $('#name').html(name);
        $('#oid').html(oid);
        $('#status').html(status);
        $('#admin-edit-order').fadeIn(200);
        $('#admin-edit-order').css('display', 'flex');
   
        
        $.ajax({
            type: "get",
            url: "admin-edit-order.php",
            data: {
                rq: 'order_details',
                oid: oid
            },
            dataType: "html",
            success: function (response) {  
                $('#admin-order-detail-body').html(response);
            }
        });
        
    });
});

order_observer.observe($('#admin-order-result-body')[0], obConf);


var fetch_order = () => {
    var username = $('#admin-order-search-usn').val();
    var status = $('#admin-order-search-status').val();
    $.ajax({
        type: "get",
        url: "admin-edit-order.php",
        data: {
            rq: "list_orders",
            username: username,
            status: status
        },
        dataType: "html",
        success: function (response) {       
            if(response.trim()){
                $('#admin-order-no-record').fadeOut(0);
                $('#admin-order-result-body').html(response);
                 
                $('#admin-order-result-body').fadeIn(200);
                $('#admin-order-result-head').fadeIn(200);

            }
            else{
                console.log('empty');
                $('#admin-order-result-head').fadeOut(100); 
                $('#admin-order-result-body').fadeOut(100);
                $('#admin-order-no-record').fadeIn(0);         
            }
            
        }
    });
}