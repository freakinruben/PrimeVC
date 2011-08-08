package primevc.js.events;

import primevc.core.dispatcher.Signals;

/**	
 * @since  march 2, 2011
 * @author Stanislav Sopov
 */
class UserEvents extends Signals	
{
	private var eventDispatcher:Dynamic;
	public var mouse	(getMouse,		null)	: MouseEvents;
	public var touch	(getTouch,		null)	: TouchEvents;
	public var gesture	(getGesture,	null)	: GestureEvents;
	public var focus	(getFocus,		null)	: FocusEvents;
	public var keyboard (getKeyboard,	null) 	: KeyboardEvents;
	
	public function new(eventDispatcher)
	{
		this.eventDispatcher = eventDispatcher;
	}
	
	private function createMouse 	() { mouse		= new MouseEvents(eventDispatcher); }
	private function createTouch 	() { touch		= new TouchEvents(eventDispatcher); }
	private function createGesture 	() { gesture	= new GestureEvents(eventDispatcher); }
	private function createFocus 	() { focus		= new FocusEvents(eventDispatcher); }
	private function createKeyboard	() { keyboard	= new KeyboardEvents(eventDispatcher); }
	
	private inline function getMouse 	() { if (mouse == null)		{ createMouse();	} return mouse; }
	private inline function getTouch 	() { if (touch == null)		{ createTouch();	} return touch; }
	private inline function getGesture 	() { if (gesture == null)	{ createGesture();	} return gesture; }
	private inline function getFocus 	() { if (focus == null)		{ createFocus();	} return focus; }
	private inline function getKeyboard	() { if (keyboard == null)	{ createKeyboard();	} return keyboard; }
	
	override public function dispose ()
	{
		eventDispatcher = null;
		
		if ((untyped this).mouse != null)		mouse.dispose();
		if ((untyped this).touch != null)		touch.dispose();
		if ((untyped this).touch != null)		gesture.dispose();
		if ((untyped this).focus != null)		focus.dispose();
		if ((untyped this).keyboard != null)	keyboard.dispose();
		
		mouse =
		touch =
		gesture = 
		focus = 
		keyboard = 
		null;
	}
}