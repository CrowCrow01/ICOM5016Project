var xmlhttp = new XMLHttpRequest();
 var localurl = window.location.href;
 var id = localurl.substring(27);
 var url = "http://localhost:5000/getuser/"+id;
 // window.alert(id);
 xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var data = JSON.parse(this.responseText);
        loadPage(data);
    }
};
 xmlhttp.open("GET", url, true);
 xmlhttp.send();

function loadPage(data) {

    document.getElementById("edithref").href = "http://localhost:5000/user_edit/"+id;
    document.getElementById("userpic").src = data.userinfo[0].upicture;
    document.getElementById("name").innerHTML = "Name: " + data.userinfo[0].uname + " " + data.userinfo[0].lastname;
    document.getElementById("username").innerHTML = "Username: " + data.userinfo[0].nick;
    document.getElementById("email").innerHTML = "Email: " + data.userinfo[0].email;
    var i, temp;
     try
    {
        for(i =1; i<4; i++){

            temp = "itemlink" + ('' + (i));
            document.getElementById(temp).href = "http://localhost:5000/item/" + data.userinfo[i].iid;

            temp = "itempic" + ('' + (i));
            document.getElementById(temp).src = data.userinfo[i].imageurl;

            temp = "itemname" + ('' + (i));
            document.getElementById(temp).innerHTML = data.userinfo[i].iname;
        }
    }catch(err){
        for(;i<4;i++){
            temp = "itempic" + ('' + (i));
            document.getElementById(temp).src = 'http://i.imgur.com/ZuE8EYG.jpg';
        }
    }
}