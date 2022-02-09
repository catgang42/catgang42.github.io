using UnityEngine;
using System.Collections;

public class Koopa_Death : Enemy_Death {
	public GameObject Shell;
	

	public override void FixedUpdate ()
	{
		if (dead) {
			Destroy (gameObject);
			Instantiate(Shell, transform.position, Quaternion.identity);
		}
	}

}
