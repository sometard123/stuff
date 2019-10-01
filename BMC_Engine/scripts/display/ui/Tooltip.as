package display.ui
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class Tooltip
   {
       
      
      public var mc:MovieClip = null;
      
      public var vis:Boolean = false;
      
      public var waiting:Boolean = true;
      
      public var displayTimer:Timer;
      
      public var toTooltip:String = "";
      
      private const _extraSymbols:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      public var enable:Boolean = true;
      
      public function Tooltip(param1:MovieClip)
      {
         this.displayTimer = new Timer(0.05,1);
         super();
         this.mc = param1;
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         param1.addEventListener(Event.ENTER_FRAME,this.process);
         Main.instance.addEventListener(MouseEvent.MOUSE_MOVE,this.move);
         this.displayTimer.addEventListener(TimerEvent.TIMER,this.waitOver);
         param1.label.autoSize = TextFieldAutoSize.LEFT;
         param1.alpha = 0;
      }
      
      public function waitOver(param1:Event) : void
      {
         if(!this.enable)
         {
            return;
         }
         this.mc.parent.setChildIndex(this.mc,this.mc.parent.numChildren - 1);
         this.waiting = false;
         this.mc.label.htmlText = "<b>" + this.toTooltip + "</b>";
         this.mc.bg.width = this.mc.label.textWidth + 5 + this.mc.label.x * 2;
         this.mc.bg.height = this.mc.label.textHeight + 5 + this.mc.label.y * 2;
         this.mc.x = Main.instance.mouseX - this.mc.bg.width / 2;
         this.mc.y = Main.instance.mouseY - this.mc.bg.height / 2;
         if(this.mc.y + this.mc.bg.height > Main.playArea.bottom - 5)
         {
            this.mc.y = Main.playArea.bottom - 5 - this.mc.bg.height;
         }
         if(this.mc.x + this.mc.bg.width > Main.playArea.right - 5)
         {
            this.mc.x = Main.playArea.right - 5 - this.mc.bg.width;
         }
         if(this.mc.x + this.mc.bg.width > Main.instance.mouseX && this.mc.y + this.mc.bg.height > Main.instance.mouseY)
         {
            this.mc.x = Main.instance.mouseX - this.mc.bg.width;
            this.mc.y = Main.instance.mouseY - this.mc.bg.height;
         }
         if(this.mc.x < 5)
         {
            this.mc.x = 5;
         }
         if(this.mc.y < 5)
         {
            this.mc.y = 5;
         }
      }
      
      public function set tooltip(param1:String) : void
      {
         this.toTooltip = param1;
      }
      
      public function addSymbol(param1:DisplayObject, param2:int = 0, param3:int = 0) : void
      {
         param1.x = param2;
         param1.y = param3;
         this._extraSymbols.push(param1);
         if(this.mc != null)
         {
            this.mc.addChild(param1);
         }
      }
      
      public function show() : void
      {
         this.waiting = true;
         this.displayTimer.reset();
         this.displayTimer.start();
         this.vis = true;
      }
      
      public function hide() : void
      {
         var _loc1_:DisplayObject = null;
         if(this.mc != null)
         {
            for each(_loc1_ in this._extraSymbols)
            {
               if(this.mc.contains(_loc1_) == true)
               {
                  this.mc.removeChild(_loc1_);
               }
            }
         }
         this._extraSymbols.length = 0;
         this.vis = false;
      }
      
      public function process(param1:Event) : void
      {
         if(this.vis && !this.waiting)
         {
            this.mc.alpha = this.mc.alpha + 0.15;
            if(this.mc.alpha > 1)
            {
               this.mc.alpha = 1;
            }
         }
         else
         {
            this.mc.alpha = this.mc.alpha - 0.15;
            if(this.mc.alpha < 0)
            {
               this.mc.alpha = 0;
            }
         }
      }
      
      protected function move(param1:MouseEvent) : void
      {
         if(this.vis && !this.waiting)
         {
            this.mc.x = Main.instance.mouseX - this.mc.bg.width / 2;
            this.mc.y = Main.instance.mouseY - this.mc.bg.height / 2;
            if(this.mc.y + this.mc.bg.height > Main.playArea.bottom - 5)
            {
               this.mc.y = Main.playArea.bottom - 5 - this.mc.bg.height;
            }
            if(this.mc.x + this.mc.bg.width > Main.playArea.right - 5)
            {
               this.mc.x = Main.playArea.right - 5 - this.mc.bg.width;
            }
            if(this.mc.x + this.mc.bg.width > Main.instance.mouseX && this.mc.y + this.mc.bg.height > Main.instance.mouseY)
            {
               this.mc.x = Main.instance.mouseX - this.mc.bg.width;
               this.mc.y = Main.instance.mouseY - this.mc.bg.height;
            }
            if(this.mc.x < 5)
            {
               this.mc.x = 5;
            }
            if(this.mc.y < 5)
            {
               this.mc.y = 5;
            }
         }
      }
   }
}
