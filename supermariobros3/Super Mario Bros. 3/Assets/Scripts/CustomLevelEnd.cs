using UnityEngine;
using System.Collections;

public class CustomLevelEnd : MonoBehaviour {
	public AudioClip Sound;
	public GameObject Luigi;
	public bool done;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		Luigi = GameObject.Find("Luigi");
		if (Luigi == null && !done) {
			GetComponent<AudioSource>().clip = Sound;
			GetComponent<AudioSource>().volume = 2.0f;
			GetComponent<AudioSource>().Play();
			done = true;
			Time.timeScale = 0.001f;
		}
	}
}
