
package {
	import alternativa.engine3d.core.Object3D;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
   
	public class MyController extends Sprite {
	   public var Radiani:Number = Math.PI / 180;
	   public var povorotVlevo:Boolean = false;
	   public var povorotVpravo:Boolean = false;
	   public var dvizhenieVverh:Boolean = false;// Klavisha A
	   public var dvizhenieVniz:Boolean = false;// Klavisha Z
	   public var dvizhenieVpered:Boolean = false;
	   public var dvizhenieNazad:Boolean = false;
	   public var dvizhenieMishi:Boolean = false;
	   public var scorost:int;
	   public var ugolPovorota:Number;
	   //Kratnost ispolzuetsya dlya privedeniya ugla v predely 360 gradusov, tak kak pri pribavlenii velichin k uglu znachenie ugla mozhet vihodit daleko za predeli 360
	   public var kratnostUgla:Number;
	   //ZnachenieMouseY ispolzuetsya pri nazhatii mishi dlya opredeleniya otnositelnoy tochki povorota cameri
	   public var znachenieMouseY:int;
	   public var proshCameraRotX:int = 0;//Ispolzuetsya dlya zapominaniya proshlogo znacheniya povorota cameri
	   public var camera:Object3D;
	   public var eventSourse:InteractiveObject;
	  
	   public function MyController(eventSourse:InteractiveObject, camera:Object3D, scorost:int):void {
					   this.camera = camera;
					   this.scorost = scorost;
					   this.eventSourse = eventSourse;
					   eventSourse.addEventListener(KeyboardEvent.KEY_DOWN, kd);
					   eventSourse.addEventListener(KeyboardEvent.KEY_UP, ku);
					   eventSourse.addEventListener(MouseEvent.MOUSE_DOWN, md);
					   eventSourse.addEventListener(MouseEvent.MOUSE_UP, mu);
	   }
	   public function update():void {
					   if (povorotVlevo) {
									   camera.rotationY -= scorost/2 * Radiani;
					   }
					   if (povorotVpravo) {
									   camera.rotationY += scorost/2 * Radiani;
					   }
					   if (dvizhenieVverh) {
									   camera.y -= scorost;
					   }
					   if (dvizhenieVniz) {
									   camera.y += scorost;
					   }
					   if (dvizhenieVpered) {
									   ugolPovorota = camera.rotationY / Radiani;
									   if (ugolPovorota < 0) {
													  ugolPovorota *= -1;
													  kratnostUgla = Math.round(ugolPovorota / 360);
													  if ((ugolPovorota - kratnostUgla * 360) >= 0) {
																	  if (kratnostUgla > 0) {
																					  ugolPovorota -= kratnostUgla * 360;
																	  }
													  }else {
																	  kratnostUgla -= 1;
																	  ugolPovorota -= kratnostUgla * 360;
													  }
													  ugolPovorota = 360 - ugolPovorota;
									   }else{
													  kratnostUgla = Math.round(ugolPovorota / 360);
													  if ((ugolPovorota - kratnostUgla * 360) >= 0) {
																	  if (kratnostUgla > 0) {
																					  ugolPovorota -= kratnostUgla * 360;
																	  }
													  }else {
																	  kratnostUgla -= 1;
																	  ugolPovorota -= kratnostUgla * 360;
													  }
									   }
									   //Za osnovu rascheta dvijeniya kamery beretsya 4 chetverti koordinat, v kajdoy iz kotoryh 90 gradusov
									   if (ugolPovorota >= 0 && ugolPovorota <= 90) {
													  camera.z += (90 - ugolPovorota) / 90 * scorost;
													  camera.x += (ugolPovorota/90)*scorost;
									   }
									   if (ugolPovorota > 90 && ugolPovorota <= 180) {
													  camera.z -= (ugolPovorota - 90) / 90 * scorost;
													  camera.x += (90 - (ugolPovorota - 90)) / 90 * scorost;
									   }
									   if (ugolPovorota > 180 && ugolPovorota <= 270) {
													  camera.z -= (90 - (ugolPovorota - 180)) / 90 * scorost;
													  camera.x -= (ugolPovorota - 180) / 90 * scorost;
									   }
									   if (ugolPovorota > 270 && ugolPovorota <= 360) {
													  camera.z += (ugolPovorota - 270) / 90 * scorost;
													  camera.x -= (90 - (ugolPovorota - 270)) / 90 * scorost;
									   }
					   }
					   if (dvizhenieNazad) {
									   ugolPovorota = camera.rotationY / Radiani;
									   if (ugolPovorota < 0) {
													  ugolPovorota *= -1;
													  kratnostUgla = Math.round(ugolPovorota / 360);
													  if ((ugolPovorota - kratnostUgla * 360) >= 0) {
																	  if (kratnostUgla > 0) {
																					  ugolPovorota -= kratnostUgla * 360;
																	  }
													  }else {
																	  kratnostUgla -= 1;
																	  ugolPovorota -= kratnostUgla * 360;
													  }
													  ugolPovorota = 360 - ugolPovorota;
									   }else{
													  kratnostUgla = Math.round(ugolPovorota / 360);
													  if ((ugolPovorota - kratnostUgla * 360) >= 0) {
																	  if (kratnostUgla > 0) {
																					  ugolPovorota -= kratnostUgla * 360;
																	  }
													  }else {
																	  kratnostUgla -= 1;
																	  ugolPovorota -= kratnostUgla * 360;
													  }
									   }
									   if (ugolPovorota >= 0 && ugolPovorota <= 90) {
													  camera.z -= (90 - ugolPovorota) / 90 * scorost;
													  camera.x -= (ugolPovorota/90)*scorost;
									   }
									   if (ugolPovorota > 90 && ugolPovorota <= 180) {
													  camera.z += (ugolPovorota - 90) / 90 * scorost;
													  camera.x -= (90 - (ugolPovorota - 90)) / 90 * scorost;
									   }
									   if (ugolPovorota > 180 && ugolPovorota <= 270) {
													  camera.z += (90 - (ugolPovorota - 180)) / 90 * scorost;
													  camera.x += (ugolPovorota - 180) / 90 * scorost;
									   }
									   if (ugolPovorota > 270 && ugolPovorota <= 360) {
													  camera.z -= (ugolPovorota - 270) / 90 * scorost;
													  camera.x += (90 - (ugolPovorota - 270)) / 90 * scorost;
									   }
					   }
					   if (dvizhenieMishi) {
									   if (znachenieMouseY >= eventSourse.mouseY) {
													  camera.rotationX = (znachenieMouseY - eventSourse.mouseY + proshCameraRotX) * Radiani;
									   }else {
													  camera.rotationX = -(eventSourse.mouseY - znachenieMouseY - proshCameraRotX) * Radiani;
									   }
					   }
	   }
	   private function kd(e:KeyboardEvent):void {
					   if (e.keyCode == 37) {
									   povorotVlevo = true;
					   }
					   if (e.keyCode == 39) {
									   povorotVpravo = true;
					   }
					   if (e.keyCode == 38) {
									   dvizhenieVpered = true;
					   }
					   if (e.keyCode == 40) {
									   dvizhenieNazad = true;
					   }
					   if (e.keyCode == 65) {// Klavisha A
									   dvizhenieVverh = true;
					   }
					   if (e.keyCode == 90) {// Klavisha Z
									   dvizhenieVniz = true;
					   }
	   }
	   private function ku(e:KeyboardEvent):void {
		   if (e.keyCode == 37) {
						   povorotVlevo = false;
		   }
		   if (e.keyCode == 39) {
						   povorotVpravo = false;
		   }
		   if (e.keyCode == 38) {
						   dvizhenieVpered = false;
		   }
		   if (e.keyCode == 40) {
						   dvizhenieNazad = false;
		   }
		   if (e.keyCode == 65) {
						   dvizhenieVverh = false;
		   }
		   if (e.keyCode == 90) {
						   dvizhenieVniz = false;
		   }
	   }
	   private function md(e:MouseEvent):void {
					   znachenieMouseY = eventSourse.mouseY;
					   dvizhenieMishi = true;
	   }
	   private function mu(e:MouseEvent):void {
					   dvizhenieMishi = false;
					   proshCameraRotX = camera.rotationX / Radiani;
	   }
	}
}
 
