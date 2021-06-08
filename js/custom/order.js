window.onload = () =>{
    fetch_order();  

}
$('#order-search-status').change(function(){
    fetch_order();
});
$('#cancel-btn').click(function(){
    $('#order-details').fadeOut(200);
});


var obConf = {childList: true};

var order_observer = new MutationObserver(()=>{
    $('.view-details-btn').click(function () { 
        var username = $(this).parents().siblings(".username").html();
        var name = $(this).parent().siblings(".name").html();
        var oid = $(this).parent().siblings(".oid").html();
        var status = $(this).siblings("span").html();

        $('#username').html(username);
        $('#name').html(name);
        $('#oid').html(oid);
        $('#status').html(status);
        $('#order-details').fadeIn(200);
        $('#order-details').css('display', 'flex');
   
        
        $.ajax({
            type: "get",
            url: "order-details.php",
            data: {
                rq: 'order_details',
                oid: oid
            },
            dataType: "html",
            success: function (response) {  
                $('#order-details-body').html(response);
            }
        });   
    });

    $('.cancel-order-btn').click(function () { 
        var oid = $(this).parent().siblings(".oid").html();
        if(confirm("Xác nhận hủy đơn hàng?")){
            $.ajax({
                type: "post",
                url: "order-details.php",
                data: {
                    oid: oid
                },
                dataType: "html",
                success: function (response) { 
                    if(response == 1){
                        alert("Đã hủy đơn hàng.");
                        location.reload();
                    } 
                    else{
                        alert("Hủy đơn hàng thất bại. Vui lòng thử lại sau.")
                    }
                }
            });   
        }
        
   
        
        
    });

    
});

order_observer.observe($('#order-result-body')[0], obConf);


var fetch_order = () => {
    var status = $('#order-search-status').val();
    $.ajax({
        type: "get",
        url: "order-details.php",
        data: {
            rq: "list_orders",
            status: status
        },
        dataType: "html",
        success: function (response) {       
            if(response.trim()){
                $('#order-no-record').fadeOut(0);
                $('#order-result-body').html(response);
                 
                $('#order-result-body').fadeIn(200);
                $('#order-result-head').fadeIn(200);

            }
            else{
                console.log('empty');
                $('#order-result-head').fadeOut(100); 
                $('#order-result-body').fadeOut(100);
                $('#order-no-record').fadeIn(0);         
            }
            
        }
    });
}