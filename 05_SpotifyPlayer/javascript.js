var tracks = [];

/* ************************ SEARCH SONGS ********************** */
function searchSong(event) {

  var queryString, request;
  $('#tracks-list').fadeOut();
  $('.widget').fadeOut();
  queryString = encodeURI($('#search-input').val());
  request = $.get('https://api.spotify.com/v1/search?type=track&query=' + queryString);

  function handleSongs(response) {
    var html = '';
    tracks = response.tracks.items;
    $('#tracks-list').empty();

    tracks.forEach(function appendTrack(track, index) {
      html += '<a href="#" class="song list-group-item" data-track-index="' + index + '">' + '<h4 class="list-group-item-heading">' + track.name
           + '</h4> <p class="list-group-item-text"><span class="artist">' + track.artists[0].name +"</span>"
           + ' - <em>(' + track.album.name + ')</em></p></div></a>';
    });
    $('#tracks-list').append(html);

    if (tracks.length > 0) {
      $('.list-group-item:first').addClass('active');
      loadWidget(tracks[0]);
      $('#tracks-list').slideDown();
      $('.widget').fadeIn();
    }

  }

  function handleError(jqXHR, textStatus, errorThrown) {
    console.error('OH NO!!', jqXHR, textStatus, errorThrown);
  }

  request.done(handleSongs);
  request.fail(handleError);
  event.preventDefault();
}

$('#search-form').on('submit', searchSong);



/* ************************ PLAYER WIDGET ********************** */
function loadWidget(track) {
  $('.widget .header .metadata .title').text(track.name);
  $('.widget .header .metadata .author').text(track.artists[0].name);
  $('.widget .cover img').attr('src', track.album.images[0].url);
  $('.widget audio').attr('src', track.preview_url);
}

function widgetPlayPause() {
  if ($('.widget .btn-play').hasClass('playing')) {
    widgetPause();
  } else {
    widgetPlay();
  }
}

function widgetPause() {
  $('.widget audio').trigger('pause');
  $('.widget .btn-play').toggleClass('disabled', true);
  $('.widget .btn-play').toggleClass('playing', false);
}

function widgetPlay() {
  $('.widget audio').trigger('play');
  $('.widget .btn-play').toggleClass('disabled', false);
  $('.widget .btn-play').toggleClass('playing', true);
}

function widgetUpdateProgressBar() {
  var current = $(this).prop('currentTime');
  $('.seekbar progress').attr('value',current);
}

$('.widget .btn-play').on('click', widgetPlayPause);

$('.widget audio').on('timeupdate', widgetUpdateProgressBar);



/* ************************ LOAD ARTIST ********************** */

function loadArtist() {
  var request, html;

  request = $.get('https://api.spotify.com/v1/artists/0OdUWJ0sBjDrqHygGUXeCF');

  function handleArtist(response) {

  $('#artist-header').text(response.name);
  debugger;
  html = ""
  }

  function handleError(jqXHR, textStatus, errorThrown) {
    console.error('OH NO!!', jqXHR, textStatus, errorThrown);
  }

  request.done(handleArtist);
  request.fail(handleError);
  event.preventDefault();
}




/* ************************ SONGS LIST ********************** */

function changeSong(event) {
  var track;
  if ($(this).hasClass('active')){
    widgetPlayPause();
  } else {
    track = tracks[this.dataset.trackIndex];
    $('.list-group-item').removeClass('active');
    $(this).addClass('active');
    loadWidget(track);
    if ($('.widget .btn-play').hasClass('playing')) {
      widgetPlay();
    }
  }
  event.preventDefault();
}

 function showArtist(event) {
   loadArtist();
   $('.artist-modal').modal();
   event.stopPropagation();
}

$('#tracks-list').on('click', '.song', changeSong);
$('#tracks-list').on('click', '.artist', showArtist);
