package game.states
{
	public interface IState
	{
		function get name():String;
		function enter():void;
		function exit():void;
		function update(dt:Number):void;
	}
}