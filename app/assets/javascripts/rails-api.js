  $(document).on('ready', function(){
    getTimeDifference();
    clickNextPost();
    getComments();
    createComments();
    Comment.templateSource = $("#comment-template").html();
    Comment.template = Handlebars.compile(Comment.templateSource);
    bindCommentDeleteEventListeners();
  });

  var allPosts = [];
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

  function Comment(comment_attributes) {
    this.id = comment_attributes.id;
    this.content = comment_attributes.content;
    this.userid = comment_attributes.post.user_id;
    this.postid = comment_attributes.post.id;
  }


  function getTimeDifference() {
    var activeUserIds = [];
    $.ajax({
      method: "get",
      url: "/posts.json",
      dataType: "json"
    }).success(function(data) {
      var post;
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
    var usernames = [];
    if(userIdsArray.length > 0) {
      $.get("/users", function(data) {
      var user;
      for(var key in data) {
        user = new User(data[key]["id"], data[key]["username"]);
        allUsers.push(user);
        for(var i=0; i < userIdsArray.length; i++) {
           if(userIdsArray[i] === user["id"]) {
             if(!usernames.includes(user["username"])) {
               usernames.push(user["username"]);
             }
          }
        }
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


  function clickNextPost() {
    $("#next_button").on("click", function(e) {
      e.preventDefault();
      var id = $(this).attr("data-id");
      getNextPost(id);
    });
  }

  function getNextPost(id) {
    var nextId;
    id = parseInt(id);
    var currentIndex;
    for(var i= 0; i<allPosts.length; i++) {
      if(allPosts[i].id === id) {
        currentIndex = i;
      }
    }
    if(currentIndex < 0 || currentIndex == allPosts.length-1) {
      nextId = allPosts[0].id
    } else {
        nextId = allPosts[currentIndex+1].id;
    }

    $.get("/posts/" + nextId, function(data) {
        $("html").html(data);
    })
  }

  function getComments() {

    var postId = $("h1#content").attr("data-id");
      $.ajax({
      method: "GET",
      url: `/posts/${postId}/comments`,
      dataType: 'script',
    }).then(function() {
      bindCommentDeleteEventListeners()

    })
  }


  Comment.prototype.commentTemplate = function() {
    return Comment.template(this);
  }

  Comment.response = function(data) {
    var new_comment = new Comment(data);
    $("input#comment_content").val("");

    var commentT = new_comment.commentTemplate();
    $(".each_comment").append(commentT);
  }

  Comment.prototype.renderComment = function (element) {
    element.append(`
      <div>
        <h1>${this.content}</h1>
      </div>
    `)
  }

function createComments() {
    $("form#new_comment").on("submit", function(event) {
        $.ajax({
           type: ($("input[name='_method']").val() || this.method),
           url: this.action,
           data: $(this).serialize(),
           dataType: 'json',
           success: function(data) {
             Comment.response(data);
         }
       })

      event.preventDefault();
  })
}

function bindCommentDeleteEventListeners() {
  $("a#delete_comment").on("click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    var comment_id = $(this).data("id");

    $.ajax({
      method: 'DELETE',
      dataType: 'JSON',
      url: this.href
    }).success(function() {
      var found = $("div.each_comment").find("p");
      for(var i=0; i<found.length; i++) {
        if(parseInt(found[i]["dataset"]["id"]) === comment_id) {
          $(found[i]).remove();
        }
      }
      return false;
    })
  })
}
