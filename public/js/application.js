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
function StoryView(){};

StoryView.prototype.populateAndAddStoryTemplate = function(content, longitude, latitude){
  var template = "<article class='story'><h3>" + content + "</h3><p>(" + longitude +" , " + latitude + ")</p></article>";
  $(".story-feed").prepend(template);
};

StoryView.prototype.findCurrentLocation = function() {
  // var coords;
  // setTimeout((function() {
  //     navigator.geolocation.getCurrentPosition(function(position) {
  //       coords = {
  //         lng: position.coords.longitude,
  //         lat: position.coords.latitude
  //       };
  //     }, function(){console.log("there was an error")}, {timeout:1000});
  //   return coords;
  // })(),1000);
  // return coords;
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
  // this.populateStoryCollection();
  // this.createStoryRiver();
};

StoryController.prototype.bindEventListeners = function(){
  $('.new-story').on('click', this.getNewStory.bind(this));
};

StoryController.prototype.getNewStory = function(e) {
  e.preventDefault();
  var me = this;

  request = $.ajax({
    url: '/stories',
    type: 'post',
    data: {longitude: 7, latitude: 7}
  });

  request.done(function(data){
    this.currentStory = new Story(data.content, data.longitude, data.latitude);
    this.view.populateAndAddStoryTemplate(this.currentStory.content, this.currentStory.longitude, this.currentStory.latitude);
  }.bind(me));

  request.fail(function(data){
    console.log('wat');
  });
};




// Revisit when there's time
// StoryController.prototype.setupCurrentStory = function(e) {
//   e.preventDefault();
//   var coordinates = this.view.findCurrentLocation();
//   this.currentStory = new Story(null, coordinates.lng, coordinates.lat);
//   // instantiate a new story
//   // set that new story equal to the current story
// }
