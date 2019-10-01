package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.TowerDescriptionClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class TowerDescription extends Sprite
   {
      
      private static const _greyColourTransform:ColorTransform = new ColorTransform(0.2,0.2,0.2,1);
       
      
      private var _clip:TowerDescriptionClip;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var available:Boolean = true;
      
      public var info:Object;
      
      public var count:int;
      
      public function TowerDescription()
      {
         this._clip = new TowerDescriptionClip();
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.initCSS();
         _greyColourTransform.redOffset = 55;
         _greyColourTransform.greenOffset = 35;
         _greyColourTransform.blueOffset = 13;
         addChild(this._clip);
      }
      
      private function initCSS() : void
      {
      }
      
      public function setIconFromClass(param1:Class, param2:Boolean = false, param3:int = 55, param4:int = 52) : void
      {
         var icon:MovieClip = null;
         var iconClass:Class = param1;
         var greyout:Boolean = param2;
         var width:int = param3;
         var height:int = param4;
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip.iconContainer);
         try
         {
            icon = new iconClass();
         }
         catch(e:Error)
         {
            icon = new BlankTowerIconClip();
         }
         icon.gotoAndStop(1);
         if(greyout)
         {
            icon.transform.colorTransform = _greyColourTransform;
         }
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(16777215,0);
         bg.graphics.drawRect(0,0,width,height);
         bg.graphics.endFill();
         this._clip.iconContainer.addChild(bg);
         this._clip.iconContainer.addChild(icon);
      }
      
      public function setCount(param1:int, param2:int) : void
      {
         this._clip.countField.text = param1.toString();
         this.count = param1;
         if(param2 > 0)
         {
            this._clip.damagedCountField.text = String(param2);
            this._clip.damagedCountField.visible = true;
         }
         else
         {
            this._clip.damagedCountField.text = "";
            this._clip.damagedCountField.visible = false;
         }
      }
      
      public function setDescription(param1:String) : void
      {
      }
   }
}
