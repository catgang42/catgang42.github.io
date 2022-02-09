using UnityEngine;
using System.Collections;

public class Winged_koopa_death : Enemy_Death {
	public GameObject Koopa;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (dead) {
			Destroy (gameObject);
			Instantiate(Koopa, transform.position, Quaternion.identity);
		}
	}
}
