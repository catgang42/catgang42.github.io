using UnityEngine;
using System.Collections;

public class Finish : MonoBehaviour {
	public AudioClip Sound;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {
			GetComponent<AudioSource>().clip = Sound;
			GetComponent<AudioSource>().volume = 2.0f;
			GetComponent<AudioSource>().Play();
			Time.timeScale = 0;
		}
	}
}
