/**
 * Created by OReva on 24.03.2015.
 */
package gge.systems
{
	/**
	 */
	public interface ISystem
	{
		/**
		 * Return system by given class.
		 */
		function getSystem(p_systemClass:Class):ISystem;

		/**
		 * Subscribes system for listening event from another systems.
		 * There is possible listen to a specified system.
		 */
		function addListener(p_eventName:String, p_handler:Function, p_specifiedSystem:Class = null):void;

		/**
		 * Removes specified subscription.
		 */
		function removeListener(p_eventName:String, p_handler:Function):void;

		/**
		 * Removes all subscription of current system.
		 */
		function removeAllListeners():void;

		/**
		 *
		 */
		function dispatch(p_event:SystemEvent):void;
	}
}
