using UnityEngine;
using System.Collections;

public class Enemy_Death : MonoBehaviour {
	private Animator enemy_anim;
	public float timer;
	public bool dead = false;
	public bool taildead = false;
	public bool dead_anim = false;
	public bool deadbytail = false;
	// Use this for initialization
	void Start () {
		enemy_anim = transform.GetComponent<Animator>();
		timer = 10.0f;
	}
	
	// Update is called once per frame
	virtual public void FixedUpdate () {
		if (dead && !dead_anim) {
			if (enemy_anim != null)
				enemy_anim.SetBool ("Dead", dead);
			timer = 0;
			if (GetComponent<Enemy_AI>() != null)
				PhysEngine2D.objs.Remove(GetComponent<Enemy_AI>());
			transform.gameObject.GetComponent<PE_Obj2D>().still = true;
			dead_anim = true;
		}
//		if (taildead && !deadbytail) {
//			timer = 0;
//			GetComponent<Enemy_AI>().vel.y = 15;
//			GetComponent<Enemy_AI>().vel.x = 3;
//			rigidbody2D.isKinematic = false;
//			transform.localScale = new Vector3(-1, -1, 1);
//			PhysEngine2D.objs.Remove(transform.GetComponent<Enemy_AI>());
//			transform.gameObject.GetComponent<PE_Obj2D>().still = true;
//			deadbytail = true;
//		}
		if ((timer >= 0.2f && timer <= 5.0f && dead_anim) || (timer >= 3.0f && timer <= 5.0f && deadbytail)) {
			if (GetComponent<PE_Obj2D>() != null)
				PhysEngine2D.objs.Remove(GetComponent<PE_Obj2D>());
			Destroy (transform.gameObject);
		}
		timer += Time.fixedDeltaTime;
	}
}
