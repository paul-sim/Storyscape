using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class AudioManager : MonoBehaviour {

	public AudioSource sfxSource;
	public AudioSource musicSource;
	public static AudioManager instance = null;

	// Use this for initialization
	void Awake () {
		if (instance == null) {
			instance = this;
		}
		else if (instance != null) {
			Destroy (gameObject); // this is a second copy so destroy it
		}

		DontDestroyOnLoad (gameObject); // music will continue regardless of a scene change
	}
	
	public void playSfx(string filename) {

		AudioClip clip = Resources.Load<AudioClip> ("Audio/Sfx/" + filename);
		if (clip) {
			sfxSource.clip = clip;
			sfxSource.Play ();
		}
	}

	public void playMusic(string filename) {

		AudioClip clip = Resources.Load<AudioClip> ("Audio/Music/" + filename);
		if (clip) {
			musicSource.clip = clip;
			musicSource.Play ();
		}
	}
}
