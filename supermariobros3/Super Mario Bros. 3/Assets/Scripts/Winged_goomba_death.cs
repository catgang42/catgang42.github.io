using UnityEngine;
using System.Collections;

public class Winged_goomba_death : Enemy_Death {
	public GameObject goomba;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (dead) {
			Destroy (gameObject);
			GameObject go = Instantiate(goomba, transform.position, Quaternion.identity) as GameObject;
			go.GetComponent<PE_Obj2D>().vel.y = -3;
		}
	}
}
