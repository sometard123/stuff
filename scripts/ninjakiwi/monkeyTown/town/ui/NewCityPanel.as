package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.NewCityPanelClip;
   import com.lgrey.utils.LGMathUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.CityNameGenerator;
   import ninjakiwi.monkeyTown.utils.ProfanityFilter;
   import org.osflash.signals.Signal;
   
   public class NewCityPanel extends HideRevealViewPopup
   {
      
      public static const MAX_CITY_NAME_LENGTH:int = 20;
       
      
      private const _clip:NewCityPanelClip = new NewCityPanelClip();
      
      private const _firstCityOKButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _firstCityRandomizeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.randomButton);
      
      private const _cityCommonDataManager:CityCommonDataManager = CityCommonDataManager.getInstance();
      
      public const makeCapitalCitySignal:Signal = new Signal(String);
      
      public const makeNewCitySignal:Signal = new Signal(String);
      
      private var _defaultCityName:String;
      
      private var _okCallback:Function;
      
      private var seedFieldDefault:String = "Enter City Seed ( Optional. uints only. )";
      
      public function NewCityPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.addChild(this._clip);
         this.isModal = true;
         this._clip.seedField.visible = false;
         this._clip.cityNameField.restrict = "\\-A-z0-9_^\\^";
         this._clip.cityNameField.maxChars = MAX_CITY_NAME_LENGTH;
         this._firstCityRandomizeButton.setClickFunction(this.randomizeCityName);
         this._firstCityOKButton.setClickFunction(this.onFirstCityOKButtonClicked);
         enableDefaultOnResize(this._clip);
      }
      
      private function setDefaultCityNameText(param1:String) : void
      {
         this._clip.cityNameField.text = param1;
         this._defaultCityName = param1;
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            if(this._okCallback != null)
            {
               this._okCallback();
            }
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this._clip.seedField.text = this.seedFieldDefault;
         this._clip.seedField.visible = false;
         MonkeySystem.getInstance().flashStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         if(MonkeySystem.getInstance().flashStage.hasEventListener(KeyboardEvent.KEY_DOWN))
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
      }
      
      private function randomizeCityName() : void
      {
         this.setDefaultCityNameText(this.getUnusedCityName());
      }
      
      public function showFirstCityView() : void
      {
         this._clip.messageField.text = "Enter a name for your\nCapital City:";
         this.setDefaultCityNameText(this.getUnusedCityName());
         this._okCallback = this.onFirstCityOKButtonClicked;
         this.reveal();
      }
      
      public function showNewCity() : void
      {
         this._clip.messageField.text = "Enter a name for your\nnew City:";
         this.setDefaultCityNameText(this.getUnusedCityName());
         this._okCallback = this.onNewCityOKButtonClicked;
         this.reveal();
      }
      
      private function getUnusedCityName() : String
      {
         var _loc1_:String = CityNameGenerator.createCityName();
         while(!this._cityCommonDataManager.isCityNameAvailable(_loc1_))
         {
            _loc1_ = CityNameGenerator.createCityName();
         }
         return _loc1_;
      }
      
      private function onFirstCityOKButtonClicked() : void
      {
         var name:String = null;
         name = this._clip.cityNameField.text.split("\r").join("");
         if(this.validateNameTest(name))
         {
            this.hide();
            if(this._clip.seedField.text !== this.seedFieldDefault)
            {
               _system.useUserSeed = true;
               _system.userSeed = uint(LGMathUtil.getInstance().removeNonNumericChars(this._clip.seedField.text));
            }
            else
            {
               _system.useUserSeed = false;
            }
            setTimeout(function():void
            {
               if(name.length > MAX_CITY_NAME_LENGTH)
               {
                  name = name.substr(0,MAX_CITY_NAME_LENGTH);
               }
               makeCapitalCitySignal.dispatch(name);
               makeNewCitySignal.dispatch(name);
            },500);
         }
      }
      
      private function onNewCityOKButtonClicked() : void
      {
         var name:String = null;
         name = this._clip.cityNameField.text.split("\r").join("");
         if(this.validateNameTest(name))
         {
            this.hide();
            setTimeout(function():void
            {
               if(name.length > MAX_CITY_NAME_LENGTH)
               {
                  name = name.substr(0,MAX_CITY_NAME_LENGTH);
               }
               makeNewCitySignal.dispatch(name);
            },500);
         }
      }
      
      private function validateNameTest(param1:String) : Boolean
      {
         var _loc2_:* = "Pl" + "ea" + "s" + "e ch" + "oose" + " a" + " " + "di" + "ffe" + "re" + "nt na" + "m" + "e";
         var _loc3_:* = "Yo" + "u ha" + "ve al" + "re" + "ady us" + "ed t" + "h" + "at na" + "me";
         if(param1 === "")
         {
            return false;
         }
         if(ProfanityFilter.isProfane(param1))
         {
            this._clip.cityNameField.text = _loc2_;
            return false;
         }
         if(param1 == _loc2_ || param1 == _loc3_)
         {
            return false;
         }
         if(!this._cityCommonDataManager.isCityNameAvailable(param1))
         {
            this._clip.cityNameField.text = _loc3_;
            return false;
         }
         return true;
      }
   }
}
