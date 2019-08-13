package ninjakiwi.monkeyTown.ui
{
   import assets.ui.OptionsPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.StageQuality;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.RadioGroup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   
   public class OptionsPanel extends HideRevealView
   {
      
      private static const COOKIE_NAME:String = "monkey_city_quality_preferences";
       
      
      private var _clip:OptionsPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _muteMusicButton:TickBox;
      
      private var _muteSFXButton:TickBox;
      
      private var _qualityRadioGroup:RadioGroup;
      
      private var _highQualityTick:TickBox;
      
      private var _medQualityTick:TickBox;
      
      private var _lowQualityTick:TickBox;
      
      public function OptionsPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new OptionsPanelClip();
         this._qualityRadioGroup = new RadioGroup();
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         this.addChild(this._clip);
         enableDefaultOnResize(this._clip);
         isModal = true;
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(this.hide);
         this._muteMusicButton = new TickBox(this._clip.musicMuteButton);
         this._muteSFXButton = new TickBox(this._clip.soundEffectsMuteButton);
         this._muteMusicButton.changedSignal.add(this.onMuteMusicButtonChanged);
         this._muteSFXButton.changedSignal.add(this.onMuteSFXButtonChanged);
         this._muteMusicButton.setTickedWithoutDispatching(AudioState.musicIsMuted);
         this._muteSFXButton.setTickedWithoutDispatching(AudioState.sfxIsMuted);
         AudioState.MUSIC_MUTE_STATE_CHANGED.add(this._muteMusicButton.setTickedWithoutDispatching);
         AudioState.SFX_MUTE_STATE_CHANGED.add(this._muteSFXButton.setTickedWithoutDispatching);
         this._highQualityTick = new TickBox(this._clip.highQualityTick);
         this._medQualityTick = new TickBox(this._clip.medQualityTick);
         this._lowQualityTick = new TickBox(this._clip.lowQualityTick);
         this._qualityRadioGroup.addTickBox(this._highQualityTick,0,0,true);
         this._qualityRadioGroup.addTickBox(this._medQualityTick,1,1,false);
         this._qualityRadioGroup.addTickBox(this._lowQualityTick,2,2,false);
         this._qualityRadioGroup.setTicked(this._highQualityTick,false);
         this._qualityRadioGroup.changed.add(this.onQualityOptionChanged);
         this.loadPreviousSettingFromCookie();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         Main.instance.btdView.setBlockTowerPlacing(true,this);
      }
      
      override public function hide(param1:Number = 0.3) : void
      {
         super.hide(param1);
         Main.instance.btdView.setBlockTowerPlacing(false,this);
      }
      
      private function onQualityOptionChanged() : void
      {
         switch(this._qualityRadioGroup.getTickedValue())
         {
            case 0:
               MonkeySystem.getInstance().flashStage.quality = StageQuality.BEST;
               break;
            case 1:
               MonkeySystem.getInstance().flashStage.quality = StageQuality.MEDIUM;
               break;
            case 2:
               MonkeySystem.getInstance().flashStage.quality = StageQuality.LOW;
         }
         this.saveSettingToCookie();
      }
      
      private function onMuteSFXButtonChanged(param1:Boolean) : void
      {
         AudioState.sfxIsMuted = param1;
         Main.instance.btdView.setSFXAudible(!param1);
      }
      
      private function onMuteMusicButtonChanged(param1:Boolean) : void
      {
         AudioState.musicIsMuted = param1;
      }
      
      private function loadPreviousSettingFromCookie() : void
      {
         var _loc1_:Object = Kloud.loadCookie(COOKIE_NAME).data;
         if(null == _loc1_ || false == _loc1_.hasOwnProperty("Quality"))
         {
            return;
         }
         var _loc2_:int = _loc1_["Quality"];
         switch(_loc2_)
         {
            case 0:
               this._qualityRadioGroup.setTicked(this._highQualityTick,true);
               break;
            case 1:
               this._qualityRadioGroup.setTicked(this._medQualityTick,true);
               break;
            case 2:
               this._qualityRadioGroup.setTicked(this._lowQualityTick,true);
         }
      }
      
      private function saveSettingToCookie() : void
      {
         var _loc1_:Object = Kloud.loadCookie(COOKIE_NAME).data;
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:Vector.<int> = new Vector.<int>();
         _loc2_.push("Quality");
         _loc3_.push(this._qualityRadioGroup.getTickedValue());
         Kloud.saveCookie(COOKIE_NAME,_loc2_,_loc3_);
      }
   }
}
