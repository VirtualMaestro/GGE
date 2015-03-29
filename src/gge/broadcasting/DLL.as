/**
* User: oreva
* Date: 29.05.2014
* Time: 14:30
*/
package gge.broadcasting
{
	internal class DLL
	{
		public var size:int = 0;

		public var head:Node;
		public var tail:Node;

		/**
		 */
		public function add(p_listenerMethod:Function, p_broadcasterHandler:IBroadcaster, p_senderClassId:int = -1):Node
		{
			var node:Node = Node.get(p_listenerMethod, p_broadcasterHandler, p_senderClassId);
			node.dll = this;

			if (tail)
			{
				tail.next = node;
				node.prev = tail;
				tail = node;
			}
			else head = tail = node;

			++size;

			return node;
		}

		/**
		 */
		public function unlink(p_node:Node):void
		{
			if (p_node == tail)
			{
				tail = tail.prev;
				if (tail == null) head = null;
				else tail.next = null;
			}
			else if (p_node == head)
			{
				head = head.next;
				if (head == null) tail = null;
				else head.prev = null;
			}
			else
			{
				var prevNode:Node = p_node.prev;
				var nextNode:Node = p_node.next;

				prevNode.next = nextNode;
				nextNode.prev = prevNode;
			}

			p_node.dispose();

			--size;
		}

		/**
		 */
		public function clear():void
		{
			while (tail)
			{
				tail.unlink();
			}
		}
	}
}
