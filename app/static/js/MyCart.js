var xmlhttp = new XMLHttpRequest();
var url = "http://localhost:5000/myCart";
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
xmlhttp.open("GET", url, true);
xmlhttp.send();

function loadPage(data) {
    var i=0, temp;
	var listhtml = "", total;
    try {
		while(data.cart[i].iid != null){
			var title = data.cart[i].title;
			var price = data.cart[i].price;
			var iid = data.cart[i].iid;
			listhtml = listhtml + '<a href="#" class="list-group-item">\n<h4 class="list-group-item-heading">' + title + "</h4>\n"
			+ "<p> $" + price + '</p>\n<form action="http://localhost:5000/cartdelete/'+ iid + '" method="POST"><input type="submit" value="Remove"></input></form></a>';
			i = i + 1;
		}
	}catch(err) {}
	document.getElementById("list").innerHTML = listhtml;
	document.getElementById("buyer").innerHTML = "Ship to: " + data.fullname;
	document.getElementById("address").innerHTML = "Address: " + data.address;
	total = data.totalprice.toFixed(2).toString();
	document.getElementById("qtyprice").innerHTML = "Total Before Shipping & Handling: $" + total;
	total = (data.totalprice + 20).toFixed(2).toString();
	document.getElementById("totalprice").innerHTML = "Total: $" + total;
}

// loadPage();