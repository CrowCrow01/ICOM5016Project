/**
 * Created by Crow on 11/17/2016.
 */
var xmlhttp = new XMLHttpRequest();
var url = "searchresultRequest.txt";
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

    for(i=0;i<10;i++)
    {
        temp = "image" + ('' + (i+1));
        document.getElementById(temp).src = data.images[i].url;

        temp = "title" + ('' + (i+1));
        document.getElementById(temp).innerHTML = data.images[i].title;

        temp = "artist" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Artist: " + data.images[i].artist;

        temp = "type" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Type" + data.images[i].type;

        temp = "date" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Creation Date: " + data.images[i].date;

        temp = "descr" + ('' + (i+1));
        document.getElementById(temp).innerHTML = data.images[i].descr;


    }
}