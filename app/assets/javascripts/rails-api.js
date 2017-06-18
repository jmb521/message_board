$(document).ready(function() {

    getTimeDifference();
    clickNextPost();

});

var allPosts = []; //a way to store the newly created post objects
var allUsers = [];

  function Post(id, content, user_id, created_at, updated_at, comments) {
    this.id = id;
    this.content = content;
    this.user_id = user_id;
    this.created_at = created_at;
    this.updated_at = updated_at;
  }

  function User(id, username) {
    this.id = id;
    this.username = username;
  }

  function getTimeDifference() {
    var activeUserIds = [];
    $.ajax({
      method: "get",
      url: "/posts.json",
      dataType: "json"
    }).success(function(data) {
      var post;

      // loop through objects to check to see if the difference is less than 7 days. If it is, put the user_id from that object into an array
      // once the array is full, get a list of users, compare their id to the user_id array to see if there is any matches and get a list of users
      // append the list of users to the dom.

      for(var key in data) {
        post = new Post(data[key]["id"], data[key]["content"], data[key]["user_id"], data[key]["created_at"], data[key]["updated_at"]);
      allPosts.push(post);
        var splitData = post["created_at"].split("T");
        var splitDate = splitData[0].split("-");
        splitDate = splitDate.join(",");
        var prevTime = new Date(splitDate);  // Feb 1, 2011
        var thisTime = new Date();              // now
        var diff = thisTime.getTime() - prevTime.getTime();   // now - Feb 1
        var daysPast = (diff / (1000*60*60*24));
          if(daysPast < 8) {
            activeUserIds.push(post["user_id"]);
          }
        }

        addActiveUsers(activeUserIds);

    });
  }



  function addActiveUsers(userIdsArray) {
    // console.log(userIdsArray)
    var usernames = [];
    if(userIdsArray.length > 0) {
      $.get("/users", function(data) {
      var user;
        //loop
        for(var key in data) {
          user = new User(data[key]["id"], data[key]["username"]);
          allUsers.push(user);
        for(var i=0; i < userIdsArray.length; i++) {
          //  for(var j=0; j< data.length; j++) {
             if(userIdsArray[i] === user["id"]) {
               if(!usernames.includes(user["username"])) {
                 usernames.push(user["username"]);
               }
            }
          // }
        }
        // console.log(usernames);
      }
        $("#active-users").append("<ul></ul>");
        $.each(usernames, function(iterator, username) {
          $("#active-users ul").append("<li>" + username + "</li");
        })
       });
       } else {
        $("#active-users").append("<p>There have not been active users in the past 7 days</p>");
      }
  }

  /////////////////////////////////////////////////////////////////////////////
//use jquery/api to get the next post and display it to the user.
  function clickNextPost() {
    $("#next_button").on("click", function(e) {
      e.preventDefault();
      var id = $(this).attr("data-id");
      getNextPost(id); //passing in the id of current post

    });

  }

  function getNextPost(id) {
    var nextId;
    id = parseInt(id);
    if(id <=allPosts.length-1) {

      nextId = id + 1;

    } else {
      nextId = 1;
    }
    console.log("nextId: " + nextId);
    $.get("/posts/" + nextId, function(data) {
        $("html").html(data);
    })
  
  }
