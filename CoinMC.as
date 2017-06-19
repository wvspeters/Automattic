package  {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class CoinMC extends MovieClip {

		var grav: Number = 0;
		var gravity : Number = 0.05;
		
		public function CoinMC() {
			this.addEventListener(Event.ENTER_FRAME, this._runnin);
		}
		
		public function _runnin(i: Event){		
			_gravity();		//accelerates drop speed of coin
			onHit();		//collision of character and coin
			removeEvent();  //waits to remove object from scene on collision
			}

		public function _gravity() :void {

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
			return Object(parent)._platform.hitTestPoint(this.x, this.y, true);  //top platform collision(blue)
		}

		public function hitGround(): Boolean {
			return Object(parent)._ground.hitTestPoint(this.x, this.y, true);  //bottom platform collision(yellow)
		}

		public function onHit(): Boolean {
			return this.hitTestObject(Object(parent).spidr1);	//tests for collision with character
		}

		public function removeEvent() : void{
			if (onHit()){
				this.removeEventListener(Event.ENTER_FRAME, this._runnin);		//prevents script from running when coin is removed
				parent.removeChild(this);	//removes coin from scene
			}
		}
	}	
}