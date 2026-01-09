
--print(isNightMode())

color={}

color.bg=backgroundc

if isNightMode() then
  --Night
  color.text_0=0xFFFBFBFB--黑白
  color.text_1=0xFFFBFBFB--灰白
  color.grid=0xFF858585
 else
  color.text_0=0xFF252525
  color.text_1=0xFF606060
  color.grid=0xFF757575
end



paints={
  text=Paint().setColor(0xFFffffff) .setTextSize(35),
  btn=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
  wall=Paint().setColor(0xFF8F6101).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
  me=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
  debug=Paint().setColor(0xFFFF0040).setStrokeWidth(2) .setStyle(Paint.Style.FILL).setTextSize(30),
  door_in=Paint().setColor(0xFF92A979).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
  door_out=Paint().setColor(0xFF8F6101).setStrokeWidth(8) .setStyle(Paint.Style.STROKE),


  grid=Paint().setColor(color.grid)
  .setStyle(Paint.Style.STROKE)
  .setStrokeWidth(8)
  .setAntiAlias(true)
  .setStrokeCap(Paint.Cap.ROUND),

  text=Paint().setColor(color.text_0)
  .setStyle(Paint.Style.FILL)
  .setStrokeWidth(7)
  .setAntiAlias(true)
  .setStrokeCap(Paint.Cap.ROUND)
  .setTextAlign(Paint.Align.LEFT)
  .setTextSize(48),

  select=Paint().setColor(0xffD32F2F)
  .setStyle(Paint.Style.STROKE)
  .setStrokeWidth(8)
  .setAntiAlias(true)
  .setStrokeCap(Paint.Cap.ROUND)
  .setTextAlign(Paint.Align.LEFT)
  .setTextSize(45)

}




