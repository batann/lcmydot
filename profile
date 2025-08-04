whil# vim:fileencoding=utf-8:foldmethod=marker
#{{{ >>>   Ortodox profile 
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
#}}}
#{{{ >>>   clear_clipboard
clear_clipboard() {
	xclip -selection clipboard /dev/null && xclip -selection primary /dev/null
	}
#}}}
#{{{ >>>   on_Login
#on Login() {
#xrandr --output HDMI-1 --auto --primary --left-of VGA-1
#lc-i3-startup


#}
#}}}
#{{{ >>>   announce_time

announce_time() {
while :; do
    notify-send -t 11000 "Time is:" "<span color='Yellow' font='36px'>"$(date +%H:%M)" </span>"
    edge-playback -t $(date +%H:%M)
    sleep 2400
done
}
#}}}
#{{{ >>>   lc-backup-browser-history 
lc-backup-browser-history() {
check_dependencies() {
DEPSBACKUPHISTORY="firefox, pipx"
for pack in $DEPSBACKUPHISTORY; do
	command -v $pack >/dev/null 2>&1 
	if [[ $? == "1" ]]; then
		echo -e "\033[34mInstalling \033[32m$pack\033[34m...\033[0m"
		sudo apt install -y $pack >/dev/null 2>&1
	fi
done
command -v browser-history >/dev/null 2>&1 
if [[ $? == "1" ]]; then
	echo -e "\033[34mInstalling \033[32mbrowser-history\033[34m...\033[0m"
pipx install browser-history >/dev/null 2>&1
fi
}
backup_firefox() {
	browser-history -b firefox -t history |grep "https"|sed 's!.*http!http!g'|sed 's![,].*$!!g' >> /home/batan/.config/lists/firefox-history.md
    cat /home/batan/.config/lists/firefox-history.md |sort -u >> tempor
    rm -f /home/batan/.config/lists/firefox-history.md
    cat tempor >> /home/batan/.config/lists/firefox-history.md
    rm -f tempor
}
check_dependencies
backup_firefox
}
#}}} <#2079
#{{{ >>>   lc-backup_bashhistory
	lc-backup_bashhistory() {
	if [[ -f /home/batan/.bash_history* ]]; then
		cat /home/batan/.bash_history* >> BASHH
		rm /home/batan/.bash_history*
		cat /home/batan/.lcconfig/lists/commands.txt >> BASHH
		rm /home/batan/.lcconfig/lists/commands.txt 
		cat BASHH|sort -u >> /home/batan/.lcconfig/lists/commands.txt 
		rm BASHH
	fi
	megals |grep LCBASHHISTORY 2>/dev/null >/dev/null 2>&1
	if [[ $? == "0" ]]; then
			megaget /Root/LCBASHHISTORY 2>/dev/null
			megarm /Root/LCBASHHISTORY 2>/dev/null
			cat /home/batan/.lcconfig/lists/commands.txt >> LCBASHHISTORY
			cat LCBASHHISTORY |sort -u >> BB
			rm LCBASHHISTORY
			mv BB LCBASHHISTORY
		else
			cat /home/batan/.lcconfig/lists/commands.txt >> LCBASHHISTORY
	fi
	megaput LCBASHHISTORY
	}
#}}}
#{{{ >>>   lc-backup-bookmarks
lc-backupbookmarks() {
    DEPS_BOOK="pipx "
    for pack in ${DEPS_BOOK[@]}; do
        dpkg -s $pack >/dev/null 2>&1
        if [[ $? == '1' ]]; then
            echo -e '\033[34mInstalling \033[35m$pack\033[34m...\033[0m'
            sudo apt-get install -y $pack
            fi
            done
    DEPS_HIST ="browser-history"
    for pack in ${DEPS_HIST[@]}; do
        pipx list|grep $pack >/dev/null 2>&1
        if [[ $? == '1' ]]; then
            echo -e '\033[34mInstalling \033[35m$pack\033[34m...\033[0m'
            pipx install $pack
            fi
            done
	
            if [[ -f /home/batan/.lcconfig/lists/bookmarks.firefox ]]; then
                browser-history -b firefox -t bookmarks|sed 's/.*http/http/'|sed 's/[,].*$//g' >> /home/batan/.lcconfig/lists/bookmarks.temp
                cat /home/batan/.lcconfig/lists/bookmarks.firefox >> /home/batan/.lcconfig/lists/bookmarks.temp
                cat /home/batan/.lcconfig/lists/bookmarks.temp|sort -u >> /home/batan/.lcconfig/lists/bookmarks.firefox
                rm 	/home/batan/.lcconfig/lists/bookmarks.temp
                else
                    browser-history -b firefox -t bookmarks|sed 's/.*http/http/'|sed 's/[,].*$//g' >> /home/batan/.lcconfig/lists/bookmarks.firefox
                    fi
                    }
