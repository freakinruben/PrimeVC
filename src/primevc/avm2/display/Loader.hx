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
package primevc.avm2.display;
 import flash.display.DisplayObject;
 import flash.display.LoaderInfo;
 import flash.display.SWFVersion;
 import flash.net.URLRequest;
 import flash.system.LoaderContext;
 import flash.utils.ByteArray;
 import primevc.avm2.events.LoaderEvents;
 import primevc.core.geom.Rectangle;
 import primevc.core.traits.IDisposable;
 import primevc.types.URI;


typedef FlashLoader = flash.display.Loader;


/**
 * @author Ruben Weijers
 * @since sometime in 2010
 */
class Loader implements IDisposable
{
	public var events		(default, null)				: LoaderEvents;
	
	public var bytes		(getBytes, never)			: ByteArray;
	public var bytesLoaded	(getBytesLoaded, never)		: UInt;
	public var bytesTotal	(getBytesTotal, never)		: UInt;
	public var isLoaded		(getIsLoaded, never)		: Bool;
	public var info			(getInfo, never)			: LoaderInfo;
	
	public var content		(getContent, never)			: DisplayObject;
	public var height		(getHeight, never)			: Float;
	public var width		(getWidth, never)			: Float;
	
	private var loader		: FlashLoader;
	private var extension	: String;
	
	
	public function new ()
	{
		loader	= new FlashLoader();
		events	= new LoaderEvents( info );
	}
	
	
	public function dispose ()
	{
#if flash10
		loader.unloadAndStop();
#end
		events.dispose();
		extension	= null;
		loader		= null;
		events		= null;
	}
	
	
	public inline function load (v:URI, ?c:LoaderContext)
	{
		extension = v.fileExt;
		return loader.load(new URLRequest(v.toString()), c);
	}
	public inline function unload ()						{ return loader.unload(); }
	public inline function close () : Void					{ if (!isLoaded) loader.close(); }
	
	public inline function isSwf () : Bool					{ return extension == "swf"; }
	
	
	
	//
	// GETTERS / SETTERS
	//
	
	private inline function getInfo ()				{ return loader.contentLoaderInfo; }
	private inline function getBytes ()				{ return info.bytes; }
	private inline function getBytesLoaded ()		{ return info.bytesLoaded; }
	private inline function getBytesTotal ()		{ return info.bytesTotal; }
	
	private inline function getWidth ()				{ return info.width; }
	private inline function getHeight ()			{ return info.height; }
	
	
	/**
	 * Method will try to return the content of the flash-loader to allow the
	 * loader to be disposed without losing the loaded content.
	 * 
	 * If the loaded content is an avm1-movie, the loader will be returned 
	 * since the content can't be seperated from the loader. This also means
	 * that when a avm1-movie is loaded and used on the stage, it will be unloaded
	 * when this loader is getting disposed!
	 * 
	 * If the loaded content is an avm2-movie, the loader will also be returned
	 * since some flex-swf's will otherwise throw errors.
	 */
	private inline function getContent ()
	{
		if (isSwf())
			loader.scrollRect = new Rectangle(0, 0, width, height);
		
		return isSwf() ? cast loader : cast loader.contentLoaderInfo.content;
		/*try {
			if (loader.contentLoaderInfo.swfVersion < 9)
				return loader;
			else
				return loader; //cast loader.contentLoaderInfo.content;
		}
		catch (e:Dynamic) {
			return cast loader.contentLoaderInfo.content;
		}*/
	}
	
	private inline function getIsLoaded ()			{ return bytesTotal > 0 && bytesLoaded >= bytesTotal; }
}