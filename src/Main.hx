package;

import openfl.events.Event;
import treefortress.sound.SoundManager;
import haxe.Timer;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import treefortress.sound.SoundInstance;
import openfl.events.MouseEvent;
import treefortress.sound.SoundHX;
import openfl.display.Sprite;

class Main extends Sprite {
	public static var CLICK:String = "click";
	public static var MUSIC:String = "music";
	public static var SOLO1:String = "solo1";
	public static var SOLO2:String = "solo2";

	private var loopCount:Int = 0;
	private var solo:SoundInstance;

	private var music:SoundManager = SoundHX.manager.group("music");
	private var solos:SoundManager = SoundHX.manager.group("solos");

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		SoundHX.manager.loadSound("assets/loop.mp3", "loop");
		SoundHX.manager.loadSound("assets/click.mp3", CLICK);
		SoundHX.manager.loadSound("assets/music.mp3", MUSIC);
		SoundHX.manager.loadSound("assets/solo1.mp3", SOLO1);
		SoundHX.manager.loadSound("assets/solo2.mp3", SOLO2);
		stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyPress);
	}

	private function onKeyPress(event:KeyboardEvent):Void {
		SoundHX.manager.stopAll();
		music.stopAll();
		solos.stopAll();
		music.fadeMasterFrom(1);
		solos.fadeMasterFrom(1);
		var volume:Float = 1;
		switch (event.keyCode) {
			case Keyboard.ESCAPE:
				SoundHX.manager.stopAll();
			case Keyboard.NUMBER_1:
				trace("Testing PLAY: Play / Stop / PlayMultiple / StopMultiple");
				SoundHX.manager.playLoop(MUSIC, volume);
				trace("play");
			case Keyboard.NUMBER_2:
				trace("PAUSE: Pause / Resume, PauseAll / ResumeAll");
				SoundHX.manager.pause(MUSIC);
				trace("pause");
			case Keyboard.NUMBER_3:
				trace("FADES: fade, fadeMultiple, fadeMaster");
				SoundHX.manager.playLoop(MUSIC, volume);
				SoundHX.manager.fadeFrom(MUSIC, 0, 1, 3000);
				trace("fadeIn");
			case Keyboard.NUMBER_4:
				trace("FADES: fade, fadeMultiple, fadeMaster");
				SoundHX.manager.playLoop(MUSIC, volume);
				Timer.delay(function() {
					SoundHX.manager.fadeTo(MUSIC, 0);
					trace("fadeOut");
				}, 3000);
			case Keyboard.NUMBER_5:
				trace("MULITPLE CHANNELS: play 3 music + 1 solo loop, muteAll, unmuteAll, 20% volumeAll, stopAll");
				SoundHX.manager.playFx(MUSIC, .5);
				SoundHX.manager.playFx(MUSIC, .5, 2000);
				SoundHX.manager.playFx(MUSIC, .5, 4000);
				SoundHX.manager.playLoop(SOLO1);
			case Keyboard.NUMBER_6:
				trace("LOOPING: Loop solo 2 times, pause halfway each time. Shows workaround for the 'loop bug': http://www.stevensacks.net/2008/08/07/as3-sound-channel-bug/ ");
				solo = SoundHX.manager.play(SOLO1, volume, 0, 0);
				solo.soundCompleted.add(playPause);
				playPause(solo);
			case Keyboard.NUMBER_7:
				trace("GROUPS: MUSIC and SOLOS. Pause solos. Resume solos. FadeOut music, FadeIn music. Set volume music. Mute solos. unMute solos. ");
				music.loadSound("assets/music.mp3", MUSIC);
				solos.loadSound("assets/solo1.mp3", SOLO1);
				solos.loadSound("assets/solo2.mp3", SOLO2);

				music.playLoop(MUSIC);

				solos.playLoop(SOLO1);
				solos.playLoop(SOLO2);
				Timer.delay(function() {
					trace("pause solos");
					solos.pauseAll();
				}, 1000);
				Timer.delay(function() {
					trace("resume solos");
					solos.resumeAll();
				}, 2000);
				Timer.delay(function() {
					trace("fadeOut Music");
					music.fadeAllTo(0);
				}, 2500);
				Timer.delay(function() {
					trace("fadeIn Music");
					music.fadeAllTo(1, 350);
				}, 4000);
				Timer.delay(function() {
					trace("Music Volume = .2");
					music.volume = .2;
				}, 5000);
				Timer.delay(function() {
					trace("Mute Solos");
					solos.mute = true;
				}, 6000);
				Timer.delay(function() {
					trace("Unmute Solos");
					solos.mute = false;
				}, 7000);
				Timer.delay(function() {
					trace("STOP ALL!");
					for (i in 0...SoundHX.manager.groups.length) {
						SoundHX.manager.groups[i].stopAll();
					}
				}, 9000);
			case Keyboard.NUMBER_8:
				trace("Should throw a sound missing error instead of a Stack overflow.");
				SoundHX.manager.play("missing", 1);
			case Keyboard.NUMBER_9:
				trace("Check if SOLO2 isPlaying or Not.");
				SoundHX.manager.play(SOLO2, 1);
				var timer = new Timer(20);
				trace("timer started");
				timer.run = function() {
					trace("SOLO2 is playing ?" + SoundHX.manager.getSound(SOLO2).isPlaying);
				};

				Timer.delay(function() {
					trace("SOLO2 Paused");
					SoundHX.manager.getSound(SOLO2).pause();
				}, 1000);
				Timer.delay(function() {
					trace("SOLO2 Resumed");
					SoundHX.manager.getSound(SOLO2).resume();
				}, 2000);
				Timer.delay(function() {
					trace("SOLO2 play & fade");
					SoundHX.manager.play(SOLO2, 1);
					SoundHX.manager.fadeTo(SOLO2, 0, 1000).fade.stopAtZero = true;
				}, 4000);
				Timer.delay(function() {
					trace("timer stopped");
					timer.stop();
				}, 6000);
			case Keyboard.SPACE:
				SoundHX.manager.fadeMasterFrom(1);

				music.loadSound("assets/music.mp3", MUSIC);
				music.playLoop(MUSIC);

				solos.loadSound("assets/solo1.mp3", SOLO1);
				solos.loadSound("assets/solo2.mp3", SOLO2);
				solos.playLoop(SOLO1);
				solos.playLoop(SOLO2);
				Timer.delay(function() {
					trace("fadeMasterTo");
					music.fadeMasterTo(0);
				}, 2000);
				Timer.delay(function() {
					trace("fadeMasterTo");
					solos.fadeMasterTo(0);
				}, 3000);
		}
	}

	function playPause(si:SoundInstance):Void {
		if (++loopCount == 3) {
			trace("INFINITE LOOP: 5 seconds of repeating Clicks");
			var click:SoundInstance = SoundHX.manager.play(CLICK, 1, 0, -1, false, false, true);
			Timer.delay(function() {
				trace("stop Clicks");
				click.stop();
				click.soundCompleted.removeAll();
				solo.soundCompleted.removeAll();
			}, 5000);
		} else {
			SoundHX.manager.play(SOLO1, 1, 0, 0);
			Timer.delay(function() {
				solo.pause();
				trace("solo paused");
			}, 500);

			Timer.delay(function() {
				solo.resume();
				trace("solo resumed");
			}, 1000);
		}
	}

	private function onMouseClick(event:MouseEvent):Void {
		var click:SoundInstance = SoundHX.manager.playFx(CLICK);
		trace("clicked");
	}
}
