package primevc.js.events;

import primevc.core.dispatcher.Wire;
import primevc.core.dispatcher.Signal1;
import primevc.core.dispatcher.IWireWatcher;
import primevc.core.ListNode;
import js.Dom;
import js.Lib;


/**
 * @author	Stanislav Sopov
 * @since 	March 2, 2011
 */

class DOMSignal1<Type> extends Signal1<Type>, implements IWireWatcher<Type->Void>
{
	var eventDispatcher:Dynamic;
	var event:String;
	
	
	public function new (eventDispatcher:Dynamic, event:String)
	{
		super();
		this.eventDispatcher = eventDispatcher;
		this.event = event;
	}
	
	
	public function wireEnabled (wire:Wire<Type->Void>):Void
	{	
		Assert.that(n != null);
		
		if (ListUtil.next(n) == null) // First wire connected
		{
			untyped
			{    
				if (js.Lib.isIE)
				{
					eventDispatcher.attachEvent(event, dispatch, false);
				}
				else 
				{
					eventDispatcher.addEventListener(event, dispatch, false);
				}
			}
		}
	}
	
	
	public function wireDisabled (wire:Wire<Type->Void>):Void
	{	
		if (n == null) // No more wires connected
		{
			untyped
			{    
				if (js.Lib.isIE)
				{
					eventDispatcher.detachEvent(event, dispatch, false);
				} 
				else 
				{
					eventDispatcher.removeEventListener(event, dispatch, false);
				}
			}
		}
	}
	
	
	private function dispatch(e:Event) 
	{
		Assert.abstract();
	}
}