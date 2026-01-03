--这里存放资源
import "android.media.SoundPool"
import "android.media.AudioAttributes"

-- 初始化 SoundPool
soundPool = SoundPool.Builder()
.setMaxStreams(10) -- 最大同时播放流数
.setAudioAttributes(AudioAttributes.Builder()
.setUsage(AudioAttributes.USAGE_GAME) -- 适用于游戏音效
.setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
.build())
.build()

-- 加载音频文件（路径：Lua脚本目录下的 `/res/sounds/Creeper_fuse.mp3`）
--local soundId = soundPool.load(activity.getLuaDir().."/res/sounds/Creeper_fuse.mp3", 1)

-- 设置加载完成监听器
soundPool.setOnLoadCompleteListener{
  onLoadComplete=function(pool, sampleId, status)
    if status == 0 then -- 0 表示加载成功
      --print(sampleId)
      -- 播放音频
      --[[
            pool.play(
                sampleId,  -- soundId
                1.0,       -- 左声道音量（0.0 ~ 1.0）
                1.0,       -- 右声道音量（0.0 ~ 1.0）
                0,        -- 优先级（0 = 最低）
                0,        -- 循环次数（0 = 不循环，-1 = 无限循环）
                1.0       -- 播放速度（1.0 = 正常速度）
            )
--]]
     else
      print("音频加载失败！")
    end
  end
}

task(109,function()
  --soundPool.play(1, 1,1,0,0,1)
end)




res={}
res.sound={}
res.bitmap={}


code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main


res.bitmap.Redstone_Dust=getFileBitmap("imgs/Redstone_Dust")
res.bitmap.Redstone_Dust_Sleep=getFileBitmap("imgs/Redstone_Dust_Sleep")




function bitmapLoader(list)
  for i=1,#list do
    res.bitmap[list[i]]=getFileBitmap("imgs/"..list[i])
  end
end

function soundLoader(list)
  for i=1,#list do
    res.sound[list[i]] = soundPool.load(activity.getLuaDir()
    .."/res/sounds/"..list[i]..".mp3", i)
  end
end


soundLoader{
  "Creeper_fuse",

  "Piglin_idle1",
  "Piglin_idle3",

  "Villager_idle1",
  "Villager_idle2",
  "Villager_idle3",

  "Skeleton_idle2",
  "Zombie_say2",

  "Click_on",
  "Click_off",



}

bitmapLoader{
  "build",
  "Creeper",
  "PiglinFace",
  "SkeletonFace",
  "EntitySprite_leatherworker",

  "Copper_bulb_0",
  "Copper_bulb_1",
  "SW_on",
  "SW_off",

}


