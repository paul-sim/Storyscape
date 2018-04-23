using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
// using UnityEngine.Events;
// using UnityEngine.EventSystems;

public class TextStylingManager : MonoBehaviour{

	public static void fadeInText(Text textUI) {
		textUI.CrossFadeAlpha (1.0f, 1, true);
	}
}
