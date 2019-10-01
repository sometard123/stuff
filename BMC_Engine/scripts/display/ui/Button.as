package display.ui
{
   import assets.sounds.NonSelect;
   import assets.sounds.Select;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   
   public class Button extends MovieClip
   {
      
      public static var enbaleTootip:Boolean = true;
       
      
      public var extra:Object;
      
      protected var valid_:Boolean = true;
      
      protected var over_:Boolean = false;
      
      public var click:Function = null;
      
      public var over:Function = null;
      
      public var out:Function = null;
      
      public var down:Function = null;
      
      public var up:Function = null;
      
      protected var tooltipText:String = null;
      
      public function Button()
      {
         this.extra = {};
         super();
         gotoAndPlay("Out");
         mouseChildren = false;
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.handleMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.handleMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         addEventListener(MouseEvent.CLICK,this.handleClick);
      }
      
      public function Destroy() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.handleMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.handleMouseOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         removeEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         removeEventListener(MouseEvent.CLICK,this.handleClick);
      }
      
      public function set valid(param1:Boolean) : void
      {
         if(this.valid == param1)
         {
            return;
         }
         this.valid_ = param1;
         this.over_ = false;
         if(param1 == false)
         {
            if(currentLabel != "Invalid")
            {
               gotoAndPlay("Invalid");
            }
            useHandCursor = false;
            buttonMode = false;
         }
         else
         {
            if(currentLabel != "Out")
            {
               gotoAndPlay("Out");
            }
            useHandCursor = true;
            buttonMode = true;
         }
      }
      
      public function get valid() : Boolean
      {
         return this.valid_;
      }
      
      public function set tooltip(param1:String) : void
      {
         if(param1 == null)
         {
            this.tooltipText = null;
            return;
         }
         this.tooltipText = param1;
      }
      
      public function get tooltip() : String
      {
         return this.tooltipText;
      }
      
      protected function handleClick(param1:MouseEvent) : void
      {
         if(this.valid)
         {
            new MaxSound(Select).play();
         }
         else
         {
            new MaxSound(NonSelect).play();
         }
         §§push(this);
         if(this.valid && this.click != null)
         {
            this.click(param1);
         }
      }
      
      protected function handleMouseDown(param1:MouseEvent) : void
      {
         if(this.valid && this.down != null)
         {
            this.down(param1);
         }
      }
      
      protected function handleMouseUp(param1:MouseEvent) : void
      {
         if(this.valid && this.up != null)
         {
            this.up(param1);
         }
      }
      
      public function handleMouseOver(param1:MouseEvent) : void
      {
         this.over_ = true;
         if(this.valid && currentLabel != "Over")
         {
            gotoAndPlay("Over");
         }
         if(this.over != null)
         {
            this.over(param1);
         }
         if(this.tooltipText && enbaleTootip)
         {
            Main.instance.tooltip.tooltip = this.tooltipText;
            Main.instance.tooltip.show();
         }
      }
      
      public function handleMouseOut(param1:MouseEvent) : void
      {
         this.over_ = false;
         if(this.valid && currentLabel != "Out")
         {
            gotoAndPlay("Out");
         }
         if(this.out != null)
         {
            this.out(param1);
         }
         if(this.tooltipText)
         {
            Main.instance.tooltip.hide();
         }
      }
   }
}
