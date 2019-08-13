package assets.town
{
   import assets.ui.MyCitiesInfoContainer;
   import assets.ui.MyCitiesTitle;
   import assets.ui.NewDesertCityPanel;
   import assets.ui.SelectCityTitle;
   import flash.display.MovieClip;
   
   public dynamic class MyCitiesPanelClip extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var city0:MyCitiesInfoContainer;
      
      public var city1:MyCitiesInfoContainer;
      
      public var cityBtn0:MovieClip;
      
      public var cityBtn1:MovieClip;
      
      public var closeButton:MovieClip;
      
      public var desertLockedPanel:NewDesertCityPanel;
      
      public var myCitiesTitle:MyCitiesTitle;
      
      public var padding:MovieClip;
      
      public var selectCityTitle:SelectCityTitle;
      
      public function MyCitiesPanelClip()
      {
         super();
      }
   }
}
