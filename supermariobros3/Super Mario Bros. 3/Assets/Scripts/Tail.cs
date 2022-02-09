using UnityEngine;
using System.Collections;

public class Tail : PE_Obj2D {

	// Use this for initialization

	
	// Update is called once per frame
	public AudioClip BreakSound;

	public override void OnTriggerEnter2D(Collider2D otherColl){
		PE_Obj2D other = otherColl.gameObject.GetComponent<PE_Obj2D>();
		if (other == null) {
			return;
		}
		else if (other.gameObject.tag == "Enemy") {
			other.gameObject.transform.GetComponent<Enemy_Death>().taildead = true;
		}
		else if (other.gameObject.tag == "Block_breakable") {
			mainCamera.GetComponent<Health>().playSound(BreakSound, 0.1f);
			Destroy (otherColl.gameObject);
		}
		else if (other.gameObject.tag == "Coin") {
			mainCamera.GetComponent<Health>().playSound(CoinSound, 0.1f);
			Destroy (otherColl.gameObject);
		}
	}

	public override void OnTriggerStay2D(Collider2D other){
		OnTriggerEnter2D(other);
	}
}