#}}}
#{{{ >>>   Text To Voice
#watch directory for changes
lc-clipboard_gutenberg() {
WATCH_DIR="/home/batan/.config/lc-gutenberg"
VOICE="en-US-EmmaNeural"  # Change this if needed

inotifywait -m -e create --format '%f' "$WATCH_DIR" | while read -r file; do
    [[ $file == *.txt ]] || continue

    base="${file%.txt}"
    txt="$WATCH_DIR/$file"
    mp3="$WATCH_DIR/$base.mp3"

    /home/batan/.local/bin/edge-tts --voice "$VOICE" -f "$txt" --write-media "$mp3" &>/dev/null
    mpv --no-terminal "$mp3"
read -n1 -p "asd" fff
    rm -f "$txt" "$mp3"
done
}
#}}}
#{{{ >>>   Move Reg
move_register() {

        cat /home/batan/.config/lc-clipboard/register9|grep "http" >> /home/batan/.config/lc-clipboard/auto.register.md 2>/dev/null
		rm -f /home/batan/.config/lc-clipboard/register9 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register8 /home/batan/.config/lc-clipboard/register9 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register7 /home/batan/.config/lc-clipboard/register8 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register6 /home/batan/.config/lc-clipboard/register7 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register5 /home/batan/.config/lc-clipboard/register6 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register4 /home/batan/.config/lc-clipboard/register5 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register3 /home/batan/.config/lc-clipboard/register4 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register2 /home/batan/.config/lc-clipboard/register3 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register1 /home/batan/.config/lc-clipboard/register2 2>/dev/null
		touch /home/batan/.config/lc-clipboard/register1
}
#}}}
#{{{ >>>   lc-clipboard background
lc-clipboard-logic() {
    DIR_BASE="$HOME/.config/lc-clipboard"
    CONFIG_FILE="$DIR_BASE/config"
	TOGGLE_FILE="$DIR_BASE/toggle_*"
    if [[ $TOGGLE_FILE == "toggle_tts" ]]; then
        MODECLIP="I"
    elif [[ $TOGGLE_FILE == "toggle_clipboard" ]]; then
        MODECLIP="II"
    elif [[ $TOGGLE_FILE == "toggle_music" ]]; then
        MODECLIP="III"
    elif [[ $TOGGLE_FILE == "toggle_search" ]]; then
        MODECLIP="IV"
    elif [[ $TOGGLE_FILE == "toggle_cloud" ]]; then
        MODECLIP="V"
    fi


#	TOGGLE_FILE="$DIR_BASE/toggle_register"
 #   mkdir -p "$DIR_BASE"
 #   touch "$CONFIG_FILE"

    previous_clipboard=""

    while true; do
        # Load config values (key=value format)
        [[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"
        current_clipboard=$(xclip -o -selection clipboard 2>/dev/null)
        cleaned_clipboard=$(echo "$current_clipboard" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Skip empty or unchanged clipboard
        [[ -z "$cleaned_clipboard" || "$cleaned_clipboard" == "$previous_clipboard" ]] && sleep 0.0001 && continue
		if [[ -f "$TOGGLE_FILE" ]]; then
			xclip -o -selection clipboard >> /home/batan/.config/lc-gutenberg/$(( $(ls /home/batan/.config/lc-gutenberg/*.txt|wc -l 2>/dev/null) + 1 )).txt
        else
			move_register
			echo "$cleaned_clipboard" > "$DIR_BASE/register1"
		fi


        # === Conditional Logic ===
        if [[ "$cleaned_clipboard" == http* ]]; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/urls.log"

        elif grep -qi youtube <<< "$cleaned_clipboard"; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/youtube.log"

        elif [[ "${LOG_PLAIN}" == "true" ]]; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/plain.log"

 #       elif [[ -n "$REDIRECT_PATH" ]]; then
 #           echo "$cleaned_clipboard" >> "$REDIRECT_PATH"
#
#        elif [[ "$CENSOR" == "true" ]]; then
#            echo "[CENSORED]" >> "$DIR_BASE/censored.log"

#        elif [[ "$cleaned_clipboard" == *password* ]]; then
#            echo "[SECRET]" >> "$DIR_BASE/secrets.log"

        fi
 echo $cleaned_clipboard >> ~/urls.txt
        previous_clipboard="$cleaned_clipboard"
        sleep 0.0001
    done
}
#}}}
#{{{ >>>   Text To Voice
#watch directory for changes
lc-clipboard_gutenberg() {
WATCH_DIR="/home/batan/.config/lc-gutenberg"
VOICE="en-US-EmmaNeural"  # Change this if needed

inotifywait -m -e create --format '%f' "$WATCH_DIR" | while read -r file; do
    [[ $file == *.txt ]] || continue

    base="${file%.txt}"
    txt="$WATCH_DIR/$file"
    mp3="$WATCH_DIR/$base.mp3"

    /home/batan/.local/bin/edge-tts --voice "$VOICE" -f "$txt" --write-media "$mp3" &>/dev/null
    mpv --no-terminal "$mp3"
read -n1 -p "asd" fff
    rm -f "$txt" "$mp3"
done
}
#}}}
#{{{ >>>    Move Reg
move_register() {

        cat /home/batan/.config/lc-clipboard/register9|grep "http" >> /home/batan/.config/lc-clipboard/auto.register.md 2>/dev/null
		rm -f /home/batan/.config/lc-clipboard/register9 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register8 /home/batan/.config/lc-clipboard/register9 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register7 /home/batan/.config/lc-clipboard/register8 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register6 /home/batan/.config/lc-clipboard/register7 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register5 /home/batan/.config/lc-clipboard/register6 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register4 /home/batan/.config/lc-clipboard/register5 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register3 /home/batan/.config/lc-clipboard/register4 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register2 /home/batan/.config/lc-clipboard/register3 2>/dev/null
		mv /home/batan/.config/lc-clipboard/register1 /home/batan/.config/lc-clipboard/register2 2>/dev/null
		touch /home/batan/.config/lc-clipboard/register1
}
#}}}
#{{{ >>>   lc-clipboard background
lc-clipboard-logic() {
    DIR_BASE="$HOME/.config/lc-clipboard"
    CONFIG_FILE="$DIR_BASE/config"
	TOGGLE_FILE="$DIR_BASE/toggle_*"
    if [[ $TOGGLE_FILE == "toggle_tts" ]]; then
        MODECLIP="I"
    elif [[ $TOGGLE_FILE == "toggle_clipboard" ]]; then
        MODECLIP="II"
    elif [[ $TOGGLE_FILE == "toggle_music" ]]; then
        MODECLIP="III"
    elif [[ $TOGGLE_FILE == "toggle_search" ]]; then
        MODECLIP="IV"
    elif [[ $TOGGLE_FILE == "toggle_cloud" ]]; then
        MODECLIP="V"
    fi


#	TOGGLE_FILE="$DIR_BASE/toggle_register"
 #   mkdir -p "$DIR_BASE"
 #   touch "$CONFIG_FILE"

    previous_clipboard=""

    while true; do
        # Load config values (key=value format)
        [[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"
        current_clipboard=$(xclip -o -selection clipboard 2>/dev/null)
        cleaned_clipboard=$(echo "$current_clipboard" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Skip empty or unchanged clipboard
        [[ -z "$cleaned_clipboard" || "$cleaned_clipboard" == "$previous_clipboard" ]] && sleep 0.0001 && continue
		if [[ -f "$TOGGLE_FILE" ]]; then
			xclip -o -selection clipboard >> /home/batan/.config/lc-gutenberg/$(( $(ls /home/batan/.config/lc-gutenberg/*.txt|wc -l 2>/dev/null) + 1 )).txt
        else
			move_register
			echo "$cleaned_clipboard" > "$DIR_BASE/register1"
		fi


        # === Conditional Logic ===
        if [[ "$cleaned_clipboard" == http* ]]; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/urls.log"

        elif grep -qi youtube <<< "$cleaned_clipboard"; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/youtube.log"

        elif [[ "${LOG_PLAIN}" == "true" ]]; then
            echo "$cleaned_clipboard" >> "$DIR_BASE/plain.log"

 #       elif [[ -n "$REDIRECT_PATH" ]]; then
 #           echo "$cleaned_clipboard" >> "$REDIRECT_PATH"
#
#        elif [[ "$CENSOR" == "true" ]]; then
#            echo "[CENSORED]" >> "$DIR_BASE/censored.log"

#        elif [[ "$cleaned_clipboard" == *password* ]]; then
#            echo "[SECRET]" >> "$DIR_BASE/secrets.log"

        fi
 echo $cleaned_clipboard >> ~/urls.txt
        previous_clipboard="$cleaned_clipboard"
        sleep 0.0001
    done
}
#}}}
#{{{ >>>   take_PID
take_PID() {
announce_time &
PIDannouncetime=$!
strace $PIDannouncetime  -c |tee -a /home/batan/.temp.BP.log &
echo "Announce_time: $PIDannouncetime"
lc-clipboard_gutenberg &
PIDgutenberg=$!
strace -p $PIDgutenberg -c |tee -a /home/batan/.temp.BP.log &
echo "Gutenberg: $PIDgutenberg"
lc-clipboard-logic &
PIDclipboard=$!
strace -p $PIDclipboard  -c |tee -a /home/batan/.temp.BP.log &
echo "Clipboard: $PIDclipboard"
	
	
	}
	#}}}


. "$HOME/.cargo/env"
