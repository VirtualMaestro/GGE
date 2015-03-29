/**
* User: OReva
* Date: 24.03.2015
* Time: 9:58
*/
package gge.broadcasting
{
	import avmplus.getQualifiedClassName;

	import com.genome2d.components.GComponent;

	import flash.utils.Dictionary;

	import flash.utils.getDefinitionByName;

	/**
	 * Special king of component for listening and sending broadcast events.
	 */
	public class BroadcastComponent extends GComponent implements IBroadcaster
	{
		private var _class:Class;
		private var _className:String;
		private var _classId:int = -1;
		private var _context:BroadcastContext;
		private var _eventsMap:Dictionary;

		/**
		 */
		public function BroadcastComponent()
		{
			super();

			_context = BroadcastContext.getInstance();
			_classId = _context.getClassId(className);
			_eventsMap = new Dictionary();
		}

		/**
		 */
		public function addListener(p_eventName:String, p_handler:Function, p_specifiedSystem:Object = null):void
		{
			if (_eventsMap[p_eventName] != null)
			{
				removeListener(p_eventName);
			}

			_eventsMap[p_eventName] = _context.addListener(p_eventName, p_handler, this, p_specifiedSystem);
		}

		/**
		 */
		public function removeListener(p_eventName:String):void
		{
			var node:Node = _eventsMap[p_eventName];
			if (node) node.unlink();
			delete _eventsMap[p_eventName];
		}

		/**
		 */
		public function removeAllListeners():void
		{
			for (var eventName:String in _eventsMap)
			{
				removeListener(eventName);
			}
		}

		/**
		 */
		public function hasEventListener(p_eventName:String):Function
		{
			var node:Node = _eventsMap[p_eventName];
			return node ? node.handlerMethod : null;
		}

		/**
		 */
		public function dispatch(p_eventName:String, p_params:Object = null):void
		{
			_context.dispatch(p_eventName, this, p_params);
		}

		/**
		 */
		override public function dispose():void
		{
			removeAllListeners();

			_context = null;
			_eventsMap = null;
			_classId =-1;
			_className = null;
			_class = null;
		}

		/**
		 */
		public function getClass():Class
		{
			if (_class == null)
				_class = getDefinitionByName(className) as Class;

			return _class;
		}

		/**
		 */
		public function get className():String
		{
			if (_className == null)
				_className = getQualifiedClassName(this);

			return _className;
		}

		/**
		 */
		public function get classId():int
		{
			return _classId;
		}

		/**
		 * Returns broadcast context.
		 */
		protected function get context():BroadcastContext
		{
			return _context;
		}
	}
}
