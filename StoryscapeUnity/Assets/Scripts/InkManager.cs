using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class InkManager : MonoBehaviour {

	[SerializeField]
	private TextAsset inkJSONAsset;
	private Story story;

	[SerializeField]
	private GameObject canvas;

	// UI Prefabs
	[SerializeField]
	private Text textPrefab;
	[SerializeField]
	private Button buttonPrefab;
	[SerializeField]
	private Button buttonContinuePrefab;

	// manager objects
	GameManager gm;
	AudioManager am;

	// for waiting before showing batch of text
	// bool isWaiting = false;

	void Start () {
		gm = GameManager.instance;
		am = AudioManager.instance;

		StartStory();
	}

	void StartStory () {
		story = new Story (inkJSONAsset.text);
		bindExternalFunctions ();
		RefreshView();
	}

	void RefreshView () {
		RemoveChildren ();

		List<string> tempTags;
		int seconds = 0;

		while (story.canContinue) {
			string text = story.Continue ().Trim();

			// check tags
			tempTags = story.currentTags;
			foreach (string str in tempTags) {
				switch (str)
				{
				case "wait3sec":
					seconds = 3;
					break;
				}
			}
			// CreateContentView (text);
			StartCoroutine (textWait (seconds, text)); // this coroutine will eventually call CreateContentView
			StartCoroutine (choicesWait (seconds));
		}
		/*
		if (story.currentChoices.Count == 0) {
			Button choice = CreateChoiceView("Continue");
			choice.onClick.AddListener(delegate{
				RefreshView();
			});
		} */
		/*
		if(story.currentChoices.Count > 0) {
			for (int i = 0; i < story.currentChoices.Count; i++) {
				Choice choice = story.currentChoices [i];
				Button button = CreateChoiceView (choice.text.Trim ());
				button.onClick.AddListener (delegate {
					OnClickChoiceButton (choice);
				});
			}
		} else {
			Button choice = CreateChoiceView("End of story. Restart?");
			choice.onClick.AddListener(delegate{
				StartStory();
			});
		}*/
	}

	void OnClickChoiceButton (Choice choice) {
		story.ChooseChoiceIndex (choice.index);
		RefreshView();
	}

	void CreateContentView (string text) {
		// ink will give empty string if a paragraph had no text but only choices
		if (text == "") {
			return;
		}
		Text storyText = Instantiate (textPrefab) as Text;
		storyText.text = text;
		storyText.canvasRenderer.SetAlpha (0.0f); // prepare for text fade-in by making text canvas transparent
		storyText.transform.SetParent (canvas.transform, false);
		TextStylingManager.fadeInText (storyText);
	}

	Button CreateChoiceView (string text) {
		Button choice = Instantiate (buttonPrefab) as Button;

		Text choiceText = choice.GetComponentInChildren<Text> ();
		choiceText.text = text;

		choiceText.canvasRenderer.SetAlpha (0.0f); // prepare for text fade-in by making text canvas transparent
		choice.transform.SetParent (canvas.transform, false);
		ButtonStylingManager.fadeInText (choiceText);

		HorizontalLayoutGroup layoutGroup = choice.GetComponent <HorizontalLayoutGroup> ();
		layoutGroup.childForceExpandHeight = false;

		return choice;
	}

	Button CreateContinueBtn () {
		Button btn = Instantiate (buttonContinuePrefab) as Button;

		btn.transform.SetParent (canvas.transform, false);
		// btn.image.CrossFadeAlpha (1.0f, 1, true);
		Color temp = btn.image.color;
		temp.a = 1;
		btn.image.color = temp;
		btn.image.CrossFadeAlpha(0.0f, 0, true);
		btn.image.CrossFadeAlpha(1.0f, 1, true);
		/*
		HorizontalLayoutGroup layoutGroup = choice.GetComponent <HorizontalLayoutGroup> ();
		layoutGroup.childForceExpandHeight = false;
		*/

		return btn;
	}

	void RemoveChildren () {
		int childCount = canvas.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i) {
			GameObject tempChild = canvas.transform.GetChild (i).gameObject;
			if (tempChild.name != "BoxBorder") {
				GameObject.Destroy (tempChild);
			}
		}
	}

	void bindExternalFunctions () {
		story.BindExternalFunction ("playSfx", (string filename) => {
			am.playSfx(filename);
		});
		story.BindExternalFunction ("playMusic", (string filename) => {
			am.playMusic(filename);
		});
		/*
		story.BindExternalFunction ("waitSeconds", (int seconds) => {
			this.waitSeconds(seconds);
		}); */
	}

	void waitSeconds (int seconds) {
		// StartCoroutine (textWait(seconds));
	}

	IEnumerator textWait(int seconds, string text) {
		yield return new WaitForSeconds (seconds);
		CreateContentView (text);
	}

	IEnumerator choicesWait(int seconds) {
		yield return new WaitForSeconds (seconds);
		// attach choices to canvas
		if (story.currentChoices.Count > 0) {
			for (int i = 0; i < story.currentChoices.Count; i++) {
				
				Choice choice = story.currentChoices [i];
				string tempStr = choice.text.Trim ();
				Button button;

				if (tempStr != "continue") {
					button = CreateChoiceView (choice.text.Trim ());
				} else {
					button = CreateContinueBtn ();
				}
				button.onClick.AddListener (delegate {
					OnClickChoiceButton (choice);
				});
			}
		}
	}
}
