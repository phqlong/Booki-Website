window.onload = () =>{
    fetch_order();  

}

$('#admin-order-search').submit((e)=>{
    e.preventDefault();
    fetch_order();
});
$('#admin-order-search-btn').click(()=>{
    fetch_order();
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
                console.log(response)
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
            console.log(response.length);
            console.log(response)
            if(response){
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