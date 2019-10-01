package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.ExplodingKnowledgeBox;
   import assets.ui.ExplodingKnowledgeBoxAncient;
   import assets.ui.ExplodingKnowledgeBoxWild;
   import assets.ui.ScreenFlash;
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.utils.widgets.Wafter;
   import org.osflash.signals.Signal;
   
   public class ExplodingBoxAnimation extends MovieClip
   {
       
      
      private var _clip:MovieClip;
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      public const explodeSignal:Signal = new Signal();
      
      public const completeSignal:Signal = new Signal();
      
      private var _wafter:Wafter;
      
      private var _waftOffsets:Point;
      
      private var _waftRange:Number = 10;
      
      private var _boxLocation:Point;
      
      private var _screenFlash:ScreenFlash;
      
      public function ExplodingBoxAnimation(param1:int = 0)
      {
         this._wafter = new Wafter();
         this._waftOffsets = new Point(1,1.86);
         this._boxLocation = new Point();
         this._screenFlash = new ScreenFlash();
         super();
         this.init(param1);
      }
      
      private function init(param1:int) : void
      {
         switch(param1)
         {
            case MonkeyKnowledgePack.STANDARD_PACK:
               this._clip = new ExplodingKnowledgeBox();
               break;
            case MonkeyKnowledgePack.ANCIENT_PACK:
               this._clip = new ExplodingKnowledgeBoxAncient();
               break;
            case MonkeyKnowledgePack.WILDCARD_PACK:
               this._clip = new ExplodingKnowledgeBoxWild();
         }
         this._clip.buttonMode = true;
         this._clip.useHandCursor = true;
         this._clip.mouseChildren = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._screenFlash,false,true);
         this._clip.addEventListener(Event.COMPLETE,this.onExplosionComplete);
         this._clip.addEventListener("explode",this.oneExplode);
         this._clip.addEventListener("flare",this.spawnFlare);
         this._screenFlash.addEventListener(Event.COMPLETE,this.onScreenFlashComplete);
         this._clip.hover.visible = false;
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
         this._wafter.speed = 2;
         this._clip.mouseChildren = false;
      }
      
      private function spawnFlare(param1:Event) : void
      {
         var _loc2_:Stage = MonkeySystem.getInstance().flashStage;
         this._screenFlash.width = _loc2_.stageWidth;
         this._screenFlash.height = _loc2_.stageHeight;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._screenFlash,true,true);
         addChild(this._screenFlash);
      }
      
      private function onScreenFlashComplete(param1:Event) : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._screenFlash,false,true);
         removeChild(this._screenFlash);
      }
      
      private function onRollover(param1:MouseEvent) : void
      {
         this._clip.hover.visible = true;
      }
      
      private function onRollout(param1:MouseEvent) : void
      {
         this._clip.hover.visible = false;
      }
      
      private function oneExplode(param1:Event) : void
      {
         this.explodeSignal.dispatch();
      }
      
      public function reveal() : void
      {
         this._boxLocation.y = -(MonkeySystem.getInstance().flashStage.stageHeight * 0.5 + 200);
         addChild(this._clip);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true,true);
         TweenLite.to(this._boxLocation,1,{
            "x":0,
            "y":0,
            "ease":Elastic.easeInOut,
            "onComplete":function onComplete():void
            {
               addEventListener(MouseEvent.CLICK,onClick);
               _clip.mouseEnabled = true;
            }
         });
         this.startWafting();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClick);
         this.open();
         this.stopWafting();
         this._clip.hover.visible = false;
         this._clip.mouseEnabled = false;
         MCSound.getInstance().playSound(MCSound.KNOWLEDGE_REVEAL_CHEST_OPEN_2,0.6);
      }
      
      public function open() : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,true,true);
      }
      
      public function cancel() : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true,true);
         if(this.contains(this._clip))
         {
            removeChild(this._clip);
         }
         this.stopWafting();
      }
      
      private function onExplosionComplete(param1:Event) : void
      {
         removeChild(this._clip);
         this._boxLocation.y = -(MonkeySystem.getInstance().flashStage.stageHeight * 0.5 + 200);
         this.completeSignal.dispatch();
      }
      
      private function startWafting() : void
      {
         addEventListener(Event.ENTER_FRAME,this.updateWaft);
         TweenLite.to(this._wafter,5,{
            "rangeX":this._waftRange,
            "rangeY":this._waftRange
         });
      }
      
      private function stopWafting() : void
      {
         TweenLite.to(this._wafter,5,{
            "rangeX":0,
            "rangeY":0,
            "onComplete":function():void
            {
               removeEventListener(Event.ENTER_FRAME,updateWaft);
            }
         });
      }
      
      private function updateWaft(param1:Event) : void
      {
         this._wafter.update();
         this._wafter.waftTarget(this._clip,this._waftOffsets,this._boxLocation);
      }
   }
}
