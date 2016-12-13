var xmlhttp = new XMLHttpRequest();
 var localurl = window.location.href;
 var id = localurl.substring(27);
 var url = "http://localhost:5000/getitem/"+id;
 // window.alert();
 xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
 xmlhttp.open("GET", url, true);
 xmlhttp.send();

function loadPage(data) {

    document.getElementById("itemImage").src = data.item.imageurl;
    document.getElementById("itemTitle").innerHTML = data.item.title + ", " + data.item.type;
    // document.getElementById("itemDimensions").innerHTML = "Measures: " + data.dimensions;
    document.getElementById("userlink").href = "http://localhost:5000/user/" + data.item.artistID;
    document.getElementById("itemArtist").innerHTML = "By: " + data.item.artist;
    document.getElementById("itemPrice").innerHTML = "Price: " + data.item.price;
    document.getElementById("itemQty").innerHTML = "Qty in stock:" + data.qty;
    // document.getElementById("itemComments").innerHTML = data.comment;
    // document.getElementById("itemDescription").innerHTML = data.item.description;
    document.getElementById("cartButton").action = "http://localhost:5000/addToCart/"+id;
}