local layout={ FrameLayout,
  layout_width = 'fill',
  layout_height = 'fill',
  id="root",
  { SurfaceView;
    layout_width = 'fill',
    layout_height = 'fill',
    id = "surface",
  },
  {MaterialCardView,
    radius="3dp",
    cardElevation=10,
    strokeWidth=0,
    layout_marginBottom='1dp',
    onClick=function() end,
    id="eee",
    layout_gravity="top|center";
    {
      TabLayout,
      id="layerTab",
      layout_width = 'fill',
      layout_height = 'fill',
    },
  },
  {MaterialCardView,
    radius="3dp",
    cardElevation=10,
    strokeWidth=0,
    layout_marginBottom='1dp',
    onClick=function() end,
    id="eee",
    layout_gravity="bottom|center";
    { LinearLayout,
      orientation='0',
      layout_width = 'fill',
      {
        TabLayout,
        id="toolTab",
        layout_width = 'fill',
        layout_height = 'fill',
        --layout_marginRight='30dp',
      },

    }
  },
  {MaterialCardView,--信息栏💧💧💧💧💧
    layout_width="220dp",
    radius="3dp",cardElevation=10,
    strokeWidth=0,
    layout_margin='5dp',
    --cardBackgroundColor=ui.卡片颜色,
    layout_gravity="top|center",
    id="info_card",
    { LinearLayout,
      orientation='1',
      layout_width="220dp",
      background='#00FFFFFF',
      onClick=function() end,
      { FrameLayout,
        layout_width="fill",
        layout_marginTop='5dp',layout_marginLeft='5dp',layout_marginRight='5dp',
        layout_gravity="top",
        background='#00FFFFFF',
        { TextView,
          text="Text",
          layout_marginLeft='5dp',
          textSize="22dp",
          id="info_card_title",
          Typeface=jost_book_typeface,
        },
        { AppCompatImageView,
          layout_width="20dp",
          layout_height="20dp",
          layout_margin='3dp',
          layout_gravity="right",
          colorFilter=primaryc,
          src="res/imgs/build.png",
          onClick=function()
            local sl=pakoo.select
            local item=pakoo.map:indexSth(sl)
            if (item or {}).uChange then
              item:uChange(pakoo)
              info_card_title.text=pakoo.map:getType(sl)
              info_card_text.text=pakoo.map:getInfo(sl)
              else
              simpleSnackMsg("无效选中或无法交互")
            end
          end,
        },
      },
      { TextView,
        text="Text",
        textSize="13dp",
        layout_margin='8dp',
        layout_marginTop='0dp',
        layout_gravity="top",
        id="info_card_text",
        Typeface=jost_book_typeface,
      },
    },
  },

  {View,
    layout_width = '0',
    layout_height = '0',
    id="chooseTools_posHepler",

  },
  { LinearLayout,
    orientation='vertical',
    layout_width='50%w',
    layout_height='fill',
    gravity="top|left";
    {ScrollView,
      { LinearLayout,
        orientation='vertical',
        layout_width='fill',
        layout_height='fill',
        {MaterialTextView,
          id="帧率",
          textColor=primaryc,
          Typeface=jost_medium_typeface

        },
        {MaterialTextView,
          id="infotext",
          --textColor=primaryc,
          Typeface=jost_medium_typeface
        },
        {MaterialButton,
          text="debug1",
          id="debug1",
        },
        {MaterialButton,
          text="debug2",
          id="debug2",
        },
        {MaterialButton,
          text="debug3",
          id="debug3",
        },
        {MaterialTextView,
          id="debugText"}
      }
    }
  }
}

activity.setContentView(loadlayout(layout))

