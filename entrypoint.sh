#!/bin/bash

echo "Generating serverconfig.txt"

cat > ./serverconfig.txt <<EOF
# Terraria Config
worldpath=/world
banlist=banlist.txt

world=/world/$WORLD
worldname=$WORLD_NAME
autocreate=$WORLD_SIZE
$([ -z "$SEED" ] && echo "#seed=" || echo "seed=$SEED")
difficulty=$DIFFICULTY
npcstream=$NPC_STREAM
maxplayers=$MAX_PLAYERS
port=$PORT
$([ -z "$PASSWORD" ] && echo "#password=" || echo "password=$PASSWORD")
secure=$SECURE
$([ -z "$MOTD" ] && echo "#motd=" || echo "motd=$MOTD")
language=$LANGUAGE
slowliquids=$SLOW_LIQUIDS
worldrollbackstokeep=$ROLLING_BACKUP

#Journey mode config:
journeypermission_time_setspeed=$J_TIME_SPEED
journeypermission_time_setfrozen=$J_TIME_TOGGLE
journeypermission_time_setdawn=$J_TIME_DAWN
journeypermission_time_setnoon=$J_TIME_NOON
journeypermission_time_setdusk=$J_TIME_DUSK
journeypermission_time_setmidnight=$J_TIME_MIDNIGHT
journeypermission_godmode=$J_GODMODE
journeypermission_wind_setstrength=$J_WEATHER_WIND
journeypermission_wind_setfrozen=$J_WEATHER_WIND_TOGGLE
journeypermission_rain_setstrength=$J_WEATHER_RAIN
journeypermission_rain_setfrozen=$J_WEATHER_RAIN_TOGGLE
journeypermission_increaseplacementrange=$J_PLACEMENT_RANGE
journeypermission_setdifficulty=$J_DIFFICULTY
journeypermission_biomespread_setfrozen=$J_BIOME
journeypermission_setspawnrate=$J_SPAWN_RATE

EOF

echo "Fetching latest terraria server download url"
dl_link = $(wget -qO - "https://runkit.io/paul1365972/terraria-latest-version-api/branches/master")

echo "Downloading $dl_link"
wget -qO "tmp.zip" "$dl_link"
unzip -q -o "tmp.zip" -d "tmp/"
dir = "tmp/*/Linux"
mv $dir/TerrariaServer.exe $dir/FNA.dll "./"
rm -rf "tmp.zip" "tmp/"

echo "Starting server"
./TerrariaServer.exe -config serverconfig.txt
