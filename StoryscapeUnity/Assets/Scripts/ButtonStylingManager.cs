using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using UnityEngine.EventSystems;

public class ButtonStylingManager : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler {

	public Animator anim;

	public static void fadeInText(Text textUI) {
		textUI.CrossFadeAlpha (1.0f, 1, true);
	}

	public void OnPointerEnter(PointerEventData eventData) {
		anim.SetBool ("mouseHoverBtn", true);
	}
	public void OnPointerExit(PointerEventData eventData) {
		anim.SetBool ("mouseHoverBtn", false);
	}
}
