package{
	
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.DisplayObject;

	public class Control extends MovieClip {
			
		var plusOrMinus: int = 1;
		var speed: int = 1;

		var bodyCent: int = width / 2;
		var tests: int = 0 + bodyCent;
		var testsNeg: int = stage.stageWidth - bodyCent;

		var bottomSpidr: Number;
		var rightSpidr: Number;

		var grav: Number = 0;
		var gravity : Number = 0.05;

		var dontPlay: Boolean = false;
			
		var bs: Boolean = true;
		var leftKey: Boolean = false;
		var rightKey: Boolean = false;
		var jumpKey: Boolean = false;
			
		var getFrame: Boolean = false;
		
		var posorneg: int;
		
		public function Control(){
			this.stage.addEventListener(Event.ENTER_FRAME, this._event);	//runs automated movement on stage
			spidrObj.addEventListener(MouseEvent.CLICK, clicked);		//checks for character to be clicked with mouse
			stage.addEventListener(MouseEvent.CLICK, clickedOut);		//checks for stage to be clicked with mouse
			}
			
		public function init() {
			this.speed = this.width * 0.05;
		}

		public function _gravity() :void {  //accelerates fall speed of character
			if (!hitGround()) {
				this.y += this.grav;
				this.grav += gravity;
			}
			else if (hitGround()) {
				this.y -= this.grav;
				this.grav = 0;
			}
			if (!hitPlatform()) {
				this.y += this.grav;
				this.grav += gravity;
			}
			else if (hitPlatform()) {
				this.y -= this.grav;
				this.grav = 0;
			}
		}

		public function hitPlatform(): Boolean {
			return Object(parent)._platform.hitTestPoint(this.rightSpidr, this.bottomSpidr, true);		//top platform collision(blue)
		}

		public function hitGround(): Boolean {
			return Object(parent)._ground.hitTestPoint(this.rightSpidr, this.bottomSpidr, true);		//bottom platform collision(yellow)
		}

		public function clicked(w: MouseEvent) {
			MovieClip(this.parent).stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);		//allows key press detection
			MovieClip(this.parent).stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);			//allows key release detection
			this.bs = false;		//prevents the clickedOut script from running
			this.stage.removeEventListener(Event.ENTER_FRAME, this._event);			//stops automated movement
			this.stage.addEventListener(Event.ENTER_FRAME, this._mover);		//allows keyboard to control character
			spidrObj.takeControl("true");		//tells animation script to stop automated movement animations
			trace("in");
		}

		public function clickedOut(ww: MouseEvent) {
			/*prevents the character from returning to autmated 
			movement when clicked, but allows returning to 
			automated movement when stage is clicked
			*/
			if (this.bs == true) {	
				MovieClip(this.parent).stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				MovieClip(this.parent).stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				trace("out");
				spidrObj.takeControl("false");
				this.stage.addEventListener(Event.ENTER_FRAME, this._event);
				this.stage.removeEventListener(Event.ENTER_FRAME, this._mover);
				spidrObj._eventfirst("Restart");
			} else {
				this.bs = true;
			}
		}
			
		public function reEnter(): void {   //allows re-entry of character when leaving stage due to gravity
			if (this.y > (stage.stageHeight + this.height)){
				this.y = 0 - this.height;
			}
				
		}

		public function keyDown(s: KeyboardEvent) {		//key press detection
			switch (s.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.A:
					this.leftKey = true;
					if (this.getFrame == false){
						spidrObj._eventfirst("Walk");    //tells animation script to play Walk animation
					}
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					this.rightKey = true;
					if (this.getFrame == false){
						spidrObj._eventfirst("Walk");
					}
					break;
				case Keyboard.SPACE:
					this.jumpKey = true;
					this.getFrame = true;
					spidrObj._eventfirst("Jump");
					break;
			}
		}

		public function keyUp(r: KeyboardEvent) {	//key release detection

			switch (r.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.A:
					this.leftKey = false;
					if (this.getFrame == false){
						spidrObj._eventfirst("Walked");		//tells animation script to play idle animation
					}
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					this.rightKey = false;
					if (this.getFrame == false){
						spidrObj._eventfirst("Walked");
					}
					break;
				case Keyboard.SPACE:
					this.jumpKey = false;
					break;
			}
		}

		public function boundries() {	//prevents character from going off stage
			if (this.x > testsNeg) {
				this.scaleX *= -1;	//turns character around
				this.x -= 3;		//character moves in opposite direction
				this.posorneg = -1;
			} else if (this.x < tests) {
				this.scaleX *= -1;
				this.x += 3;
				this.posorneg = 1;
			}
		}

		public function moveDirect(iSay: String) {		//for automation, to prevent conflict between boundries and movement direction
			if (iSay == "right") {
				this.posorneg = 1;
			} else if (iSay == "left") {
				this.posorneg = -1;
			}
		}

		public function _mover(ll: Event) {
			this.bottomSpidr = this.y + this.height / 2;	//adds current frame position of the bottom of the character
			this.rightSpidr = this.x + this.width / 2;		//adds current frmae position of the right side of character
			
			_gravity();
			
			/*the code in this function dictates movement of 
			character on keypress and forces different animations
			then automated ones
			*/
			if (this.leftKey && this.scaleX > 0) {
				this.x -= 3;
				this.scaleX *= -1;
				moveDirect("left");
			} else if (this.leftKey) {
				this.x -= 3;
				moveDirect("left");
			}
			if (this.rightKey && this.scaleX < 0) {
				this.x += 3;
				this.scaleX *= -1;
				moveDirect("right");
			} else if (this.rightKey) {
				this.x += 3;
				moveDirect("right");
			}
			if (this.jumpKey || this.getFrame == true) {	//contains animation restrictions for controlling character
				if (spidrObj.currentFrame <= 62) {
					this.getFrame = true;
				} else if (spidrObj.currentFrame > 72 && spidrObj.currentFrame <= 79) {
					this.y -= 15;
				} else if (spidrObj.currentFrame > 79 && spidrObj.currentFrame <= 86) {
				} else if (spidrObj.currentFrame == 95) {
					this.getFrame = false;
				} 
			}
			boundries();	//checks boundries
			reEnter();		//checks for leaving bottom of scene
		}

		public function _event(t: Event): void {
			this.bottomSpidr = this.y + this.height / 2;
			this.rightSpidr = this.x + this.width / 2;
			
			_gravity();
			
			/* This code contains parameters to make sure the
			animation goes from one animation to another 
			without	looping the script and contrains movement 
			for the animation
			*/
			if (spidrObj.runnin == 0) {
				this.x = this.x + (3 * this.plusOrMinus);
			} else if (spidrObj.runnin == 1) {
				if (spidrObj.currentFrame <= 72) {
					this.x = this.x + (3 * this.plusOrMinus);
				} else if (spidrObj.currentFrame > 72 && spidrObj.currentFrame <= 79) {
					this.x = this.x + (3 * this.plusOrMinus);
					this.y -= 15;
				} else if (spidrObj.currentFrame > 79 && spidrObj.currentFrame <= 86) {
					this.x = this.x + (3 * this.plusOrMinus);
				} else {
					this.x = this.x + (3 * this.plusOrMinus);
				}
			} else {
				if (spidrObj.currentFrame <= 143) {
					this.x = this.x + (3 * this.plusOrMinus);
				} else if (spidrObj.currentFrame > 143 && spidrObj.currentFrame <= 167) {
					this.x += 0;
				} else {
					this.x = this.x + (3 * this.plusOrMinus);
				}
			}
			if (this.x > testsNeg) {
				this.scaleX *= -1;
				this.plusOrMinus = -1 * this.speed;
			} else if (this.x < tests) {
				this.scaleX *= -1;
				this.plusOrMinus = 1 * this.speed;
			}
			reEnter();
		}
		}
}