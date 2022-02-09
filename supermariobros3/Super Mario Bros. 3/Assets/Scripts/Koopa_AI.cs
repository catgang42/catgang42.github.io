using UnityEngine;
using System.Collections;

public class Koopa_AI : Enemy_AI {
//	public LayerMask GroundLayers;
//	private Transform is_on_ground;
//	public bool canJump;
//	public bool canJump2;

	// Use this for initialization
	public override void Start () {
//		vel.x = -2.0f;
		// transform.localScale = new Vector3(1, 1, 1);
		//transform.FindChild("Sprite").localScale = new Vector3(-Mathf.Sign (vel.x), 1, 1);
//		is_on_ground = transform.FindChild("IsOnGround");

		base.Start();
	}
	// Update is called once per frame
//	void FixedUpdate () {
//		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.collider2D.bounds.size.x/2, 
//		                             is_on_ground.transform.position.y - is_on_ground.collider2D.bounds.size.y/2);
//		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.collider2D.bounds.size.x/2, 
//		                             is_on_ground.transform.position.y + is_on_ground.collider2D.bounds.size.y/2);
//		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);
//		// next bool needed so that you can't jump off walls
//
//		canJump2 = Physics2D.OverlapPoint(is_on_ground.position, GroundLayers);
//		// go in opposite direction if the enemy approaches a cliff
//
//		if (!canJump){
//			GetComponent<PE_Obj2D>().acc.y = -60.0f;
//			// terminal velocity
//			if (GetComponent<PE_Obj2D>().vel.y <= -20.0f) {
//				GetComponent<PE_Obj2D>().acc.y = 0;
//				GetComponent<PE_Obj2D>().vel.y = -20.0f;
//			}
//		}
//		if (!canJump2 && GetComponent<PE_Obj2D>().acc.y == 0) {
//			turnAround();
//		}
//		// canJump2 = canJump2 || (Mathf.Abs (GetComponent<PE_Obj2D>().acc.y) < 0.1f);
//	}
//
//	public override void OnTriggerEnter2D(Collider2D otherColl){
//		PE_Obj2D other = otherColl.gameObject.GetComponent<PE_Obj2D>();
//		if (other == null) {
//			return;
//		}
//		if (other.gameObject.tag == "PlayerFeet"){
//			print ("stomped");
//		}
//		else if (other.gameObject.tag == "Block_item" || other.gameObject.tag == "Block_empty") {
//			turnAround ();
//			base.OnTriggerEnter2D(otherColl);
//		} else {
//			base.OnTriggerEnter2D(otherColl);
//		}
//	}
//
//	public override void OnTriggerStay2D(Collider2D other){
//		OnTriggerEnter2D(other);
//	}
//
//	void turnAround() {
//
//
//		float curr_vel = vel.x;
//		vel.x = -curr_vel;
//		transform.position = new Vector2(transform.position.x + Mathf.Sign (vel.x) * 0.1f, transform.position.y);
//		//transform.FindChild("Sprite").localScale = new Vector3(Mathf.Sign (curr_vel), 1, 1);
//		transform.localScale = new Vector3 (Mathf.Sign (curr_vel), 1, 1);
//	}
}
