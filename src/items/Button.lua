--创建一个可爱的按钮



function Button() end
Button={
  __call=function(_,data)
    return Button.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Light",
        iotype="i",
        p=data.p or Vector(),
        act=data.act or false,
        actStartTick=0,
        actStayTick=35

      }
      return setmetatable(data,Button)
    end,

    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."act="..tostring(item.act)
    end,

    ptON=Paint().setColor(0xFF8e8e8e).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOFF=Paint().setColor(0xFFBDBDBD).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOutline=Paint().setColor(0xFF424242).setStrokeWidth(5) .setStyle(Paint.Style.FILL),

    onDraw=function(String_,graph)

      local pt
      if String_.act then
        pt=String_.ptON
       else
        pt=String_.ptOFF
      end

      --graph:drawBitmap(res.bitmap.Redstone_Dust,String_.p+Vector(-.48,.5),0.006,pakoo.graph.paints.grid)
      graph:drawRect(String_.p+Vector(-.3,.2),String_.p+Vector(.3,-.2),pt)

    end,

    setSignal=function(btn,map,v)
      map:signalLayerSet(btn.p,v)
      map:signalLayerSet(btn.p+Vector.front,v)
      map:signalLayerSet(btn.p+Vector.back,v)
      map:signalLayerSet(btn.p+Vector.left,v)
      map:signalLayerSet(btn.p+Vector.right,v)
    end,
    onClick_on=function(btn)
      soundPool.play(res.sound.Click_on, 1,1,0,0,1)
      pakoo.map:signalLayerAdd_Quartet(btn.p)

    end,


    onClick_off=function(btn)
      soundPool.play(res.sound.Click_off, 1,1,0,0,1)
      pakoo.map:signalLayerSub_Quartet(btn.p)
    end,
    onUpdate=function(btn,pakoo)
      if btn.act then
        if btn.actStayTick+btn.actStartTick< pakoo.tick then
          btn.act=false
          btn:onClick_off()
          -- print(btn.actStayTick+btn.actStartTick)
          --btn:setSignal(pakoo.map,0)
        end
       else
      end
    end,

    onDelete=function(item,map)
      if item.act then
        item:onClick_off()
      end
      map[item.p.x][item.p.y]=nil
    end,

    isThis=function(sth)
      return getmetatable(sth)==Button
    end,
    onCreate=function(btn,pakoo)

    end,
    onTouch_ACTION_DOWN=function(btn,pakoo)
      if btn.act then
       else
        btn.act=true
        btn.actStartTick=pakoo.tick
        --print(btn.actStartTick)
        btn:onClick_on()
      end
    end


  }
}
setmetatable(Button, Button)


return Button
