extends Node

@onready var music_player = $MusicPlayer
@onready var mute_button = $UI_MusicControl/MuteButton
@onready var panel_audio = $UI_MusicControl  # Panel setting audio

var is_muted: bool = false

# Path icon
var icon_mute = preload("res://uibuttonicon/UI ICON MUTE.png")
var icon_unmute = preload("res://uibuttonicon/UI SET AUDIO HEAR.png")

func _ready() -> void:
	# Hubungkan tombol mute ke fungsi mute
	mute_button.pressed.connect(_on_mute_button_pressed)

	# Set icon default
	mute_button.icon = icon_unmute
	
	# Cek apakah kita berada di Main Scene
	var current_scene = get_tree().current_scene.scene_file_path
	if current_scene == "res://scenes/main.tscn":
		panel_audio.hide()  # Sembunyikan panel audio hanya di Main.tscn

func _on_mute_button_pressed() -> void:
	is_muted = !is_muted
	if is_muted:
		music_player.volume_db = -80  # Mute
		mute_button.icon = icon_mute  # Ganti icon ke Mute
	else:
		music_player.volume_db = 0  # Unmute (volume normal)
		mute_button.icon = icon_unmute  # Ganti icon ke Unmute

func play_music(track_path: String) -> void:
	if music_player.stream and music_player.stream.resource_path == track_path:
		return  # Jangan restart lagu jika sudah sama

	var new_music = load(track_path)
	if new_music:
		music_player.stream = new_music
		music_player.play()

# Tampilkan/sembunyikan panel audio saat tombol Setting ditekan
func toggle_audio_panel():
	if panel_audio.visible:
		panel_audio.hide()
	else:
		panel_audio.show()
