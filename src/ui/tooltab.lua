toolList={
  Move="Move",
  Signalstr="Signalstr",
  Add="Add",
  Delete="Delete",
  Info="Info"

}
tool=toolList.Move

toolTabList={
  toolTab.newTab().setIcon(getFileDrawable("imgs/Move")).setId(1),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Redstone_Dust")).setId(2),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Add")).setId(3),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Delete")).setId(4),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Info")).setId(5),
}

for a, item in pairs(toolTabList) do
  toolTab.addTab(item)
end

toolTab.setOnTabSelectedListener{
  onTabSelected=function(tab)
    info_card_dimiss(true)
    local id=tab.getId()
    if id==1
      tool=toolList.Move
      pakoo.select=Vector.newNan()
     elseif id==2
      tool=toolList.Signalstr
     elseif id==3
      tool=toolList.Add
     elseif id==4
      tool=toolList.Delete
     elseif id==5
      tool=toolList.Info
    end
  end
}

layerList={
  Main=0,
  Signal=1,
  Jumper=2

}

layer=layerList.Main

layerTabList={
  layerTab.newTab().setIcon(getFileDrawable("imgs/Dashboard")).setId(1),
  layerTab.newTab().setIcon(getFileDrawable("imgs/Flare")).setId(2),
  layerTab.newTab().setIcon(getFileDrawable("imgs/Insert_link")).setId(3),
}

for a, item in pairs(layerTabList) do
  layerTab.addTab(item)
end

layerTab.setOnTabSelectedListener{
  onTabSelected=function(tab)
    local id=tab.getId()
    if id==1
      layer=layerList.Main
     elseif id==2
      layer=layerList.Signal
     elseif id==3
      layer=layerList.Jumper
    end
  end
}



info_card_dimiss=function(a)
  if a then
    info_card.setVisibility(View.GONE)
    info_card.x=activity.getWidth()
    info_card.y=activity.getHeight()
   else
    info_card.setVisibility(View.VISIBLE)
  end
end
info_card_dimiss(true)




function funcsBtn(t,todo)
  return {
    MaterialCardView,
    elevation="0",
    radius="5dp",
    layout_marginRight="8dp",
    layout_marginBottom="8dp",
    --cardBackgroundColor="#FFE8EAF6",
    layout_width="70dp",
    layout_height="45dp",
    layout_marginLeft='6dp';
    layout_marginRight="6dp";
    cardElevation=0,
    strokeWidth=3,
    --cardBackgroundColor=c.c1,
    onClick=function()
      todo(t)
      pops.dismiss()
    end,
    tooltipText=t,
    {
      TextView,
      text=t,
      textSize="18sp",
      layout_gravity='center';
      Typeface=jost_book_typeface,
      --textColor=c.text,
    };
  };
end



function chooseTools(view,todo)
  pops= PopupWindow(activity)
  pops.setContentView(loadlayout(
  { LinearLayout,
    layout_width='fill',
    layout_height='200dp',
    --BackgroundColor=c.bgc,
    { MaterialCardView;
      layout_width='fill',
      layout_height='wrap',
      --CardBackgroundColor=c.bgc,
      strokeWidth=0,
      radius='5dp';
      layout_margin="6dp",
      cardElevation=5,
      {
        ScrollView,
        layout_width="fill",
        layout_height="fill",
        {LinearLayout,
          layout_width='fill',
          layout_height='wrap',
          orientation=1,
          {TextView,
            layout_margin="10dp",
            layout_height="wrap",
            text="选择元件",
            layout_width="wrap",
            textSize="23dp",
            --textColor=c.text,
          },
          {TextView,
            layout_marginLeft="15dp",
            layout_margin="10dp",
            layout_height="wrap",
            text="信号源",
            textSize="15dp",
            layout_width="wrap",
            --textColor=c.text,
          },
          {
            HorizontalScrollView,
            layout_width='fill';
            layout_height='fill';

            { LinearLayout,
              layout_width='fill',
              layout_height='60dp',
              background='#00FFFFFF',
              funcsBtn("Torch",todo),
              funcsBtn("Button",todo),
              funcsBtn("Switch",todo),
            },
          },

          {TextView,
            layout_margin="15dp",
            layout_height="wrap",
            text="逻辑运算--暂未实装",
            layout_width="wrap",
            --textColor=c.text,
          },
          {
            HorizontalScrollView,
            layout_width='fill';
            layout_height='fill';
            { LinearLayout,
              layout_width='fill',
              layout_height='60dp',
              background='#00FFFFFF',
              funcsBtn("Repeater",todo),
              funcsBtn("And",todo),
              funcsBtn("Or",todo),
              funcsBtn("Not",todo),
            },
          },
          {TextView,
            layout_margin="15dp",
            layout_height="wrap",
            text="消费者",
            layout_width="wrap",
            --textColor=c.text,
          },
          {
            HorizontalScrollView,
            layout_width='fill';
            layout_height='fill';
            { LinearLayout,
              layout_width='fill',
              layout_height='60dp',
              background='#00FFFFFF',
              funcsBtn("Light",todo),
              funcsBtn("NoteBox",todo),
            },
          },

          {TextView,
            layout_margin="15dp",
            layout_height="wrap",
            text="生物音盒",
            layout_width="wrap",
            --textColor=c.text,
          },
          {
            HorizontalScrollView,
            layout_width='fill';
            layout_height='fill';
            { LinearLayout,
              layout_width='fill',
              layout_height='60dp',
              background='#00FFFFFF',
              funcsBtn("Creeper",todo),
              funcsBtn("Piglin",todo),
              funcsBtn("Skeleton",todo),

            },
          },


        },
      },
    },
  }))
  pops.setWidth(activity.getWidth()*0.8)
  pops.setHeight(dp2px(350))
  pops.setFocusable(false)
  pops.setOutsideTouchable(true)
  pops.setBackgroundDrawable(ColorDrawable(0x00000000))
  pops.showAsDropDown(view)--弹出菜单
end



