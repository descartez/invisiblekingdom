$(document).ready(function() {
  var controller = new StoryController( new StoryView() );
  controller.init();
  // $('.new-story').on('click', function(e){
  //   e.preventDefault();
  //   // function
  //   if (navigator.geolocation){
  //     navigator.geolocation.getCurrentPosition(function(position) {
  //       var coords = {
  //         lng: position.coords.longitude,
  //         lat: position.coords.latitude
  //       };
  //       // }
  //       // function
  //       $.ajax({
  //         url: '/stories',
  //         type: 'post',
  //         data: {longitude: coords.lng, latitude: coords.lat}
  //       }).done(function(serverData){
  //         console.log(serverData);
  //         addStory(serverData);
  //         console.log('success!');
  //       }).fail(function(serverData){
  //         console.log('wat');
  //       });
  //     }
  //     );

  //     // fine
  //     $('.map-story').on('click', function(e){
  //       e.preventDefault();
  //       console.log('should redirect to map: use a partial?');
  //     });
  //   }
  // });
});

// ------View ------- //
function StoryView(){}

StoryView.prototype.populateAndAddStoryTemplate = function(content, longitude, latitude){
  var template = "<article class='story'><h3>" + content + "</h3><p>(" + longitude +"," + latitude + ")</p></article>";
  $(".story-feed").prepend(template);
};

StoryView.prototype.findCurrentLocation = function() {
  // if (navigator.geolocation){
    navigator.geolocation.getCurrentPosition(this.positionSuccess);
  // }else{
  //   this.positionFail();
  // }

};

StoryView.prototype.positionSuccess = function(position) {
    var lng = position.coords.longitude;
    var lat = position.coords.latitude;

    request = $.ajax({
    url: '/stories',
    type: 'post',
    data: {longitude: lng, latitude: lat}
  });

  request.done(function(data){
    console.log(data);
    this.currentStory = new Story(data.content, data.longitude, data.latitude);
    this.view.populateAndAddStoryTemplate(this.currentStory.content, this.currentStory.longitude, this.currentStory.latitude);
  }.bind(me));

  request.fail(function(data){
    console.log('wat');
  });
};

StoryView.prototype.positionFail = function() {
  console.log("fail")
  request = $.ajax({
    url: '/stories',
    type: 'post',
    data: {longitude: -123, latitude: -48}
  });

  request.done(function(data){
    console.log(data);
    this.currentStory = new Story(data.content, data.longitude, data.latitude);
    this.view.populateAndAddStoryTemplate(this.currentStory.content, this.currentStory.longitude, this.currentStory.latitude);
  }.bind(me));

  request.fail(function(data){
    console.log('wat');
  });
};

// ------Model ------- //
function Story(content, longitude, latitude){
  this.content = content;
  this.longitude = longitude;
  this.latitude = latitude;
}

// ------Controller ------- //
function StoryController(view){
  this.view = view;
  this.currentStory = null;
}

StoryController.prototype.init = function(){
  this.bindEventListeners();
};

StoryController.prototype.bindEventListeners = function(){
  $('.new-story').on('click', this.getNewStory.bind(this));
};

StoryController.prototype.getNewStory = function(e) {
  e.preventDefault();
  me = this;
  this.view.findCurrentLocation();
};




// Revisit when there's time
// StoryController.prototype.setupCurrentStory = function(e) {
//   e.preventDefault();
//   var coordinates = this.view.findCurrentLocation();
//   this.currentStory = new Story(null, coordinates.lng, coordinates.lat);
//   // instantiate a new story
//   // set that new story equal to the current story
// }
