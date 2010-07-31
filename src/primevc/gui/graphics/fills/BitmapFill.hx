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
 *  Ruben Weijers	<ruben @ onlinetouch.nl>
 */
package primevc.gui.graphics.fills;
 import primevc.core.geom.Matrix2D;
 import primevc.gui.graphics.GraphicElement;
 import primevc.gui.graphics.GraphicFlags;
 import primevc.types.Bitmap;


/**
 * Bitmap fill
 * 
 * @author Ruben Weijers
 * @creation-date Jul 30, 2010
 */
class BitmapFill extends GraphicElement, implements IFill 
{
	public var bitmap	(default, setBitmap)	: Bitmap;
	public var matrix	(default, setMatrix)	: Matrix2D;
	public var smooth	(default, setSmooth)	: Bool;
	public var repeat	(default, setRepeat)	: Bool;
	
	
	public function new (bitmap:Bitmap, ?matrix:Matrix2D = null)
	{
		super();
		this.bitmap = bitmap;
		this.matrix	= matrix;
	}
	
	
	override public function dispose ()
	{
		bitmap.dispose();
		untyped bitmap = null;
		matrix = null;
		super.dispose();
	}
	
	
	
	//
	// GETTERS / SETTERES
	//
	
	private inline function setBitmap (v:Bitmap)
	{
		if (v != bitmap) {
			if (bitmap != null)
				bitmap.state.change.unbind(this);
			
			bitmap = v;
			
			if (bitmap != null) {
				if (bitmap.state.is(BitmapStates.loaded))
					invalidate( GraphicFlags.FILL_CHANGED );
				
				handleBitmapStateChange.on( bitmap.state.change, this );
			}
		}
		return v;
	}


	private inline function setMatrix (v:Matrix2D)
	{
		if (v != matrix) {
			matrix = v;
			invalidate( GraphicFlags.FILL_CHANGED );
		}
		return v;
	}


	private inline function setSmooth (v:Bool)
	{
		if (v != smooth) {
			smooth = v;
			invalidate( GraphicFlags.FILL_CHANGED );
		}
		return v;
	}


	private inline function setRepeat (v:Bool)
	{
		if (v != repeat) {
			repeat = v;
			invalidate( GraphicFlags.FILL_CHANGED );
		}
		return v;
	}
	
	
	//
	// EVENT HANDLERS
	//
	
	private inline function handleBitmapStateChange (oldState:BitmapStates, newState:BitmapStates)
	{
		switch (newState) {
			case BitmapStates.loaded:	invalidate( GraphicFlags.FILL_CHANGED );
			case BitmapStates.empty:	invalidate( GraphicFlags.FILL_CHANGED );
		}
	}
	
	
	
	//
	// IFILL METHODS
	//
	
	public inline function begin (target, ?bounds)
	{
		changes = 0;
		
		if (bitmap.state.is(BitmapState.loaded))
		{
#if flash9
			target.graphics.beginBitmapFill( bitmap.data, matrix, repeat, smooth );
#end
		}
	}
	
	
	public inline function end (target)
	{
		if (bitmap.state.is(BitmapState.loaded))
		{
#if flash9
			target.graphics.endFill();
#end
		}
	}
}