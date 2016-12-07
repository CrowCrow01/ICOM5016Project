/**
 * Created by Crow on 11/17/2016.
 */
var term = window.location.href.substring(39);
var xmlhttp = new XMLHttpRequest();
var url =  "http://localhost:5000/searchResults/" + term //"searchresultRequest.txt";
// alert(term);
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        // alert(data.images[0].url);
        loadPage(data);
    }
};
xmlhttp.open("GET", url, true);
xmlhttp.send();

function loadPage(data) {
    var i = 0, temp;

    try
    {
    for(i=0;i<11;i++)
    {
        temp = "link" + ('' + (i+1));
        document.getElementById(temp).href = "item/" + data.images[i].itemid;

        temp = "image" + ('' + (i+1));
        document.getElementById(temp).src = data.images[i].url;

        temp = "title" + ('' + (i+1));
        document.getElementById(temp).innerHTML = data.images[i].title;

        temp = "artist" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Artist: " + data.images[i].artist;

        temp = "type" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Type: " + data.images[i].type;

        temp = "date" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Creation Date: " + data.images[i].date;

        temp = "descr" + ('' + (i+1));
        document.getElementById(temp).innerHTML = "Description: " + data.images[i].descr;


    }
    }catch(err) {
        for(;i<11;i++)
        {
            temp = "image" + ('' + (i+1));
            document.getElementById(temp).src = 'http://i.imgur.com/ZuE8EYG.jpg';
        }
    }
}