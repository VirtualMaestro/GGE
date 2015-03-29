/**
* User: oreva
* Date: 29.05.2014
* Time: 13:30
*/
package gge.broadcasting
{
	internal class Node
	{
		public var dll:DLL;
		public var next:Node;
		public var prev:Node;

		public var handlerMethod:Function;
		public var handlerBroadcaster:IBroadcaster;
		public var expectedSenderClassId:int;

		/**
		 */
		public function unlink():void
		{
			if (dll)
				dll.unlink(this);
		}

		/**
		 */
		public function dispose():void
		{
			dll = null;
			next = prev = null;
			handlerMethod = null;
			handlerBroadcaster = null;
			expectedSenderClassId = -1;

			put(this);
		}

		// pooling
		static private var _pool:Vector.<Node> = new <Node>[];
		static private var _size:int = 0;

		/**
		 */
		static public function get(p_listener:Function, p_broadcaster:IBroadcaster, p_expectedSenderClassId:int = -1):Node
		{
			var node:Node;

			if (_size > 0)
			{
				node = _pool[--_size];
				_pool[_size] = null;
			}
			else node = new Node();

			node.handlerMethod = p_listener;
			node.handlerBroadcaster = p_broadcaster;
			node.expectedSenderClassId = p_expectedSenderClassId;

			return node;
		}

		/**
		 */
		[Inline]
		static private function put(p_node:Node):void
		{
			_pool[_size++] = p_node;
		}

		/**
		 */
		static public function rid():void
		{
			for (var i:int = 0; i < _size; i++)
			{
				_pool[i] = null;
			}

			_pool.length = 0;
		}
	}
}
