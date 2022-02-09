using UnityEngine;
using System.Collections;

public class Switch : PE_Obj2D {
	public Animator anim;
	public GameObject door;
	public bool steppedon;
	public AudioClip switchSound;

	void playSound(AudioClip sound, float vol){
		GetComponent<AudioSource>().clip = sound;
		GetComponent<AudioSource>().volume = vol;
		GetComponent<AudioSource>().Play();
	}

	public override void Start () {
		anim = GetComponent<Animator>();
		base.Start ();
	}
	public override void OnTriggerEnter2D(Collider2D other){
		// PE_Obj2D other = otherColl.gameObject.GetComponent<PE_Obj2D>();
		// if (other == null) {
		// 	return;
		// } else if (other.gameObject.tag == "Shell") {
		if ((other.gameObject.tag == "PlayerFeet") && (other.gameObject.transform.position.y >= transform.position.y + this.GetComponent<Collider2D>().bounds.size.y/2 - 0.1f) && !steppedon) {
			anim.SetBool ("SteppedOn", true);
			playSound(switchSound, 1.0f);
			if (door.GetComponent<PE_Obj2D>() != null)
				PhysEngine2D.objs.Remove(door.GetComponent<PE_Obj2D>());
			Destroy (door);
			steppedon = true;
		} else {
			base.OnTriggerEnter2D(other);
		}
	}
	
	public override void OnTriggerStay2D(Collider2D other){
		OnTriggerEnter2D(other);
	}


}
