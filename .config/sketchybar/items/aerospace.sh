#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=$ITEM_BG_COLOR \
        background.corner_radius=5 \
        background.height=20 \
        background.drawing=off \
        background.padding_right = 3 \
        background.padding_left = 3 \
        label="$sid" \
        label.padding_right=3 \
        label.padding_left=3 \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

