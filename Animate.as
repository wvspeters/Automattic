package{

import flash.events.Event;
import flash.display.MovieClip;

	public class Animate extends MovieClip{
		
		var runnin :int;
		var cont :Boolean = false;
		var notmoving :Boolean = false;
		var animchoice : String;
		
		public function Animate(){
		
		}
		
		public function probNum():int {			//returns a random number 0 - 2 which tells which animation to play (Walk = 0, Jump = 1, Idle = 2)
				var prob:Number = Math.ceil(Math.random()*100);
				if(prob <= 25){
						return 0;
					}
				else if(prob > 25 && prob <= 80){
						return 1;
					}
				else {
						return 2;
					}
			}

		public function takeControl(iSay: String){		//control script tells animation if character is being controlled by player
			
			if(iSay == "true"){
				this.cont = true;
				this.stage.addEventListener(Event.ENTER_FRAME, this._eventtwo);
			}
			else if (iSay == "false"){
				this.cont = false;
				this.stage.removeEventListener(Event.ENTER_FRAME, this._eventtwo);
			}
		}
		
		public function _eventfirst(iSay: String): void{	//Automated animations
				
			this.runnin = probNum();
				
				
			if(this.cont == false){	
				switch (this.runnin) {
					
				case 0:
					gotoAndPlay("Walk");
					break;
				case 1:
					gotoAndPlay("Jump");
					break;
				default:
					gotoAndPlay("Idle");
					}
				}
			else{
				this.animchoice = iSay;	
				}
			}
			
		public function _eventtwo(wwe: Event){	//player controlled animations
			
			/*if statements were written in a way
			to prevent: 
				1. Playing the wrong animation
				2. Causing the scripts from re-running
				3. Looping the animation
			*/
			if (this.animchoice == "Walk"){
				if (currentFrame == 48){
					gotoAndPlay("Walk");
					}
				else if (currentFrame < 48 && currentFrame > 2){
					
					}
				else{
					gotoAndPlay("Walk");
					}
				}
			if (this.animchoice == "Walked"){

				if (currentFrame == 167){
					gotoAndPlay("Idle_Stop")
					}
				else if (currentFrame > 145 && currentFrame < 167){
					
					}
				else{	
					gotoAndPlay("Idle_Stop");
					}
				}	
			if (this.animchoice == "Jump"){
				if (currentFrame == 95){
					gotoAndPlay("Idle_Stop");
					this.animchoice = "Jumped";
					}
				if (currentFrame > 61 && currentFrame < 95){
					
					}
				else{
					gotoAndPlay("Walkin_Jump");
					}
				}
			if (this.animchoice == "Jumped"){
				if (currentFrame == 167){
					gotoAndPlay("Idle_Stop");
					}
				else if (currentFrame > 145 && currentFrame < 167){
					
					}
				else{	
					gotoAndPlay("Idle_Stop");
					}
				}
			}
		}
	}