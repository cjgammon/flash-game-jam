package game.utils.sound
{
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.EventDispatcher;
	
	public class SoundWrapper extends EventDispatcher
	{
		//---------------------------------------
		// Constants
		//---------------------------------------
		
		public static const LOOP_ENDLESSLY:int			= -1;
		
		//private static const BLOCK_SIZE:int			= 3072;
		
		//---------------------------------------
		// Variables
		//---------------------------------------
		
		//private var _position: Number;
		//private var _aoTarget: ByteArray;
		
		private var _sfxSound:Sound;
		private var _nRepeatCount:int;
		private var _oSoundChannel:SoundChannel;
		private var _oSoundTransform:SoundTransform;
		
		private var _bPaused:Boolean;
		private var _bValid:Boolean;
		
		//---------------------------------------
		// Initializers
		//---------------------------------------
		
		public function SoundWrapper()
		{
			_oSoundTransform = new SoundTransform();
			
			//_nSoundPausePosition = -1;
			_bPaused = false;
			_bValid = false;
		}
		
		
		//---------------------------------------
		// 
		//---------------------------------------
		
		public function vPlay(sfxSound:Sound):void
		{
			vPlayLoop(sfxSound, 0);
		}
		
		public function vPlayLoop(sfxSound:Sound, nRepeatCount:int = LOOP_ENDLESSLY):void
		{
			if (	_bValid &&
					(_sfxSound == sfxSound)		)
				return;
			
			if (!sfxSound)
			{
				vStop_Soft();
				return;
			}			
			
			_bValid = true;
			_bPaused = false;
			
			_sfxSound = sfxSound;
			_nRepeatCount = nRepeatCount;
			
			_oSoundChannel = _sfxSound.play();
			_oSoundChannel.soundTransform = _oSoundTransform;
			
			_oSoundChannel.addEventListener(Event.SOUND_COMPLETE, vHandleSoundComplete, false, 0, true);
			//_sfxSound.addEventListener(SampleDataEvent.SAMPLE_DATA, vHandleSampleData, false, 0, true);
		}
		
		public function vStopLooping():void
		{
			_nRepeatCount = 0;
		}
		
		// stops the sound without dispatching an event
		private function vStop_Soft():void
		{			
			//trace('SoundWrapper::vStop_Soft');
			if (_oSoundChannel)
			{
				//trace('SoundWrapper::vStop_Soft stopping');
				_oSoundChannel.stop();
				_oSoundChannel.removeEventListener(Event.SOUND_COMPLETE, vHandleSoundComplete);
				_oSoundChannel = null;
			}
			
			_sfxSound = null;
			_nRepeatCount = 0;
			_bValid = false;
		}
		
		public function vStop():void
		{
			//trace('SoundWrapper::vStop()');
			vStop_Soft();
			
			dispatchEvent(		new Event(Event.SOUND_COMPLETE)	);
		}
		
		public function vPause():void
		{
			if (_bPaused)
				return;
				
			if (_oSoundChannel)
				_oSoundChannel.stop();
				
			_bPaused = true;
		}
		
		public function vUnpause():void
		{
			if (!_bPaused)
				return;
			
			var nPosition:int = _oSoundChannel.position;
			
			if (_sfxSound)
			{
				_oSoundChannel = _sfxSound.play(nPosition);
				_oSoundChannel.soundTransform = _oSoundTransform;
			}
			else
			{
				vStop();
			}	
			
			_bPaused = false;
		}
		
		//---------------------------------------
		// Getter
		//---------------------------------------
		
		public function get bValid():Boolean
		{
			return _bValid;
		}
		
		public function get soundTransform():SoundTransform
		{
			return _oSoundTransform;
		}
		
		public function set soundTransform(oValue:SoundTransform):*
		{
			// they have to set it to a valid value, otherwise things will break
			if (!_oSoundTransform)
				throw new Error('Attempted to set SoundWrapper:soundTransform to a null value')
			
			_oSoundTransform = oValue;
			if (!_oSoundChannel)
				return null;
				
			_oSoundChannel.soundTransform = _oSoundTransform;
		}
		
		public function set fVolume(fValue:Number):void
		{
			_oSoundTransform.volume = fValue;			
			soundTransform = _oSoundTransform;
		}
		
		
		//---------------------------------------
		// Event Handler
		//---------------------------------------
		
		private function vHandleSampleData(evt:Event):void
		{
			//var _aoData:ByteArray = evt.data;
			
		}
		
		private function vHandleSoundComplete(evt:Event):void
		{
			_bValid = false; // sound has completed and is not valid at the moment
			
			if (_nRepeatCount == LOOP_ENDLESSLY)
			{
				vPlayLoop(_sfxSound, LOOP_ENDLESSLY);
			}
			else if (_nRepeatCount == 0)
			{
				vStop();
			}
			else
			{
				if (0 < _nRepeatCount)
					--_nRepeatCount;
				else
					_nRepeatCount = 0;
					
				vPlayLoop(_sfxSound, _nRepeatCount);
			}
		}
		
	}
}