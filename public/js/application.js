$(document).ready(function() {
  var addStory = function(story){
    $(".story-feed").prepend("<article class='story'><h3>" + story.content + "</h3><p>" + story.longitude +" , " + story.lattitude + "</p></article>");
  };

  $('.new-story').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: '/stories',
      type: 'post'
      //need to pass longitude and lattitude
    }).done(function(serverData){
      console.log(serverData);
      addStory(serverData);
      console.log('success!');
    }).fail(function(serverData){
      console.log('wat');
    });
  });

  $('.map-story').on('click', function(e){
    e.preventDefault();
    console.log('should redirect to map: use a partial?');
  });

});
