/**
 * Created by Crow on 11/17/2016.
 */
var data;
var term = window.location.href.substring(39);
var xmlhttp = new XMLHttpRequest();
var url =  "http://localhost:5000/searchResults/" + term //"searchresultRequest.txt";
// alert(term);
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
xmlhttp.open("GET", url, true);
xmlhttp.send();

var j = 0;
function loadPage(data) {
    var i = 0, temp;
    
    if(j==0) document.getElementById("prev").disabled = true;

    try{
        for(i=0;i<10;i++){
            if (data.images[j].url == "http://i.imgur.com/ZuE8EYG.jpg"){
                var performingErrorOnPurpose = data.images[1].itemid;
            }
            temp = "link" + ('' + (i+1));
            document.getElementById(temp).href = "item/" + data.images[j].itemid;

            temp = "image" + ('' + (i+1));
            document.getElementById(temp).src = data.images[j].url;

            temp = "title" + ('' + (i+1));
            document.getElementById(temp).innerHTML = data.images[j].title;

            temp = "artist" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "Artist: " + data.images[j].artist;

            temp = "type" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "Type: " + data.images[j].type;

            temp = "date" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "Creation Date: " + data.images[j].date;

            temp = "descr" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "Description: " + data.images[j].descr;
            
            j = j+1;
        }
    }catch(err) {
        for(;i<10;i++)
        {
            temp = "image" + ('' + (i+1));
            document.getElementById(temp).src = 'http://i.imgur.com/ZuE8EYG.jpg';

            temp = "link" + ('' + (i+1));
            document.getElementById(temp).href = "#";

            temp = "title" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "";

            temp = "artist" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "";

            temp = "type" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "";

            temp = "date" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "";

            temp = "descr" + ('' + (i+1));
            document.getElementById(temp).innerHTML = "";
        
            j = j+1;
        }
        document.getElementById("next").disabled = true;
    }
    if(data.images[j].itemid == null) {document.getElementById("next").disabled = true; window.alert(data.images[j].itemid);}
}

function getNextPage() {
    document.getElementById("prev").disabled = false;
    loadPage(data);
}

function getPreviousPage() {
    document.getElementById("next").disabled = false;
    j = j - 20;
    loadPage(data);
}
