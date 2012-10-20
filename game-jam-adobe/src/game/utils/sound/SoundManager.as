package game.utils.sound
{
	import flash.display.Sprite;
		
	import game.utils.sound.SoundWrapper
	import flash.media.Sound;
	import flash.events.Event;
	
	import game.utils.FrameTime;
	
	/**
	* Manages all of the audio
	*/
	public class SoundManager extends Object
	{
		// must be negative
		public static const LOOP_ENDLESSLY:int = -1;
		
		private static const VOLUME_SCALER_MUSIC:Number = 1.0;
		private static const VOLUME_SCALER_SFX:Number = 0.8;
		
		//============================================
		//	variables 
		//============================================
		
		private var _aoSoundLayer:Vector.<SoundManagerLayer>;
		//private var _oMusic_Target:SoundWrapper; // for cross fading
		
		// volumes as set by player options
		private var _fVolumeSfx_Options:Number;
		private var _fVolumeMusic_Options:Number;
		
		// volume as set by fade ins/outs
		private var _fVolumeSfx_Fade:Number;
		private var _fVolumeMusic_Fade:Number;
		
		private var _fVolumeSfx_Fade_Target:Number;
		private var _fVolumeMusic_Fade_Target:Number;
		
		private var _fVolumeMusic_Fade_ChangeDuration:Number;
		
		private var _oSprite:Sprite;
		
		//============================================
		//	instance methods
		//============================================
		
		
		/**
		* @constructor
		*/
		public function SoundManager(singletonEnforcer:SingletonEnforcer):void
		{
			//m_oPlayerData = GlobalData.instance.currentProfile;
			// we always want at least 1 sound layer
			_aoSoundLayer = new Vector.<SoundManagerLayer>();
			_aoSoundLayer.push(		new SoundManagerLayer()	);
			
			_fVolumeSfx_Options			= 1.0;
			_fVolumeMusic_Options		= 1.0;
			_fVolumeSfx_Fade			= 1.0;
			_fVolumeMusic_Fade			= 1.0;
			
			_fVolumeSfx_Fade_Target		= 1.0;
			_fVolumeMusic_Fade_Target	= 1.0;
		
			_fVolumeMusic_Fade_ChangeDuration = 0.0;
			
			_oSprite = new Sprite();			
		}
		
		private static var _instance:SoundManager;
		public static function get instance():SoundManager
		{
			// set up the initial instance if it hasn't been set up yet.
			if (_instance == null)
			{
				_instance = new SoundManager(	new SingletonEnforcer()		);
			}
			
			return _instance;
		}
		
		public function vSetUpProfile():void
		{
			//GlobalData.instance.currentProfile.removeEventListener(SavedPlayerData.EVENT_SOUND_VOLUMECHANGE, vHandleVolumeChange);
			//GlobalData.instance.currentProfile.addEventListener(SavedPlayerData.EVENT_SOUND_VOLUMECHANGE, vHandleVolumeChange, false, 0, true);
			//vHandleVolumeChange();
		}
		
		//============================================
		//	managing sounds
		//============================================
		public function vPlaySound(sfxSound:Sound):SoundWrapper
		{
			return vPlaySoundLoop(sfxSound, 0);
		}
		
		public function vPlaySoundLoop(sfxSound:Sound, nRepeatCount:int = LOOP_ENDLESSLY):SoundWrapper
		{
			if (nRepeatCount == LOOP_ENDLESSLY)
				nRepeatCount = SoundWrapper.LOOP_ENDLESSLY;
			
			var oSound:SoundWrapper = new SoundWrapper();
			oSound.vPlayLoop(sfxSound, nRepeatCount);
			oSound.addEventListener(Event.SOUND_COMPLETE, vHandleSoundCompleted, false, 0, true);
			oSound.fVolume = fVolume_Sfx;
			
			oSoundLayer_Current.aoSFXs.push(oSound);
			
			return oSound;
			
		}
		
		public function vSetMusic(sfxNewMusic:Sound):void
		{
			oSoundLayer_Current.oMusic.vPlayLoop(sfxNewMusic);
			oSoundLayer_Current.oMusic.fVolume = fVolume_Music;
		}
				
		public function vPause():void
		{
			oSoundLayer_Current.oMusic.vPause();
			var i:int;
			var aoSFXs:Vector.<SoundWrapper> = oSoundLayer_Current.aoSFXs;
			var nTotalSFX:int = aoSFXs.length;
			for (i = 0; i < nTotalSFX; ++i)
			{				
				aoSFXs[i].vPause();
			}
			
			_aoSoundLayer.push(		new SoundManagerLayer()	);
		}
		
		public function vUnpause():void
		{
			// can only unpause if we have a layer of sounds to unpause
			if (_aoSoundLayer.length <= 1)
				return;
			
			// kill the current music
			oSoundLayer_Current.oMusic.vStop();
			
			//take all current SFX and add them to the previous layer			
			var i:int;
			var aoSFXs:Vector.<SoundWrapper> = oSoundLayer_Current.aoSFXs;
			var aoSFXs_PreviousLayer:Vector.<SoundWrapper> = _aoSoundLayer[_aoSoundLayer.length-2].aoSFXs;
			var nTotalSFX:int = aoSFXs.length;
			for (i = 0; i < nTotalSFX; ++i)
			{
				aoSFXs_PreviousLayer.push(	aoSFXs_PreviousLayer.pop()	)
			}
			
			_aoSoundLayer.pop();
				
			this.oSoundLayer_Current.oMusic.vUnpause();
			
			aoSFXs = oSoundLayer_Current.aoSFXs;
			nTotalSFX = aoSFXs.length;
			for (i = 0; i < nTotalSFX; ++i)
			{				
				aoSFXs[i].vUnpause();
			}
		}
		
		public function vSetMusicFade(fNewValue:Number, fDuration:Number = 0.0):void
		{			
			_fVolumeMusic_Fade_Target = fNewValue;
			_fVolumeMusic_Fade_ChangeDuration = fDuration;
			
			_oSprite.addEventListener(Event.ENTER_FRAME, vHandleEnterFrame, false, 0, true);
		}
		
		
		//============================================
		//	privates
		//============================================
		private function get oSoundLayer_Current():SoundManagerLayer
		{
			return _aoSoundLayer[	_aoSoundLayer.length - 1	];
		}
		
		private function get fVolume_Music():Number
		{
			return (	VOLUME_SCALER_MUSIC * _fVolumeMusic_Options * _fVolumeMusic_Fade	);
		}
		
		private function get fVolume_Sfx():Number
		{			
			return (	VOLUME_SCALER_SFX * _fVolumeSfx_Options * _fVolumeSfx_Fade	);
		}
		
		//============================================
		//	events
		//============================================
		
		private function vHandleEnterFrame(evt:Event):void
		{
			var dt:Number = FrameTime.timeDiffInSeconds;
			var fChangeThisFrame:Number;
			if (_fVolumeMusic_Fade_ChangeDuration <= 0)
				_fVolumeMusic_Fade = _fVolumeMusic_Fade_Target;
			else	
			{
				fChangeThisFrame = (dt / _fVolumeMusic_Fade_ChangeDuration);				
				fChangeThisFrame = Math.min(1.0, fChangeThisFrame);				
				_fVolumeMusic_Fade += (_fVolumeMusic_Fade_Target - _fVolumeMusic_Fade) * fChangeThisFrame;
				
				_fVolumeMusic_Fade_ChangeDuration -= dt;
			}
				
			
			vHandleVolumeChange();
			
			// we are done, remove the listener
			if (_fVolumeMusic_Fade == _fVolumeMusic_Fade_Target)
			{
				_oSprite.removeEventListener(Event.ENTER_FRAME, vHandleEnterFrame);
			}
		}
		
		private function vHandleSoundCompleted(evt:Event):void
		{			
			evt.target.removeEventListener(Event.SOUND_COMPLETE, vHandleSoundCompleted);
			
			var i:int;
			var nTotalLayers:int = _aoSoundLayer.length;
			var nFoundIndex:int;
			// for effiency start at the latest layer
			for (i = nTotalLayers-1; 0 <= i; --i )
			{
				nFoundIndex = _aoSoundLayer[i].aoSFXs.indexOf(evt.target);
				if (0 < nFoundIndex)
				{
					_aoSoundLayer[i].aoSFXs.splice(nFoundIndex, 1);
				}
			}
			
			//attempt to find the target objectevt.target
		}
		
		
		private function vHandleVolumeChange(evt:Event = null):void
		{
			_fVolumeSfx_Options = 1.0;//GlobalData.instance.currentProfile.sfxVolume;
			_fVolumeMusic_Options = 1.0;//GlobalData.instance.currentProfile.musicVolume;
			
			var fVolumeMusic_Current:Number = fVolume_Music;
			var fVolumeSfx_Current:Number = fVolume_Sfx;
		
			//trace("SoundManager::vHandleVolumeChange " + _fVolumeMusic_Options);
			
			var i:int;
			var nTotalLayers:int = _aoSoundLayer.length;
			
			var nSFX:int;
			var nTotalSFXs:int;
			var aoSFXs:Vector.<SoundWrapper>;
			var oSoundLayer:SoundManagerLayer;
			
			for (i = 0; i < nTotalLayers; ++i )
			{
				//trace("setting sound for layer " + i);
				oSoundLayer = _aoSoundLayer[i];
				oSoundLayer.oMusic.fVolume = fVolumeMusic_Current;
				
				aoSFXs = oSoundLayer.aoSFXs;
				nTotalSFXs = aoSFXs.length;
				for (nSFX = 0; nSFX < nTotalSFXs; ++nSFX)
				{
					aoSFXs[nSFX].fVolume = fVolumeSfx_Current;
				}
				
			}
		}
		
		
	}	
}
import flash.media.Sound;
import game.utils.sound.SoundWrapper;

internal class SoundManagerLayer
{
	public var oMusic:SoundWrapper;
	public var aoSFXs:Vector.<SoundWrapper>;
	
	public function SoundManagerLayer()
	{
		oMusic = new SoundWrapper();
		aoSFXs = new Vector.<SoundWrapper>();		
	}
	
}


internal class SingletonEnforcer {}