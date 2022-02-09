using UnityEngine;
using System.Collections;

public class Piranha_collider : MonoBehaviour {
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {
			GetComponentInParent<Piranha_plant>().player_seen = true;
			GetComponentInParent<Piranha_plant>().player_pos = other.gameObject.transform;

		}
	}

	void OnTriggerExit2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {

			GetComponentInParent<Piranha_plant>().player_seen = false;
		}
	}
}
