/**
 * User: VirtualMaestro
 * Date: 29.03.2015
 * Time: 12:45
 */
package gge.broadcasting
{
	/**
	 * Interface for implementation system functionality.
	 */
	public interface ISystem extends IBroadcaster
	{
		/**
		 * Return system by given class or full class name.
		 * Possible values:
		 * - Class;
		 * - string - full class name - e.g. gge.broadcasting::BroadcastComponent.
		 */
		function getSystem(p_systemClass:Class):ISystem;

		/**
		 * Check if specified system exist and ready to use by given its class.
		 */
		function isSystemExist(p_systemClass:Class):Boolean;
	}
}
