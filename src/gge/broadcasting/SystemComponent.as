/**
 * User: VirtualMaestro
 * Date: 29.03.2015
 * Time: 14:55
 */
package gge.broadcasting
{
	/**
	 * Special kind of component for organization of game logic.
	 */
	public class SystemComponent extends BroadcastComponent implements ISystem
	{
		public function SystemComponent()
		{
			super();

			context.addSystem(this);
		}

		/**
		 * Returns system by given class or full class name.
		 */
		public function getSystem(p_systemClass:Class):ISystem
		{
			return context.getSystem(p_systemClass);
		}

		/**
		 */
		public function isSystemExist(p_systemClass:Class):Boolean
		{
			return context.isSystemExist(p_systemClass);
		}

		/**
		 */
		override public function dispose():void
		{
			context.removeSystem(this);
			super.dispose();
		}
	}
}
