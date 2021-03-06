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
 * DAMAGE.s
 *
 *
 * Authors:
 *  Ruben Weijers	<ruben @ onlinetouch.nl>
 */
package primevc.gui.events;
 import primevc.core.dispatcher.Signal0;
 import primevc.core.dispatcher.Signals;


/**
 * @author	Ruben Weijers
 * @since	Jan 24, 2011
 */
typedef BrowserEvents = 
	#if		flash9	primevc.avm2.events.BrowserEvents;
	#elseif	flash8	primevc.avm1.events.BrowserEvents;
	#elseif	js		primevc.js  .events.BrowserEvents;
	#else	#error	#end


/**
 * Cross-platform browser events.
 * 
 * @author Ruben Weijers
 * @creation-date Jan 24, 2011
 */
class BrowserSignals extends Signals
{
	/**
	 * Dispatched when the browser is completly done with loading
	 */
	public var init					(default, null) : Signal0;
	
	/**
	 * Dispatched when the url is changed by the application
	 */
	public var urlInternalChange	(default, null) : Signal0;
	
	/**
	 * Dispatched when the url is changed by the browser
	 */
	public var urlExternalChange	(default, null) : Signal0;
	
	/**
	 * Dispatched when the url is changed by the browser or by the application
	 */
	public var urlChange			(default, null) : Signal0;
}
