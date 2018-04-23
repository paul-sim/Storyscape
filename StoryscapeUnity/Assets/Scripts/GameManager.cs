using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour {

	// manager objects
	public static GameManager instance = null;
	public AudioManager am;
	public CharacterManager cm;
	public SceneManager sm;

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

	void Start () {
		am = AudioManager.instance;
	}
	
	// Update is called once per frame
	void Update () {
		
	}

}
