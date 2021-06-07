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
    $('button.edit-status-btn').click(()=>{ 
        console.log($(this)[0])
        var username = $(this).parents("td").siblings(".username").html();
        var name = $(this).parent().siblings(".name").html();
        var oid = $(this).parent().siblings(".oid").html();
        console.log(username);
        console.log(oid);
        console.log(name);
        $('#username').html(1);
        $('#name').html(name);
        $('oid').html(oid);
        $('#admin-edit-order').css('display', 'flex');
    });
});
order_observer.observe($('#admin-order-result-body')[0], obConf)


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
            if(response){
                $('#admin-order-no-record').fadeOut(0);
                $('#admin-order-result-body').html(response);
                 
                $('#admin-order-result-body').fadeIn(200);
                $('#admin-order-result-head').fadeIn(200);

            }
            else{
                $('#admin-order-result-head').fadeOut(100); 
                $('#admin-order-result-body').fadeOut(100);
                $('#admin-order-no-record').fadeIn(0);         
            }
            
            
        }
    });
}