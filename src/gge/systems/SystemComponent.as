/**
 * Created by OReva on 24.03.2015.
 */
package gge.systems
{
	import avmplus.getQualifiedClassName;

	import com.genome2d.components.GComponent;

	import flash.utils.getDefinitionByName;

	/**
	 * Special king of component for implementation game logic.
	 */
	public class SystemComponent extends GComponent implements ISystem
	{
		private var _class:Class;

		/**
		 */
		public function SystemComponent()
		{
			super();
		}

		/**
		 *
		 */
		override public function init():void
		{

		}

		/**
		 */
		public function getSystem(p_systemClass:Class):ISystem
		{
			return null;
		}

		/**
		 */
		public function isSystemExist(p_systemClass:Class):Boolean
		{
			return false;
		}

		/**
		 */
		public function addListener(p_eventName:String, p_handler:Function, p_specifiedSystem:Class = null):void
		{
		}

		/**
		 */
		public function removeListener(p_eventName:String):void
		{
		}

		/**
		 */
		public function removeAllListeners():void
		{
		}

		/**
		 */
		public function dispatch(p_eventName:String, p_params:Object = null):void
		{
		}

		/**
		 */
		override public function dispose():void
		{

		}

		/**
		 */
		public function getClass():Class
		{
			if (_class == null) _class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			return _class;
		}
	}
}
