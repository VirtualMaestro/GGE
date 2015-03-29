/**
* User: OReva
* Date: 24.03.2015
* Time: 9:46
*/
package gge.broadcasting
{
	import avmplus.getQualifiedClassName;
	import flash.utils.Dictionary;

	/**
	 *
	 */
	internal class BroadcastContext
	{
		static private var _instance:BroadcastContext;

		/**
		 */
		static public function getInstance():BroadcastContext
		{
			if (_instance == null)
				_instance = new BroadcastContext();

			return _instance;
		}

		/*********/

		private var _classNameToClassIdMap:Dictionary;
		private var _systemsMap:Dictionary;
		private var _listenersMap:Dictionary;

		private var _idCounter:int = 0;

		/**
		 */
		public function BroadcastContext()
		{
			super();

			_classNameToClassIdMap = new Dictionary();
			_systemsMap = new Dictionary();
			_listenersMap = new Dictionary();
		}

		/**
		 * Returns generated class id by given full class name (gge.broadcasting::BroadcastComponent)
		 */
		[Inline]
		final public function getClassId(p_className:String):int
		{
			var classIdObj:Object = _classNameToClassIdMap[p_className];
			var classId:int;

			if (classIdObj == null)
			{
				classId = _idCounter++;
				_classNameToClassIdMap[p_className] = classId;
			}
			else classId = classIdObj as int;

			return classId;
		}

		/**
		 */
		public function addSystem(p_system:ISystem):void
		{
			_systemsMap[p_system.className] = p_system;
		}

		/**
		 */
		public function removeSystem(p_system:ISystem):void
		{
			delete _systemsMap[p_system.className];
		}

		/**
		 */
		public function isSystemExist(p_system:Object):Boolean
		{
			return _systemsMap[getClassName(p_system)] != null;
		}

		/**
		 * Returns system by given class or full class name.
		 */
		public function getSystem(p_system:Object):ISystem
		{
			return _systemsMap[getClassName(p_system)];
		}

		/**
		 * Returns class name of given value.
		 * There are possible a few parameters:
		 * - Class;
		 * - instance has to be inherited IBroadcaster;
		 * - string - full class name - e.g. gge.broadcasting::BroadcastComponent.
		 */
		[Inline]
		final public function getClassName(p_value:Object):String
		{
			var className:String;

			if (p_value is Class)
			{
				className = getQualifiedClassName(p_value);
			}
			else if (p_value is String)
			{
				className = p_value as String;
			}
			else if (p_value is IBroadcaster)
			{
				className = (p_value as IBroadcaster).className;
			}
			else
				throw new Error("BroadcastContext.isSystemExist: p_system is not a type of IBroadcaster");

			return className;
		}

		/**
		 */
		public function dispatch(p_eventName:String, p_sender:IBroadcaster, p_params:Object = null):void
		{
			var dll:DLL = _listenersMap[p_eventName];
			if (dll && dll.size > 0)
			{
				var node:Node = dll.head;
				var currentNode:Node;
				var expectedSenderClass:int;
				var senderClassId:int = p_sender.classId;

				while (node)
				{
					currentNode = node;
					node = node.next;

					expectedSenderClass = currentNode.expectedSenderClassId;

					if (expectedSenderClass != -1 || (expectedSenderClass == senderClassId))
					{
						currentNode.handlerMethod(p_sender, p_params);
					}
				}
			}
		}

		/**
		 */
		public function addListener(p_eventName:String, p_listenerMethod:Function, p_listenerBroadcaster:IBroadcaster, p_specifiedSender:Object = null):Node
		{
			var listeners:DLL = _listenersMap[p_eventName];
			if (listeners == null)
			{
				listeners = new DLL();
				_listenersMap[p_eventName] = listeners;
			}

			var classId:int = -1;

			if (p_specifiedSender != null)
			{
				if (p_specifiedSender is Class)
				{
					classId = getClassId(getQualifiedClassName(p_specifiedSender));
				}
				else
				{
					classId = getClassId(p_specifiedSender as String);
				}
			}

			return listeners.add(p_listenerMethod, p_listenerBroadcaster, classId);
		}

	}
}
