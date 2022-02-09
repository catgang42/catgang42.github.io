using UnityEngine;
using System.Collections;

public class Fireball : MonoBehaviour {

	// Use this for initialization
	void OnBecameInvisible () {
		if (!gameObject.activeSelf)
			return;

		StartCoroutine ("destroy");

	}

	void OnBecameVisible() {
		StopCoroutine ("destroy");
	}

	IEnumerator destroy() {
		yield return new WaitForSeconds (2);
		Destroy (gameObject);
	}

	void OnTriggerEnter2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {
			GameObject mainCamera = GameObject.Find ("Main Camera");
			mainCamera.GetComponent<Health>().gothurt = true;
		}
	}

	void OnTriggerStay2D(Collider2D other) {
		OnTriggerEnter2D (other);
	}
}
