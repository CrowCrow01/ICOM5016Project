var xmlhttp = new XMLHttpRequest();
var url = "paymentconfirmationRequest.txt";
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
xmlhttp.open("GET", url, true);
xmlhttp.send();

function loadPage(data) {

    document.getElementById("itemTitle").innerHTML = "Your order was: " + data.title;
    document.getElementById("orderID").innerHTML = "Your order number: #" + data.orderID;
    document.getElementById("shipDate").innerHTML = "Arriving: " + data.shipdate;
    document.getElementById("buyer").innerHTML = "Ship to: " + data.buyer;
    document.getElementById("buyerAddress").innerHTML = "Shipping Address: " + data.address;
    document.getElementById("itemPrice").innerHTML = "Total before shipping & handling: $" + data.itemprice;
    document.getElementById("shippingPrice").innerHTML = "Shipping & Handling: $" + data.shipprice;
    document.getElementById("totalPrice").innerHTML = "Order Total: $" + data.totalprice;

}