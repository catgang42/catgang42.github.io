using UnityEngine;
using System.Collections;

public class Spawner : MonoBehaviour {
	public GameObject go;
	public GameObject myObject;
	public bool respawn = true;
	public float timer = 3f;
	public bool dead = true;

	// Use this for initialization
	void Start () {
	
	}


	void OnBecameVisible() {
		if (myObject == null && respawn == true) {
			myObject = Instantiate(go, this.transform.position, Quaternion.identity) as GameObject;
			respawn = false;
			dead = false;
		}
	}

	void OnBecameInvisible() {
	}

	void Update() {
		if (myObject == null) 
			dead = true;
		if (!respawn && !dead) {
			if (myObject.GetComponent<Renderer>().isVisible)
					timer = 3f;
			else if (GetComponent<Renderer>().isVisible)
					timer = 3f;
			
			timer -= Time.deltaTime;

			if (timer <= 0) {
				Destroy (myObject);
				respawn = true;
			}

		}
	}
}
