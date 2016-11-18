var xmlhttp = new XMLHttpRequest();
 var url = "homepageRequest.txt";
 xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
 xmlhttp.open("GET", url, true);
 xmlhttp.send();

function loadPage(data) {
var i, temp;

for(i=0;i<9;i++)
{
    temp = "featTitle" + ('' + (i+1));
    document.getElementById(temp).innerHTML = data.images[i].title;

    temp = "featImage" + ('' + (i+1));
    document.getElementById(temp).src = data.images[i].url;

}
}