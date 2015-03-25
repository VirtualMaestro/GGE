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
		 * Check if specified system exist and ready to use by given its class.
		 */
		function isSystemExist(p_systemClass:Class):Boolean;

		/**
		 * Subscribes system for listening event from another systems.
		 * There is possible listen to a specified system.
		 */
		function addListener(p_eventName:String, p_handler:Function, p_specifiedSystem:Class = null):void;

		/**
		 * Removes specified subscription.
		 */
		function removeListener(p_eventName:String):void;

		/**
		 * Removes all subscription of current system.
		 */
		function removeAllListeners():void;

		/**
		 * Dispatches events. There is possible to add some params.
		 */
		function dispatch(p_eventName:String, p_params:Object = null):void;

		/**
		 * Returns class of system.
		 */
		function getClass():Class;

		/**
		 * Destroys system.
		 */
		function dispose():void;
	}
}
