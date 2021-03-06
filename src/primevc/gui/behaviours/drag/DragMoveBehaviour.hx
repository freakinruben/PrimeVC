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
package primevc.gui.behaviours.drag;
 import primevc.core.geom.IntRectangle;
 import primevc.gui.events.MouseEvents;
 import primevc.gui.traits.ILayoutable;
  using primevc.utils.NumberUtil;
  using primevc.utils.TypeUtil;


/**
 * Behaviour will add drag-and-move behaviour to the given target. 
 * Drag-and-move is an action in which the target can be dragged around and
 * by dragging it around it will be moved
 * 
 * @author Ruben Weijers
 * @creation-date Jul 22, 2010
 */
class DragMoveBehaviour extends DragBehaviourBase
{
	override private function stopDrag (mouseObj:MouseState) : Void
	{
		super.stopDrag(mouseObj);
		
		if (target.is(ILayoutable))
		{
			var l = target.as(ILayoutable).layout;
			l.x = target.x.roundFloat();
			l.y = target.y.roundFloat();
		}
		
		disposeDragInfo();
	}
	
	
	override private function cancelDrag (mouseObj:MouseState) : Void
	{
		dragInfo.restore();
		
		//notifiy the dragged item that the drag-operation is canceled
		target.userEvents.drag.cancel.send( dragInfo );
	}
}