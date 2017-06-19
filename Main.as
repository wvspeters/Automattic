package{
import flash.display.MovieClip;
import flash.events.*;
	
public class Main extends MovieClip{

	var done : int = 0;	
	
	public function Main(){
		stage.addEventListener(Event.ENTER_FRAME, fallin);  	//adds eventListener to enable function fallin()
		}
	public function fallin(_event : Event) : void{
		if (this.done < 2){		//tests done for 2 in order to restrict number of objects in scene
			for (var i: int = 0; i < 3; i++){
				var rnd : Number = Math.floor(Math.random() * stage.stageWidth);		//makes random number between 0 and 650 inclusive
				
				var coinMC : CoinMC = new CoinMC();
				coinMC.x = rnd;			//sets coinMC object to spawn at random x value
				coinMC.y = -30; 		//sets coinMC object to spawn above stage
				this.addChild(coinMC);		//makes coinMC child of stage
				this.done ++;		//variable done increments inside the for loop
				}
			}
		else {
			stage.removeEventListener(Event.ENTER_FRAME, fallin);		//prevents additional coinMC objects
			}
		}
	
	}
}