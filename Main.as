package
{
	import alternativa.engine3d.containers.ConflictContainer;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.MouseEvent3D;
	import alternativa.engine3d.core.Object3DContainer;
	import alternativa.engine3d.core.Vertex;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.BSP;
	import alternativa.engine3d.objects.Sprite3D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.*;
	import flash.utils.ByteArray;
   
	public class Main extends Sprite {
	   private var container:ConflictContainer = new ConflictContainer();
	   private var camera:Camera3D = new Camera3D();
	   private var controller:MyController;
	   private var BSP_S:Vector.<BSP> = new Vector.<BSP>();
	   private var mesh:Mesh = new Mesh();
	   private var radiani:Number = Math.PI / 180;
	   private var conteinerModeli:Object3DContainer = new Object3DContainer();
	   private var vektTochek:Array = new Array();
	   private var massVremVertexov:Array = new Array();
	   private var massSootvVershVertexam:Array = new Array();
	   private var indMassSootvVershVertexam:Array = new Array();
	   private var massVneshTexturCill:Array = new Array();
	   private var massVnutrTexturCill:Array = new Array();
	   private var massRazrezaCill:Array = new Array();//Ispolzuetsya dlya udaleniya ishodnix tochek Cillindra
	   private var postroenieCill:Boolean = false;//Ispolzuetsya kak perekluchatel dlya funkcii Cillindra
	   private var vneshGranCill:Boolean = true;
	   private var vnutrGranCill:Boolean = false;
	   private var materialTochek:FillMaterial = new FillMaterial(0xFFFF80);
	   private var materialVidelenTochek:FillMaterial = new FillMaterial(0xCACA00);
	   private var znachX:TextField = new TextField();
	   private var nazvanX:TextField = new TextField();
	   private var znachU:TextField = new TextField();
	   private var nazvanU:TextField = new TextField();
	   private var znachV:TextField = new TextField();
	   private var nazvanV:TextField = new TextField();
	   private var znachY:TextField = new TextField();
	   private var nazvanY:TextField = new TextField();
	   private var znachZ:TextField = new TextField();
	   private var nazvanZ:TextField = new TextField();
	   private var dobavitVershinu:TextField = new TextField();
	   private var dobavitGran:TextField = new TextField();
	   private var udalitVershinu:TextField = new TextField();
	   private var udalitGran:TextField = new TextField();
	   private var raschUV:TextField = new TextField();
	   private var izmVectNorm:TextField = new TextField();
	   private var snyatieVideleniya:TextField = new TextField();
	   private var zagruzkaTeksturi:TextField = new TextField();
	   private var povLevoTeksturi:TextField = new TextField();
	   private var povPravoTeksturi:TextField = new TextField();
	   private var vneshTeksturaCill:TextField = new TextField();
	   private var vnutrTeksturaCill:TextField = new TextField();
	   private var sozdCilindra:TextField = new TextField();
	   private var nazvanKolSegm:TextField = new TextField();
	   private var kolichSegmenCil:TextField = new TextField();
	   private var vnutGraniCill:TextField = new TextField();
	   private var vnesGraniCill:TextField = new TextField();
	   private var otmenaCil:TextField = new TextField();
	   private var sohrCil:TextField = new TextField();
	   private var nazvanKolGrad:TextField = new TextField();
	   private var kolichGradCil:TextField = new TextField();
	   private var sohrProekta:TextField = new TextField();
	   private var zagrProekta:TextField = new TextField();
	   private var zagrTexturi:TextField = new TextField();
	   private var vivProekta:TextField = new TextField();
	   private var txFormat:TextFormat = new TextFormat();
	   private var shetchikVershin:int = 0;
	   private var shetchikVertexov:int = 0;
	   private var shetchikGraney:int = 0;
	   private var kolichTochekCill:int;
	   private var kolichGraneyCill:int;
	   private var tekCvet:Number;
	   private var massImenTekstur:Array = new Array();
	   private var massTekstur:Array = new Array();
	   private var tekGran:String;
	   private var videlenVershina:Sprite3D;
	   private var videlenie:Boolean = false;
	   private var massVidelenVershin:Array = new Array();
	   private var massUvershin:Array = new Array();
	   private var massVvershin:Array = new Array();
	   private var massVershCill:Array;
	   private var vremMassVert:Array = new Array();//Ispolzuetsya dlya poiska vseh Vertexov, svyazannih s viselennoi tochkoy
	   private var massVremGraneyCill:Array = new Array();
	   private var massZagrMnogoTextur:Array = new Array();
	   private var massZagrMnogoImenTextur:Array = new Array();
	   private var cvetVidKnopki:String = "0x80FF00";
	   private var proshKnopkaGrany:TextField;
	   private var massKnopokGraney:Array = new Array();
	   private var konteinerKnopok:Sprite = new Sprite();
	   private var knKonteineraVverh:Sprite = new Sprite();
	   private var knKonteineraVniz:Sprite = new Sprite();
	   private var oknoVivoda:Sprite = new Sprite();
	   private var viborVivodaX:String;//Ukazivayut polojenie na osyah itogovogo mesha
	   private var viborVivodaY:String;
	   private var viborVivodaZ:String;
	  
	   public function Main():void {
		   camera.view = new View(1000, 650);
		   camera.z = -500;
		   addChild(camera.view);
		   camera.view.hideLogo();
		   container.addChild(camera);
		   controller = new MyController(stage, camera, 10);
		   BSP_S[0] = new BSP();
		   conteinerModeli.addChild(BSP_S[0]);
		   container.addChild(conteinerModeli);
		   addEventListener(Event.ENTER_FRAME, en);
		   stage.addEventListener(KeyboardEvent.KEY_DOWN, KD);
		   stage.addEventListener(KeyboardEvent.KEY_UP, KU);
		   addChild(nazvanX)
		   addChild(znachX);
		   addChild(nazvanU)
		   addChild(znachU);
		   addChild(nazvanV)
		   addChild(znachV);
		   addChild(nazvanY)
		   addChild(znachY);
		   addChild(nazvanZ)
		   addChild(znachZ);
		   addChild(dobavitVershinu);
		   addChild(dobavitGran);
		   addChild(udalitVershinu);
		   addChild(udalitGran);
		   addChild(raschUV);
		   addChild(izmVectNorm);
		   addChild(snyatieVideleniya);
		   addChild(zagruzkaTeksturi);
		   addChild(povLevoTeksturi);
		   addChild(povPravoTeksturi);
		   addChild(vneshTeksturaCill);
		   addChild(vnutrTeksturaCill);
		   addChild(sozdCilindra);
		   addChild(nazvanKolSegm);
		   addChild(kolichSegmenCil);
		   addChild(vnesGraniCill);
		   addChild(vnutGraniCill);
		   addChild(otmenaCil);
		   addChild(sohrCil);
		   addChild(nazvanKolGrad);
		   addChild(kolichGradCil);
		   addChild(sohrProekta);
		   addChild(vivProekta);
		   addChild(zagrProekta);
		   addChild(zagrTexturi);
		   addChild(konteinerKnopok);
		   addChild(knKonteineraVverh);
		   addChild(knKonteineraVniz);
		   addChild(oknoVivoda);
		   konteinerKnopok.x = 890;
		   with (graphics) {
						   beginFill("0xFFFFFF",0.3);
						   drawRect(885, 0, 95, 650);
		   }
		   knKonteineraVverh.x = konteinerKnopok.x + 90;
		   knKonteineraVniz.x = knKonteineraVverh.x;
		   knKonteineraVniz.y = knKonteineraVverh.y + 15;
		   knKonteineraVverh.addEventListener(MouseEvent.CLICK, dvizheniePolyaKnopok);
		   knKonteineraVniz.addEventListener(MouseEvent.CLICK, dvizheniePolyaKnopok);
		   with (knKonteineraVverh.graphics) {
						   beginFill("0x34aabb");
						   drawRect(2, 2, 13, 13);
		   }
		   with (knKonteineraVniz.graphics) {
						   beginFill("0x34aabb");
						   drawRect(2, 2, 13, 13);
		   }
		   with (txFormat) {
						   size = 15;
						   align = TextFormatAlign.LEFT;
		   }
		   with (nazvanX) {
						   selectable = false;
						   width = 20;
						   height = 20;
						   text = "X";
		   }
		   with (znachX) {
						   width = 40;
						   height = 20;
						   border = true;
						   background = true;
						   x = 20;
						   defaultTextFormat = txFormat;
						   text = "0";
						   type = TextFieldType.INPUT;
						   addEventListener(Event.CHANGE, vvodZnacheniy);
		   }
		   with (nazvanU) {
						   selectable = false;
						   width = 20;
						   height = 20;
						   text = "U";
						   y = 25;
		   }
		   with (znachU) {
						   width = 40;
						   height = 20;
						   border = true;
						   background = true;
						   x = 20;
						   y = 25;
						   defaultTextFormat = txFormat;
						   text = "0";
						   type = TextFieldType.INPUT;
						   addEventListener(Event.CHANGE, vvodZnacheniy);
		   }
		   with (nazvanY) {
						   selectable = false;
						   width = 20;
						   height = 20;
						   text = "Y";
						   x = 70;
		   }
		   with (znachY) {
						   width = 40;
						   height = 20;
						   border = true;
						   background = true;
						   x = 90;
						   defaultTextFormat = txFormat;
						   text = "0";
						   type = TextFieldType.INPUT;
						   addEventListener(Event.CHANGE, vvodZnacheniy);
		   }
		   with (nazvanV) {
						   selectable = false;
						   width = 20;
						   height = 20;
						   text = "V";
						   x = 70;
						   y = 25;
		   }
		   with (znachV) {
						   width = 40;
						   height = 20;
						   border = true;
						   background = true;
						   x = 90;
						   y = 25;
						   defaultTextFormat = txFormat;
						   text = "0";
						   type = TextFieldType.INPUT;
						   addEventListener(Event.CHANGE, vvodZnacheniy);
		   }
		   with (nazvanZ) {
						   selectable = false;
						   width = 20;
						   height = 20;
						   text = "Z";
						   x = 140;
		   }
		   with (znachZ) {
						   width = 40;
						   height = 20;
						   border = true;
						   background = true;
						   x = 160;
						   defaultTextFormat = txFormat;
						   text = "0";
						   type = TextFieldType.INPUT;
						   addEventListener(Event.CHANGE, vvodZnacheniy);
		   }
		   with (dobavitVershinu) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 65;
						   height = 20;
						   x = 210;
						   defaultTextFormat = txFormat;
						   text = "dobVersh";
						   addEventListener(MouseEvent.CLICK, dobavlenieVershiny);
		   }
		   with (udalitVershinu) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 285;
						   defaultTextFormat = txFormat;
						   text = "udalVersh";
						   addEventListener(MouseEvent.CLICK, udalenieVershiny);
		   }
		   with (dobavitGran) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 60;
						   height = 20;
						   x = 360;
						   defaultTextFormat = txFormat;
						   text = "dobGran";
						   addEventListener(MouseEvent.CLICK, dobavlenieGrani);
		   }
		   with (udalitGran) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 80;
						   height = 20;
						   x = 425;
						   defaultTextFormat = txFormat;
						   text = "udalitGran";
						   addEventListener(MouseEvent.CLICK, udalenieGrani);
		   }
		   with (raschUV) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 80;
						   height = 20;
						   x = 425;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "raschitatUV";
						   addEventListener(MouseEvent.CLICK, raschetUVgrani);
		   }
		   with (izmVectNorm) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 510;
						   defaultTextFormat = txFormat;
						   text = "izmVector";
						   addEventListener(MouseEvent.CLICK, izmenenieNormali);
		   }
		   with (snyatieVideleniya) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 585;
						   defaultTextFormat = txFormat;
						  text = "snVidelen";
						   addEventListener(MouseEvent.CLICK, snyatVidelen);
		   }
		   with (zagruzkaTeksturi) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 660;
						   defaultTextFormat = txFormat;
						   text = "Textura";
						   addEventListener(MouseEvent.CLICK, zagrTeksturu);
		   }
		   with (povLevoTeksturi) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 660;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "Lev";
						   addEventListener(MouseEvent.CLICK, povorotTekstuti);
		   }
		   with (povPravoTeksturi) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 697;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "Prav";
						   addEventListener(MouseEvent.CLICK, povorotTekstuti);
		   }
		   with (vneshTeksturaCill) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 660;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "Vnes";
						   name = "vneshTeksturaCill";
						   addEventListener(MouseEvent.CLICK, zagrTeksturu);
		   }
		   with (vnutrTeksturaCill) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 697;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "Vnut";
						   name = "vnutrTeksturaCill";
						   addEventListener(MouseEvent.CLICK, zagrTeksturu);
		   }
		   with (sozdCilindra) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 735;
						   defaultTextFormat = txFormat;
						   text = "sozdCylin";
						   addEventListener(MouseEvent.CLICK, sozdatCylindr);
		   }
		   with (nazvanKolSegm) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 735;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "KolSeg";
		   }
		   with (kolichSegmenCil) {
						   background = true;
						   border = true;
						   width = 33;
						   height = 20;
						   x = 772;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "8";
						   type = TextFieldType.INPUT;
		   }
		   with (vnesGraniCill) {
						   selectable = false;
						   background = true;
						   backgroundColor = cvetVidKnopki;
						   width = 33;
						   height = 20;
						   x = 735;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "Vnes";
						   addEventListener(MouseEvent.CLICK, ustanVnutVneshGranCill);
		   }
		   with (vnutGraniCill) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 772;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "Vnut";
						   addEventListener(MouseEvent.CLICK, ustanVnutVneshGranCill);
		   }
		   with (otmenaCil) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 810;
						   y = 0;
						   defaultTextFormat = txFormat;
						   text = "OtmenCill";
						   addEventListener(MouseEvent.CLICK, otmenaCillindra);
		   }
		   with (sohrCil) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 810;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "SohrCill";
						   addEventListener(MouseEvent.CLICK, sohranenieCillindra);
		   }
		   with (nazvanKolGrad) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 33;
						   height = 20;
						   x = 810;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "Grad";
		   }
		   with (kolichGradCil) {
						   background = true;
						   border = true;
						   width = 33;
						   height = 20;
						   x = 847;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "360";
						   type = TextFieldType.INPUT;
		   }
		   with (sohrProekta) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 510;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "Sohranit";
						   addEventListener(MouseEvent.CLICK, sohranenieProekta);
		   }
		   with (vivProekta) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 510;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "VivestiMesh";
						   addEventListener(MouseEvent.CLICK, otkritieOknaVivoda);
		   }
		   with (zagrProekta) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 585;
						   y = 22;
						   defaultTextFormat = txFormat;
						   text = "ZagrProekt";
						   addEventListener(MouseEvent.CLICK, zagruzkaProekta);
		   }
		   with (zagrTexturi) {
						   selectable = false;
						   background = true;
						   backgroundColor = "0x80FFFF";
						   width = 70;
						   height = 20;
						   x = 585;
						   y = 46;
						   defaultTextFormat = txFormat;
						   text = "ZagrTextur";
						   addEventListener(MouseEvent.CLICK, zagrMnogoTekstur);
		   }
		   //******************************************* Opisanie okna Vivoda *********************************************//
		   var knLevX:Sprite = new Sprite();
		   var knSredX:Sprite = new Sprite();
		   var knPravX:Sprite = new Sprite();
		   var knLevY:Sprite = new Sprite();
		   var knSredY:Sprite = new Sprite();
		   var knPravY:Sprite = new Sprite();
		   var knLevZ:Sprite = new Sprite();
		   var knSredZ:Sprite = new Sprite();
		   var knPravZ:Sprite = new Sprite();
		   var vivodTeksta:TextField = new TextField();
		   var passchitatMesh:TextField = new TextField();
		   var zakriytOkno:TextField = new TextField();
		   var nazMesha:TextField = new TextField();
		   var imyaMesha:TextField = new TextField();
		   var proshViborX:String;
		   var proshViborY:String;
		   var proshViborZ:String;
		  
		   with (knLevX) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   name = "knLevX";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knSredX) {
			   graphics.beginFill("0x008A23");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 20;
			   name = "knSredX";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knPravX) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 40;
			   name = "knPravX";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knLevY) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   y = 20;
			   name = "knLevY";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knSredY) {
			   graphics.beginFill("0x008A23");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 20;
			   y = 20;
			   name = "knSredY";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knPravY) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 40;
			   y = 20;
			   name = "knPravY";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knLevZ) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   y = 40;
			   name = "knLevZ";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knSredZ) {
			   graphics.beginFill("0x008A23");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 20;
			   y = 40;
			   name = "knSredZ";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (knPravZ) {
			   graphics.beginFill("0x00FF40");
			   graphics.drawRect(2, 2, 13, 13);
			   x = 40;
			   y = 40;
			   name = "knPravZ";
			   addEventListener(MouseEvent.CLICK, sposobVivoda);
		   }
		   with (vivodTeksta) {
			   background = true;
			   border = true;
			   width = 490;
			   height = 535;
			   x = 5;
			   y = 60;
			   defaultTextFormat = txFormat;
			   text = "";
			   name = "vivodTeksta";
		   }
		   with (passchitatMesh) {
			   selectable = false;
			   background = true;
			   backgroundColor = "0x80FFFF";
			   width = 70;
			   height = 20;
			   x = 70;
			   y = 2;
			   defaultTextFormat = txFormat;
			   text = "Passchitat";
			   addEventListener(MouseEvent.CLICK, vivodMesha);
		   }
		   with (zakriytOkno) {
			   selectable = false;
			   background = true;
			   backgroundColor = "0x80FFFF";
			   width = 70;
			   height = 20;
			   x = 150;
			   y = 2;
			   defaultTextFormat = txFormat;
			   text = "Zakrit";
			   addEventListener(MouseEvent.CLICK, zakritieOknaVivoda);
		   }
		   with (nazMesha) {
			   selectable = false;
			   background = true;
			   backgroundColor = "0x80FFFF";
			   width = 70;
			   height = 20;
			   x = 70;
			   y = 24;
			   defaultTextFormat = txFormat;
			   text = "ImyaMesha";
		   }
		   with (imyaMesha) {
			   background = true;
			   border = true;
			   width = 70;
			   height = 20;
			   x = 150;
			   y = 24;
			   defaultTextFormat = txFormat;
			   text = "mesh";
			   type = TextFieldType.INPUT;
			   name = "imyaMesha";
		   }
		   function otkritieOknaVivoda(e:MouseEvent):void {
			   oknoVivoda.x = 250;
		   }
		   function zakritieOknaVivoda(e:MouseEvent):void {
			   oknoVivoda.x = -600;
			   vivodTeksta.text = "";
		   }
		   function sposobVivoda(e:MouseEvent):void {//Raskraska vibrannoi knopki
			   if (e.target == knLevX || e.target == knSredX || e.target == knPravX) {
				  with (oknoVivoda.getChildByName(e.target.name)) {
					  graphics.clear();
					  graphics.beginFill("0x008A23");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  with (oknoVivoda.getChildByName(proshViborX)) {
					  graphics.clear();
					  graphics.beginFill("0x00FF40");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  viborVivodaX = e.target.name;
				  proshViborX = e.target.name;
			   }
			   if (e.target == knLevY || e.target == knSredY || e.target == knPravY) {
				  with (oknoVivoda.getChildByName(e.target.name)) {
					  graphics.clear();
					  graphics.beginFill("0x008A23");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  with (oknoVivoda.getChildByName(proshViborY)) {
					  graphics.clear();
					  graphics.beginFill("0x00FF40");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  viborVivodaY = e.target.name;
				  proshViborY = e.target.name;
			   }
			   if (e.target == knLevZ || e.target == knSredZ || e.target == knPravZ) {
				  with (oknoVivoda.getChildByName(e.target.name)) {
					  graphics.clear();
					  graphics.beginFill("0x008A23");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  with (oknoVivoda.getChildByName(proshViborZ)) {
					  graphics.clear();
					  graphics.beginFill("0x00FF40");
					  graphics.drawRect(2, 2, 13, 13);
				  }
				  viborVivodaZ = e.target.name;
				  proshViborZ = e.target.name;
			   }
		   }
		   with (oknoVivoda) {
			   graphics.beginFill("0x34aabb");
			   graphics.drawRoundRect(0, 0, 500, 600, 10, 10);
			   x = -600;
			   y = 20;
			   addChild(knLevX);
			   addChild(knSredX);
			   addChild(knPravX);
			   addChild(knLevY);
			   addChild(knSredY);
			   addChild(knPravY);
			   addChild(knLevZ);
			   addChild(knSredZ);
			   addChild(knPravZ);
			   addChild(vivodTeksta);
			   addChild(passchitatMesh);
			   addChild(zakriytOkno);
			   addChild(nazMesha);
			   addChild(imyaMesha);
		   }
		   viborVivodaX = knSredX.name;
		   viborVivodaY = knSredY.name;
		   viborVivodaZ = knSredZ.name;
		   proshViborX = viborVivodaX;
		   proshViborY = viborVivodaY;
		   proshViborZ = viborVivodaZ;
		   //**************************************************************************************************************//
}
private function en(e:Event):void {
   controller.update();
   camera.render();
}
private function raschetUVgrani(e:MouseEvent):void {// Tolko elsi fran lejit na odnoy ploskosti
   if (tekGran != null) {
	   var minX:Number = 100000;
	   var maxX:Number = -100000;
	   var minY:Number = 100000;
	   var maxY:Number = -100000;
	   var minZ:Number = 100000;
	   var maxZ:Number = -100000;
	   var vert:Vertex;
	   var U:Number = -1000;
	   var V:Number = -1000;
	   for (var i:int = 0; i < mesh.getFaceById(tekGran).vertices.length; i++) {
		  minX = Math.min(minX, mesh.getFaceById(tekGran).vertices[i].x);
		  maxX = Math.max(maxX, mesh.getFaceById(tekGran).vertices[i].x);
		  minY = Math.min(minY, mesh.getFaceById(tekGran).vertices[i].y);
		  maxY = Math.max(maxY, mesh.getFaceById(tekGran).vertices[i].y);
		  minZ = Math.min(minZ, mesh.getFaceById(tekGran).vertices[i].z);
		  maxZ = Math.max(maxZ, mesh.getFaceById(tekGran).vertices[i].z);
	   }
	   for (i = 0; i < mesh.getFaceById(tekGran).vertices.length; i++) {
		  vert = mesh.getFaceById(tekGran).vertices[i];
		  if (minX == maxX) {
			  U = raznicaMinMax(minZ, vert.z) / raznicaMinMax(minZ, maxZ);
			  V = raznicaMinMax(minY, vert.y) / raznicaMinMax(minY, maxY);
		  }else if (minY == maxY) {
			  U = raznicaMinMax(minX, vert.x) / raznicaMinMax(minX, maxX);
			  V = raznicaMinMax(minZ, vert.z) / raznicaMinMax(minZ, maxZ);
		  }else {
			  U = raznicaMinMax(minX, vert.x) / raznicaMinMax(minX, maxX);
			  V = raznicaMinMax(minY, vert.y) / raznicaMinMax(minY, maxY);
		  }
		  mesh.getFaceById(tekGran).vertices[i].u = U;
		  mesh.getFaceById(tekGran).vertices[i].v = V;
	   }
	   BSP_S[0].createTree(mesh);
   }
}
private function raznicaMinMax(min:Number, max:Number):Number {
   var raznica:Number;
   if (min >= 0 && max >= 0) {
	raznica = max - min;
   }
   if (min < 0 && max >= 0) {
	raznica = -1 * min + max;
   }
   if (min < 0 && max < 0) {
	raznica = ( -1 * min) - ( -1 * max);
   }
   return raznica;
}
private function vivodMesha(e:MouseEvent):void {
		   var minX:Number = 100000;
		   var maxX:Number = -100000;
		   var minY:Number = 100000;
		   var maxY:Number = -100000;
		   var minZ:Number = 100000;
		   var maxZ:Number = -100000;
		   var sredneeX:Number;
		   var sredneeY:Number;
		   var sredneeZ:Number;
		   var vremX:Number;
		   var vremY:Number;
		   var vremZ:Number;
		   var vert:Vertex;
		   var imya:String = TextField(oknoVivoda.getChildByName("imyaMesha")).text;
		   var dannie:String = "";
		   var sglajivanieTextur:String = "";
		   var rashirMat:String;
		   var vremImyaTexturi:String;
		   var vremMassVert:String = "[";//Ispolzuetsya dlya vivoda vertexov v gran
		   var sovpadenie:Boolean = false;//Eta peremennaya i massiv vremImyaTexturi ispolzuyutsya dlya otslejivaniya sovpadeniy tekstur i vertexov
		   var vremMassTekst:Array = new Array();//Ispolzuetsya dlya otslejivaniya zadvoeniya tekstur i vertexov
		   var material:Array = new Array();//Zdes budut hranitsya peremennie materialov
		   for (var i:int = 0; i < mesh.faces.length; i++) {
						   //Otslejivanie tekstur i zapis ih v itogovuyu peremennuyu
						   vremImyaTexturi = String(massImenTekstur[mesh.faces[i].id]);
						   for (var k:int = 0; k < vremMassTekst.length; k++) {
										  if (vremImyaTexturi == vremMassTekst[k]) {
											  sovpadenie = true;
											  material[i] = material[k];
											  break;
										  }
										  if (k == vremMassTekst.length - 1) {
											  sovpadenie = false;
										  }
						   }
						   if (sovpadenie == false) {
							  rashirMat = vremImyaTexturi.slice(vremImyaTexturi.length - 3, vremImyaTexturi.length);
							  if (rashirMat == "jpg" || rashirMat == "JPG" || rashirMat == "png" || rashirMat == "PNG") {
											  dannie += '[Embed(source = "' + massImenTekstur[mesh.faces[i].id] + '")] private static const ' + "TexMat" + imya + i + ":Class;" + "\n";
											  dannie += "private var " + "TM" + imya + i + ":TextureMaterial = new TextureMaterial(new " + "TexMat" + imya + i + "().bitmapData);" + "\n";
											  material[i] = "TM" + imya + i;
											  sglajivanieTextur += "TM" + imya + i + ".smooth = true;" + "\n";
							  }else {
											  dannie += "private var FM" + imya + i + ":FillMaterial = new FillMaterial(0x" + massImenTekstur[mesh.faces[i].id] + ");" + "\n";
											  material[i] = "FM" + imya + i;
							  }
							  vremMassTekst.push(vremImyaTexturi);
						   }
						   for (var j:int = 0; j < mesh.faces[i].vertices.length; j++) {
							  minX = Math.min(minX, mesh.faces[i].vertices[j].x);
							  maxX = Math.max(maxX, mesh.faces[i].vertices[j].x);
							  minY = Math.min(minY, mesh.faces[i].vertices[j].y);
							  maxY = Math.max(maxY, mesh.faces[i].vertices[j].y);
							  minZ = Math.min(minZ, mesh.faces[i].vertices[j].z);
							  maxZ = Math.max(maxZ, mesh.faces[i].vertices[j].z);
						   }
		   }
		   dannie += "\n";
		   dannie += sglajivanieTextur + "\n";
		   if (minX >= 0 && maxX >= 0) {
						   sredneeX = (maxX - minX) / 2 + minX;
		   }
		   if (minX < 0 && maxX >= 0) {
						   sredneeX = ( -1 * minX + maxX) / 2 + minX;
		   }
		   if (minX < 0 && maxX < 0) {
						   sredneeX = (( -1 * minX) - ( -1 * maxX)) / 2 + minX;
		   }
		   if (minY >= 0 && maxY >= 0) {
						   sredneeY = (maxY - minY) / 2 + minY;
		   }
		   if (minY < 0 && maxY >= 0) {
						   sredneeY = ( -1 * minY + maxY) / 2 + minY;
		   }
		   if (minY < 0 && maxY < 0) {
						   sredneeY = (( -1 * minY) - ( -1 * maxY)) / 2 + minY;
		   }
		   if (minZ >= 0 && maxZ >= 0) {
						   sredneeZ = (maxZ - minZ) / 2 + minZ;
		   }
		   if (minZ < 0 && maxZ >= 0) {
						   sredneeZ = ( -1 * minZ + maxZ) / 2 + minZ;
		   }
		   if (minZ < 0 && maxZ < 0) {
						   sredneeZ = (( -1 * minZ) - ( -1 * maxZ)) / 2 + minZ;
		   }
		   vremMassTekst.length = 0;
		   sovpadenie = false;
		   for (i = 0; i < mesh.faces.length; i++) {
						   vremMassVert = "[";
						   for (j = 0; j < mesh.faces[i].vertices.length; j++) {
										  vert = mesh.faces[i].vertices[j];
										  //Opredeleniya zadvoeniya vertexov v buduschem vivode
										  for (var l:int = 0; l < vremMassTekst.length; l++) {
														  if (vert.id == vremMassTekst[l]) {
																		  sovpadenie = true;
																		  break;
														  }
														  if (l == vremMassTekst.length - 1) {
																		  sovpadenie = false;
														  }
										  }
										  vremMassTekst.push(vert.id);
										  if (j != mesh.faces[i].vertices.length - 1) {
														  vremMassVert += '"' + vert.id + '",';
										  }else {
														  vremMassVert += '"' + vert.id +'"]';
										  }
										  //******************************************** Centrirovanie mesha po osyam soglasno vibrannim polojeniyam ***********************
										  if (viborVivodaX == "knLevX") {
														  if (minX >= 0) {
																		  vremX = vert.x - minX;
														  }else {
																		  vremX = -1 * minX + vert.x;
														  }
										  }
										  if (viborVivodaX == "knSredX") {
											  if (vert.x >= 0 && sredneeX >= 0) {
												  if (vert.x <= sredneeX) {
																 vremX = -1 * (sredneeX - vert.x);
												  }else {
																 vremX = vert.x - sredneeX;
												  }
											  }
											  if (vert.x < 0 && sredneeX >= 0) {
												vremX = vert.x - sredneeX;
											  }
											  if (vert.x < 0 && sredneeX < 0) {
												  if (vert.x <= sredneeX) {
																 vremX = -1 * sredneeX + vert.x;
												  }else {
																 vremX = -1 * sredneeX - ( -1 * vert.x);
												  }
											  }
										  }
										  if (viborVivodaX == "knPravX") {
											  if (maxX >= 0) {
												vremX = vert.x - maxX;
											  }else {
												vremX = -1 * maxX + vert.x;
											  }
										  }
										  if (viborVivodaY == "knLevY") {
											  if (minY >= 0) {
												vremY = vert.y - minY;
											  }else {
												vremY = -1 * minY + vert.y;
											  }
										  }
										  if (viborVivodaY == "knSredY") {
											  if (vert.y >= 0 && sredneeY >= 0) {
												  if (vert.y <= sredneeY) {
													vremY = -1 * (sredneeY - vert.y);
												  }else {
													vremY = vert.y - sredneeY;
												  }
											  }
											  if (vert.y < 0 && sredneeY >= 0) {
												vremY = vert.y - sredneeY;
											  }
											  if (vert.y < 0 && sredneeY < 0) {
												  if (vert.y <= sredneeY) {
													vremY = -1 * sredneeY + vert.y;
												  }else {
													vremY = -1 * sredneeY - ( -1 * vert.y);
												  }
											  }
										  }
										  if (viborVivodaY == "knPravY") {
											  if (maxY >= 0) {
												vremY = vert.y - maxY;
											  }else {
												vremY = -1 * maxY + vert.y;
											  }
										  }
										  if (viborVivodaZ == "knLevZ") {
											  if (minZ >= 0) {
												vremZ = vert.z - minZ;
											  }else {
												vremZ = -1 * minZ + vert.z;
											  }
										  }
										  if (viborVivodaZ == "knSredZ") {
											  if (vert.z >= 0 && sredneeZ >= 0) {
												  if (vert.z <= sredneeZ) {
													vremZ = -1 * (sredneeZ - vert.z);
												  }else {
													vremZ = vert.z - sredneeZ;
												  }
											  }
											  if (vert.z < 0 && sredneeZ >= 0) {
												  vremZ = vert.z - sredneeZ;
											  }
											  if (vert.z < 0 && sredneeZ < 0) {
												  if (vert.z <= sredneeZ) {
													vremZ = -1 * sredneeZ + vert.z;
												  }else {
													vremZ = -1 * sredneeZ - ( -1 * vert.z);
												  }
											  }
										  }
										  if (viborVivodaZ == "knPravZ") {
											  if (maxZ >= 0) {
															  vremZ = vert.z - maxZ;
											  }else {
															  vremZ = -1 * maxZ + vert.z;
											  }
										  }
										  if (sovpadenie == false) {
											  dannie += imya + ".addVertex(" + vremX + ", " + vremY + ", " + vremZ + ", " + vert.u + ", " + vert.v + ", " + '"' + vert.id + '");' + "\n";
										  }
						   }
						   dannie += imya + ".addFaceByIds(" + vremMassVert + ", " + material[i] + ", " +'"'+ mesh.faces[i].id + '");' + "\n";
		   }
		   dannie += imya +".calculateFacesNormals();";
		   TextField(oknoVivoda.getChildByName("vivodTeksta")).text = dannie;
}
private function sohranenieProekta(e:MouseEvent):void {
		   var dannie:String = "";
		   var vremMassVert:String = "[";
		   var vert:Vertex;
		   var ssilkaNaFail:FileReference = new FileReference();
		   var massBytov:ByteArray = new ByteArray();
		   for (var i:int = 0; i < mesh.faces.length; i++) {
						   for (var j:int = 0; j < mesh.faces[i].vertices.length; j++) {
										  vert = mesh.faces[i].vertices[j];
										  if (j != mesh.faces[i].vertices.length - 1) {
														  vremMassVert += vert.id + ",";
										  }else {
														  vremMassVert += vert.id +"]";
										  }
										  dannie += "vertex{" + "x=" + vert.x + "," + "y=" + vert.y + "," + "z=" + vert.z + "," + "u=" + vert.u + "," + "v=" + vert.v + "," + "id=" + vert.id + "}" + "\r\n";
						   }
						   dannie += "face{" + vremMassVert + "," + massImenTekstur[mesh.faces[i].id] +"," + mesh.faces[i].id + "}\r\n";
						   vremMassVert = "[";
		   }
		   massBytov.writeUTFBytes(dannie);
		   ssilkaNaFail.save(massBytov);
}
private function zagruzkaProekta(e:MouseEvent):void {
		   mesh = new Mesh();
		   var ssilkaNaFail:FileReference = new FileReference();
		   var dannie:String = "";
		   ssilkaNaFail.addEventListener(Event.SELECT, vibor);
		   ssilkaNaFail.addEventListener(Event.COMPLETE, zagr);
		   ssilkaNaFail.browse();
		   function vibor(e:Event):void {
						   ssilkaNaFail.load();
		   }
		   function zagr(e:Event):void {
						   massSootvVershVertexam.length = 0;
						   indMassSootvVershVertexam.length = 0;
						   massUvershin.length = 0;
						   massVvershin.length = 0;
						   massTekstur.length = 0;
						   massImenTekstur.length = 0;
						   videlenVershina = null;
						   massVidelenVershin.length = 0;
						   massVremVertexov.length = 0;
						   shetchikGraney = 0;
						   shetchikVertexov = 0;
						   for (var k:int = 0; k < massKnopokGraney.length; k++) {
										  massKnopokGraney[k].removeEventListener(MouseEvent.CLICK, izmenenieGrany);
										  massKnopokGraney[k].removeEventListener(MouseEvent.MOUSE_OVER, nadKnopkoiGrani);
										  massKnopokGraney[k].removeEventListener(MouseEvent.MOUSE_OUT, vneKnopkiGrani);
										  konteinerKnopok.removeChild(massKnopokGraney[k]);
						   }
						   massKnopokGraney.length = 0;
						   for (k = 0; k < shetchikVershin; k++) {
										  if (vektTochek["nomVerh" + k] != null) {
														  vektTochek["nomVerh" + k].removeEventListener(MouseEvent3D.CLICK, videlenieVershiny);
														  conteinerModeli.removeChild(vektTochek["nomVerh" + k]);
										  }
						   }
						   shetchikVershin = 0;
						   vektTochek.length = 0;
						   var massBytov:ByteArray = ByteArray(ssilkaNaFail.data);
						   var X:Number;
						   var Y:Number;
						   var Z:Number;
						   var U:Number;
						   var V:Number;
						   var ID:String;
						   var matZagrGrani:String = "";
						   var tip:String;
						   var tipPeremennoi:String;
						   var tekZnachenie:String = "";
						   var dobavVmassiv:Boolean = false;//Otslejivaet nachalo dobavleniya vertexov v massiv
						   var massZagrVershGrani:Array = new Array();
						   var massZagrTochekGrani:Array = new Array();//Ispolzuetsya dlya hraneniya tochek, svyazannih s vertexami
						   var vseZagrVertexi:Array = new Array();//Ispolzuetsya dlya otslejivaniya uje zagrujennih vertexov
						   var dobavVertvMesh:Boolean = true;
						   var dobavVmassTochki:Boolean = true;
						   var proverkaTekstur:Boolean = false;//Proveryaet est li tekstura v massive zagrujaemih tekstur
						   dannie = massBytov.readUTFBytes(massBytov.bytesAvailable);
						   for (var i:int = 0; i < dannie.length; i++) {
										  if (dannie.slice(i, i + 7) == "vertex{") {
														  i += 6;
														  tip = "vertex";
														  tekZnachenie = "";
										  }
										  if (dannie.charAt(i) == "x" && dannie.charAt(i + 1) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "X";
														  i += 2;
										  }
										  if (dannie.charAt(i) == "y" && dannie.charAt(i + 1) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "Y";
														  i += 2;
										  }
										  if (dannie.charAt(i) == "z" && dannie.charAt(i + 1) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "Z";
														  i += 2;
										  }
										  if (dannie.charAt(i) == "u" && dannie.charAt(i + 1) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "U";
														  i += 2;
										  }
										  if (dannie.charAt(i) == "v" && dannie.charAt(i + 1) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "V";
														  i += 2;
										  }
										  if (dannie.charAt(i) == "i" && dannie.charAt(i + 1) == "d" && dannie.charAt(i + 2) == "=") {
														  tekZnachenie = "";
														  tipPeremennoi = "ID";
														  i += 3;
										  }
										  if (dannie.charAt(i) == "," && tip == "vertex") {
														  if (tipPeremennoi == "X") {
																		  X = Number(tekZnachenie);
														  }
														  if (tipPeremennoi == "Y") {
																		  Y = Number(tekZnachenie);
														  }
														  if (tipPeremennoi == "Z") {
																		  Z = Number(tekZnachenie);
														  }
														  if (tipPeremennoi == "U") {
																		  U = Number(tekZnachenie);
														  }
														  if (tipPeremennoi == "V") {
																		  V = Number(tekZnachenie);
														  }
														  tekZnachenie = "";
										  }
										  if (dannie.charAt(i) == "}" && tipPeremennoi == "ID" && tip == "vertex") {
														  ID = tekZnachenie;
														  tekZnachenie = "";
														  tip = "";
														  for (k = 0; k < vseZagrVertexi.length; k++) {
																		  if (ID == vseZagrVertexi[k]) {
																						 dobavVertvMesh = false;
																						 break;
																		  }
																		  if (k == vseZagrVertexi.length - 1) {
																						 dobavVertvMesh = true;
																		  }
														  }
														  if (dobavVertvMesh) {
																		  mesh.addVertex(X, Y, Z, U, V, ID);
																		  vseZagrVertexi.push(ID);
																		  shetchikVertexov = Math.max(shetchikVertexov, Number(ID.slice(6, ID.length)));
														  }
														  for (k = 0; k < shetchikVershin; k++) {
																		  if (vektTochek["nomVerh" + k].x == X && vektTochek["nomVerh" + k].y == Y && vektTochek["nomVerh" + k].z == Z) {
																						 massZagrTochekGrani.push("nomVerh" + k);
																						 dobavVmassTochki = false;
																						 break;
																		  }
																		  if (k == shetchikVershin - 1) {
																						 dobavVmassTochki = true;
																		  }
														  }
														  if (dobavVmassTochki) {
																		  massZagrTochekGrani.push("nomVerh" + shetchikVershin);
																		  vektTochek["nomVerh" + shetchikVershin] = new Sprite3D(5, 5, materialTochek);
																		  vektTochek["nomVerh" + shetchikVershin].x = X;
																		  vektTochek["nomVerh" + shetchikVershin].y = Y;
																		  vektTochek["nomVerh" + shetchikVershin].z = Z;
																		  massUvershin["nomVerh" + shetchikVershin] = U;
																		  massVvershin["nomVerh" + shetchikVershin] = V;
																		  vektTochek["nomVerh" + shetchikVershin].name = "nomVerh" + shetchikVershin;
																		  conteinerModeli.addChild(vektTochek["nomVerh" + shetchikVershin]);
																		  vektTochek["nomVerh" + shetchikVershin].addEventListener(MouseEvent3D.CLICK, videlenieVershiny);
																		  shetchikVershin += 1;
														  }
														  X = 0;
														  Y = 0;
														  Z = 0;
														  U = 0;
														  V = 0;
														  ID = "";
										  }
										  if (dannie.slice(i, i + 5) == "face{") {
														  i += 6;
														  tip = "face";
														  matZagrGrani = "";
														  tekZnachenie = "";
														  massZagrVershGrani.length = 0;
														  dobavVmassiv = true;
										  }
										  if (dannie.charAt(i) == "," && tip == "face" && dobavVmassiv) {
														  massZagrVershGrani.push(tekZnachenie);
														  tekZnachenie = "";
														  i += 1;
										  }
										  if (dannie.charAt(i) == "]" && tip == "face" && dobavVmassiv) {
														  massZagrVershGrani.push(tekZnachenie);
														  tekZnachenie = "";
														  dobavVmassiv = false;
														  i += 1;
										  }
										  if (dannie.charAt(i) == "," && tip == "face" && dobavVmassiv == false && matZagrGrani == "") {
														  matZagrGrani = tekZnachenie;
														  tekZnachenie = "";
														  i += 1;
										  }
										  if (dannie.charAt(i) == "}" && tip == "face") {
														  tekZnachenie = "";
														  tip = "";
														  for (k = 0; k < massZagrMnogoImenTextur.length; k++) {
																		  if (matZagrGrani == massZagrMnogoImenTextur[k]) {
																						 massTekstur["nomGrany" + shetchikGraney] = massZagrMnogoTextur[k];
																						 massImenTekstur["nomGrany" + shetchikGraney] = matZagrGrani;
																						 proverkaTekstur = true;
																						 break;
																		  }
																		  if (k == massZagrMnogoImenTextur.length - 1) {
																						 proverkaTekstur = false;
																		  }
														  }
														  if (proverkaTekstur == false) {
																		  var vremCvet:Number = Math.round(Math.random() * 16581375);
																		  massTekstur["nomGrany" + shetchikGraney] = new FillMaterial(vremCvet);
																		  massImenTekstur["nomGrany" + shetchikGraney] = vremCvet;
														  }
														  mesh.addFaceByIds(massZagrVershGrani, massTekstur["nomGrany" + shetchikGraney], "nomGrany" + shetchikGraney);
														  massSootvVershVertexam["nomGrany" + shetchikGraney] = new Array();
														  indMassSootvVershVertexam["nomGrany" + shetchikGraney] = new Array();
														  for (k = 0; k < massZagrVershGrani.length; k++) {
																		  massSootvVershVertexam["nomGrany" + shetchikGraney][massZagrTochekGrani[k]] = massZagrVershGrani[k];
																		  indMassSootvVershVertexam["nomGrany" + shetchikGraney][k] = massZagrTochekGrani[k];
														  }
														  massKnopokGraney[massKnopokGraney.length] = new TextField();
														  with (massKnopokGraney[massKnopokGraney.length-1]) {
																		  selectable = false;
																		  background = true;
																		  backgroundColor = "0x80FFFF";
																		  width = 90;
																		  height = 20;
																		  y = (massKnopokGraney.length - 1) * 22;
																		  defaultTextFormat = txFormat;
																		  text = "nomGrany" + shetchikGraney;
																		  name = "nomGrany" + shetchikGraney;
																		  addEventListener(MouseEvent.CLICK, izmenenieGrany);
																		  addEventListener(MouseEvent.MOUSE_OVER, nadKnopkoiGrani);
																		  addEventListener(MouseEvent.MOUSE_OUT, vneKnopkiGrani);
														  }
														  konteinerKnopok.addChild(massKnopokGraney[massKnopokGraney.length-1]);
														  shetchikGraney += 1;
														  massZagrVershGrani.length = 0;
														  massZagrTochekGrani.length = 0;
														  matZagrGrani = "";
														  ID = "";
										  }
										  tekZnachenie += dannie.charAt(i);
						   }
						   shetchikVertexov += 1;
						   BSP_S[0].createTree(mesh);
						   ssilkaNaFail.removeEventListener(Event.SELECT, vibor);
						   ssilkaNaFail.removeEventListener(Event.COMPLETE, zagr);
		   }
}
private function ustanVnutVneshGranCill(e:MouseEvent):void {
		   if (e.target == vnesGraniCill) {
						   if (vneshGranCill == false) {
										  vneshGranCill = true;
										  vnesGraniCill.backgroundColor = uint(cvetVidKnopki);
						   }else {
										  vneshGranCill = false;
										  vnesGraniCill.backgroundColor = 0x80FFFF;
						   }
		   }
		   if (e.target == vnutGraniCill) {
						   if (vnutrGranCill == false) {
										  vnutrGranCill = true;
										  vnutGraniCill.backgroundColor = uint(cvetVidKnopki);
						   }else {
										  vnutrGranCill = false;
										  vnutGraniCill.backgroundColor = 0x80FFFF;
						   }
		   }
}
private function otmenaCillindra(e:MouseEvent):void {
		   if(postroenieCill){
						   for (var i:int = shetchikVershin - 1; i >= kolichTochekCill; i--) {
										  conteinerModeli.removeChild(vektTochek["nomVerh" + i]);
						   }
						   for (i = shetchikGraney - 1; i >= kolichGraneyCill; i--) {
										  mesh.removeFaceById("Cill" + i);
										  massTekstur["Cill" + i] = null;
										  massImenTekstur["Cill" + i] = null;
						   }
						   for (i = 0; i < massRazrezaCill.length; i++) {
										  massRazrezaCill[i].visible = true;
						   }
						   BSP_S[0].createTree(mesh);
						   shetchikVershin = kolichTochekCill;
						   shetchikGraney = kolichGraneyCill;
						   postroenieCill = false;
		   }
}
private function sohranenieCillindra(e:MouseEvent):void {
		   if(postroenieCill){
						   for (var i:int = 0; i < massRazrezaCill.length; i++) {
										  conteinerModeli.removeChild(massRazrezaCill[i]);
						   }
						   for (i = 0; i < massVremGraneyCill.length; i++) {
										  massKnopokGraney[massKnopokGraney.length] = new TextField();
										  with (massKnopokGraney[massKnopokGraney.length-1]) {
														  selectable = false;
														  background = true;
														  backgroundColor = "0x80FFFF";
														  width = 90;
														  height = 20;
														  y = (massKnopokGraney.length - 1) * 22;
														  defaultTextFormat = txFormat;
														  text = massVremGraneyCill[i];
														  name = massVremGraneyCill[i];
														  addEventListener(MouseEvent.CLICK, izmenenieGrany);
														  addEventListener(MouseEvent.MOUSE_OVER, nadKnopkoiGrani);
														  addEventListener(MouseEvent.MOUSE_OUT, vneKnopkiGrani);
										  }
										  konteinerKnopok.addChild(massKnopokGraney[massKnopokGraney.length-1]);
										  if (proshKnopkaGrany != null) {
														  proshKnopkaGrany.backgroundColor = uint("0x80FFFF");
										  }
										  proshKnopkaGrany = massKnopokGraney[massKnopokGraney.length - 1];
						   }
						   postroenieCill = false;
		   }
}
//Funkciya ispolzuetsya v Sozdanii cilindra
private function vichislPosTochiKruga(radius:Number, gradus:Number):Point {
		   var tochka:Point = new Point();
		   if (gradus >= 0 && gradus <= 90) {
						   tochka.x = -1 * radius * Math.sin(gradus * radiani);
						   tochka.y = -1 * radius * Math.cos(gradus * radiani);
		   }
		   if (gradus > 90 && gradus <= 180) {
						   tochka.x = -1 * radius * Math.cos((gradus - 90) * radiani);
						   tochka.y = radius * Math.sin((gradus - 90) * radiani);
		   }
		   if (gradus > 180 && gradus <= 270) {
						   tochka.x = radius * Math.sin((gradus - 180) * radiani);
						   tochka.y = radius * Math.cos((gradus - 180) * radiani);
		   }
		   if (gradus > 270) {
						   tochka.x = radius * Math.cos((gradus - 270) * radiani);
						   tochka.y = -1 * radius * Math.sin((gradus - 270) * radiani);
		   }
		   return tochka;
}
private function sozdatCylindr(e:MouseEvent):void {
		   if (videlenie == false && massVidelenVershin.length != 0 && postroenieCill == false) {
						   tekGran = null;
						   var uslovie:Boolean = true;
						   var kolichSegm:int = int(kolichSegmenCil.text);
						   var chisloGradusov:int = int(kolichGradCil.text);
						   var shag:Number = chisloGradusov / kolichSegm;
						   var tekGradus:Number;
						   var koordinaty:Point;
						   var minY:Number = 100000;
						   var maxY:Number = -100000;//min i max ispolzuyutsya dlya korrektnogo rascheta V-koordinat
						   //Proverka na sootvetstvie usloviyam funkcii (pervaya tochka v videlenii - os vrascheniya, X i Y vseh tochek >0)
						   for (var i:int = 1; i < massVidelenVershin.length; i++) {
										  minY = Math.min(minY, vektTochek[massVidelenVershin[i]].y);
										  maxY = Math.max(maxY, vektTochek[massVidelenVershin[i]].y);
										  if (vektTochek[massVidelenVershin[i]].x < 0 || vektTochek[massVidelenVershin[i]].y < 0 || vektTochek[massVidelenVershin[0]].x < vektTochek[massVidelenVershin[i]].x) {
														  uslovie = false;
										  }
						   }
						   if (uslovie) {
										  massVneshTexturCill.length = 0;
										  massVnutrTexturCill.length = 0;
										  postroenieCill = true;
										  kolichTochekCill = shetchikVershin;
										  kolichGraneyCill = shetchikGraney;
										  massVnutrTexturCill.length = 0;
										  massVneshTexturCill.length = 0;
										  massRazrezaCill.length = 0;
										  massVremGraneyCill.length = 0;
										  massVershCill = new Array();
										  var vremCvetVnesh:Number = Math.round(Math.random() * 16581375);
										  var vremCvetVnutr:Number = Math.round(Math.random() * 16581375);
										  var vremCvetVneshGraney:FillMaterial = new FillMaterial(vremCvetVnesh);
										  var vremCvetVnutrGraney:FillMaterial = new FillMaterial(vremCvetVnutr);
										  var massSootVershin:Array = new Array();//Ispolzuetsya dlya svyazki tochek i vertexov
										  var massVertDlyaGrani:Array = new Array();
										  massRazrezaCill[massRazrezaCill.length] = vektTochek[massVidelenVershin[0]];
										  vektTochek[massVidelenVershin[0]].visible = false;//Ischeznovenie ishodnih tochek
										  for (i = 1; i < massVidelenVershin.length; i++) {
														  massVershCill[i] = new Array();
														  tekGradus = chisloGradusov;
														  massRazrezaCill[massRazrezaCill.length] = vektTochek[massVidelenVershin[i]];
														  vektTochek[massVidelenVershin[i]].visible = false;//ubrat ishodnie tochki (seceniya)
														  //Sozdanie Vershin
														  for (var j:int = 0; j < kolichSegm; j++) {
																		  koordinaty = vichislPosTochiKruga(vektTochek[massVidelenVershin[0]].x - vektTochek[massVidelenVershin[i]].x, tekGradus);
																		  massVershCill[i][j] = new Vertex();
																		  massVershCill[i][j].x = koordinaty.x + vektTochek[massVidelenVershin[0]].x;
																		  massVershCill[i][j].y = vektTochek[massVidelenVershin[i]].y;
																		  massVershCill[i][j].z = koordinaty.y;
																		  massVershCill[i][j].u = (1 / kolichSegm) * j;
																		  massVershCill[i][j].v = raznicaMinMax(minY, massVershCill[i][j].y) / raznicaMinMax(minY, maxY);//(1 / (massVidelenVershin.length - 2)) * (i-1);//ot dlini massiva otnimaetsya 2 po prichine, 1-ya tochka - os okrujnosti
																		  massVershCill[i][j].id = "vertex" + shetchikVertexov;
																		  massSootVershin["vertex" + shetchikVertexov] = "nomVerh" + shetchikVershin;
																		  vektTochek["nomVerh" + shetchikVershin] = new Sprite3D(5, 5, materialTochek);
																		  vektTochek["nomVerh" + shetchikVershin].x = massVershCill[i][j].x;
																		  vektTochek["nomVerh" + shetchikVershin].y = massVershCill[i][j].y;
																		  vektTochek["nomVerh" + shetchikVershin].z = massVershCill[i][j].z;
																		  massUvershin["nomVerh" + shetchikVershin] = massVershCill[i][j].u;
																		  massVvershin["nomVerh" + shetchikVershin] = massVershCill[i][j].v;
																		  vektTochek["nomVerh" + shetchikVershin].name = "nomVerh" + shetchikVershin;
																		  conteinerModeli.addChild(vektTochek["nomVerh" + shetchikVershin]);
																		  vektTochek["nomVerh" + shetchikVershin].addEventListener(MouseEvent3D.CLICK, videlenieVershiny);
																		  shetchikVershin += 1;
																		  shetchikVertexov += 1;
																		  //Sozdanie poslednei zamikayushei vershini, ona ravna 1-i vershine, otlichayutsya tolko teksturnie koorfinati
																		  if (j == kolichSegm - 1) {
																						 massVershCill[i][j + 1] = new Vertex();
																						 massVershCill[i][j + 1].x = massVershCill[i][0].x;
																						 massVershCill[i][j + 1].y = massVershCill[i][0].y;
																						 massVershCill[i][j + 1].z = massVershCill[i][0].z;
																						 massVershCill[i][j + 1].u = (1 / kolichSegm) * (j + 1);
																						 massVershCill[i][j + 1].v = raznicaMinMax(minY, massVershCill[i][j].y) / raznicaMinMax(minY, maxY);//(1 / (massVidelenVershin.length - 2)) * (i - 1);
																						 massVershCill[i][j + 1].id = "vertex" + shetchikVertexov;
																						 massSootVershin["vertex" + shetchikVertexov] = massSootVershin[massVershCill[i][0].id];
																						 mesh.addVertex(massVershCill[i][j + 1].x, massVershCill[i][j + 1].y, massVershCill[i][j + 1].z, massVershCill[i][j + 1].u, massVershCill[i][j + 1].v, massVershCill[i][j + 1].id);
																						 shetchikVertexov += 1;
																		  }
																		  mesh.addVertex(massVershCill[i][j].x, massVershCill[i][j].y, massVershCill[i][j].z, massVershCill[i][j].u, massVershCill[i][j].v, massVershCill[i][j].id);
																		  tekGradus -= shag;
														  }
										  }
										  //Sozdanie Graney
										  for (i = 1; i < massVidelenVershin.length; i++) {
														  for (j = 0; j < kolichSegm; j++) {
																		  massSootvVershVertexam["Cill" + shetchikGraney] = new Array();
																		  indMassSootvVershVertexam["Cill" + shetchikGraney] = new Array();
																		  massSootvVershVertexam["Cill" + (shetchikGraney+1)] = new Array();
																		  indMassSootvVershVertexam["Cill" + (shetchikGraney+1)] = new Array();
																		  if (j != kolichSegm - 1 && i != massVidelenVershin.length - 1) {
																						 massVertDlyaGrani.push(massVershCill[i][j].id);
																						 massVertDlyaGrani.push(massVershCill[i + 1][j].id);
																						 massVertDlyaGrani.push(massVershCill[i + 1][j + 1].id);
																						  massVertDlyaGrani.push(massVershCill[i][j + 1].id);
																						 if (vneshGranCill) {
																										 massVneshTexturCill.push("Cill" + shetchikGraney);
																										 massTekstur["Cill" + shetchikGraney] = vremCvetVneshGraney;
																										 massImenTekstur["Cill" + shetchikGraney] = vremCvetVnesh;
																										 mesh.addFaceByIds(massVertDlyaGrani, vremCvetVneshGraney, "Cill" + shetchikGraney);
																										 massVremGraneyCill[massVremGraneyCill.length] = "Cill" + shetchikGraney;
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j].id]] = massVershCill[i][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][0] = massSootVershin[massVershCill[i][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j].id]] = massVershCill[i + 1][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][1] = massSootVershin[massVershCill[i + 1][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j + 1].id]] = massVershCill[i + 1][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][2] = massSootVershin[massVershCill[i + 1][j + 1].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j + 1].id]] = massVershCill[i][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][3] = massSootVershin[massVershCill[i][j + 1].id];
																										 shetchikGraney += 1;
																						 }
																						 if (vnutrGranCill) {
																										 massVnutrTexturCill.push("Cill" + shetchikGraney);
																										 massTekstur["Cill" + shetchikGraney] = vremCvetVnutrGraney;
																										 massImenTekstur["Cill" + shetchikGraney] = vremCvetVnutr;
																										 massVertDlyaGrani = massVertDlyaGrani.reverse();
																										 mesh.addFaceByIds(massVertDlyaGrani, vremCvetVnutrGraney, "Cill" + shetchikGraney);//vnutrennyaya storona
																										 massVremGraneyCill[massVremGraneyCill.length] = "Cill" + shetchikGraney;
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j].id]] = massVershCill[i][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][3] = massSootVershin[massVershCill[i][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j].id]] = massVershCill[i + 1][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][2] = massSootVershin[massVershCill[i + 1][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j + 1].id]] = massVershCill[i + 1][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][1] = massSootVershin[massVershCill[i + 1][j + 1].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j + 1].id]] = massVershCill[i][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][0] = massSootVershin[massVershCill[i][j + 1].id];
																										 shetchikGraney += 1;
																						 }
																						 massVertDlyaGrani.length = 0;
																		  }
																		  //Formirovanie poslednei zamikayushey grani
																		  if (j == kolichSegm - 1 && i != massVidelenVershin.length - 1 && chisloGradusov == 360) {
																						 massSootvVershVertexam["Cill" + shetchikGraney] = new Array();
																						 indMassSootvVershVertexam["Cill" + shetchikGraney] = new Array();
																						 massSootvVershVertexam["Cill" + (shetchikGraney+1)] = new Array();
																						 indMassSootvVershVertexam["Cill" + (shetchikGraney+1)] = new Array();
																						 massVertDlyaGrani.push(massVershCill[i][j].id);
																						 massVertDlyaGrani.push(massVershCill[i + 1][j].id);
																						 massVertDlyaGrani.push(massVershCill[i + 1][j + 1].id);
																						 massVertDlyaGrani.push(massVershCill[i][j + 1].id);
																						 if (vneshGranCill) {
																										 massVneshTexturCill.push("Cill" + shetchikGraney);
																										 massTekstur["Cill" + shetchikGraney] = vremCvetVneshGraney;
																										 massImenTekstur["Cill" + shetchikGraney] = vremCvetVnesh;
																										 mesh.addFaceByIds(massVertDlyaGrani, vremCvetVneshGraney, "Cill" + shetchikGraney);
																										 massVremGraneyCill[massVremGraneyCill.length] = "Cill" + shetchikGraney;
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j].id]] = massVershCill[i][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][0] = massSootVershin[massVershCill[i][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j].id]] = massVershCill[i + 1][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][1] = massSootVershin[massVershCill[i + 1][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j + 1].id]] = massVershCill[i + 1][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][2] = massSootVershin[massVershCill[i + 1][j + 1].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j + 1].id]] = massVershCill[i][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][3] = massSootVershin[massVershCill[i][j + 1].id];
																										 shetchikGraney += 1;
																						 }
																						 if (vnutrGranCill) {
																										 massVnutrTexturCill.push("Cill" + shetchikGraney);
																										 massTekstur["Cill" + shetchikGraney] = vremCvetVnutrGraney;
																										 massImenTekstur["Cill" + shetchikGraney] = vremCvetVnutr;
																										 massVertDlyaGrani = massVertDlyaGrani.reverse();
																										 mesh.addFaceByIds(massVertDlyaGrani, vremCvetVnutrGraney, "Cill" + shetchikGraney);//vnutrennyaya storona
																										 massVremGraneyCill[massVremGraneyCill.length] = "Cill" + shetchikGraney;
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j].id]] = massVershCill[i][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][3] = massSootVershin[massVershCill[i][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j].id]] = massVershCill[i + 1][j].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][2] = massSootVershin[massVershCill[i + 1][j].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i + 1][j + 1].id]] = massVershCill[i + 1][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][1] = massSootVershin[massVershCill[i + 1][j + 1].id];
																										 massSootvVershVertexam["Cill" + shetchikGraney][massSootVershin[massVershCill[i][j + 1].id]] = massVershCill[i][j + 1].id;
																										 indMassSootvVershVertexam["Cill" + shetchikGraney][0] = massSootVershin[massVershCill[i][j + 1].id];
																										 shetchikGraney += 1;
																						 }
																						 massVertDlyaGrani.length = 0;
																		  }
														  }
														 
										  }
										  BSP_S[0].createTree(mesh);
						   }
		   }
}
private function povorotTekstuti(e:MouseEvent):void {
		   if (tekGran != null) {
						   var i:int;
						   var tekUV1:Point = new Point();
						   var tekUV2:Point = new Point();
						   if (massVremVertexov.length == 0) {
										  for (i = 0; i < mesh.getFaceById(tekGran).vertices.length; i++) {
														  massVremVertexov.push(mesh.getFaceById(tekGran).vertices[i].id);
										  }
						   }
						   if (e.target == povLevoTeksturi) {
										  for (i = 0; i < massVremVertexov.length; i++) {
														  if (i == 0) {
																		  tekUV1.x = mesh.getVertexById(massVremVertexov[i]).u;
																		  tekUV1.y = mesh.getVertexById(massVremVertexov[i]).v;
																		  mesh.getVertexById(massVremVertexov[i]).u = mesh.getVertexById(massVremVertexov[massVremVertexov.length - 1]).u;
																		  mesh.getVertexById(massVremVertexov[i]).v = mesh.getVertexById(massVremVertexov[massVremVertexov.length - 1]).v;
														  }else {
																		  tekUV2.x = mesh.getVertexById(massVremVertexov[i]).u;
																		  tekUV2.y = mesh.getVertexById(massVremVertexov[i]).v;
																		  mesh.getVertexById(massVremVertexov[i]).u = tekUV1.x;
																		  mesh.getVertexById(massVremVertexov[i]).v = tekUV1.y;
																		  tekUV1.x = tekUV2.x;
																		  tekUV1.y = tekUV2.y;
																		  if (i == massVremVertexov.length - 2) {
																						 mesh.getVertexById(massVremVertexov[i+1]).u = tekUV1.x;
																						 mesh.getVertexById(massVremVertexov[i+1]).v = tekUV1.y;
																		  }
														  }
										  }
						   }
						   if (e.target == povPravoTeksturi) {
										  for (i = massVremVertexov.length - 1; i > 0; i--) {
														  if (i == massVremVertexov.length - 1) {
																		  tekUV1.x = mesh.getVertexById(massVremVertexov[i]).u;
																		  tekUV1.y = mesh.getVertexById(massVremVertexov[i]).v;
																		  mesh.getVertexById(massVremVertexov[i]).u = mesh.getVertexById(massVremVertexov[0]).u;
																		  mesh.getVertexById(massVremVertexov[i]).v = mesh.getVertexById(massVremVertexov[0]).v;
														  }else {
																		  tekUV2.x = mesh.getVertexById(massVremVertexov[i]).u;
																		  tekUV2.y = mesh.getVertexById(massVremVertexov[i]).v;
																		  mesh.getVertexById(massVremVertexov[i]).u = tekUV1.x;
																		  mesh.getVertexById(massVremVertexov[i]).v = tekUV1.y;
																		  tekUV1.x = tekUV2.x;
																		  tekUV1.y = tekUV2.y;
																		  if (i == 1) {
																						 mesh.getVertexById(massVremVertexov[0]).u = tekUV1.x;
																						 mesh.getVertexById(massVremVertexov[0]).v = tekUV1.y;
																		  }
														  }
										  }
						   }
						   BSP_S[0].createTree(mesh);
		   }
}
private function zagrTeksturu(e:MouseEvent):void {
		   if (tekGran != null || massVneshTexturCill.length != 0 || massVnutrTexturCill.length != 0) {
						   var fRef:FileReference = new FileReference();
						   var loader:Loader = new Loader();
						   var material:TextureMaterial;
						   var name:String = e.target.name;
						   fRef.addEventListener(Event.SELECT, vibor);
						   fRef.addEventListener(Event.COMPLETE, zagr);
						   loader.contentLoaderInfo.addEventListener(Event.COMPLETE, otobraj);
						   fRef.browse();
						   function vibor(e:Event):void {
										  fRef.load();
						   }
						   function zagr(e:Event):void {
										  loader.loadBytes(fRef.data);
						   }
						   function otobraj(e:Event):void {
										  material = new TextureMaterial(Bitmap(loader.content).bitmapData);
										  if (tekGran != null) {
														  massImenTekstur[tekGran] = fRef.name;
														  massTekstur[tekGran] = material;
														  massTekstur[tekGran].smooth = true;
														  mesh.getFaceById(tekGran).material = massTekstur[tekGran];
										  }else {
														  if (massVneshTexturCill.length != 0 && name == "vneshTeksturaCill") {
																		  for (var i:int = 0; i < massVneshTexturCill.length; i++) {
																						 massImenTekstur[massVneshTexturCill[i]] = fRef.name;
																						 massTekstur[massVneshTexturCill[i]] = material;
																						 massTekstur[massVneshTexturCill[i]].smooth = true;
																						 mesh.getFaceById(massVneshTexturCill[i]).material = massTekstur[massVneshTexturCill[i]];
																						
																		  }
														  }
														  if (massVnutrTexturCill.length != 0 && name == "vnutrTeksturaCill") {
																		  for (var j:int = 0; j < massVnutrTexturCill.length; j++) {
																						 massImenTekstur[massVnutrTexturCill[j]] = fRef.name;
																						 massTekstur[massVnutrTexturCill[j]] = material;
																						 massTekstur[massVnutrTexturCill[j]].smooth = true;
																						 mesh.getFaceById(massVnutrTexturCill[j]).material = massTekstur[massVnutrTexturCill[j]];
																		  }
														  }
										  }
										  BSP_S[0].createTree(mesh);
										  fRef.removeEventListener(Event.SELECT, vibor);
										  fRef.removeEventListener(Event.COMPLETE, zagr);
										  loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, otobraj);
						   }
		   }
}
private function zagrMnogoTekstur(e:MouseEvent):void {
		   if (true) {
						   var fRef:FileReference = new FileReference();
						   var loader:Loader = new Loader();
						   var name:String = e.target.name;
						   fRef.addEventListener(Event.SELECT, vibor);
						   fRef.addEventListener(Event.COMPLETE, zagr);
						   loader.contentLoaderInfo.addEventListener(Event.COMPLETE, otobraj);
						   fRef.browse();
						   function vibor(e:Event):void {
										  fRef.load();
						   }
						   function zagr(e:Event):void {
										  loader.loadBytes(fRef.data);
						   }
						   function otobraj(e:Event):void {
										  massZagrMnogoTextur.push(new TextureMaterial(Bitmap(loader.content).bitmapData));
										  massZagrMnogoImenTextur.push(fRef.name);
										  fRef.removeEventListener(Event.SELECT, vibor);
										  fRef.removeEventListener(Event.COMPLETE, zagr);
										  loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, otobraj);
						   }
		   }
}
private function dvizheniePolyaKnopok(e:MouseEvent):void {
		   if (e.target == knKonteineraVverh) {
						   konteinerKnopok.y += 20;
		   }
		   if (e.target == knKonteineraVniz) {
						   konteinerKnopok.y -= 20;
		   }
}
private function nadKnopkoiGrani(e:MouseEvent):void {
		   massVidelenVershin.length = 0;
		   massVremVertexov.length = 0;
		   videlenVershina = null;
		   //Sbros cveta u vseh tochek
		   for (var i:int = 0; i < shetchikVershin; i++) {
						   if (vektTochek["nomVerh" +i] != null) {
										  vektTochek["nomVerh" +i].material = materialTochek;
						   }
		   }
		   //Raskraska tochek Grani
		   for (i = 0; i < mesh.getFaceById(e.target.name).vertices.length; i++) {
						   vektTochek[indMassSootvVershVertexam[e.target.name][i]].material = materialVidelenTochek;
		   }
}
private function vneKnopkiGrani(e:MouseEvent):void {
		   //Sbros cveta u vseh tochek
		   for (var i:int = 0; i < shetchikVershin; i++) {
						   if (vektTochek["nomVerh" +i] != null) {
										  vektTochek["nomVerh" +i].material = materialTochek;
						   }
		   }
}
private function izmenenieGrany(e:MouseEvent):void {
		   if (proshKnopkaGrany != null) {
						   proshKnopkaGrany.backgroundColor = uint("0x80FFFF");
		   }
		   tekGran = e.target.name;
		   e.target.backgroundColor = cvetVidKnopki;
		   //Nabor massiva dlya vozmozhnosti izmenit normal grani
		   massVremVertexov.length = 0;
		   for (var i:int = 0; i < mesh.getFaceById(tekGran).vertices.length; i++) {
						   massVremVertexov.push(mesh.getFaceById(tekGran).vertices[i].id);
		   }
		   proshKnopkaGrany = TextField(e.target);
}
private function snyatVidelen(e:MouseEvent):void {
		   if (videlenVershina != null) {
						   videlenVershina.material = materialTochek;
						   for (var k:int = 0; k < massVidelenVershin.length; k++) {
										  vektTochek[massVidelenVershin[k]].material = materialTochek;
						   }
		   }
		   massVidelenVershin.length = 0;
		   massVremVertexov.length = 0;
		   videlenVershina = null;
		   tekGran = null;
		   if (proshKnopkaGrany != null) {
						   proshKnopkaGrany.backgroundColor = uint("0x80FFFF");
		   }
		   proshKnopkaGrany = null;
}
private function vvodZnacheniy(e:Event):void {// Ustanavlivaet vershinu na ukazannuyu poziciyu
		   if (videlenVershina != null) {//Izmenenie U/V konkretnogo vertexa, konkretnoy grani
						   if (massSootvVershVertexam[tekGran] != null && massSootvVershVertexam[tekGran][videlenVershina.name] != null) {
										  if (e.target == znachU) {
														  mesh.getVertexById(massSootvVershVertexam[tekGran][videlenVershina.name]).u = Number(znachU.text);
										  }
										  if (e.target == znachV) {
														  mesh.getVertexById(massSootvVershVertexam[tekGran][videlenVershina.name]).v = Number(znachV.text);
										  }
						   }
						   if (vremMassVert.length != 0) {//Izmenenie koordinat vseh vertexov, svyazannih s tochkoi
										  videlenVershina.x = Number(znachX.text);
										  videlenVershina.y = Number(znachY.text);
										  videlenVershina.z = Number(znachZ.text);
										  for (var i:int = 0; i < vremMassVert.length; i++) {
														  mesh.getVertexById(vremMassVert[i]).x = videlenVershina.x;
														  mesh.getVertexById(vremMassVert[i]).y = videlenVershina.y;
														  mesh.getVertexById(vremMassVert[i]).z = videlenVershina.z;
										  }
						   }else {
										  if (e.target == znachX) {
														  videlenVershina.x = Number(znachX.text);
										  }
										  if (e.target == znachY) {
														  videlenVershina.y = Number(znachY.text);
										  }
										  if (e.target == znachZ) {
														  videlenVershina.z = Number(znachZ.text);
										  }
										  if (e.target == znachU) {
														  massUvershin[videlenVershina.name] = znachU.text;
										  }
										  if (e.target == znachV) {
														  massVvershin[videlenVershina.name] = znachV.text;
										  }
						   }
						  BSP_S[0].createTree(mesh);
		   }
}
private function KD(e:KeyboardEvent):void {
		   if (e.keyCode == 16) {// Klavisha Shift
						   videlenie = true;
		   }
}
private function KU(e:KeyboardEvent):void {
		   if (e.keyCode == 16) {
						   videlenie = false;
		   }
}
private function dobavlenieVershiny(e:MouseEvent):void {
		   vektTochek["nomVerh" + shetchikVershin] = new Sprite3D(5, 5, materialTochek);
		   vektTochek["nomVerh" + shetchikVershin].x = Number(znachX.text);
		   vektTochek["nomVerh" + shetchikVershin].y = Number(znachY.text);
		   vektTochek["nomVerh" + shetchikVershin].z = Number(znachZ.text);
		   massUvershin["nomVerh" + shetchikVershin] = znachU.text;
		   massVvershin["nomVerh" + shetchikVershin] = znachV.text;
		   vektTochek["nomVerh" + shetchikVershin].name = "nomVerh" + shetchikVershin;
		   conteinerModeli.addChild(vektTochek["nomVerh" + shetchikVershin]);
		   vektTochek["nomVerh" + shetchikVershin].addEventListener(MouseEvent3D.CLICK, videlenieVershiny);
		   shetchikVershin += 1;
}
private function dobavlenieGrani(e:MouseEvent):void {
		   if (videlenie == false && massVidelenVershin.length != 0) {
						   massSootvVershVertexam["nomGrany" + shetchikGraney] = new Array();
						   indMassSootvVershVertexam["nomGrany" + shetchikGraney] = new Array();
						   tekCvet = Math.round(Math.random() * 16581375);
						   if (massVidelenVershin.length == 4) {//Ustanovka teksturnih koordinat v sluchae esli videleno 4 vershini
										  massUvershin[massVidelenVershin[0]] = 0;
										  massVvershin[massVidelenVershin[0]] = 0;
										  massUvershin[massVidelenVershin[1]] = 0;
										  massVvershin[massVidelenVershin[1]] = 1;
										  massUvershin[massVidelenVershin[2]] = 1;
										  massVvershin[massVidelenVershin[2]] = 1;
										  massUvershin[massVidelenVershin[3]] = 1;
										  massVvershin[massVidelenVershin[3]] = 0;
						   }
						   for (var i:int = 0; i < massVidelenVershin.length; i++) {
										  mesh.addVertex(vektTochek[massVidelenVershin[i]].x, vektTochek[massVidelenVershin[i]].y, vektTochek[massVidelenVershin[i]].z, massUvershin[massVidelenVershin[i]], massVvershin[massVidelenVershin[i]], "vertex" + shetchikVertexov);
										  massSootvVershVertexam["nomGrany" + shetchikGraney][massVidelenVershin[i]] = "vertex" + shetchikVertexov;
										  indMassSootvVershVertexam["nomGrany" + shetchikGraney][i] = massVidelenVershin[i];
										  massVremVertexov.push("vertex" + shetchikVertexov);
										  shetchikVertexov += 1;
										  Sprite3D(conteinerModeli.getChildByName(massVidelenVershin[i])).material = materialTochek;
						   }
						   mesh.addFaceByIds(massVremVertexov, new FillMaterial(tekCvet), "nomGrany" + shetchikGraney);
						   tekGran = "nomGrany" + shetchikGraney;
						   massTekstur[tekGran] = new FillMaterial(tekCvet);
						   massImenTekstur[tekGran] = tekCvet;
						   massKnopokGraney[massKnopokGraney.length] = new TextField();
						   with (massKnopokGraney[massKnopokGraney.length-1]) {
										  selectable = false;
										  background = true;
										  backgroundColor = cvetVidKnopki;
										  width = 90;
										  height = 20;
										  y = (massKnopokGraney.length - 1) * 22;
										  defaultTextFormat = txFormat;
										  text = tekGran;
										  name = tekGran;
										  addEventListener(MouseEvent.CLICK, izmenenieGrany);
										  addEventListener(MouseEvent.MOUSE_OVER, nadKnopkoiGrani);
										  addEventListener(MouseEvent.MOUSE_OUT, vneKnopkiGrani);
						   }
						   konteinerKnopok.addChild(massKnopokGraney[massKnopokGraney.length-1]);
						   if (proshKnopkaGrany != null) {
										  proshKnopkaGrany.backgroundColor = uint("0x80FFFF");
						   }
						   proshKnopkaGrany = massKnopokGraney[massKnopokGraney.length - 1];
						   BSP_S[0].createTree(mesh);
						   videlenVershina = null;
						   massVidelenVershin.length = 0;
						   massVremVertexov.length = 0;
						   shetchikGraney += 1;
		   }
}
private function udalenieVershiny(e:MouseEvent):void {
		   if (videlenVershina != null) {
						   var sovpadenie:Boolean = false;
						   for (var i:int = 0; i < mesh.faces.length; i++) {
										  if (sovpadenie) {
														  break;
										  }
										  for (var j:int = 0; j < mesh.faces[i].vertices.length; j++) {
														  if (indMassSootvVershVertexam[mesh.faces[i].id][j] == videlenVershina.name) {
																		  sovpadenie = true;
																		  break;
														  }
										  }
						   }
						   if (sovpadenie == false) {
										  vektTochek[videlenVershina.name] = null;
										  conteinerModeli.removeChild(videlenVershina);
										  videlenVershina = null;
						   }
		   }
}
private function udalenieGrani(e:MouseEvent):void {
		   if (tekGran != null) {
						   var smeschKnopok:Boolean = false;
						   for (var i:int = 0; i < massKnopokGraney.length; i++) {
										  if (massKnopokGraney[i].name == tekGran) {
														  smeschKnopok = true;
														  konteinerKnopok.removeChild(massKnopokGraney[i]);
														  massKnopokGraney[i] = null;
										  }
										  if (smeschKnopok && i != massKnopokGraney.length - 1) {
														  massKnopokGraney[i + 1].y = 22 * i;
														  massKnopokGraney[i] = massKnopokGraney[i + 1];
										  }
						   }
						   massKnopokGraney.length -= 1;
						   var massVershin:Vector.<Vertex> = mesh.getFaceById(tekGran).vertices.slice(0, mesh.getFaceById(tekGran).vertices.length);
						   mesh.removeFaceById(tekGran);
						   massTekstur[tekGran] = null;
						   massImenTekstur[tekGran] = null;
						   massSootvVershVertexam[tekGran] = null;
						   indMassSootvVershVertexam[tekGran] = null;
						   BSP_S[0].createTree(mesh);
						   if (proshKnopkaGrany != null) {
										  proshKnopkaGrany.backgroundColor = uint("0x80FFFF");
						   }
						   tekGran = null;
		   }
}
private function izmenenieNormali(e:MouseEvent):void {
		   if (tekGran != null) {
						   if (mesh.getFaceById(tekGran) != null) {
										  if(massVremVertexov.length == 0){
														  for (var i:int; i < mesh.getFaceById(tekGran).vertices.length; i++) {
																		  massVremVertexov.push(mesh.getFaceById(tekGran).vertices[i].id);
														  }
										  }
										  massVremVertexov = massVremVertexov.reverse();
										  mesh.removeFaceById(tekGran);
										  mesh.addFaceByIds(massVremVertexov, massTekstur[tekGran], tekGran);
										  BSP_S[0].createTree(mesh);
						   }
		   }
}
private function videlenieVershiny(e:MouseEvent3D):void {
		   if (videlenie == false) {
						   if (videlenVershina != null) {
										  videlenVershina.material = materialTochek;
						   }
						   //Sbros cveta u vseh tochek
						   for (var i:int = 0; i < shetchikVershin; i++) {
										  if (vektTochek["nomVerh" +i] != null) {
														  vektTochek["nomVerh" +i].material = materialTochek;
										  }
						   }
						   massVidelenVershin.length = 0;
						   massVremVertexov.length = 0;
		   }else if (videlenVershina != null && massVidelenVershin.length == 0) {
						   massVidelenVershin.push(videlenVershina.name);
		   }
		   vremMassVert.length = 0;
		   videlenVershina = Sprite3D(e.target);
		   for (var j:int = 0; j < mesh.faces.length; j++) {
			   for (var k:int = 0; k < mesh.faces[j].vertices.length; k++) {
							  if (indMassSootvVershVertexam[mesh.faces[j].id][k] == videlenVershina.name) {
											  vremMassVert.push(massSootvVershVertexam[mesh.faces[j].id][videlenVershina.name]);
							  }
			   }
		   }
		   e.target.material = materialVidelenTochek;
		   znachX.text = e.target.x;
		   znachY.text = e.target.y;
		   znachZ.text = e.target.z;
		   if (tekGran != null && massSootvVershVertexam[tekGran] != null && massSootvVershVertexam[tekGran][videlenVershina.name] != null) {
			   znachU.text = mesh.getVertexById(massSootvVershVertexam[tekGran][videlenVershina.name]).u+"";
			   znachV.text = mesh.getVertexById(massSootvVershVertexam[tekGran][videlenVershina.name]).v + "";
		   }else {
			   znachU.text = massUvershin[videlenVershina.name];
			   znachV.text = massVvershin[videlenVershina.name];
		   }
		   if (videlenie) {//Neobhodimo isklyuchit vozmojnost zadvoeniya videleniya vershin
				massVidelenVershin.push(e.target.name);
		   }
	   }
	}
   
}
 
