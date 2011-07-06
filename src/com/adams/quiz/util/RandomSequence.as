package com.adams.quiz.util
{
	public class RandomSequence
	{
		private var _array:Array=new Array;  
		private var _min:Number;  
		private var _max:Number;  
		
		//constructor: it accepts a min and max value.  
		public function RandomSequence (_min:Number,_max:Number){  
			this._min=_min;  
			this._max=_max;  
		}  
		
		//public method with the main algorithm. Returns an Array with the random numbers.  
		public function getSequence():Array{  
			var exit:Boolean=false;  
			_array[0]=f();  
			for(var i:int=1;i<=(_max-_min);i++){  
				do{  
					var rn:Number=f();  
					exit=true;  
					for(var j:int=0;j<i;j++){  
						if(_array[j]==rn){  
							exit=false;  
							break;  
						}  
					}  
				}while(exit==false);  
				_array[i]=rn;         
			}  
			return _array;  
		}  
		
		//private method to get the random number between _min and _max, also included.  
		
		private function f():Number{  
			return Math.round(Math.random()*(_max-_min)+(_min));  
		}  
	}
}