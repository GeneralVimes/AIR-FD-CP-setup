package
{

	import com.junkbyte.console.Cc;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Alexey Izvalov aka Airapport
	 */
	public class Main extends Sprite 
	{	
		public static var self:Main;
		
		public var config:MainConfig;
		public function Main()
		{			
			self = this;
			config = new MainConfig();
			
			if (config.isConsoleShowing){
				showConsole();
			}
			
			Cc.log('starting...');			
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0xff0000, 1);
			spr.graphics.drawCircle(0, 0, 50);
			spr.graphics.endFill();
			addChild(spr);
			spr.x = 100;
			spr.y = 100;
			
			var tf:TextField = new TextField();
			tf.text = "Hello!"
			tf.setTextFormat(new TextFormat("Arial", 32, 0x0000ff));
			
			tf.x = 250;
			tf.y = 50;
			addChild(tf);
		}

		
		public function buidCapabilitiesString():String 
		{
			var str:String = "";
			str += " OS: " + Capabilities.os;
			str += " cpuAddressSize: " + Capabilities.cpuAddressSize;
			str += " cpuArchitecture: " + Capabilities.cpuArchitecture;
			str += " manufacturer: " + Capabilities.manufacturer;
			str += " pixelAspectRatio: " + Capabilities.pixelAspectRatio.toString();
			str += " playerType: " + Capabilities.playerType;
			str += " screenDPI: " + Capabilities.screenDPI;
			str += " screenResX: " + Capabilities.screenResolutionX;
			str += " screenResY: " + Capabilities.screenResolutionY;
			str += " screenColor: " + Capabilities.screenColor;
			str += " supports32BitProcesses: " + Capabilities.supports32BitProcesses;
			str += " supports64BitProcesses: " + Capabilities.supports64BitProcesses;
			str += " version: " + Capabilities.version;		
			
			str += "\nStage width: " + stage.stageWidth;
			str += " stage height: " + stage.stageHeight;
			str += " full screen width: " + stage.fullScreenWidth;
			str += " full screen height: " + stage.fullScreenHeight;
			
			return str;
		}
		
		public function showConsole():void 
		{
			Cc.config.style.menuFontSize = 24;
			Cc.config.style.traceFontSize = 22;
			Cc.startOnStage(this);
			
			Cc.listenUncaughtErrors(this.loaderInfo);							
			
			Cc.visible = true;
			Cc.log(buidCapabilitiesString());
		}
		
		public function hideConsole():void{
			Cc.visible = false;
		}
	}
}