/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.service
{
	import com.adams.swizdao.response.AbstractResult; 
	import com.adams.swizdao.model.collections.ICollection;
	import com.adams.swizdao.model.processor.IVOProcessor;
	import com.adams.swizdao.model.vo.CurrentInstance; 
	import com.adams.swizdao.model.vo.IValueObject; 
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.signals.AbstractSignal;
	import com.adams.swizdao.signals.PushRefreshSignal;
	import com.adams.swizdao.signals.ResultSignal;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class ServiceResult extends AbstractResult
	{ 
		public function ServiceResult()
		{
			super();
		}
		override protected function resultHandler( rpcevt:ResultEvent, prevSignal:AbstractSignal = null ):void {
			super.resultHandler(rpcevt,prevSignal);
			resultSignal.dispatch( resultObj, prevSignal.currentSignal );
			// on push
			if(prevSignal.currentSignal.action == Action.FINDPUSH_ID){  
				pushRefreshSignal.dispatch( prevSignal.currentSignal );
			}
			signalSeq.onSignalDone();
		}  
	}
}