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
package primevc.gui.behaviours.layout;
 import primevc.core.dispatcher.Wire;
 import primevc.gui.behaviours.BehaviourBase;
 import primevc.gui.core.UIWindow;
 import primevc.gui.states.LayoutStates;
  using primevc.utils.Bind;


/**
 * @author Ruben Weijers
 * @creation-date Jul 26, 2010
 */
class WindowLayoutBehaviour extends BehaviourBase < UIWindow >
{
	/**
	 * Reference to the last used enterFrame binding. If the state of a 
	 * layoutclient changes to parentInvalidated, this enterFrame binding
	 * should be removed.
	 */
	private var enterFrameBinding	: Wire <Dynamic>;

	
	override private function init ()
	{
		Assert.that(target.layout != null, "Layout of "+target+" can't be null for "+this);
		layoutStateChangeHandler.on( target.layout.states.change, this );
		
		//trigger the event handler for the current state as well
		layoutStateChangeHandler( null, target.layout.states.current );
	}


	override private function reset ()
	{
		removeEnterFrameBinding();
		
		if (target.layout == null)
			return;

		target.layout.states.change.unbind( this );
	}


	private function layoutStateChangeHandler (oldState:LayoutStates, newState:LayoutStates)
	{
		switch (newState) {
			case LayoutStates.invalidated:
				if (enterFrameBinding == null)
					enterFrameBinding = measure.onceOn( target.displayEvents.enterFrame, this );

			case LayoutStates.measuring:
				removeEnterFrameBinding();
			
			case LayoutStates.validated:
				removeEnterFrameBinding();
		}
	}
	
	
	private function measure () {
		removeEnterFrameBinding();
		target.layout.measure();
	}


	private inline function removeEnterFrameBinding ()
	{
		if (enterFrameBinding != null) {
			enterFrameBinding.dispose();
			enterFrameBinding = null;
		}
	}
}