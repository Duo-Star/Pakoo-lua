
function Switch() end
Switch={
  __call=function(_,data)
    return Switch.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Switch",
        p=data.p or Vector(),
        act=data.act or false,

      }
      return setmetatable(data,Switch)
    end,

    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."act="..tostring(item.act)
    end,

    ptON=Paint().setColor(0xFFC62828).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOFF=Paint().setColor(0xFF9E9E9E).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOutline=Paint().setColor(0xFF424242).setStrokeWidth(1) .setStyle(Paint.Style.FILL),

    onDraw=function(String_,graph)

      local pt
      local pt_outline
      if String_.act then
        pt=String_.ptON
        --graph:drawBitmap(res.bitmap.SW_on,String_.p+Vector(-.6,.6),0.02,ptOutline)

       else
        pt=String_.ptOFF

        --graph:drawBitmap(res.bitmap.SW_off,String_.p+Vector(-.6,.6),0.02,ptOutline)

      end

      graph:drawRect(String_.p+Vector(-.5,-.255),String_.p+Vector(.5,-.5),pt)
      graph:drawRect(String_.p+Vector(-.5,-.19),String_.p+Vector(.5,-.23),pt)


    end,

    setSignal=function(btn,map,v)
      map:signalLayerSet(btn.p,v)
      map:signalLayerSet(btn.p+Vector.front,v)
      map:signalLayerSet(btn.p+Vector.back,v)
      map:signalLayerSet(btn.p+Vector.left,v)
      map:signalLayerSet(btn.p+Vector.right,v)
    end,




    onClick_on=function(btn)
      pakoo.map:signalLayerAdd_Quartet(btn.p)
      soundPool.play(res.sound.Click_on, 1,1,0,0,1)
    end,
    onClick_off=function(btn)
      pakoo.map:signalLayerSub_Quartet(btn.p)
      soundPool.play(res.sound.Click_off, 1,1,0,0,1)
    end,

    onUpdate=function(btn,pakoo)
      if btn.act then
        --btn:setSignal(pakoo.map,1)
       else
        --btn:setSignal(pakoo.map,0)
      end
    end,

    onDelete=function(item,map)
      if item.act then
        item:onClick_off()
      end
      map[item.p.x][item.p.y]=nil
    end,

    isThis=function(sth)
      return getmetatable(sth)==Switch
    end,
    onCreate=function(btn,pakoo)

    end,
    onTouch_ACTION_DOWN=function(btn,pakoo)
      btn.act=not btn.act

      if btn.act then
        btn:onClick_on()

       else
        btn:onClick_off()

      end
    end


  }
}
setmetatable(Switch, Switch)


return Switch
