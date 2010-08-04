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
package primevc.gui.core;
 import primevc.core.Bindable;
 import primevc.gui.behaviours.layout.ValidateLayoutBehaviour;
 import primevc.gui.behaviours.BehaviourList;
 import primevc.gui.behaviours.RenderGraphicsBehaviour;
 import primevc.gui.display.Shape;
 import primevc.gui.graphics.shapes.IGraphicShape;
 import primevc.gui.layout.LayoutClient;
 import primevc.gui.states.UIElementStates;
  using primevc.utils.Bind;


/**
 * @author Ruben Weijers
 * @creation-date Aug 02, 2010
 */
class UIGraphic extends Shape, implements IUIElement
{
	public var behaviours		(default, null)		: BehaviourList;
	public var layout			(default, null)		: LayoutClient;
	public var state			(default, null)		: UIElementStates;
	public var graphicData		(default, null)		: Bindable < IGraphicShape >;
	
	
	public function new ()
	{
		super();
		visible = false;
		init.onceOn( displayEvents.addedToStage, this );
		
		state			= new UIElementStates();
		behaviours		= new BehaviourList();
		graphicData		= new Bindable < IGraphicShape > ();
		
		//add default behaviours
		behaviours.add( new RenderGraphicsBehaviour(this) );
		behaviours.add( new ValidateLayoutBehaviour(this) );
		
		createBehaviours();
		createLayout();
		
		state.current = state.constructed;
	}
	
	
	
	//
	// METHODS
	//
	
	
	private function init ()
	{
		behaviours.init();
		
		//overwrite the graphics of the skin with custom graphics (or do nothing if the method isn't overwritten)
		createGraphics();
		
		//finish initializing
		visible = true;
		state.current = state.initialized;
	}
	
	
	public inline function render () : Void
	{
		if (graphicData.value != null)
		{
			graphics.clear();
			graphicData.value.draw(this, false);
		}
	}
	
	
	private inline function removeBehaviours ()
	{
		behaviours.dispose();
		behaviours = null;
	}
	
	
	private function createLayout () : Void
	{
		layout = new LayoutClient();
	}
	
	
	
	//
	// ABSTRACT METHODS
	//
	
	private function createBehaviours ()	: Void; //	{ Assert.abstract(); }
	private function createGraphics ()		: Void		{ Assert.abstract(); }
	private function removeGraphics ()		: Void; //	{ Assert.abstract(); }
}