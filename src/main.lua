require "model.util"
mf=import "model.MathForest.main"
G=import "model.G"

--str={ntl="\n"}

pakoo={}

--使得输入法不影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

import "resLoader"

function Map() end
Map=import"items.Map"

function Signalstr() end
Signalstr=import"items.Signalstr"

function Scab() end
Scab=import"items.Scab"


function Torch() end
Torch=import"items.Torch"

function Light() end
Light=import"items.Light"

function Button() end
Button=import"items.Button"

function Switch() end
Switch=import"items.Switch"

function Creeper() end
Creeper=import"items.Notebox.Creeper"

function Piglin() end
Piglin=import"items.Notebox.Piglin"

function Skeleton() end
Skeleton=import"items.Notebox.Skeleton"

function Repeater() end
Repeater=import"items.Repeater"



import "ui.main"

--

--[
function print(str)
  local str=tostring(str)
  debugText.setText(debugText.text..str.."\n")
end
--]]

pakoo.graph=G(surface)


function Main()
  pta=pakoo.graph.paint.a

  task(50,function()
    pakoo.graph.o=Vector(0.1*pakoo.graph.w,
    .9*pakoo.graph.h)
  end)

  pakoo.map=Map{}


  --[[
  pakoo.map:addSignalstr(Vector(1,1))

  pakoo.map:addSignalstr(Vector(3,1))
  for i=4,10 do
    pakoo.map:addSignalstr(Vector(i,1))
  end
--]]


  debug1.onClick=function()
    for i=2,50 do
      for j=2,50 do
        pakoo.map:addLight(Vector(i,j),pakoo)
      end
    end
    print("debug1overClick\n")
  end

  debug2.onClick=function()
    --pakoo.map:addSignalstr(Vector(2,1))
    print("debug2overClick\n")
  end

  debug3.onClick=function()
    --pakoo.map:addTorch(Vector(1,2))
    print("debug3overClick\n")
  end

  --[[
  for i=2,50 do
    for j=2,50 do
      pakoo.map:addLight(Vector(i,j),pakoo)
    end
  end
--]]


  pakoo.graph.bgc=0xffE8EAF6
  pakoo.graph.debug=false
  pakoo.graph.paints={
    text=Paint().setColor(0xFFffffff) .setTextSize(35),
    btn=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    wall=Paint().setColor(0xFF8F6101).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    me=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    debug=Paint().setColor(0xFFFF0040).setStrokeWidth(2) .setStyle(Paint.Style.FILL).setTextSize(30),
    door_in=Paint().setColor(0xFF92A979).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    door_out=Paint().setColor(0xFF8F6101).setStrokeWidth(8) .setStyle(Paint.Style.STROKE),


    grid=Paint().setColor(0x45000000)
    .setStyle(Paint.Style.STROKE)
    .setStrokeWidth(8)
    .setAntiAlias(true)
    .setStrokeCap(Paint.Cap.ROUND),

    text=Paint().setColor(0xff000000)--0xFFFFFFFF)
    .setStyle(Paint.Style.STROKE)
    .setStrokeWidth(5)
    .setAntiAlias(true)
    .setStrokeCap(Paint.Cap.ROUND)
    .setTextAlign(Paint.Align.LEFT)
    .setTextSize(45),

    select=Paint().setColor(0xff3949AB)
    .setStyle(Paint.Style.STROKE)
    .setStrokeWidth(10)
    .setAntiAlias(true)
    .setStrokeCap(Paint.Cap.ROUND)
    .setTextAlign(Paint.Align.LEFT)
    .setTextSize(45)

  }
  pakoo.select=Vector.newNan()


  Canvas=Canvas
  pakoo.graph.onDraw=function(graph)
    graph.canvas.drawColor(surfaceVar)


    _x=(0-graph.o.x)/graph.lam
    x_=(graph.w*1-graph.o.x)/graph.lam
    _y=-(graph.h-graph.o.y)/graph.lam
    y_=-(0-graph.o.y)/graph.lam


    -- graph:drawPoint(Vector(),graph.paint.a)
    local draw_x=floor(_x)-1
    if draw_x<1 then draw_x= 1 end
    local drawx_=floor(x_)+1
    if drawx_>100 then drawx_= 100 end

    local draw_y=floor(_y)-1
    if draw_y<1 then draw_y= 1 end
    local drawy_=floor(y_)+1
    if drawy_>100 then drawy_= 100 end


    if layer==layerList.Main then
      for i=draw_x,drawx_ do
        for j=draw_y,drawy_ do
          local item=pakoo.map[i][j]
          if item then
            item:onDraw(graph)
          end
        end
      end
      if pakoo.graph.debug then
        for index, value in pairs(pakoo.map.scab) do
          value:onDraw(pakoo.map,graph)
        end
      end
     elseif layer==layerList.Signal then
      for i=draw_x,drawx_ do
        for j=draw_y,drawy_ do
          local v=Vector(i,j,0)
          local item=pakoo.map:signalLayerIndex(v)
          if item then
            graph:drawText("snl: "..item,v+Vector(-.2,-.1),paints.text)
          end
        end
      end


    end

    for x=floor(_x),x_ do
      graph:drawPoint(Vector(x),paints.text)
      graph:drawText(""..x,Vector(x)+Vector(-.1,-.2),paints.text)
      graph:drawSegment(Vector(x+.5,y_),Vector(x+.5,_y),paints.grid)
    end
    for y=floor(_y),y_ do
      graph:drawPoint(Vector(0,y),paints.text)
      graph:drawText(""..y,Vector(0,y)+Vector(-.2,-.1),paints.text)
      graph:drawSegment(Vector(_x,y+.5),Vector(x_,y+.5),paints.grid)
    end


    graph:drawRect(pakoo.select+Vector(-.5,.5),pakoo.select+Vector(.5,-.5),pakoo.graph.paints.select)

    --graph.canvas.drawLine(0,0,100,100,pakoo.graph.paints.grid)

    --graph.canvas.drawBitmap(bitmap_RedStoneDust,300,300,pakoo.graph.paints.grid)



  end


  pakoo.graph.onTouch_ACTION_DOWN=function(v, event)
    local ftcp=(pakoo.graph:getTCP()+Vector(.5,.5)):floor()
    local sp=pakoo.graph:toSP(ftcp)
    --print(dump(ftcp))
    if tool=="Move" then
      local item=pakoo.map:indexSth(ftcp)
      if item then
        item:onTouch_ACTION_DOWN(pakoo)
      end

     elseif tool=="Signalstr" then
      pakoo.select=ftcp

      pakoo.map:addSignalstr(ftcp)

     elseif tool=="Add" then
      pakoo.select=ftcp
      --pakoo.map:addTorch(ftcp)

      chooseTools_posHepler.x=sp.x
      chooseTools_posHepler.y=sp.y
      chooseTools(chooseTools_posHepler,function(t)
        print("Create: "..t)
        pakoo.map["add"..t](pakoo.map,ftcp,pakoo)
      end)

     elseif tool=="Delete" then
      pakoo.tick_sleep=true
      pakoo.select=ftcp
      pakoo.map:deleteSth(ftcp)
      --print("Delete ")
      pakoo.tick_sleep=false


     elseif tool=="Info" then
      pakoo.select=ftcp

      info_card_dimiss(false)
      info_card.x=sp.x+0.35*pakoo.graph.lam
      info_card.y=sp.y+0.35*pakoo.graph.lam
      info_card_title.text=pakoo.map:getType(ftcp)
      info_card_text.text=pakoo.map:getInfo(ftcp)


    end
  end



  function Tick(t)
    --print("a")
    for i=1,100 do
      for j=1,100 do
        local item=pakoo.map[i][j]
        if item then
          item:onUpdate(pakoo)
        end
      end
    end
    for k, v in pairs(pakoo.map.scab) do
      v:onUpdate(pakoo)
    end

  end



  pakoo.dt=0.05
  pakoo.t=0.0
  pakoo.tick=0
  pakoo.tick_sleep=false
  pakoo.tk=Ticker()
  pakoo.tk.Period=pakoo.dt*1000
  pakoo.tk.onTick=function()
    pakoo.tick=pakoo.tick+1
    pakoo.t=pakoo.t+pakoo.dt
    if pakoo.tick_sleep then
     else
      Tick(pakoo.t)
    end
    infotext.setText("tick: "..pakoo.tick.."\n"
    .."dt="..pakoo.dt.."\n"
    .."t="..(.01)*floor(pakoo.t*100).."\n"
    .."tick_sleep="..tostring(pakoo.tick_sleep).."\n"
    .."select: ("..pakoo.select.x..", "..pakoo.select.y..")\n"
    .."tool: "..tool.."\n"
    .."layer: "..layer.."\n"
    .."ScabNum: "..pakoo.map:totalScabNum().."\n"
    .."Pakoo-1.0.1-budlet")
  end
  pakoo.tk.start()
  function onDestroy()
    pakoo.tk.stop()
  end
  



  帧率.setText("please wait")
  -- 帧率计算相关变量
  local lastFrameTime = System.nanoTime() -- 使用纳秒级时间戳
  local frameCount = 0
  local currentFPS = 0
  local isMonitoring = true

  -- 使用 Choreographer 获取真实帧率
  local choreographer = Choreographer.getInstance()
  local frameCallback

  frameCallback = {
    doFrame = function(frameTimeNanos)
      frameCount = frameCount + 1
      local elapsed = (frameTimeNanos - lastFrameTime) / 1000000000 -- 转换为秒

      if elapsed >= 1.0 then
        currentFPS = frameCount
        frameCount = 0
        lastFrameTime = frameTimeNanos
        帧率.setText(string.format("FPS: %.1f", currentFPS))
      end

      if isMonitoring then
        choreographer.postFrameCallback(frameCallback)
      end
    end
  }

  -- 开始帧率监控
  function startFPSMonitor()
    isMonitoring = true
    choreographer.postFrameCallback(frameCallback)
  end

  -- 停止帧率监控
  function stopFPSMonitor()
    isMonitoring = false
    choreographer.removeFrameCallback(frameCallback)
  end

  -- 启动监控
  startFPSMonitor()

  -- Activity生命周期处理
  function onPause()
    stopFPSMonitor()
  end

  function onResume()
    if not isMonitoring then
      startFPSMonitor()
    end
  end

  function onStop()
    stopFPSMonitor()
  end



end


pakoo.graph:init(Main)
