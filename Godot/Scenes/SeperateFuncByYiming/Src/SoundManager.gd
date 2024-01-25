extends Node2D

@export var num_sfx_at_once := 5 #how many sounds can play at once

@export var music : Array[Resource]
@export var effects : Array[Resource]

@onready var effects_container = $EffectNode2D
@onready var audio_stream_player = $MusicNode2D/MusicPlayer2D

var paused_position : float = 0.0 #the position music has been paused at

func _ready():
    for i in num_sfx_at_once:
        var stream = AudioStreamPlayer.new()
        effects_container.add_child(stream)

func play_fx(play_sfx_name : String):
    """
        Behavior:
            Plays a sound effect
        Args:
            play_sfx_name (String): The name of the sound effect to play
        Returns:
            None
    """
    for i in effects.size():
        var sound = effects[i]
        var sfx_name = sound.resource_path.get_file().get_basename()
        if sfx_name == play_sfx_name:
            var player = effects_container.get_child(0)
            player.stream = sound
            player.play()
            effects_container.move_child(player, num_sfx_at_once - 1)
            break

func play_music(play_song_name : String):
    for i in music.size():
        var song = music[i]
        var music_name = song.resource_path.get_file().get_basename()
        if music_name == play_song_name and audio_stream_player.stream != song or paused_position > 0.0 or !audio_stream_player.playing:
            audio_stream_player.stream = song
            audio_stream_player.play(paused_position)
            paused_position = 0.0

func stop_music():
    paused_position = 0.0
    audio_stream_player.stop()

func pause_music():
    paused_position = audio_stream_player.get_playback_position()
    audio_stream_player.stop()
