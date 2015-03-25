/**
 * Created by OReva on 24.03.2015.
 */
package gge.systems
{
	import com.genome2d.components.GComponent;

	/**
	 *
	 */
	internal class SystemManager extends GComponent
	{
		public function SystemManager()
		{
			super();
		}

		/**
		 */
		public function addSystem(p_system:ISystem):void
		{

		}

		/**
		 */
		public function removeSystem(p_system:ISystem):void
		{

		}

		/**
		 */
		public function dispatch(p_eventName:String, p_sender:ISystem, p_params:Object = null):void
		{

		}
	}
}
