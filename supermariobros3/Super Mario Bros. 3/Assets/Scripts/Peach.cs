using UnityEngine;
using System.Collections;

public class Peach : PE_Obj2D {
	public LayerMask GroundLayers;
	public Transform is_on_ground;
	public Animator anim;
	private GameObject camera;
	private GameObject mario;
	public bool canJump;
	public bool canJump2;
	public AudioClip hit_by_shell;
	public bool dead = false;

	// Use this for initialization
/// <summary>
/// /Jrim
/// </summary>
	public override void Start () {
		camera = GameObject.Find ("Main Camera");
		if (camera.GetComponent<Health>().type == PowerUp.none)
			mario = GameObject.Find ("Mario");
		else if (camera.GetComponent<Health>().type == PowerUp.mushroom)
			mario = GameObject.Find ("Mario_Big");
		else if (camera.GetComponent<Health>().type == PowerUp.tanooki)
			mario = GameObject.Find ("Mario_Tanooki");
			
		anim = GetComponent<Animator>();
		// vel.x = -2.0f;
		transform.localScale = new Vector3(-1, 1, 1);

		vel.x = 2.0f;
		
		base.Start ();
	}
//Josh
//	public override void Start () {
//		vel.x = -2.0f;
//		transform.localScale = new Vector3(-1, 1, 1);
//		is_on_ground = transform.FindChild("IsOnGround");
//		base.Start ();
//////>>>>>>>>>>>>>
	// Update is called once per frame

	public virtual void Update () {

		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y - is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y + is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);
		// next bool needed so that you can't jump off walls
		canJump2 = Physics2D.OverlapPoint(is_on_ground.position, GroundLayers);
		// go in opposite direction if the enemy approaches a cliff
		if (transform.position.x >= 5.0f) {
			anim.SetBool ("Cry", true);
			vel.x = 0;
		}
		if (!canJump){
			//if ((vel.y > 0) && (timer < 0.005f)) {
			//	acc.y = 0;
			//}
			//else
				acc.y = -30.0f;
			// terminal velocity
			if (vel.y <= -15.0f) {
				acc.y = 0;
				vel.y = -15.0f;
			}
		}
	}
	public override void OnTriggerEnter2D(Collider2D other){
		// PE_Obj2D other = otherColl.gameObject.GetComponent<PE_Obj2D>();
		// if (other == null) {
		// 	return;
		// } else if (other.gameObject.tag == "Shell") {
		if (other.gameObject.tag == "Item") {
		
		} else {
			base.OnTriggerEnter2D(other);
		}
	}
	
	public override void OnTriggerStay2D(Collider2D other){
		OnTriggerEnter2D(other);
	}
}

