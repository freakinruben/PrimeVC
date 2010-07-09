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
package primevc.utils;
 

/**
 * Helper class for working with bit flags
 * 
 * @creation-date	Jun 15, 2010
 * @author			Ruben Weijers
 */
class BitUtil 
{
	/**
	 * Checks if any of the bits in 'flag' are set.
	 */
	public static inline function has (bits:Int, flag:Int) : Bool {
		return (bits & flag) != 0;
	}
	
	/**
	 * Checks if none of the bits in 'flag' are set.
	 */
	public static inline function hasNone (bits:Int, flag:Int) : Bool {
		return (bits & flag) == 0;
	}
	
	/**
	 * Returns an Int with the bits set in 'flag' added to 'bits'.
	 */
	public static inline function set (bits:Int, flag:Int) : Int {
		return bits |= flag;
	}
	
	/**
	 * Returns an Int with the bits set in 'flag' removed from 'bits'.
	 */
	public static inline function unset (bits:Int, flag:Int) : Int {
		//is faster and better predictable than the commented code since there's one if statement less (6 ms faster on 7.000.000 iterations)
		return bits &= 0xffffffff ^ flag; // has(bits, flag) ? bits ^= flag : bits;
	}
}