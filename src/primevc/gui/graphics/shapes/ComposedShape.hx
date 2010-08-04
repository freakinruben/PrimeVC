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
package primevc.gui.graphics.shapes;
 import primevc.gui.graphics.GraphicFlags;
 import primevc.gui.traits.IDrawable;
 import primevc.utils.FastArray;
  using primevc.utils.FastArray;


/**
 * A composed fill is a composition of multiple shapes that will be rendered
 * in the same render cycle on the same target.
 * 
 * @author Ruben Weijers
 * @creation-date Aug 01, 2010
 */
class ComposedShape extends ShapeBase 
{
	public var children (default, null)		: FastArray < IGraphicShape >;
	
	
	public function new (?layout, ?fill, ?border)
	{
		super(layout, fill, border);
		children = FastArrayUtil.create();
	}
	
	
	override public function dispose ()
	{
		for (child in children)
			child.dispose();
		
		children = null;
		super.dispose();
	}
	
	
	//
	// ISHAPE METHODS
	//
	
	override private function drawShape (target:IDrawable, x:Int, y:Int, width:Int, height:Int) : Void
	{
		for (child in children)
			child.draw(target, true);
	}



	//
	// LIST METHODS
	//

	public inline function add ( child:IGraphicShape, depth:Int = -1 )
	{
		children.insertAt( child, depth );
		child.listeners.add(this);
		invalidate( GraphicFlags.SHAPE_CHANGED );
	}


	public inline function remove ( child:IGraphicShape )
	{
		child.listeners.add(this);
		children.remove(child);
		invalidate( GraphicFlags.SHAPE_CHANGED );
	}
}