/*
 * Copyright (c) 2010, The PrimeVC Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE PRIMEVC PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE PRIMVC PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 *
 *
 * Authors:
 *  Danny Wilson	<danny @ onlinetouch.nl>
 *  Ruben Weijers	<ruben @ onlinetouch.nl>
 */
package primevc.avm2;
 import primevc.core.IDisposable;
 import primevc.gui.display.ISprite;
 import primevc.gui.display.DisplayList;
 import primevc.gui.display.Window;
 import primevc.gui.events.DisplayEvents;
 import primevc.gui.events.UserEvents;
  using primevc.utils.TypeUtil;

 
/**
 * AVM2 sprite implementation
 * 
 * @author	Danny Wilson
 * @author	Ruben Weijers
 */
class Sprite extends flash.display.Sprite, implements ISprite
{
	/**
	 * The displaylist to which this sprite belongs.
	 */
	public var displayList		(default, default)		: DisplayList;
	
	/**
	 * List with all the children of the sprite
	 */
	public var children			(default, null)			: DisplayList;
	
	/**
	 * Wrapper object for the stage.
	 */
	public var window			(default, setWindow)	: Window;
	public var userEvents		(default, null)			: UserEvents;
	public var displayEvents	(default, null)			: DisplayEvents;
	
	
	public function new()
	{
		super();
		children		= new DisplayList( this );
		userEvents		= new UserEvents( this );
		displayEvents	= new DisplayEvents( this );
	}
	
	
	public function dispose()
	{
		if (userEvents == null)
			return;		// already disposed
		
		children.dispose();
		userEvents.dispose();
		displayEvents.dispose();
		
		if (displayList != null)
			displayList.remove(this);
		
		children		= null;
		userEvents		= null;
		displayEvents	= null;
		displayList		= null;
		window			= null;
	}
	
	
	public function render () {}
	
	
	//
	// GETTERS / SETTERS
	//
	
	private function setWindow (v) {
		return window = v;
	}
	
	
	/*public function attachTo(target:DisplayObjectContainer)
	{
		target.addChild(this);
	}*/
	
	
	
/*	public inline function resizeScrollRect (newWidth:Float, newHeight:Float)
	{
		var rect			= scrollRect == null ? new flash.geom.Rectangle() : scrollRect;
		rect.width			= newWidth;
		rect.height			= newHeight;
		scrollRect			= rect;
	}
	
	
	public inline function moveScrollRect (?newX:Float = 0, ?newY:Float = 0)
	{
		var rect			= scrollRect == null ? new flash.geom.Rectangle() : scrollRect;
		rect.x				= newX;
		rect.y				= newY;
		scrollRect			= rect;
	}*/
}
