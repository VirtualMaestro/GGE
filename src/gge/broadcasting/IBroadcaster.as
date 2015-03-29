/**
* User: OReva
* Date: 24.03.2015
* Time: 9:56
*/
package gge.broadcasting
{
	/**
	 */
	public interface IBroadcaster
	{
		/**
		 * Subscribes broadcaster for listening event from another broadcaster.
		 * There is possible listen to a specified broadcaster.
		 * As p_specifiedSystem there is possible to set class (Class) or full class name.
		 */
		function addListener(p_eventName:String, p_handler:Function, p_specifiedBroadcaster:Object = null):void;

		/**
		 * Removes specified subscription.
		 */
		function removeListener(p_eventName:String):void;

		/**
		 * Removes all subscription of current broadcaster.
		 */
		function removeAllListeners():void;

		/**
		 * Check if there was subscribed for a specified event.
		 * If yes, returns function handler for that event.
		 */
		function hasEventListener(p_eventName:String):Function;

		/**
		 * Dispatches events. There is possible to add some params.
		 */
		function dispatch(p_eventName:String, p_params:Object = null):void;

		/**
		 * Returns full class name of broadcaster.
		 */
		function get className():String;

		/**
		 */
		function get classId():int;

		/**
		 * Destroys broadcaster.
		 */
		function dispose():void;
	}
}
